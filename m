Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8609490418
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Aug 2019 16:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHPOou (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Aug 2019 10:44:50 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46168 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727245AbfHPOou (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:44:50 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hydTF-0002na-I6; Fri, 16 Aug 2019 16:44:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nftables 1/8] src: libnftnl: run single-initcalls only once
Date:   Fri, 16 Aug 2019 16:42:34 +0200
Message-Id: <20190816144241.11469-2-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816144241.11469-1-fw@strlen.de>
References: <20190816144241.11469-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

---
 src/libnftables.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/libnftables.c b/src/libnftables.c
index a693c0c69075..b169dd2f2afe 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -90,11 +90,6 @@ static void nft_init(struct nft_ctx *ctx)
 	realm_table_rt_init(ctx);
 	devgroup_table_init(ctx);
 	ct_label_table_init(ctx);
-
-	gmp_init();
-#ifdef HAVE_LIBXTABLES
-	xt_init();
-#endif
 }
 
 static void nft_exit(struct nft_ctx *ctx)
@@ -142,8 +137,17 @@ static void nft_ctx_netlink_init(struct nft_ctx *ctx)
 EXPORT_SYMBOL(nft_ctx_new);
 struct nft_ctx *nft_ctx_new(uint32_t flags)
 {
+	static bool init_once;
 	struct nft_ctx *ctx;
 
+	if (!init_once) {
+		init_once = true;
+		gmp_init();
+#ifdef HAVE_LIBXTABLES
+		xt_init();
+#endif
+	}
+
 	ctx = xzalloc(sizeof(struct nft_ctx));
 	nft_init(ctx);
 
-- 
2.21.0

