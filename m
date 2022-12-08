Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88C647376
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLHPq6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 10:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiLHPqv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:46:51 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE45654C2
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zo+55dOUkT6+hUluLa2BcxG3j8uoCcHYQPhh7lRlfws=; b=UlphCjwnXFQ0IzHXd2PXkJFb7Y
        ebu7zG8kimwXa2E7+SNOmbjLgJBzqQuTZqpohRknHeYPkitAngmS4gl1WogKjxMszOUySw23B5dS2
        hfEVWFh1Yuu6IgAd/ugscDqfQwCyVtGaph3C8wMe0hSyFzJg3pzQccIrIP6OwrsJaHkvPwDXWw0zR
        xV1kyzjOkU5TgOIeQ7i2cjAOnd2JsSFDp/dg263hfPkd8DHDj2SSJxnR45vTRympV1xQg98OZmAiA
        Ms2sKoOu/mAnxV8nNcJPI+EQXu0NLA4VVPUIqcg2mysP6r0sZJBCpUad8/XwFt3vYUsqgULO+pmZb
        3vsVKHvA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1p3J6f-0005fJ-Pd; Thu, 08 Dec 2022 16:46:41 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Jan Engelhardt <jengelh@inai.de>
Subject: [iptables PATCH v2 07/11] Makefile: Fix for 'make distcheck'
Date:   Thu,  8 Dec 2022 16:46:12 +0100
Message-Id: <20221208154616.14622-8-phil@nwl.cc>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221208154616.14622-1-phil@nwl.cc>
References: <20221208154616.14622-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since extensions/ directory does not use automake, some targets have to
be added manually. Apart from that, several Makefiles either missed to
specify relevant files or did not specify them correctly for 'make dist'
to add them to the tarball.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 Makefile.am               |  4 +++-
 extensions/GNUmakefile.in | 15 ++++++++++++++-
 include/Makefile.am       |  2 ++
 iptables/Makefile.am      |  5 ++++-
 libipq/Makefile.am        |  2 +-
 libiptc/Makefile.am       |  2 ++
 utils/Makefile.am         |  4 ++--
 7 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 799bf8b81c74a..1292f4b7065f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -16,9 +16,11 @@ SUBDIRS         += extensions
 # Depends on extensions/libext.a:
 SUBDIRS         += iptables
 
+EXTRA_DIST	= autogen.sh iptables-test.py xlate-test.py
+
 if ENABLE_NFTABLES
 confdir		= $(sysconfdir)
-dist_conf_DATA	= etc/ethertypes
+dist_conf_DATA	= etc/ethertypes etc/xtables.conf
 endif
 
 .PHONY: tarball
diff --git a/extensions/GNUmakefile.in b/extensions/GNUmakefile.in
index 188e7a7902566..c37e4619f91f9 100644
--- a/extensions/GNUmakefile.in
+++ b/extensions/GNUmakefile.in
@@ -79,7 +79,7 @@ targets_install :=
 
 .SECONDARY:
 
-.PHONY: all install uninstall clean distclean FORCE
+.PHONY: all install uninstall clean distclean FORCE dvi check installcheck
 
 all: ${targets}
 
@@ -235,3 +235,16 @@ matches.man: ${initext_depfiles} $(wildcard ${srcdir}/lib*.man)
 
 targets.man: ${initext_depfiles} $(wildcard ${srcdir}/lib*.man)
 	$(call man_run,$(call ex_targets,${pfx_build_mod} ${pfb_build_mod} ${pfa_build_mod} ${pf4_build_mod} ${pf6_build_mod} ${pfx_symlinks}))
+
+dist_initext_src = $(addprefix $(srcdir)/,${initext_sources})
+dist_sources = $(filter-out ${dist_initext_src},$(wildcard $(srcdir)/*.[ch]))
+
+distdir:
+	mkdir -p $(distdir)
+	cp -p ${dist_sources} $(distdir)/
+	cp -p $(wildcard ${srcdir}/lib*.man) $(distdir)/
+	cp -p $(srcdir)/*.{t,txlate} $(distdir)/
+
+dvi:
+check: all
+installcheck:
diff --git a/include/Makefile.am b/include/Makefile.am
index ea34c2fef0d98..348488a45ce84 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -11,6 +11,8 @@ nobase_include_HEADERS += \
 	libiptc/ipt_kernel_headers.h libiptc/libiptc.h \
 	libiptc/libip6tc.h libiptc/libxtc.h libiptc/xtcshared.h
 
+EXTRA_DIST = iptables linux iptables.h ip6tables.h
+
 uninstall-hook:
 	dir=${includedir}/libiptc; { \
 		test ! -d "$$dir" && test ! -f "$$dir" && test ! -r "$$dir"; \
diff --git a/iptables/Makefile.am b/iptables/Makefile.am
index 7ca2b1a4ba762..4353dd0094c9e 100644
--- a/iptables/Makefile.am
+++ b/iptables/Makefile.am
@@ -63,7 +63,8 @@ man_MANS         = iptables.8 iptables-restore.8 iptables-save.8 \
                    ip6tables-save.8 iptables-extensions.8 \
                    iptables-apply.8 ip6tables-apply.8
 
-sbin_SCRIPTS     = iptables-apply
+dist_sbin_SCRIPTS = iptables-apply
+dist_pkgdata_DATA = iptables.xslt
 
 if ENABLE_NFTABLES
 man_MANS	+= iptables-translate.8 ip6tables-translate.8 \
@@ -144,3 +145,5 @@ pkgconfig_DATA = xtables.pc
 		); \
 		( cd "$$dir" && rm -f ip6tables-apply ); \
 	}
+
+EXTRA_DIST = tests
diff --git a/libipq/Makefile.am b/libipq/Makefile.am
index 2cdaf32e03292..68da15fe56439 100644
--- a/libipq/Makefile.am
+++ b/libipq/Makefile.am
@@ -6,7 +6,7 @@ AM_LDFLAGS = ${regular_LDFLAGS}
 
 libipq_la_SOURCES = libipq.c
 lib_LTLIBRARIES   = libipq.la
-man_MANS         = ipq_create_handle.3 ipq_destroy_handle.3 ipq_errstr.3 \
+dist_man_MANS    = ipq_create_handle.3 ipq_destroy_handle.3 ipq_errstr.3 \
                    ipq_get_msgerr.3 ipq_get_packet.3 ipq_message_type.3 \
                    ipq_perror.3 ipq_read.3 ipq_set_mode.3 ipq_set_verdict.3 \
                    libipq.3
diff --git a/libiptc/Makefile.am b/libiptc/Makefile.am
index 097842f212bb5..d8fe169e32487 100644
--- a/libiptc/Makefile.am
+++ b/libiptc/Makefile.am
@@ -11,3 +11,5 @@ libip4tc_la_SOURCES = libip4tc.c
 libip4tc_la_LDFLAGS = -version-info 2:0:0
 libip6tc_la_SOURCES = libip6tc.c
 libip6tc_la_LDFLAGS = -version-info 2:0:0
+
+EXTRA_DIST = libiptc.c linux_list.h
diff --git a/utils/Makefile.am b/utils/Makefile.am
index 327a29e028c4d..e9eec48ffc3b5 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -6,13 +6,13 @@ AM_CPPFLAGS = ${regular_CPPFLAGS} -I${top_builddir}/include \
 AM_LDFLAGS = ${regular_LDFLAGS}
 
 sbin_PROGRAMS =
-pkgdata_DATA =
+dist_pkgdata_DATA =
 man_MANS =
 
 if HAVE_LIBNFNETLINK
 man_MANS += nfnl_osf.8
 sbin_PROGRAMS += nfnl_osf
-pkgdata_DATA += pf.os
+dist_pkgdata_DATA += pf.os
 
 nfnl_osf_LDADD = ${libnfnetlink_LIBS}
 
-- 
2.38.0

