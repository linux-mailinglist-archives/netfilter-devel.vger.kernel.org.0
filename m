Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B49FF1772FA
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2020 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgCCJsu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Mar 2020 04:48:50 -0500
Received: from kadath.azazel.net ([81.187.231.250]:40822 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgCCJsr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aJCaxnk5yr8w2LMhJBk36taEfKEfTYvApVy7O8oGFy8=; b=eAhnOMcsGxWOFtwlr48hgY457H
        NuYMDjU8vZaTy/5Y29J5eN5h/Q+msacGucK0UG+OzRAxcZNfmS5zQpDlGdB//KEEDffrAgggq8n/1
        8Jfulmz3qgPzUkarB2bOpKuYu00F3LA+Nw+yLSMlYu/zjvnqSuUqnyIax0NJEJQaJiHON7gTX33Af
        0+0phScGy9vUkAdnBSNXOOBf7NuawZLboDr5WNq81126ebfsq2PPcefZbd8ytV4pivGphFkC11ZnV
        dkMKwRua5EqJjbdVZBAORKpBKkwmmtMvI7rl0kIE/onksG3GC3ocGyHYtUPZU7Y41l/vYpQXxsAyi
        UlkJcpRA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j94AP-00081M-Gd; Tue, 03 Mar 2020 09:48:45 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v3 05/18] evaluate: no need to swap byte-order for values of fewer than 16 bits.
Date:   Tue,  3 Mar 2020 09:48:31 +0000
Message-Id: <20200303094844.26694-6-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303094844.26694-1-jeremy@azazel.net>
References: <20200303094844.26694-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Endianness is not meaningful for objects smaller than 2 bytes and the
byte-order conversions are no-ops in the kernel, so just update the
expression as if it were constant.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c              | 2 +-
 tests/py/any/meta.t.payload | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 9b1a04f26f44..f4260436ae0f 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -147,7 +147,7 @@ static int byteorder_conversion(struct eval_ctx *ctx, struct expr **expr,
 				  byteorder_names[byteorder],
 				  byteorder_names[(*expr)->byteorder]);
 
-	if (expr_is_constant(*expr))
+	if (expr_is_constant(*expr) || (*expr)->len / BITS_PER_BYTE < 2)
 		(*expr)->byteorder = byteorder;
 	else {
 		op = byteorder_conversion_op(*expr, byteorder);
diff --git a/tests/py/any/meta.t.payload b/tests/py/any/meta.t.payload
index 486d7aa566ea..2af244a9e246 100644
--- a/tests/py/any/meta.t.payload
+++ b/tests/py/any/meta.t.payload
@@ -99,14 +99,12 @@ ip test-ip4 input
 # meta l4proto 33-45
 ip test-ip4 input
   [ meta load l4proto => reg 1 ]
-  [ byteorder reg 1 = hton(reg 1, 2, 1) ]
   [ cmp gte reg 1 0x00000021 ]
   [ cmp lte reg 1 0x0000002d ]
 
 # meta l4proto != 33-45
 ip test-ip4 input
   [ meta load l4proto => reg 1 ]
-  [ byteorder reg 1 = hton(reg 1, 2, 1) ]
   [ range neq reg 1 0x00000021 0x0000002d ]
 
 # meta l4proto { 33, 55, 67, 88}
@@ -865,7 +863,6 @@ __set%d test-ip4 0
 	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]	element 00000042  : 0 [end]	element 00000059  : 1 [end]
 ip test-ip4 input 
   [ meta load l4proto => reg 1 ]
-  [ byteorder reg 1 = hton(reg 1, 2, 1) ]
   [ lookup reg 1 set __set%d ]
 
 # meta l4proto != { 33-55, 66-88}
@@ -874,7 +871,6 @@ __set%d test-ip4 0
 	element 00000000  : 1 [end]	element 00000021  : 0 [end]	element 00000038  : 1 [end]	element 00000042  : 0 [end]	element 00000059  : 1 [end]
 ip test-ip4 input 
   [ meta load l4proto => reg 1 ]
-  [ byteorder reg 1 = hton(reg 1, 2, 1) ]
   [ lookup reg 1 set __set%d 0x1 ]
 
 # meta skuid { 2001-2005, 3001-3005} accept
-- 
2.25.1

