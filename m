Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29C64FE501
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfKOSiY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 13:38:24 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:55622 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOSiX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:38:23 -0500
Received: from localhost ([::1]:40480 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iVgU9-00069A-M5; Fri, 15 Nov 2019 19:38:21 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] scanner: Introduce numberstring
Date:   Fri, 15 Nov 2019 19:38:13 +0100
Message-Id: <20191115183813.25085-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This token combines decstring and hexstring. The latter two had
identical action blocks (which were not completely trivial), this allows
to merge them.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/scanner.l | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/src/scanner.l b/src/scanner.l
index 3de5a9e0426e6..80b5a5f0dafcf 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -116,6 +116,7 @@ digit		[0-9]
 hexdigit	[0-9a-fA-F]
 decstring	{digit}+
 hexstring	0[xX]{hexdigit}+
+numberstring	({decstring}|{hexstring})
 letter		[a-zA-Z]
 string		({letter}|[_.])({letter}|{digit}|[/\-_\.])*
 quotedstring	\"[^"]*\"
@@ -608,17 +609,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 				return STRING;
 			}
 
-{decstring}		{
-				errno = 0;
-				yylval->val = strtoull(yytext, NULL, 0);
-				if (errno != 0) {
-					yylval->string = xstrdup(yytext);
-					return STRING;
-				}
-				return NUM;
-			}
-
-{hexstring}		{
+{numberstring}		{
 				errno = 0;
 				yylval->val = strtoull(yytext, NULL, 0);
 				if (errno != 0) {
-- 
2.24.0

