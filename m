Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9B488918
	for <lists+netfilter-devel@lfdr.de>; Sun,  9 Jan 2022 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiAIL6n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 9 Jan 2022 06:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiAIL6m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:58:42 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6FC061748
        for <netfilter-devel@vger.kernel.org>; Sun,  9 Jan 2022 03:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G0LXHGf3CQ8Cexshm5zFNPGcxJ1O7P46WjsBEjjPDu4=; b=X8Z7cOo0PHOapQhWV8lBaO/DGY
        jCjWnRUFmMR7C+x3FZzbryBUtyA37nCcc8Q53Kto3e6ikTyuaWoxctRIVxxMZ6toes1juQJyEhUa0
        sMIljBVktVxAJCKYn4oz4V+bEY13v+SSmTjFouagwx5a/m30oDKrdY535+IQ49N2jbJiwxqIgQ32n
        4KvfaapZzH0rlEEKtmfbWT+vGSD79/BSegftzF8STWqCSA1lMv1Vt5VWcp92lGg7DpZobcdUhG2T3
        h1bHS+CPXO3dn84mu/6Tn+px1rUJ/zZ+rV9kZmKTmdSl6FLzqpSGg4fsEhgasltMEi2qv+znpUdsD
        RMZvZBcw==;
Received: from ulthar.dreamlands ([192.168.96.2] helo=ulthar.dreamlands.azazel.net)
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1n6WqO-002BZm-Cx
        for netfilter-devel@vger.kernel.org; Sun, 09 Jan 2022 11:58:40 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v2 02/10] build: use pkg-config for libdbi
Date:   Sun,  9 Jan 2022 11:57:45 +0000
Message-Id: <20220109115753.1787915-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220109115753.1787915-1-jeremy@azazel.net>
References: <20220109115753.1787915-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

libdbi introduced pkg-config support in 0.9.0, which was released in
2013.  Use it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 acinclude.m4           | 84 ------------------------------------------
 configure.ac           |  6 +--
 output/dbi/Makefile.am |  4 +-
 3 files changed, 5 insertions(+), 89 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 8388c452aade..c7a1c67280f7 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -265,87 +265,3 @@ fi
 
 ])
 
-dnl @synopsis CT_CHECK_DBI
-dnl
-dnl This macro tries to find the headers and libraries for libdbi.
-dnl
-dnl If includes are found, the variable DBI_INC will be set. If
-dnl libraries are found, the variable DBI_LIB will be set. if no check
-dnl was successful, the script exits with a error message.
-dnl
-dnl @category InstalledPackages
-dnl @author Pierre Chifflier <chifflier@inl.fr>
-dnl @version 2008-10-30
-dnl @license AllPermissive
-
-AC_DEFUN([CT_CHECK_DBI], [
-
-AC_ARG_WITH(dbi,
-	[  --with-dbi=PREFIX		Prefix of your libdbi installation],
-	[dbi=$withval], [dbi_prefix=])
-AC_ARG_WITH(dbi-inc,
-	[  --with-dbi-inc=PATH		Path to the include directory of dbi],
-	[dbi_inc=$withval], [dbi_inc=/usr/include])
-AC_ARG_WITH(dbi-lib,
-	[  --with-dbi-lib=PATH		Path to the libraries of dbi],
-	[dbi_lib=$withval], [dbi_lib=/usr/lib])
-
-
-AC_SUBST(DBI_INC)
-AC_SUBST(DBI_LIB)
-
-if test "$dbi_prefix" != "no"; then
-
-if test "$dbi_prefix" != ""; then
-   AC_MSG_CHECKING([for libdbi includes in $dbi_prefix/include])
-   if test -f "$dbi_prefix/include/dbi.h" ; then
-      DBI_INC="-I$dbi_prefix/include"
-      AC_MSG_RESULT([yes])
-   elif test -f "$dbi_prefix/include/dbi/dbi.h" ; then
-      DBI_INC="-I$dbi_prefix/include/dbi"
-      AC_MSG_RESULT([yes])
-   else
-      AC_MSG_WARN(dbi.h not found)
-   fi
-   AC_MSG_CHECKING([for libdbi in $dbi_prefix/lib])
-   if test -f "$dbi_prefix/lib/libdbi.so" ; then
-      DBI_LIB="-L$dbi_prefix/lib -ldbi";
-      AC_MSG_RESULT([yes])
-   else
-      AC_MSG_WARN(libdbi.so not found)
-   fi
-else
-  if test "$dbi_inc" != ""; then
-    AC_MSG_CHECKING([for libdbi includes in $dbi_inc])
-    if test -f "$dbi_inc/dbi.h" ; then
-      DBI_INC="-I$dbi_inc"
-      AC_MSG_RESULT([yes])
-    elif test -f "$dbi_inc/dbi/dbi.h" ; then
-      DBI_INC="-I$dbi_inc/dbi"
-      AC_MSG_RESULT([yes])
-    else
-      AC_MSG_WARN(dbi.h not found)
-    fi
-  fi
-  if test "$dbi_lib" != ""; then
-    AC_MSG_CHECKING([for libdbi in $dbi_lib])
-    if test -f "$dbi_lib/libdbi.so" ; then
-      DBI_LIB="-L$dbi_lib -ldbi";
-      AC_MSG_RESULT([yes])
-    else
-      AC_MSG_WARN(libdbi.so not found)
-    fi
-  fi
-fi
-
-if test "$DBI_INC" = "" ; then
-  AC_CHECK_HEADER([dbi.h], [], AC_MSG_WARN(dbi.h not found))
-fi
-if test "$DBI_LIB" = "" ; then
-  AC_CHECK_LIB(dbi, dbi_close, [], AC_MSG_WARN(libdbi.so not found))
-fi
-
-fi
-
-])
-
diff --git a/configure.ac b/configure.ac
index b24357dcd4b4..a3ad198a1d33 100644
--- a/configure.ac
+++ b/configure.ac
@@ -102,9 +102,9 @@ AM_CONDITIONAL([HAVE_SQLITE3], [test "x$libsqlite3_LIBS" != "x"])
 AC_ARG_ENABLE([dbi],
               [AS_HELP_STRING([--enable-dbi], [Enable DBI output plugin [default=test]])])
 AS_IF([test "x$enable_dbi" != "xno"],
-      [CT_CHECK_DBI()])
-AS_IF([test "x$DBI_LIB" != "x"], [enable_dbi=yes], [enable_dbi=no])
-AM_CONDITIONAL(HAVE_DBI, [test "x$DBI_LIB" != "x"])
+      [PKG_CHECK_MODULES([libdbi], [dbi], [], [:])])
+AS_IF([test "x$libdbi_LIBS" != "x"], [enable_dbi=yes], [enable_dbi=no])
+AM_CONDITIONAL([HAVE_DBI], [test "x$libdbi_LIBS" != "x"])
 
 AC_ARG_ENABLE([pcap],
               [AS_HELP_STRING([--enable-pcap], [Enable PCAP output plugin [default=test]])])
diff --git a/output/dbi/Makefile.am b/output/dbi/Makefile.am
index f8b0a9c68c78..9a618b160559 100644
--- a/output/dbi/Makefile.am
+++ b/output/dbi/Makefile.am
@@ -1,9 +1,9 @@
 include $(top_srcdir)/Make_global.am
 
-AM_CPPFLAGS += $(DBI_INC)
+AM_CPPFLAGS += $(libdbi_CFLAGS)
 
 pkglib_LTLIBRARIES = ulogd_output_DBI.la
 
 ulogd_output_DBI_la_SOURCES = ulogd_output_DBI.c ../../util/db.c
-ulogd_output_DBI_la_LIBADD  = ${DBI_LIB}
+ulogd_output_DBI_la_LIBADD  = $(libdbi_LIBS)
 ulogd_output_DBI_la_LDFLAGS = -avoid-version -module
-- 
2.34.1

