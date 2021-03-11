Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301BA3373C5
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Mar 2021 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhCKNYe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Mar 2021 08:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhCKNYG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:24:06 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5FC061574
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Mar 2021 05:24:06 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lKLIK-0003hk-No; Thu, 11 Mar 2021 14:24:04 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 11/12] scanner: move until,over,used keywords away from init state
Date:   Thu, 11 Mar 2021 14:23:12 +0100
Message-Id: <20210311132313.24403-12-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210311132313.24403-1-fw@strlen.de>
References: <20210311132313.24403-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Only applicable for limit and quota. "ct count" also needs 'over'.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/scanner.l | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/scanner.l b/src/scanner.l
index e373ff848ba9..d09189ae4492 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -370,11 +370,13 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 	"rate"			{ return RATE; }
 	"burst"			{ return BURST; }
 }
-"until"			{ return UNTIL; }
-"over"			{ return OVER; }
+<SCANSTATE_CT,SCANSTATE_LIMIT,SCANSTATE_QUOTA>"over"		{ return OVER; }
 
 "quota"			{ scanner_push_start_cond(yyscanner, SCANSTATE_QUOTA); return QUOTA; }
-<SCANSTATE_QUOTA>"used"	{ return USED; }
+<SCANSTATE_QUOTA>{
+	"used"		{ return USED; }
+	"until"		{ return UNTIL; }
+}
 
 "second"		{ return SECOND; }
 "minute"		{ return MINUTE; }
-- 
2.26.2

