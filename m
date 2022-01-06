Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10B486BA6
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Jan 2022 22:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiAFVKJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Jan 2022 16:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbiAFVKI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:10:08 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB41C06118A
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Jan 2022 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Arum/idBvBfgIv7O5VBzAzX691UPc6/AQlwnnX8SXbI=; b=lNJlmVvS1SWnb4JGGOwlJYKZPz
        cWXahqXzqF9fWXO2kK0EKAmPaM9WpSJVGiSG8VnoLpoOZPkAcPwGlVuhH9eVuWxiYuerNEr9mMkWI
        pdfu1ePWj/+LERjimzBdFpWVTiovberZ2ZdT+v1Nh8PTXMKzAYS8gG/PFrvaRPCBu21Hz/2eDZE0a
        3F+BDqX93tRVBpAr4MvHyKfh1NKGBK6ItjJglBIwEPytyQaQiFLAlVcRR2zOrAOcoTmDTrGjzyFpY
        BysDrvVeUZloeSpvczt2PjYtlUezqTh7tAQsYU2tN8TAWamI2iRlIQU10YJsMXsywfSwC4WecPFpO
        Q5B5Rrhg==;
Received: from ulthar.dreamlands ([192.168.96.2] helo=ulthar.dreamlands.azazel.net)
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1n5a1O-00H0N6-Am
        for netfilter-devel@vger.kernel.org; Thu, 06 Jan 2022 21:10:06 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH 05/10] build: use pkg-config for libpq if available
Date:   Thu,  6 Jan 2022 21:09:32 +0000
Message-Id: <20220106210937.1676554-6-jeremy@azazel.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106210937.1676554-1-jeremy@azazel.net>
References: <20220106210937.1676554-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Recent versions of postgresql have supported pkg-config.  Use pkg-config
if available, otherwise fall back to pg_config.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 acinclude.m4             | 95 ----------------------------------------
 configure.ac             | 33 ++++++++++++--
 output/pgsql/Makefile.am |  4 +-
 3 files changed, 31 insertions(+), 101 deletions(-)
 delete mode 100644 acinclude.m4

diff --git a/acinclude.m4 b/acinclude.m4
deleted file mode 100644
index 6d88c3a53cff..000000000000
--- a/acinclude.m4
+++ /dev/null
@@ -1,95 +0,0 @@
-dnl @synopsis CT_CHECK_POSTGRES_DB
-dnl
-dnl This macro tries to find the headers and libraries for the
-dnl PostgreSQL database to build client applications.
-dnl
-dnl If includes are found, the variable PQINCPATH will be set. If
-dnl libraries are found, the variable PQLIBPATH will be set. if no check
-dnl was successful, the script exits with a error message.
-dnl
-dnl @category InstalledPackages
-dnl @author Christian Toepp <c.toepp@gmail.com>
-dnl @version 2005-12-30
-dnl @license AllPermissive
-
-AC_DEFUN([CT_CHECK_POSTGRES_DB], [
-
-AC_ARG_WITH(pgsql,
-	[  --with-pgsql=PREFIX		Prefix of your PostgreSQL installation],
-	[pg_prefix=$withval], [pg_prefix=])
-AC_ARG_WITH(pgsql-inc,
-	[  --with-pgsql-inc=PATH		Path to the include directory of PostgreSQL],
-	[pg_inc=$withval], [pg_inc=])
-AC_ARG_WITH(pgsql-lib,
-	[  --with-pgsql-lib=PATH		Path to the libraries of PostgreSQL],
-	[pg_lib=$withval], [pg_lib=])
-
-
-AC_SUBST(PQINCPATH)
-AC_SUBST(PQLIBPATH)
-AC_SUBST(PQLIBS)
-PQLIBS=-lpq
-
-if test "$pg_prefix" != "no"; then
-
-AC_MSG_CHECKING([for PostgreSQL pg_config program])
-for d in $pg_prefix/bin /usr/bin /usr/local/bin /usr/local/pgsql/bin /opt/pgsql/bin /opt/packages/pgsql/bin
-do
-	if test -x $d/pg_config -a "$cross_compiling" = "no";
-	then
-		AC_MSG_RESULT(found pg_config in $d)
-		PQINCPATH=`$d/pg_config --includedir`
-		PQLIBPATH=`$d/pg_config --libdir`
-		break
-	fi
-done
-
-if test "$PQINCPATH" = ""; then
-   if test "$pg_prefix" != ""; then
-      AC_MSG_CHECKING([for PostgreSQL includes in $pg_prefix/include])
-      if test -f "$pg_prefix/include/libpq-fe.h" ; then
-         PQINCPATH="-I$pg_prefix/include"
-         AC_MSG_RESULT([yes])
-      else
-         AC_MSG_WARN(libpq-fe.h not found)
-      fi
-      AC_MSG_CHECKING([for PostgreSQL libraries in $pg_prefix/lib])
-      if test -f "$pg_prefix/lib/libpq.so" ; then
-         PQLIBPATH="-L$pg_prefix/lib"
-         AC_MSG_RESULT([yes])
-      else
-         AC_MSG_WARN(libpq.so not found)
-      fi
-   else
-     if test "$pg_inc" != ""; then
-       AC_MSG_CHECKING([for PostgreSQL includes in $pg_inc])
-       if test -f "$pg_inc/libpq-fe.h" ; then
-         PQINCPATH="-I$pg_inc"
-         AC_MSG_RESULT([yes])
-       else
-         AC_MSG_WARN(libpq-fe.h not found)
-       fi
-     fi
-     if test "$pg_lib" != ""; then
-       AC_MSG_CHECKING([for PostgreSQL libraries in $pg_lib])
-       if test -f "$pg_lib/libpq.so" ; then
-         PQLIBPATH="-L$pg_lib"
-         AC_MSG_RESULT([yes])
-       else
-         AC_MSG_WARN(libpq.so not found)
-       fi
-     fi
-   fi
-fi
-
-if test "$PQINCPATH" = "" ; then
-  AC_CHECK_HEADER([libpq-fe.h], [], AC_MSG_WARN(libpq-fe.h not found))
-fi
-if test "$PQLIBPATH" = "" ; then
-  AC_CHECK_LIB(pq, PQconnectdb, [], AC_MSG_WARN(libpq.so not found))
-fi
-
-fi
-
-])
-
diff --git a/configure.ac b/configure.ac
index bbca53e4c394..df6fa543e81f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,10 +80,35 @@ AM_CONDITIONAL([BUILD_NFACCT], [test "x$enable_nfacct" = "xyes"])
 
 AC_ARG_ENABLE([pgsql],
               [AS_HELP_STRING([--enable-pgsql], [Enable PostgreSQL output plugin [default=test]])])
-AS_IF([test "x$enable_pgsql" != "xno"],
-      [CT_CHECK_POSTGRES_DB()])
-AS_IF([test "x$PQLIBPATH" != "x"], [enable_pgsql=yes], [enable_pgsql=no])
-AM_CONDITIONAL([HAVE_PGSQL], [test "x$PQLIBPATH" != "x"])
+AS_IF([test "x$enable_pgsql" != "xno"], [
+
+  PKG_CHECK_EXISTS([libpq], [PKG_CHECK_MODULES([libpq], [libpq])], [
+
+    AC_ARG_WITH([pg_config],
+                [AS_HELP_STRING([--with-pg-config=PATH], [Path to the pg_config script])],
+                [pg_config="$withval"], [pg_config=pg_config])
+
+    AC_MSG_CHECKING([for pg_config])
+
+    AS_IF([command -v "$pg_config" >/dev/null], [
+
+      libpq_CFLAGS="`$pg_config --includedir`"
+      libpq_LIBS="`$pg_config --libdir` -lpq"
+
+      AC_SUBST([libpq_CFLAGS])
+      AC_SUBST([libpq_LIBS])
+
+      AC_MSG_RESULT([$pg_config])
+
+    ], [
+      AC_MSG_RESULT([no])
+    ])
+
+  ])
+
+])
+AS_IF([test "x$libpq_LIBS" != "x"], [enable_pgsql=yes], [enable_pgsql=no])
+AM_CONDITIONAL([HAVE_PGSQL], [test "x$libpq_LIBS" != "x"])
 
 AC_ARG_ENABLE([mysql],
               [AS_HELP_STRING([--enable-mysql], [Enable MySQL output plugin [default=test]])])
diff --git a/output/pgsql/Makefile.am b/output/pgsql/Makefile.am
index 9cdf22d7f765..c458c04900ba 100644
--- a/output/pgsql/Makefile.am
+++ b/output/pgsql/Makefile.am
@@ -1,9 +1,9 @@
 include $(top_srcdir)/Make_global.am
 
-AM_CPPFLAGS += -I$(PQINCPATH)
+AM_CPPFLAGS += -I$(libpq_CFLAGS)
 
 pkglib_LTLIBRARIES = ulogd_output_PGSQL.la
 
 ulogd_output_PGSQL_la_SOURCES = ulogd_output_PGSQL.c ../../util/db.c
-ulogd_output_PGSQL_la_LIBADD  = ${PQLIBS}
+ulogd_output_PGSQL_la_LIBADD  = $(libpq_LIBS)
 ulogd_output_PGSQL_la_LDFLAGS = -avoid-version -module
-- 
2.34.1

