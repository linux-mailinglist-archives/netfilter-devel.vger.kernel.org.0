Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FC12A45E
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Dec 2019 00:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLXXMN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Dec 2019 18:12:13 -0500
Received: from kadath.azazel.net ([81.187.231.250]:49684 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfLXXMN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Dec 2019 18:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=h+d8xRCBqMM0iBHFiL2cxqYadKH4RA21/v4sJMnhMVM=; b=p+1xodUf6sLbEPYyWvqB5VvzqG
        yi9bhGxGtFDq37/L5I4+Hy0Qog/GLzgza5QGE7ngul08WGDTZDN+CVNLROc5/aqFux6i+g77nKIR7
        I2oP0seIlImaW6pl3G0hbv3ZZ2PrAmmYE1OhwDdzpXy/vvT18pe4A4Uzmi3WqP9EA/l4768Hah9T5
        xKueeRFhQxLxDbcGBtZ1ZY3rj4hHzV9hDpkMLI+SUeKyO/9Dw731tILCtbuHf/biXezTv+a+MStdw
        +16HWU2M8+6bfcH6is6sRjxq976UtFVQd/INBGGMztRMReRWDKJCCISWd2/Ejo1wHTbB7Ylz8L2z8
        U4FfUN5g==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1ijtLX-00025L-Fa
        for netfilter-devel@vger.kernel.org; Tue, 24 Dec 2019 23:12:11 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nftables] evaluate: remove expr_set_context call.
Date:   Tue, 24 Dec 2019 23:12:11 +0000
Message-Id: <20191224231211.1972101-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220190215.1743199-1-jeremy@azazel.net>
References: <20191220190215.1743199-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

expr_evaluate_binop calls expr_set_context for shift expressions to set
the context data-type to `integer`.  This doesn't seem to serve a
purpose, and its only effect is to clobber the byte-order of the
context, resulting in unexpected conversions to NBO.  For example:

  $ sudo nft flush ruleset
  $ sudo nft add table t
  $ sudo nft add chain t c '{ type filter hook output priority mangle; }'
  $ sudo nft add rule t c oif lo tcp dport ssh ct mark set '0x10 | 0xe'
  $ sudo nft add rule t c oif lo tcp dport ssh ct mark set '0xf << 1'
  $ sudo nft list table t
  table ip t {
          chain c {
                  type filter hook output priority mangle; policy accept;
                  oif "lo" tcp dport 22 ct mark set 0x0000001e
                  oif "lo" tcp dport 22 ct mark set 0x1e000000
          }
  }

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index a865902c0fc7..0feb7d484405 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1144,8 +1144,6 @@ static int expr_evaluate_binop(struct eval_ctx *ctx, struct expr **expr)
 		return -1;
 	left = op->left;
 
-	if (op->op == OP_LSHIFT || op->op == OP_RSHIFT)
-		expr_set_context(&ctx->ectx, &integer_type, ctx->ectx.len);
 	if (expr_evaluate(ctx, &op->right) < 0)
 		return -1;
 	right = op->right;
-- 
2.24.0

