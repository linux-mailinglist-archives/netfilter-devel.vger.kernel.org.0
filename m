Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A421766B8
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCBWTT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:19:19 -0500
Received: from kadath.azazel.net ([81.187.231.250]:41500 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgCBWTT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MG/4Muke66DEE3195+EI6d+aJ1+1r8eHjC+yCa/YzfE=; b=YqEAHLlPb9fW10rg+9dzqeYR1D
        hENXkPV6X5ah/GvV/jWGeioemYhCAlMOwuQMp+pJ4yEhZrg7tpU8a6Dl9kUJ0Hph6odqkncwH410e
        zL5xClccbnbSYxjIERYd0I4THLx350mM7JnmhLrmgMNbzxhWXCqw1knso2GfLR3HLLgb09/xV6hiG
        l3900f8TvqaU2XeMXtkdPGjLvCJuW9OKDZwXn8Im93FshVqxVbCJNbdKzMfl2OqkRga3+xm0uvEda
        wodUbMwzEuNU7cP8Qwk2SWgz32bjTUYEDJv5qexnLIjlcv2kwthx2yJ8ZqxG60gh/DXZwq63QaHS7
        Y4YLwZgQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPB-0000Sg-6A; Mon, 02 Mar 2020 22:19:17 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 07/18] src: fix leaks.
Date:   Mon,  2 Mar 2020 22:19:05 +0000
Message-Id: <20200302221916.1005019-8-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302221916.1005019-1-jeremy@azazel.net>
References: <20200302221916.1005019-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Some bitmask variables are not cleared.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c            | 2 ++
 src/netlink_delinearize.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index f4260436ae0f..4a23b231c74d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -483,6 +483,7 @@ static void expr_evaluate_bits(struct eval_ctx *ctx, struct expr **exprp)
 	mask = constant_expr_alloc(&expr->location, expr_basetype(expr),
 				   BYTEORDER_HOST_ENDIAN, masklen, NULL);
 	mpz_set(mask->value, bitmask);
+	mpz_clear(bitmask);
 
 	and = binop_expr_alloc(&expr->location, OP_AND, expr, mask);
 	and->dtype	= expr->dtype;
@@ -2290,6 +2291,7 @@ static int stmt_evaluate_payload(struct eval_ctx *ctx, struct stmt *stmt)
 	mpz_export_data(data, bitmask, BYTEORDER_HOST_ENDIAN, sizeof(data));
 	mask = constant_expr_alloc(&payload->location, expr_basetype(payload),
 				   BYTEORDER_HOST_ENDIAN, masklen, data);
+	mpz_clear(bitmask);
 
 	payload_bytes = payload_expr_alloc(&payload->location, NULL, 0);
 	payload_init_raw(payload_bytes, payload->payload.base,
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 3c80895a43f9..79efda123c14 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2558,6 +2558,7 @@ static void stmt_payload_binop_postprocess(struct rule_pp_ctx *ctx)
 			mpz_init_bitmask(bitmask, payload->len);
 			mpz_xor(bitmask, bitmask, value->value);
 			mpz_set(value->value, bitmask);
+			mpz_clear(bitmask);
 			break;
 		case OP_OR: /* IIb */
 			break;
-- 
2.25.1

