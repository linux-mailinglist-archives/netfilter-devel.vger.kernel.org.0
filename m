Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9944F8F5
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Nov 2021 17:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhKNQRu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Nov 2021 11:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhKNQRt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:17:49 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37870C061746
        for <netfilter-devel@vger.kernel.org>; Sun, 14 Nov 2021 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HDP4SjxU0kCmurGd10UZSN1mDDgmjYOPKCd3IzqCUxA=; b=smCdD/EZBQggFA7PgRt1FbnpTf
        YJ9bk0jJ1GJoIVlfTKFExwzGN2gNtzoQnUXQSAPYpyeNRhbcoV7UTVxhiL7vvs6Oxro6gRFF2D7g+
        DNsgelEt5exGhKn8M1vJt/SR6fAJacetL83h5jJEpTqZ82DaWIvD2hT8FF/7wRnjN7VrLWZSEklc/
        monfZFHP87Pus7wAs06wZsuc/Pp0DYmEebvLj4VO88LoGic6o0POx52vpxGXWvcOHObiUj4FlWo5a
        Yv6qvGhzCLhejOZkg24EyzgiAWbT8EEEZnVOr5lLDI4rWL/ujyIf3Sa2AwdXiQ51iZ5/uc7ICjFRv
        /RmEseYw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mmHo9-00CfJ1-Tb
        for netfilter-devel@vger.kernel.org; Sun, 14 Nov 2021 15:52:41 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v4 15/15] build: use `AS_IF` consistently in configure.ac
Date:   Sun, 14 Nov 2021 15:52:31 +0000
Message-Id: <20211114155231.793594-16-jeremy@azazel.net>
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

configure.ac contains a mix of `AS_IF` and `if` conditionals.  Prefer
the portable M4sh `AS_IF` macro.  In some cases, where there are both
`AS_IF` and `if` conditionals evaluating the same predicates, the latter
are merged into the former.

Replace three instance of `test -n "$var"` with the usual, more portable,
autoconf idiom: `test "x$var" != "x"`.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 configure.ac | 116 ++++++++++++++++-----------------------------------
 1 file changed, 37 insertions(+), 79 deletions(-)

diff --git a/configure.ac b/configure.ac
index ff18cbe194db..895d58439ef7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,10 +41,8 @@ AC_ARG_ENABLE([ulog],
               [AS_HELP_STRING([--enable-ulog], [Enable ulog module [default=yes]])],
               [enable_ulog=$enableval],
               [enable_ulog=yes])
+AS_IF([test "x$enable_ulog" != "xyes"], [enable_ulog=no])
 AM_CONDITIONAL([BUILD_ULOG], [test "x$enable_ulog" = "xyes"])
-if [! test "x$enable_ulog" = "xyes"]; then
-	enable_ulog="no"
-fi
 
 dnl Check for the right nfnetlink version
 PKG_CHECK_MODULES([LIBNFNETLINK], [libnfnetlink >= 1.0.1])
@@ -53,115 +51,75 @@ AC_ARG_ENABLE([nflog],
               [AS_HELP_STRING([--enable-nflog], [Enable nflog module [default=yes]])],
               [enable_nflog=$enableval],
               [enable_nflog=yes])
-AS_IF([test "x$enable_nflog" = "xyes"], [
-    PKG_CHECK_MODULES([LIBNETFILTER_LOG], [libnetfilter_log >= 1.0.0])
-    AC_DEFINE([BUILD_NFLOG], [1], [Building nflog module])
-])
+AS_IF([test "x$enable_nflog" = "xyes"],
+      [PKG_CHECK_MODULES([LIBNETFILTER_LOG], [libnetfilter_log >= 1.0.0])
+       AC_DEFINE([BUILD_NFLOG], [1], [Building nflog module])],
+      [enable_nflog=no])
 AM_CONDITIONAL([BUILD_NFLOG], [test "x$enable_nflog" = "xyes"])
-if [! test "x$enable_nflog" = "xyes"]; then
-	enable_nflog="no"
-fi
 
 AC_ARG_ENABLE([nfct],
               [AS_HELP_STRING([--enable-nfct], [Enable nfct module [default=yes]])],
               [enable_nfct=$enableval],
               [enable_nfct=yes])
-AS_IF([test "x$enable_nfct" = "xyes"], [
-    PKG_CHECK_MODULES([LIBNETFILTER_CONNTRACK], [libnetfilter_conntrack >= 1.0.2])
-    AC_DEFINE([BUILD_NFCT], [1], [Building nfct module])
-])
+AS_IF([test "x$enable_nfct" = "xyes"],
+      [PKG_CHECK_MODULES([LIBNETFILTER_CONNTRACK], [libnetfilter_conntrack >= 1.0.2])
+       AC_DEFINE([BUILD_NFCT], [1], [Building nfct module])],
+      [enable_nfct=no])
 AM_CONDITIONAL([BUILD_NFCT], [test "x$enable_nfct" = "xyes"])
-if [! test "x$enable_nfct" = "xyes"]; then
-	enable_nfct="no"
-fi
 
 AC_ARG_ENABLE([nfacct],
               [AS_HELP_STRING([--enable-nfacct], [Enable nfacct module [default=yes]])],
               [enable_nfacct=$enableval],
               [enable_nfacct=yes])
-AS_IF([test "x$enable_nfacct" = "xyes"], [
-    PKG_CHECK_MODULES([LIBMNL], [libmnl >= 1.0.3])
-    PKG_CHECK_MODULES([LIBNETFILTER_ACCT], [libnetfilter_acct >= 1.0.1])
-    AC_DEFINE([BUILD_NFACCT], [1], [Building nfacct module])
-])
+AS_IF([test "x$enable_nfacct" = "xyes"],
+      [PKG_CHECK_MODULES([LIBMNL], [libmnl >= 1.0.3])
+       PKG_CHECK_MODULES([LIBNETFILTER_ACCT], [libnetfilter_acct >= 1.0.1])
+       AC_DEFINE([BUILD_NFACCT], [1], [Building nfacct module])],
+      [enable_nfacct=no])
 AM_CONDITIONAL([BUILD_NFACCT], [test "x$enable_nfacct" = "xyes"])
-if [! test "x$enable_nfacct" = "xyes"]; then
-	enable_nfacct="no"
-fi
 
 AC_ARG_WITH([pgsql],
             [AS_HELP_STRING([--without-pgsql], [Build without postgresql output plugin [default=test]])])
-AS_IF([test "x$with_pgsql" != "xno"], [
-	CT_CHECK_POSTGRES_DB()
-])
+AS_IF([test "x$with_pgsql" != "xno"],
+      [CT_CHECK_POSTGRES_DB()])
+AS_IF([test "x$PQLIBPATH" != "x"], [enable_pgsql=yes], [enable_pgsql=no])
 AM_CONDITIONAL([HAVE_PGSQL], [test "x$PQLIBPATH" != "x"])
-if test "x$PQLIBPATH" != "x"; then
-	enable_pgsql="yes"
-else
-	enable_pgsql="no"
-fi
 
 AC_ARG_WITH([mysql],
             [AS_HELP_STRING([--without-mysql], [Build without mysql output plugin [default=test]])])
-AS_IF([test "x$with_mysql" != "xno"], [
-	CT_CHECK_MYSQL_DB()
-])
+AS_IF([test "x$with_mysql" != "xno"],
+      [CT_CHECK_MYSQL_DB()])
+AS_IF([test "x$MYSQL_LIB" != "x"], [enable_mysql=yes], [enable_mysql=no])
 AM_CONDITIONAL([HAVE_MYSQL], [test "x$MYSQL_LIB" != "x"])
-if test "x$MYSQL_LIB" != "x"; then
-	enable_mysql="yes"
-else
-	enable_mysql="no"
-fi
-
 
 AC_ARG_WITH([sqlite],
             [AS_HELP_STRING([--without-sqlite], [Build without SQLITE3 output plugin [default=test]])])
-AS_IF([test "x$with_sqlite" != "xno"], [
-    PKG_CHECK_MODULES([libsqlite3], [sqlite3], [], [:])
-])
-AM_CONDITIONAL([HAVE_SQLITE3], [test -n "$libsqlite3_LIBS"])
-if test "x$libsqlite3_LIBS" != "x"; then
-	enable_sqlite3="yes"
-else
-	enable_sqlite3="no"
-fi
+AS_IF([test "x$with_sqlite" != "xno"],
+      [PKG_CHECK_MODULES([libsqlite3], [sqlite3], [], [:])])
+AS_IF([test "x$libsqlite3_LIBS" != "x"], [enable_sqlite3=yes], [enable_sqlite3=no])
+AM_CONDITIONAL([HAVE_SQLITE3], [test "x$libsqlite3_LIBS" != "x"])
 
 AC_ARG_WITH([dbi],
             [AS_HELP_STRING([--without-dbi], [Build without DBI output plugin [default=test]])])
-AS_IF([test "x$with_dbi" != "xno"], [
-    CT_CHECK_DBI()
-])
-AM_CONDITIONAL([HAVE_DBI], [test "x$DBI_LIB" != "x"])
-if test "x$DBI_LIB" != "x"; then
-	enable_dbi="yes"
-else
-	enable_dbi="no"
-fi
+AS_IF([test "x$with_dbi" != "xno"],
+      [CT_CHECK_DBI()])
+AS_IF([test "x$DBI_LIB" != "x"], [enable_dbi=yes], [enable_dbi=no])
+AM_CONDITIONAL(HAVE_DBI, [test "x$DBI_LIB" != "x"])
 
 AC_ARG_WITH([pcap],
             [AS_HELP_STRING([--without-pcap], [Build without PCAP output plugin [default=test]])])
-AS_IF([test "x$with_pcap" != "xno"], [
-    AC_SEARCH_LIBS([pcap_close], [pcap], [libpcap_LIBS="-lpcap"; LIBS=""])
-    AC_SUBST([libpcap_LIBS])
-])
-AM_CONDITIONAL([HAVE_PCAP], [test -n "$libpcap_LIBS"])
-if test "x$libpcap_LIBS" != "x"; then
-	enable_pcap="yes"
-else
-	enable_pcap="no"
-fi
+AS_IF([test "x$with_pcap" != "xno"],
+      [AC_SEARCH_LIBS([pcap_close], [pcap], [libpcap_LIBS="-lpcap"; LIBS=""])
+       AC_SUBST([libpcap_LIBS])])
+AS_IF([test "x$libpcap_LIBS" != "x"], [enable_pcap=yes], [enable_pcap=no])
+AM_CONDITIONAL([HAVE_PCAP], [test "x$libpcap_LIBS" != "x"])
 
 AC_ARG_WITH([jansson],
             [AS_HELP_STRING([--without-jansson], [Build without JSON output plugin [default=test]])])
-AS_IF([test "x$with_jansson" != "xno"], [
-    PKG_CHECK_MODULES([libjansson], [jansson], [], [:])
-])
-AM_CONDITIONAL([HAVE_JANSSON], [test -n "$libjansson_LIBS"])
-if test "x$libjansson_LIBS" != "x"; then
-	enable_jansson="yes"
-else
-	enable_jansson="no"
-fi
+AS_IF([test "x$with_jansson" != "xno"],
+      [PKG_CHECK_MODULES([libjansson], [jansson], [], [:])])
+AS_IF([test "x$libjansson_LIBS" != "x"], [enable_jansson=yes], [enable_jansson=no])
+AM_CONDITIONAL([HAVE_JANSSON], [test "x$libjansson_LIBS" != "x"])
 
 AC_ARG_WITH([ulogd2libdir],
             [AS_HELP_STRING([--with-ulogd2libdir=PATH], [Default directory to load ulogd2 plugin from [[LIBDIR/ulogd]]])],
-- 
2.33.0

