Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89386F5007
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjECGWd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 02:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjECGWc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 02:22:32 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EF4D35A2
        for <netfilter-devel@vger.kernel.org>; Tue,  2 May 2023 23:22:30 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: deactivate anonymous set from preparation phase
Date:   Wed,  3 May 2023 08:22:22 +0200
Message-Id: <20230503062222.10254-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

Toggle deleted anonymous sets as inactive in the next generation, so
users cannot perform any update on it. Clear the generation bitmask
in case the transaction is aborted.

The following KASAN splat shows a set element deletion for a bound
anonymous set that has been already removed in the same transaction.

[   64.921510] ==================================================================
[   64.923123] BUG: KASAN: wild-memory-access in nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.924745] Write of size 8 at addr dead000000000122 by task test/890
[   64.927903] CPU: 3 PID: 890 Comm: test Not tainted 6.3.0+ #253
[   64.931120] Call Trace:
[   64.932699]  <TASK>
[   64.934292]  dump_stack_lvl+0x33/0x50
[   64.935908]  ? nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.937551]  kasan_report+0xda/0x120
[   64.939186]  ? nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.940814]  nf_tables_commit+0xa24/0x1490 [nf_tables]
[   64.942452]  ? __kasan_slab_alloc+0x2d/0x60
[   64.944070]  ? nf_tables_setelem_notify+0x190/0x190 [nf_tables]
[   64.945710]  ? kasan_set_track+0x21/0x30
[   64.947323]  nfnetlink_rcv_batch+0x709/0xd90 [nfnetlink]
[   64.948898]  ? nfnetlink_rcv_msg+0x480/0x480 [nfnetlink]

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  1 +
 net/netfilter/nf_tables_api.c     | 12 ++++++++++++
 net/netfilter/nft_dynset.c        |  2 +-
 net/netfilter/nft_lookup.c        |  2 +-
 net/netfilter/nft_objref.c        |  2 +-
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3ed21d2d5659..2e24ea1d744c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -619,6 +619,7 @@ struct nft_set_binding {
 };
 
 enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 09542951656c..1b4bcc4b87ed 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5125,12 +5125,24 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (nft_set_is_anonymous(set))
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
 	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 274579b1696e..bd19c7aec92e 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -342,7 +342,7 @@ static void nft_dynset_activate(const struct nft_ctx *ctx,
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index cecf8ab90e58..03ef4fdaa460 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -167,7 +167,7 @@ static void nft_lookup_activate(const struct nft_ctx *ctx,
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index cb37169608ba..a48dd5b5d45b 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -185,7 +185,7 @@ static void nft_objref_map_activate(const struct nft_ctx *ctx,
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
-- 
2.30.2

