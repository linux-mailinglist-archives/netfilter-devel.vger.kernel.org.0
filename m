Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0E1F06EB
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgFFOOx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFOOw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:14:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CCFC03E96A
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2020 07:14:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jhZaz-0001Ne-R1; Sat, 06 Jun 2020 16:14:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH lnf-queue] configure: add --with/without-doxygen switch
Date:   Sat,  6 Jun 2020 16:14:44 +0200
Message-Id: <20200606141444.69372-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Allows to turn off doxygen even if its installed, via
--without-doxygen.

Default is to probe for doxygen presence (--with-doxygen).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 configure.ac | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 95ee82ab39b7..8960fd8046a7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,12 +36,17 @@ AC_CONFIG_FILES([Makefile src/Makefile utils/Makefile examples/Makefile
 	doxygen/Makefile
 	include/linux/Makefile include/linux/netfilter/Makefile])
 
-dnl Only run doxygen Makefile if doxygen installed
+AC_ARG_WITH([doxygen], [AS_HELP_STRING([--with-doxygen],
+            [create doxygen documentation])],
+	    [with_doxygen="$withval"], [with_doxygen=yes])
 
-AC_CHECK_PROGS([DOXYGEN], [doxygen])
-if test -z "$DOXYGEN";
-	then AC_MSG_WARN([Doxygen not found - continuing without Doxygen support])
-fi
+AS_IF([test "x$with_doxygen" != xno], [
+       AC_CHECK_PROGS([DOXYGEN], [doxygen])
+])
 
 AM_CONDITIONAL([HAVE_DOXYGEN], [test -n "$DOXYGEN"])
+if test -z "$DOXYGEN"; then
+	dnl Only run doxygen Makefile if doxygen installed
+	AC_MSG_WARN([Doxygen not found - continuing without Doxygen support])
+fi
 AC_OUTPUT
-- 
2.26.2

