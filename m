Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D542371B
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Oct 2021 06:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhJFE22 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Oct 2021 00:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFE21 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:28:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA19C061749
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Oct 2021 21:26:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w11so794697plz.13
        for <netfilter-devel@vger.kernel.org>; Tue, 05 Oct 2021 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsFnx0bJy/cJMwir4KH4unpXDSrI9EITLSbUcgXPwnU=;
        b=qTSOu5Lo83kkk2V8Cd4pIHR+zvS+Tsny5PHXsdqc5Z5pMhfRbtaTHwgoJ/sIrnJXjI
         vUedxcz6AKt0EC8qFa9AqTcR/PCDYcDgnuIzY9Za847SQeCHvAfPbPq/Kll0GKpysgMT
         72MUU67cli5lx7H+2LyvIlxlVx54syI2jhZ3IDlfrckJUsIckPfHn4Ys11wSYAFLGmJu
         ckCN+s3tVnID5kMaAtZVmfhZpNlTY4BhTW91Dc5Z0yW9ZvqSvPYa7Xu9Wq+JMtH/p+L6
         SQgRAPK3aDKe+UQLL8x2ulqXRixK3zDnlT+ytf4w8enD86mqLOriQz9VR0S0M3zNBmc5
         zGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HsFnx0bJy/cJMwir4KH4unpXDSrI9EITLSbUcgXPwnU=;
        b=O8O8gC9XYMQ2fdhXLjgABvLot9hqoVfMOn4rack3PKg9jbf6UaMU2wbiTQq6b7l+78
         DOcPgSKHm0jx0oeef0Xcfdf6bvyb2S326B5W0bCYDWCd4MNA9JaxaPdlTO5nMiRH8YFb
         HQZANXWQfNvsI5a0hw7CjJpbFMl9s7b4qHhUg7F08SOP6Wwo4fG7zRGql0YXyNmhSkUQ
         GLAYJy4p8xeITg3tM+Y2o6Ld7vd0CojlddDnWAtW7IsyYGNF5/yTq6D2MOx4edH/O35V
         1T9VgVvldjcr0LtXGmOLSBI9gGAGkz1FdkqLeRaSQtJ5W4J687EVGL0T93SF4q6GbUKm
         RdsQ==
X-Gm-Message-State: AOAM5319Eo9S0yf7wNH6iGfbfwnlyFxx44Nfzwfvtdqfv/+OSHlO6fp2
        uhsT3O6zn8vtCsj2ll7+h7rUH1N0Hy8=
X-Google-Smtp-Source: ABdhPJzwsQqI1AO6dLM7D4GCoxHLYx6CJ6Wm8aQ+q/fEc/ETpcjf8f/YMdaXWK7MC7rv0j+RkSObTg==
X-Received: by 2002:a17:902:9687:b0:13d:b848:479d with SMTP id n7-20020a170902968700b0013db848479dmr8866201plp.59.1633494392907;
        Tue, 05 Oct 2021 21:26:32 -0700 (PDT)
Received: from slk1.local.net (n49-192-82-34.sun3.vic.optusnet.com.au. [49.192.82.34])
        by smtp.gmail.com with ESMTPSA id k17sm24905pff.214.2021.10.05.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 21:26:32 -0700 (PDT)
Sender: Duncan Roe <duncan.roe2@gmail.com>
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_log v3] build: doc: `make` generates requested documentation
Date:   Wed,  6 Oct 2021 15:26:27 +1100
Message-Id: <20211006042627.22161-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Generate man pages, HTML, neither or both according to ./configure.
Based on the work done for libnetfilter_queue

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
v2: remove --without-doxygen since -disable-man-pages does that
v3: - update .gitignore for clean `git status` after in-tree build
    - adjust configure.ac indentation for better readability
    - adjust configure.ac for all lines to fit in 80cc
 .gitignore                               |  7 ++--
 Makefile.am                              |  2 +-
 autogen.sh                               |  8 +++++
 configure.ac                             | 45 +++++++++++++++++++++++-
 doxygen/Makefile.am                      | 39 ++++++++++++++++++++
 doxygen.cfg.in => doxygen/doxygen.cfg.in |  9 ++---
 6 files changed, 102 insertions(+), 8 deletions(-)
 create mode 100644 doxygen/Makefile.am
 rename doxygen.cfg.in => doxygen/doxygen.cfg.in (76%)

diff --git a/.gitignore b/.gitignore
index 5eaabe3..bb5e9d8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,9 @@ Makefile.in
 /configure
 /libtool
 
-/doxygen/
-/doxygen.cfg
+doxygen/doxygen.cfg
+doxygen/build_man.sh
+doxygen/doxyfile.stamp
+doxygen/man/
+doxygen/html/
 /*.pc
diff --git a/Makefile.am b/Makefile.am
index 2a9cdd8..6662d7b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,4 +1,4 @@
-SUBDIRS	= include src utils
+SUBDIRS	= include src utils doxygen
 
 ACLOCAL_AMFLAGS = -I m4
 
diff --git a/autogen.sh b/autogen.sh
index 5e1344a..b47c529 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -1,4 +1,12 @@
 #!/bin/sh -e
 
+# Allow to override build_man.sh url for local testing
+# E.g. export NFQ_URL=file:///usr/src/libnetfilter_queue
+NFQ_URL=${NFQ_URL:-https://git.netfilter.org/libnetfilter_queue/plain}
+
+curl $NFQ_URL/doxygen/build_man.sh -O
+chmod a+x build_man.sh
+mv build_man.sh doxygen/
+
 autoreconf -fi
 rm -Rf autom4te.cache
diff --git a/configure.ac b/configure.ac
index c914e00..134178d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,6 +12,23 @@ m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
 dnl kernel style compile messages
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
+AC_ARG_ENABLE([html-doc],
+	      AS_HELP_STRING([--enable-html-doc], [Enable html documentation]),
+	      [], [enable_html_doc=no])
+AM_CONDITIONAL([BUILD_HTML], [test "$enable_html_doc" = yes])
+AS_IF([test "$enable_html_doc" = yes],
+      [AC_SUBST(GEN_HTML, YES)],
+      [AC_SUBST(GEN_HTML, NO)])
+
+AC_ARG_ENABLE([man-pages],
+	      AS_HELP_STRING([--disable-man-pages],
+			     [Disable man page documentation]),
+	      [], [enable_man_pages=yes])
+AM_CONDITIONAL([BUILD_MAN], [test "$enable_man_pages" = yes])
+AS_IF([test "$enable_man_pages" = yes],
+      [AC_SUBST(GEN_MAN, YES)],
+      [AC_SUBST(GEN_MAN, NO)])
+
 AC_PROG_CC
 AM_PROG_CC_C_O
 AC_DISABLE_STATIC
@@ -35,8 +52,34 @@ PKG_CHECK_MODULES([LIBNETFILTER_CONNTRACK], [libnetfilter_conntrack >= 1.0.2],
 		  [HAVE_LNFCT=1], [HAVE_LNFCT=0])
 AM_CONDITIONAL([BUILD_NFCT], [test "$HAVE_LNFCT" -eq 1])
 
+AS_IF([test "$enable_man_pages" = no -a "$enable_html_doc" = no],
+      [with_doxygen=no], [with_doxygen=yes])
+
+AS_IF([test "x$with_doxygen" != xno], [
+	AC_CHECK_PROGS([DOXYGEN], [doxygen], [""])
+	AC_CHECK_PROGS([DOT], [dot], [""])
+	AS_IF([test "x$DOT" != "x"],
+	      [AC_SUBST(HAVE_DOT, YES)],
+	      [AC_SUBST(HAVE_DOT, NO)])
+])
+
+AM_CONDITIONAL([HAVE_DOXYGEN], [test -n "$DOXYGEN"])
+AS_IF([test "x$DOXYGEN" = x], [
+	AS_IF([test "x$with_doxygen" != xno], [
+		dnl Only run doxygen Makefile if doxygen installed
+		AC_MSG_WARN([Doxygen not found - not building documentation])
+		enable_html_doc=no
+		enable_man_pages=no
+	])
+])
+
 dnl Output the makefile
 AC_CONFIG_FILES([Makefile src/Makefile include/Makefile
 	include/libnetfilter_log/Makefile utils/Makefile libnetfilter_log.pc
-	doxygen.cfg])
+	doxygen/Makefile doxygen/doxygen.cfg])
 AC_OUTPUT
+
+echo "
+libnetfilter_log configuration:
+man pages:                    ${enable_man_pages}
+html docs:                    ${enable_html_doc}"
diff --git a/doxygen/Makefile.am b/doxygen/Makefile.am
new file mode 100644
index 0000000..582db4e
--- /dev/null
+++ b/doxygen/Makefile.am
@@ -0,0 +1,39 @@
+if HAVE_DOXYGEN
+
+doc_srcs = $(top_srcdir)/src/libnetfilter_log.c\
+	   $(top_srcdir)/src/nlmsg.c\
+	   $(top_srcdir)/src/libipulog_compat.c
+
+doxyfile.stamp: $(doc_srcs) Makefile
+	rm -rf html man
+	doxygen doxygen.cfg >/dev/null
+
+if BUILD_MAN
+	$(abs_top_srcdir)/doxygen/build_man.sh
+endif
+
+	touch doxyfile.stamp
+
+CLEANFILES = doxyfile.stamp
+
+all-local: doxyfile.stamp
+clean-local:
+	rm -rf man html
+install-data-local:
+if BUILD_MAN
+	mkdir -p $(DESTDIR)$(mandir)/man3
+	cp --no-dereference --preserve=links,mode,timestamps man/man3/*.3\
+	  $(DESTDIR)$(mandir)/man3/
+endif
+if BUILD_HTML
+	mkdir  -p $(DESTDIR)$(htmldir)
+	cp  --no-dereference --preserve=links,mode,timestamps html/*\
+		$(DESTDIR)$(htmldir)
+endif
+
+# make distcheck needs uninstall-local
+uninstall-local:
+	rm -rf $(DESTDIR)$(mandir) man html doxyfile.stamp $(DESTDIR)$(htmldir)
+endif
+
+EXTRA_DIST = build_man.sh
diff --git a/doxygen.cfg.in b/doxygen/doxygen.cfg.in
similarity index 76%
rename from doxygen.cfg.in
rename to doxygen/doxygen.cfg.in
index dc2fddb..b6c27dc 100644
--- a/doxygen.cfg.in
+++ b/doxygen/doxygen.cfg.in
@@ -1,12 +1,11 @@
 # Difference with default Doxyfile 1.8.20
 PROJECT_NAME           = @PACKAGE@
 PROJECT_NUMBER         = @VERSION@
-OUTPUT_DIRECTORY       = doxygen
 ABBREVIATE_BRIEF       =
 FULL_PATH_NAMES        = NO
 TAB_SIZE               = 8
 OPTIMIZE_OUTPUT_FOR_C  = YES
-INPUT                  = .
+INPUT                  = @abs_top_srcdir@/src
 FILE_PATTERNS          = *.c
 RECURSIVE              = YES
 EXCLUDE_SYMBOLS        = nflog_g_handle \
@@ -18,7 +17,9 @@ SOURCE_BROWSER         = YES
 ALPHABETICAL_INDEX     = NO
 GENERATE_LATEX         = NO
 LATEX_CMD_NAME         = latex
-GENERATE_MAN           = YES
-HAVE_DOT               = YES
+GENERATE_MAN           = @GEN_MAN@
+GENERATE_HTML          = @GEN_HTML@
+MAN_LINKS              = YES
+HAVE_DOT               = @HAVE_DOT@
 DOT_TRANSPARENT        = YES
 SEARCHENGINE           = NO
-- 
2.17.5

