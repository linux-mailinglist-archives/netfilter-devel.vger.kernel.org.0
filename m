Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7916F068
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGTSwh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 14:52:37 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41196 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfGTSwg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:52:36 -0400
Received: from localhost ([::1]:54286 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1houTD-00070Y-3S; Sat, 20 Jul 2019 20:52:35 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/2] parser_bison: Get rid of (most) bison compiler warnings
Date:   Sat, 20 Jul 2019 20:52:25 +0200
Message-Id: <20190720185226.8876-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Shut the complaints about POSIX incompatibility by passing -Wno-yacc to
bison. An alternative would be to not pass -y, but that caused seemingly
unsolveable problems with automake and expected file names.

Fix two warnings about deprecated '%pure-parser' and '%error-verbose'
statements by replacing them with what bison suggests.

A third warning sadly left in place: Replacing '%name-prefix' by what
is suggested leads to compilation errors.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/Makefile.am    | 2 +-
 src/parser_bison.y | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index e2b531390cefb..740c21f2cac85 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -22,7 +22,7 @@ AM_CFLAGS = -Wall								\
 	    -Waggregate-return -Wunused -Wwrite-strings ${GCC_FVISIBILITY_HIDDEN}
 
 
-AM_YFLAGS = -d
+AM_YFLAGS = -d -Wno-yacc
 
 BUILT_SOURCES = parser_bison.h
 
diff --git a/src/parser_bison.y b/src/parser_bison.y
index c90de47e88f74..12e499b4dd025 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -116,12 +116,12 @@ int nft_lex(void *, void *, void *);
 
 %name-prefix "nft_"
 %debug
-%pure-parser
+%define api.pure
 %parse-param		{ struct nft_ctx *nft }
 %parse-param		{ void *scanner }
 %parse-param		{ struct parser_state *state }
 %lex-param		{ scanner }
-%error-verbose
+%define parse.error verbose
 %locations
 
 %initial-action {
-- 
2.22.0

