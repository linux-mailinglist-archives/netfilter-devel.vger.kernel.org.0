Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207629657A
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Oct 2020 21:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508686AbgJVToh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Oct 2020 15:44:37 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44184 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370377AbgJVToh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:44:37 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4CHHr45hFVzFvjJ;
        Thu, 22 Oct 2020 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1603395876; bh=TvvhhVJiBpovn7GtjztN4xrH7zQh2cAAouhyuGFz/Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tS7jZ2KRF3F/pIW9O3TiMhNF1/T2nWueyLK/G1PfuZv4TO7RMilUJCa1xf6LzKkZ/
         8HJ0Xb7R+USoEYSLrR3LUALoB+Kf0Xd68e0oEnHR9UpOIelopWCiQ6ZlX8kEQrSgeN
         ojYdalDEP19e3jDw1JL1iyMdhVlo7uY0dl62s3Dw=
X-Riseup-User-ID: 0B8D75DE600FA784C4957AAAD225760E24D346F91EB48CBC4BDB7B2855B3B8CB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4CHHr36q3vz8sX6;
        Thu, 22 Oct 2020 12:44:35 -0700 (PDT)
From:   "Jose M. Guisado Gomez" <guigom@riseup.net>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables 4/5] evaluate: add netdev support for reject default
Date:   Thu, 22 Oct 2020 21:43:54 +0200
Message-Id: <20201022194355.1816-5-guigom@riseup.net>
In-Reply-To: <20201022194355.1816-1-guigom@riseup.net>
References: <20201022194355.1816-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Enables not specifying any icmp type and code when using reject inside
netdev.

This patch completely enables using reject for the netdev family.

Signed-off-by: Jose M. Guisado Gomez <guigom@riseup.net>
---
 src/evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index abbf83ae..af52ab18 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2745,6 +2745,7 @@ static int stmt_evaluate_reject_default(struct eval_ctx *ctx,
 		}
 		break;
 	case NFPROTO_BRIDGE:
+	case NFPROTO_NETDEV:
 		desc = ctx->pctx.protocol[PROTO_BASE_NETWORK_HDR].desc;
 		if (desc == NULL) {
 			stmt->reject.type = NFT_REJECT_ICMPX_UNREACH;
-- 
2.28.0

