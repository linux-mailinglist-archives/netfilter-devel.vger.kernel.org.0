Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C1A142F89
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jan 2020 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgATQ0A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jan 2020 11:26:00 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60808 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgATQ0A (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:26:00 -0500
Received: from localhost ([::1]:45666 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1itZsF-00063P-G9; Mon, 20 Jan 2020 17:25:59 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/4] netlink: Fix leak in unterminated string deserializer
Date:   Mon, 20 Jan 2020 17:25:37 +0100
Message-Id: <20200120162540.9699-2-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120162540.9699-1-phil@nwl.cc>
References: <20200120162540.9699-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Allocated 'mask' expression is not freed before returning to caller,
although it is used temporarily only.

Fixes: b851ba4731d9f ("src: add interface wildcard matching")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_delinearize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 154353b8161a0..06a0312b9921a 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2030,7 +2030,7 @@ static bool __expr_postprocess_string(struct expr **exprp)
 
 static struct expr *expr_postprocess_string(struct expr *expr)
 {
-	struct expr *mask;
+	struct expr *mask, *out;
 
 	assert(expr_basetype(expr)->type == TYPE_STRING);
 	if (__expr_postprocess_string(&expr))
@@ -2040,7 +2040,9 @@ static struct expr *expr_postprocess_string(struct expr *expr)
 				   BYTEORDER_HOST_ENDIAN,
 				   expr->len + BITS_PER_BYTE, NULL);
 	mpz_init_bitmask(mask->value, expr->len);
-	return string_wildcard_expr_alloc(&expr->location, mask, expr);
+	out = string_wildcard_expr_alloc(&expr->location, mask, expr);
+	expr_free(mask);
+	return out;
 }
 
 static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
-- 
2.24.1

