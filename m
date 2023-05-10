Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C486FD9BB
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 10:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjEJIlg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjEJIl2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 04:41:28 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A357D1BCB;
        Wed, 10 May 2023 01:41:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 2/7] netfilter: conntrack: fix possible bug_on with enable_hooks=1
Date:   Wed, 10 May 2023 10:33:08 +0200
Message-Id: <20230510083313.152961-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230510083313.152961-1-pablo@netfilter.org>
References: <20230510083313.152961-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

I received a bug report (no reproducer so far) where we trip over

712         rcu_read_lock();
713         ct_hook = rcu_dereference(nf_ct_hook);
714         BUG_ON(ct_hook == NULL);  // here

In nf_conntrack_destroy().

First turn this BUG_ON into a WARN.  I think it was triggered
via enable_hooks=1 flag.

When this flag is turned on, the conntrack hooks are registered
before nf_ct_hook pointer gets assigned.
This opens a short window where packets enter the conntrack machinery,
can have skb->_nfct set up and a subsequent kfree_skb might occur
before nf_ct_hook is set.

Call nf_conntrack_init_end() to set nf_ct_hook before we register the
pernet ops.

Fixes: ba3fbe663635 ("netfilter: nf_conntrack: provide modparam to always register conntrack hooks")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/core.c                    | 6 ++++--
 net/netfilter/nf_conntrack_standalone.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index f0783e42108b..5f76ae86a656 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -711,9 +711,11 @@ void nf_conntrack_destroy(struct nf_conntrack *nfct)
 
 	rcu_read_lock();
 	ct_hook = rcu_dereference(nf_ct_hook);
-	BUG_ON(ct_hook == NULL);
-	ct_hook->destroy(nfct);
+	if (ct_hook)
+		ct_hook->destroy(nfct);
 	rcu_read_unlock();
+
+	WARN_ON(!ct_hook);
 }
 EXPORT_SYMBOL(nf_conntrack_destroy);
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 57f6724c99a7..169e16fc2bce 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1218,11 +1218,12 @@ static int __init nf_conntrack_standalone_init(void)
 	nf_conntrack_htable_size_user = nf_conntrack_htable_size;
 #endif
 
+	nf_conntrack_init_end();
+
 	ret = register_pernet_subsys(&nf_conntrack_net_ops);
 	if (ret < 0)
 		goto out_pernet;
 
-	nf_conntrack_init_end();
 	return 0;
 
 out_pernet:
-- 
2.30.2

