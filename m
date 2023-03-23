Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519A6C6FA6
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Mar 2023 18:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCWRri (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Mar 2023 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCWRrh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:47:37 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D1FC1B314
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Mar 2023 10:47:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net
Subject: [PATCH nft] payload: set byteorder when completing expression
Date:   Thu, 23 Mar 2023 18:47:33 +0100
Message-Id: <20230323174733.635835-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise payload expression remains in invalid byteorder which is
handled as network byteorder for historical reason.

No functional change is intended.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
IIRC, Jeremy posted a similar patch.

 src/payload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/payload.c b/src/payload.c
index ed76623c9393..f67b54078792 100644
--- a/src/payload.c
+++ b/src/payload.c
@@ -991,6 +991,7 @@ void payload_expr_complete(struct expr *expr, const struct proto_ctx *ctx)
 
 		expr->dtype	   = tmpl->dtype;
 		expr->payload.desc = desc;
+		expr->byteorder = tmpl->byteorder;
 		expr->payload.tmpl = tmpl;
 		return;
 	}
-- 
2.30.2

