Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B627CD703
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Oct 2023 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJRIvx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Oct 2023 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJRIvt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:51:49 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BE5C6;
        Wed, 18 Oct 2023 01:51:48 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qt2HH-0006LQ-A8; Wed, 18 Oct 2023 10:51:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 5/7] netfilter: make nftables drops visible in net dropmonitor
Date:   Wed, 18 Oct 2023 10:51:09 +0200
Message-ID: <20231018085118.10829-6-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018085118.10829-1-fw@strlen.de>
References: <20231018085118.10829-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

net_dropmonitor blames core.c:nf_hook_slow.
Add NF_DROP_REASON() helper and use it in nft_do_chain().

The helper releases the skb, so exact drop location becomes
available. Calling code will observe the NF_STOLEN verdict
instead.

Adjust nf_hook_slow so we can embed an erro value wih
NF_STOLEN verdicts, just like we do for NF_DROP.

After this, drop in nftables can be pinpointed to a drop due
to a rule or the chain policy.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h      | 10 ++++++++++
 net/netfilter/core.c           |  6 +++---
 net/netfilter/nf_tables_core.c |  6 +++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index d68644b7c299..80900d910992 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -22,6 +22,16 @@ static inline int NF_DROP_GETERR(int verdict)
 	return -(verdict >> NF_VERDICT_QBITS);
 }
 
+static __always_inline int
+NF_DROP_REASON(struct sk_buff *skb, enum skb_drop_reason reason, u32 err)
+{
+	BUILD_BUG_ON(err > 0xffff);
+
+	kfree_skb_reason(skb, reason);
+
+	return ((err << 16) | NF_STOLEN);
+}
+
 static inline int nf_inet_addr_cmp(const union nf_inet_addr *a1,
 				   const union nf_inet_addr *a2)
 {
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index ef4e76e5aef9..3126911f5042 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -639,10 +639,10 @@ int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
 			if (ret == 1)
 				continue;
 			return ret;
+		case NF_STOLEN:
+			return NF_DROP_GETERR(verdict);
 		default:
-			/* Implicit handling for NF_STOLEN, as well as any other
-			 * non conventional verdicts.
-			 */
+			WARN_ON_ONCE(1);
 			return 0;
 		}
 	}
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 6009b423f60a..8b536d7ef6c2 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -308,10 +308,11 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 
 	switch (regs.verdict.code & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
-	case NF_DROP:
 	case NF_QUEUE:
 	case NF_STOLEN:
 		return regs.verdict.code;
+	case NF_DROP:
+		return NF_DROP_REASON(pkt->skb, SKB_DROP_REASON_NETFILTER_DROP, EPERM);
 	}
 
 	switch (regs.verdict.code) {
@@ -342,6 +343,9 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 	if (static_branch_unlikely(&nft_counters_enabled))
 		nft_update_chain_stats(basechain, pkt);
 
+	if (nft_base_chain(basechain)->policy == NF_DROP)
+		return NF_DROP_REASON(pkt->skb, SKB_DROP_REASON_NETFILTER_DROP, EPERM);
+
 	return nft_base_chain(basechain)->policy;
 }
 EXPORT_SYMBOL_GPL(nft_do_chain);
-- 
2.41.0

