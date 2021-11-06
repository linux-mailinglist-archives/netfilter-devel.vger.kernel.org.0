Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2F446F0A
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Nov 2021 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhKFQr0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Nov 2021 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhKFQr0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Nov 2021 12:47:26 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646FC061570
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Nov 2021 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=echW/htfqBAj89aalY2vvFeI/uRfsLq4Nwrn2U4/CYQ=; b=cLHkquqKMJBw9m7cv9FFG9TVQb
        gsk/wEiSR9HpgnNNhVU4v861F/MJNKPY0KarSYlWySiP32a3dozy3V/zmzOdeBanZ85R9holggu+N
        6Slyniambm1f6m/F9jEEB5No1T9YLs2inyA1DalMfcfpj1u/9cM2Ts2oaGdIPW/NiaTqYGG0XqWPe
        dOwPXlDAriIKCpKXJjVRs9fzztKK5baNaxByJgJNWU6KPk3im8JVTcaz3LpeL6EYcOTVQ/POp+tuL
        BVfXc5kcCc8PKJOH9ejLDoI7JxRmbQozikzDJXe6sLeRmUEplkD6VaBAg6ZdN38VUo1/CC4Ud4BtN
        /Sd+mzFQ==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mjOOR-004loO-AN
        for netfilter-devel@vger.kernel.org; Sat, 06 Nov 2021 16:18:11 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v2 11/12] build: quote and reformat some autoconf macro arguments
Date:   Sat,  6 Nov 2021 16:17:58 +0000
Message-Id: <20211106161759.128364-12-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211106161759.128364-1-jeremy@azazel.net>
References: <20211106161759.128364-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 configure.ac | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/configure.ac b/configure.ac
index b88c7a6d7708..d52025fd549c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,7 +22,7 @@ AC_SUBST([libdl_LIBS])
 
 dnl Checks for header files.
 AC_HEADER_DIRENT
-AC_CHECK_HEADERS(fcntl.h unistd.h)
+AC_CHECK_HEADERS([fcntl.h unistd.h])
 
 dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
@@ -32,7 +32,7 @@ AC_SYS_LARGEFILE
 
 dnl Checks for library functions.
 AC_FUNC_VPRINTF
-AC_CHECK_FUNCS(socket strerror)
+AC_CHECK_FUNCS([socket strerror])
 
 AC_SEARCH_LIBS([pthread_create], [pthread], [libpthread_LIBS="$LIBS"; LIBS=""])
 AC_SUBST([libpthread_LIBS])
@@ -155,27 +155,29 @@ AC_ARG_WITH([ulogd2libdir],
         [ulogd2libdir="${libdir}/ulogd"])
 AC_SUBST([ulogd2libdir])
 
-dnl AC_SUBST(DATABASE_DIR)
-dnl AC_SUBST(DATABASE_LIB)
-dnl AC_SUBST(DATABASE_LIB_DIR)
-dnl AC_SUBST(DB_DEF)
-dnl AC_SUBST(EXTRA_MYSQL_DEF)
-dnl AC_SUBST(EXTRA_PGSQL_DEF)
-
-dnl AC_SUBST(DATABASE_DRIVERS)
-
-dnl AM_CONDITIONAL(HAVE_MYSQL, test x$mysqldir != x)
-dnl AM_CONDITIONAL(HAVE_PGSQL, test x$pgsqldir != x)
-
-AC_CONFIG_FILES(include/Makefile include/ulogd/Makefile include/libipulog/Makefile \
-	  include/linux/Makefile include/linux/netfilter/Makefile \
-	  include/linux/netfilter_ipv4/Makefile libipulog/Makefile \
-	  input/Makefile input/packet/Makefile input/flow/Makefile \
-	  input/sum/Makefile \
-	  filter/Makefile filter/raw2packet/Makefile \
-	  output/Makefile output/pcap/Makefile output/mysql/Makefile output/pgsql/Makefile output/sqlite3/Makefile \
-	  output/dbi/Makefile output/ipfix/Makefile \
-	  src/Makefile Makefile)
+AC_CONFIG_FILES([include/Makefile
+		 include/ulogd/Makefile
+		 include/libipulog/Makefile
+		 include/linux/Makefile
+		 include/linux/netfilter/Makefile
+		 include/linux/netfilter_ipv4/Makefile
+		 libipulog/Makefile
+		 input/Makefile
+		 input/packet/Makefile
+		 input/flow/Makefile
+		 input/sum/Makefile
+		 filter/Makefile
+		 filter/raw2packet/Makefile
+		 output/Makefile
+		 output/pcap/Makefile
+		 output/mysql/Makefile
+		 output/pgsql/Makefile
+		 output/sqlite3/Makefile
+		 output/dbi/Makefile
+		 output/ipfix/Makefile
+		 src/Makefile
+		 Makefile])
+
 AC_OUTPUT
 
 define([EXPAND_VARIABLE],
-- 
2.33.0

