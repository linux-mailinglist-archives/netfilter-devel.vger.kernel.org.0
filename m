Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A81136D33
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgAJMiJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 07:38:09 -0500
Received: from kadath.azazel.net ([81.187.231.250]:39862 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgAJMiI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9J6vMRqXwsp855kEhNzUy8m+HTiK0YbTGvnaOBpsjMI=; b=oq6wdh6kgEdW38HewQSapeUbuZ
        TRuiEKoIbCwJ9BPq7KYIYk4TshWyN0c5LL346Yud++5f08y0y453sxnOD4V2O2Z006RNx2buEa8Ov
        VyY2l9opgnKkFw3QNiCHwzU7heDXyW0Io4mi4lHF7G3PEG9tIMGtir9XSzJ5fy0h21pqf1wzLKhBL
        p6MxdRpaG8l4AxWA5BAXsgjIe9qYVoiC8rU463DUGCukYABpxZVcvDKeSEApPZ/28foiFeBbuPqTC
        5F0qOgYbzlHBY0y2hzM1b2T6mvAzI4kj6SxQXLnZcBcdSoZIBWGjyn1Ceoamwj2cd45bwJoLlaR2H
        QavP9nZg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1iptYF-0003im-Av
        for netfilter-devel@vger.kernel.org; Fri, 10 Jan 2020 12:38:07 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 5/7] parser: add parenthesized statement expressions.
Date:   Fri, 10 Jan 2020 12:38:04 +0000
Message-Id: <20200110123806.106546-6-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110123806.106546-1-jeremy@azazel.net>
References: <20200110123806.106546-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Primary and primary RHS expressions support parenthesized basic and
basic RHS expressions.  However, primary statement expressions do not
support parenthesized basic statement expressions.  Add them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/parser_bison.y | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 799f7a308b07..45cc013cfe28 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2992,18 +2992,19 @@ synproxy_sack		:	/* empty */	{ $$ = 0; }
 			}
 			;
 
-primary_stmt_expr	:	symbol_expr		{ $$ = $1; }
-			|	integer_expr		{ $$ = $1; }
-			|	boolean_expr		{ $$ = $1; }
-			|	meta_expr		{ $$ = $1; }
-			|	rt_expr			{ $$ = $1; }
-			|	ct_expr			{ $$ = $1; }
-			|	numgen_expr             { $$ = $1; }
-			|	hash_expr               { $$ = $1; }
-			|	payload_expr		{ $$ = $1; }
-			|	keyword_expr		{ $$ = $1; }
-			|	socket_expr		{ $$ = $1; }
-			|	osf_expr		{ $$ = $1; }
+primary_stmt_expr	:	symbol_expr			{ $$ = $1; }
+			|	integer_expr			{ $$ = $1; }
+			|	boolean_expr			{ $$ = $1; }
+			|	meta_expr			{ $$ = $1; }
+			|	rt_expr				{ $$ = $1; }
+			|	ct_expr				{ $$ = $1; }
+			|	numgen_expr             	{ $$ = $1; }
+			|	hash_expr               	{ $$ = $1; }
+			|	payload_expr			{ $$ = $1; }
+			|	keyword_expr			{ $$ = $1; }
+			|	socket_expr			{ $$ = $1; }
+			|	osf_expr			{ $$ = $1; }
+			|	'('	basic_stmt_expr	')'	{ $$ = $2; }
 			;
 
 shift_stmt_expr		:	primary_stmt_expr
-- 
2.24.1

