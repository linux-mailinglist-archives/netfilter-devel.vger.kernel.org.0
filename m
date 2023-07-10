Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA074D098
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jul 2023 10:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGJIuj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jul 2023 04:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGJIui (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC53118
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688978987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9rq8NRpR2njBA08OWcvSoajA+Ltoifvp1BWXwF6C7o=;
        b=U49Acs79eWLe7kgaTtGOISqynsgn9iyFtfr+zYg1s9F3hfT8UEtN9Yv1rsx3onT3QWMqoF
        F8xsNCUy86fNREkFqhEWC8k0kbNpNHbqAUjDFYolhNbWjRAOdWiZ6Hl34gujF5FPSoNIia
        5ut3OQ4UHTjJCdeWu7d3N4HzkiCVEZU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-OfI8414HOFS_GYPvdOSGAQ-1; Mon, 10 Jul 2023 04:49:43 -0400
X-MC-Unique: OfI8414HOFS_GYPvdOSGAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA1E81C0896B
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE6A111DCE3;
        Mon, 10 Jul 2023 08:49:42 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [nft PATCH 3/4] libnftables: inline creation of nf_sock in nft_ctx_new()
Date:   Mon, 10 Jul 2023 10:45:18 +0200
Message-ID: <20230710084926.172198-4-thaller@redhat.com>
In-Reply-To: <20230710084926.172198-1-thaller@redhat.com>
References: <20230710084926.172198-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The function only has one caller. It's not clear how to extend this in a
useful way, so that it makes sense to keep the initialization in a
separate function.

Simplify the code, by inlining and dropping the static function
nft_ctx_netlink_init(). There was only one caller.

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 src/libnftables.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/libnftables.c b/src/libnftables.c
index 5b3eb2dc3df4..79dfdfc7c6ec 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -186,11 +186,6 @@ void nft_ctx_clear_include_paths(struct nft_ctx *ctx)
 	ctx->include_paths = NULL;
 }
 
-static void nft_ctx_netlink_init(struct nft_ctx *ctx)
-{
-	ctx->nf_sock = nft_mnl_socket_open();
-}
-
 EXPORT_SYMBOL(nft_ctx_new);
 struct nft_ctx *nft_ctx_new(uint32_t flags)
 {
@@ -218,7 +213,7 @@ struct nft_ctx *nft_ctx_new(uint32_t flags)
 	ctx->output.error_fp = stderr;
 	init_list_head(&ctx->vars_ctx.indesc_list);
 
-	nft_ctx_netlink_init(ctx);
+	ctx->nf_sock = nft_mnl_socket_open();
 
 	return ctx;
 }
-- 
2.41.0

