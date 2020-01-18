Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9634A1419D1
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 22:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgARVXV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 16:23:21 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55192 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgARVXV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=P8twnjR945anPShsIuTsyYo9nyaxdwzvOWiJZmyWD7k=; b=EwY3ME8gVQagvFDCuvU+/onHIH
        AJZUb0vz/0RyVJumMlIzjHXDSz52Nu5xMHGn2X7FU1HuaCNTCL4SPy6rhMYorUTbRdYWwnNPFy6TJ
        5fjrE3UUmPFVChZynbTLW3MisubmOBkDndWi/AshUuzOx6HkTdx+tLPYAzFztdwniOu+GKpnxcOZA
        SmQA8rHmRjCZsHnncpLIROCOYT9kBLWInkugtAF8FhXRUJyo/RvKllfWaupJX0y7e/XI3ZTa084tY
        Tspcep+NsxGoQNt1FoD8qUvSn/MwtHxRONTYEGOrHBJMrbVUzudpVxssJM+WMEKD8uW3M95Fn1vm7
        Y6vuCwJw==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1isvYt-0006Ji-Uo
        for netfilter-devel@vger.kernel.org; Sat, 18 Jan 2020 21:23:20 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 6/9] evaluate: change shift byte-order to host-endian.
Date:   Sat, 18 Jan 2020 21:23:16 +0000
Message-Id: <20200118212319.253112-7-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118212319.253112-1-jeremy@azazel.net>
References: <20200118212319.253112-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The byte-order of the righthand operands of the right-shifts generated
for payload and exthdr expressions is big-endian.  However, all right
shift operands should be host-endian.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 09dd493f0757..658f3d77990d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -487,7 +487,7 @@ static void expr_evaluate_bits(struct eval_ctx *ctx, struct expr **exprp)
 	if (shift) {
 		off = constant_expr_alloc(&expr->location,
 					  expr_basetype(expr),
-					  BYTEORDER_BIG_ENDIAN,
+					  BYTEORDER_HOST_ENDIAN,
 					  sizeof(shift), &shift);
 
 		lshift = binop_expr_alloc(&expr->location, OP_RSHIFT, and, off);
-- 
2.24.1

