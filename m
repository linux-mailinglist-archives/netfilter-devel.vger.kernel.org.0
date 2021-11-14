Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C024C44F8D6
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Nov 2021 16:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhKNPzk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Nov 2021 10:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhKNPzh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Nov 2021 10:55:37 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B2C061200
        for <netfilter-devel@vger.kernel.org>; Sun, 14 Nov 2021 07:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k54GslsH3dC8WO0RY5sBihWZReT/GhxI5aCMg46cg98=; b=K4dHoJORZJ250GvZJWMSPJF1KY
        ySmy+XLqOrH01WhKo9n63lW3UZ01+i2vIXXn1Fz9b05quU27o9Rv0ECpCSY1sod5vI+Xw10Dy9LMt
        khNq3Pn43Oc9JZMf/v285dt/OWC7RYjJUORZ3sUuAf0DmPIRAlIvRyjKXOFuLeQnqZtF3ZjKCSeOJ
        +i3AU8JRsaC4PxwNUo3Roh3lJpGzGS4U3nTpPBvWwnHsT7/SOohBbLjzqsN1eYfDju2sSvnn64tE6
        uEqKeueLwMIIFytGUh0TUGVmpChBsnGwIF5cpSfr3Ivn/tQMDqMckJz3aGrWNrNbTWXsLtf1lKlWM
        LBCkSXMQ==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mmHo8-00CfJ1-Nm
        for netfilter-devel@vger.kernel.org; Sun, 14 Nov 2021 15:52:40 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v4 03/15] build: remove unused Makefile fragment
Date:   Sun, 14 Nov 2021 15:52:19 +0000
Message-Id: <20211114155231.793594-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211114155231.793594-1-jeremy@azazel.net>
References: <20211114155231.793594-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rules.make.in contains a number of variables defined by configure.  It
is left-over from the pre-Automake build-system, in which it used to
fill a similar role to Make_global.am.  It is no longer used anywhere.
Remove it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 .gitignore    |  1 -
 Rules.make.in | 43 -------------------------------------------
 configure.ac  |  2 +-
 3 files changed, 1 insertion(+), 45 deletions(-)
 delete mode 100644 Rules.make.in

diff --git a/.gitignore b/.gitignore
index 3eb592245c0d..5c06684db5fb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,7 +12,6 @@ Makefile
 Makefile.in
 
 # this dir
-/Rules.make
 /ulogd.conf
 
 # build system
diff --git a/Rules.make.in b/Rules.make.in
deleted file mode 100644
index 21b05d9ca6ff..000000000000
--- a/Rules.make.in
+++ /dev/null
@@ -1,43 +0,0 @@
-#
-
-PREFIX=@prefix@
-exec_prefix=@exec_prefix@
-ETCDIR=@sysconfdir@
-BINDIR=@sbindir@
-
-ULOGD_CONFIGFILE=@sysconfdir@/ulogd.conf
-
-ULOGD_LIB_PATH=@libdir@/ulogd
-
-# Path of libipulog (from iptables)
-LIBIPULOG=@top_srcdir@/libipulog
-INCIPULOG=-I@top_srcdir@/libipulog/include
-INCCONFFILE=-I@top_srcdir@/conffile
-
-CC=@CC@
-LD=@LD@
-INSTALL=@INSTALL@
-
-CFLAGS=@CFLAGS@ @CPPFLAGS@ -Wall
-CFLAGS+=-DULOGD_CONFIGFILE=\"$(ULOGD_CONFIGFILE)\"
-# doesn't work for subdirs
-#CFLAGS+=$(INCIPULOG) $(INCCONFFILE)
-CFLAGS+=-I/lib/modules/`uname -r`/build/include
-#CFLAGS+=@DEFS@
-#CFLAGS+=-g -DDEBUG -DDEBUG_MYSQL -DDEBUG_PGSQL
-
-LIBS=@LIBS@
-
-
-# Names of the plugins to be compiled
-ULOGD_SL:=BASE OPRINT PWSNIFF LOGEMU LOCAL SYSLOG
-
-# mysql output support
-#ULOGD_SL+=MYSQL
-MYSQL_CFLAGS=-I@MYSQLINCLUDES@ @EXTRA_MYSQL_DEF@
-MYSQL_LDFLAGS=@DATABASE_LIB_DIR@ @MYSQL_LIB@
-
-# postgreSQL output support
-#ULOGD_SL+=PGSQL
-PGSQL_CFLAGS=-I@PGSQLINCLUDES@ @EXTRA_PGSQL_DEF@
-PGSQL_LDFLAGS=@DATABASE_LIB_DIR@ @PGSQL_LIB@
diff --git a/configure.ac b/configure.ac
index 48b4995f148c..e341ad12a159 100644
--- a/configure.ac
+++ b/configure.ac
@@ -180,7 +180,7 @@ AC_CONFIG_FILES(include/Makefile include/ulogd/Makefile include/libipulog/Makefi
 	  filter/Makefile filter/raw2packet/Makefile filter/packet2flow/Makefile \
 	  output/Makefile output/pcap/Makefile output/mysql/Makefile output/pgsql/Makefile output/sqlite3/Makefile \
 	  output/dbi/Makefile output/ipfix/Makefile \
-	  src/Makefile Makefile Rules.make)
+	  src/Makefile Makefile)
 AC_OUTPUT
 
 define([EXPAND_VARIABLE],
-- 
2.33.0

