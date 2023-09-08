Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153817983BB
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Sep 2023 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjIHIKp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Sep 2023 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbjIHIKo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:10:44 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180631BF1;
        Fri,  8 Sep 2023 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3Xq5Im7fumYrRMB6e8uFKv7Zwppr6d8ISGzTZvMpbco=; b=V+YzuZm/dX4/KoN4kuzUd88PqY
        z4EKQJklsm006orL+LGups/tsGrJujYcnibeNZie9Hs+/qcf7DhhrfdZFenapIw/ge7timdWfs0tS
        YQMr+Q6VSg9zC4JPGnX747gQG3sbGIkhn7S+yssVP50NdwpaSUZmcOb8djg+aZvzBW4GCWVgLOyYT
        e1VDOQZMOsbpdgqhlICHJW1sLKf8HwFrLbW3wZwnRVIq3fVum6PjwyJlkdp3LfSOm7H1B50nP1NZi
        U+GvadoO9vLIR/9gLbp6/mCubspK//ddQIbJ755e2Ai7DxHBlTfdC/C+GlD9MGufyOpaCWw9SU7lz
        yeu+CrdA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qeWZY-00046B-PI; Fri, 08 Sep 2023 10:10:36 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        audit@vger.kernel.org
Subject: [nf PATCH v2] netfilter: nf_tables: Fix entries val in rule reset audit log
Date:   Fri,  8 Sep 2023 10:10:33 +0200
Message-ID: <20230908081033.30806-1-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The value in idx and the number of rules handled in that particular
__nf_tables_dump_rules() call is not identical. The former is a cursor
to pick up from if multiple netlink messages are needed, so its value is
ever increasing. Fixing this is not just a matter of subtracting s_idx
from it, though: When resetting rules in multiple chains,
__nf_tables_dump_rules() is called for each and cb->args[0] is not
adjusted in between.

The audit notification in __nf_tables_dump_rules() had another problem:
If nf_tables_fill_rule_info() failed (e.g. due to buffer exhaustion), no
notification was sent - despite the rules having been reset already.

To catch all the above and return to a single (if possible) notification
per table again, move audit logging back into the caller but into the
table loop instead of past it to avoid the potential null-pointer
deref.

This requires to trigger the notification in two spots. Care has to be
taken in the second case as cb->args[0] is also not updated in between
tables. This requires a helper variable as either it is the first table
(with potential non-zero cb->args[0] cursor) or a consecutive one (with
idx holding the current cursor already).

Fixes: 9b5ba5c9c5109 ("netfilter: nf_tables: Unbreak audit log reset")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Use max_t() to eliminate the kernel warning
---
 net/netfilter/nf_tables_api.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e429ebba74b3d..5a1ff10d1d2a5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3481,9 +3481,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 		(*idx)++;
 	}
 
-	if (reset && *idx)
-		audit_log_rule_reset(table, cb->seq, *idx);
-
 	return 0;
 }
 
@@ -3494,11 +3491,12 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 	const struct nft_rule_dump_ctx *ctx = cb->data;
 	struct nft_table *table;
 	const struct nft_chain *chain;
-	unsigned int idx = 0;
+	unsigned int idx = 0, s_idx;
 	struct net *net = sock_net(skb->sk);
 	int family = nfmsg->nfgen_family;
 	struct nftables_pernet *nft_net;
 	bool reset = false;
+	int ret;
 
 	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETRULE_RESET)
 		reset = true;
@@ -3529,16 +3527,23 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 						       cb, table, chain, reset);
 				break;
 			}
+			if (reset && idx > cb->args[0])
+				audit_log_rule_reset(table, cb->seq,
+						     idx - cb->args[0]);
 			goto done;
 		}
 
+		s_idx = max_t(long, idx, cb->args[0]);
 		list_for_each_entry_rcu(chain, &table->chains, list) {
-			if (__nf_tables_dump_rules(skb, &idx,
-						   cb, table, chain, reset))
-				goto done;
+			ret = __nf_tables_dump_rules(skb, &idx,
+						     cb, table, chain, reset);
+			if (ret)
+				break;
 		}
+		if (reset && idx > s_idx)
+			audit_log_rule_reset(table, cb->seq, idx - s_idx);
 
-		if (ctx && ctx->table)
+		if ((ctx && ctx->table) || ret)
 			break;
 	}
 done:
-- 
2.41.0

