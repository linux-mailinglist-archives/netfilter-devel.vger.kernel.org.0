Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658751F06F2
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFFOZO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 10:25:14 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:50912 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbgFFOZN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:25:13 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail109.syd.optusnet.com.au (Postfix) with SMTP id 7297FD7960D
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 00:25:11 +1000 (AEST)
Received: (qmail 6953 invoked by uid 501); 6 Jun 2020 14:25:08 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     fw@strlen.de, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue v2 1/1] build: dist: Add fixmanpages.sh to distribution tree
Date:   Sun,  7 Jun 2020 00:25:08 +1000
Message-Id: <20200606142508.6906-2-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200606142508.6906-1-duncan_roe@optusnet.com.au>
References: <20200606142508.6906-1-duncan_roe@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=nTHF0DUjJn0A:10 a=RSmzAf-M6YYA:10 a=PO7r1zJSAAAA:8
        a=-hZqD4WVWLorXeaqBCcA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Also move fixmanpages.sh into the doxygen directory

Tested by running Slackware package builder on libnetfilter_queue-1.0.4.tar.bz2
created by 'make dist' after applying the patch. Works now, failed before.

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 Makefile.am                              | 1 +
 doxygen/Makefile.am                      | 4 ++--
 fixmanpages.sh => doxygen/fixmanpages.sh | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
 rename fixmanpages.sh => doxygen/fixmanpages.sh (99%)

diff --git a/Makefile.am b/Makefile.am
index a5b347b..7d3bf23 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -10,3 +10,4 @@ pkgconfigdir = $(libdir)/pkgconfig
 pkgconfig_DATA = libnetfilter_queue.pc
 
 EXTRA_DIST += Make_global.am
+EXTRA_DIST += doxygen/fixmanpages.sh
diff --git a/doxygen/Makefile.am b/doxygen/Makefile.am
index ef468e0..a4db804 100644
--- a/doxygen/Makefile.am
+++ b/doxygen/Makefile.am
@@ -8,8 +8,8 @@ doc_srcs = $(top_srcdir)/src/libnetfilter_queue.c  \
            $(top_srcdir)/src/extra/udp.c           \
            $(top_srcdir)/src/extra/pktbuff.c
 
-doxyfile.stamp: $(doc_srcs) $(top_srcdir)/fixmanpages.sh
-	rm -rf html man && cd .. && doxygen doxygen.cfg && ./fixmanpages.sh
+doxyfile.stamp: $(doc_srcs) fixmanpages.sh
+	rm -rf html man && (cd .. && doxygen doxygen.cfg) && ./fixmanpages.sh
 	touch doxyfile.stamp
 
 CLEANFILES = doxyfile.stamp
diff --git a/fixmanpages.sh b/doxygen/fixmanpages.sh
similarity index 99%
rename from fixmanpages.sh
rename to doxygen/fixmanpages.sh
index dd8b3a4..38e97ba 100755
--- a/fixmanpages.sh
+++ b/doxygen/fixmanpages.sh
@@ -3,7 +3,7 @@
 function main
 {
   set -e
-  cd doxygen/man/man3
+  cd man/man3
   rm -f _*
   setgroup LibrarySetup nfq_open
     add2group nfq_close nfq_bind_pf nfq_unbind_pf
-- 
2.14.5

