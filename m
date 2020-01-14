Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C213A980
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2020 13:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgANMkZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jan 2020 07:40:25 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50300 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANMkZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:40:25 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1irLUd-0005Qk-Hq; Tue, 14 Jan 2020 13:40:23 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] xfrm: spi is big endian
Date:   Tue, 14 Jan 2020 13:40:15 +0100
Message-Id: <20200114124015.31064-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

the kernel stores spi in a __be32, so fix up the byteorder annotation
accordingly.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/xfrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/xfrm.c b/src/xfrm.c
index d0773ab789f1..80f0ea037429 100644
--- a/src/xfrm.c
+++ b/src/xfrm.c
@@ -39,7 +39,7 @@ const struct xfrm_template xfrm_templates[] = {
 	[NFT_XFRM_KEY_DADDR_IP6]	= XFRM_TEMPLATE_BE("daddr", &ip6addr_type, 16 * BITS_PER_BYTE),
 	[NFT_XFRM_KEY_SADDR_IP6]	= XFRM_TEMPLATE_BE("saddr", &ip6addr_type, 16 * BITS_PER_BYTE),
 	[NFT_XFRM_KEY_REQID]		= XFRM_TEMPLATE_HE("reqid", &integer_type, 4 * BITS_PER_BYTE),
-	[NFT_XFRM_KEY_SPI]		= XFRM_TEMPLATE_HE("spi", &integer_type, 4 * BITS_PER_BYTE),
+	[NFT_XFRM_KEY_SPI]		= XFRM_TEMPLATE_BE("spi", &integer_type, 4 * BITS_PER_BYTE),
 };
 
 static void xfrm_expr_print(const struct expr *expr, struct output_ctx *octx)
-- 
2.24.1

