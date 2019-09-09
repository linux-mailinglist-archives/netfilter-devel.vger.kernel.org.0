Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7DADFAE
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Sep 2019 21:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfIITw5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Sep 2019 15:52:57 -0400
Received: from mx1.riseup.net ([198.252.153.129]:58114 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfIITw5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:52:57 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 481801B947E
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Sep 2019 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1568058776; bh=4NJU0NiX1RfzpweZrybotXLI07B66xqKlCKNMCuCyCk=;
        h=From:To:Cc:Subject:Date:From;
        b=aobDDRa4qsjH68fGDRR9jLRc2C+mL+yAmEfpSeb32Dk9KarQ1NqJtQnFEF0OVBeSH
         rIzj+fRTWjmH6MxYLHKeMQM+xky8OIhK/XeqIwhQH75MvhKvRlOCw9qRQbXtawYTeU
         Pz3nDwF4bofzlWoblY0hVeanemkE2+EM4Qix7DsY=
X-Riseup-User-ID: 14BBBF6357A4985DDB5F6F34BFBCF33441A6049705C555636B83464938F1E041
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 64C33120A03;
        Mon,  9 Sep 2019 12:52:55 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nft] netlink_delinearize: fix wrong conversion to "list" in ct mark
Date:   Mon,  9 Sep 2019 21:52:47 +0200
Message-Id: <20190909195247.14535-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We only prefer "list" representation in "ct event". For any other type of "ct"
use the "or" representation so nft prints "ct mark set ct mark | 0x00000001"
instead of "ct mark set ct mark,0x00000001".

Link: https://bugzilla.netfilter.org/show_bug.cgi?id=1364
Fixes: cb8f81ac3079 ("netlink_delinearize: prefer ct event set foo,bar over 'set foo|bar'")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 src/netlink_delinearize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index fc2574b..f7d328a 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2550,7 +2550,8 @@ static void rule_parse_postprocess(struct netlink_parse_ctx *ctx, struct rule *r
 			if (stmt->ct.expr != NULL) {
 				expr_postprocess(&rctx, &stmt->ct.expr);
 
-				if (stmt->ct.expr->etype == EXPR_BINOP)
+				if (stmt->ct.expr->etype == EXPR_BINOP &&
+				    stmt->ct.key == NFT_CT_EVENTMASK)
 					stmt->ct.expr = binop_tree_to_list(NULL,
 									   stmt->ct.expr);
 			}
-- 
2.20.1

