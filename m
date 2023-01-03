Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C0F65C02A
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Jan 2023 13:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbjACMrf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Jan 2023 07:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbjACMre (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:47:34 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAFB33
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Jan 2023 04:47:32 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pCghX-0003tw-4b; Tue, 03 Jan 2023 13:47:31 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 2/3] netfilter: nf_tables: avoid retpoline overhead for objref calls
Date:   Tue,  3 Jan 2023 13:47:16 +0100
Message-Id: <20230103124717.8178-3-fw@strlen.de>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230103124717.8178-1-fw@strlen.de>
References: <20230103124717.8178-1-fw@strlen.de>
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

objref expression is builtin, so avoid calls to it for
RETOLINE=y builds.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables_core.h |  4 ++++
 net/netfilter/nf_tables_core.c         |  2 ++
 net/netfilter/nft_objref.c             | 12 ++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 3e825381ac5c..bedef373ec21 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -164,4 +164,8 @@ void nft_payload_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
 			    const struct nft_pktinfo *pkt,
 			    struct nft_inner_tun_ctx *ctx);
 
+void nft_objref_eval(const struct nft_expr *expr, struct nft_regs *regs,
+		     const struct nft_pktinfo *pkt);
+void nft_objref_map_eval(const struct nft_expr *expr, struct nft_regs *regs,
+			 const struct nft_pktinfo *pkt);
 #endif /* _NET_NF_TABLES_CORE_H */
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 0f26d002d8b3..d9992906199f 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -234,6 +234,8 @@ static void expr_call_ops_eval(const struct nft_expr *expr,
 	X(e, nft_dynset_eval);
 	X(e, nft_rt_get_eval);
 	X(e, nft_bitwise_eval);
+	X(e, nft_objref_eval);
+	X(e, nft_objref_map_eval);
 #undef  X
 indirect_call:
 #endif /* CONFIG_RETPOLINE */
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 7b01aa2ef653..cb37169608ba 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -13,9 +13,9 @@
 
 #define nft_objref_priv(expr)	*((struct nft_object **)nft_expr_priv(expr))
 
-static void nft_objref_eval(const struct nft_expr *expr,
-			    struct nft_regs *regs,
-			    const struct nft_pktinfo *pkt)
+void nft_objref_eval(const struct nft_expr *expr,
+		     struct nft_regs *regs,
+		     const struct nft_pktinfo *pkt)
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
@@ -100,9 +100,9 @@ struct nft_objref_map {
 	struct nft_set_binding	binding;
 };
 
-static void nft_objref_map_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
+void nft_objref_map_eval(const struct nft_expr *expr,
+			 struct nft_regs *regs,
+			 const struct nft_pktinfo *pkt)
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 	const struct nft_set *set = priv->set;
-- 
2.38.2

