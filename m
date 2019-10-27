Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2156E61B1
	for <lists+netfilter-devel@lfdr.de>; Sun, 27 Oct 2019 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfJ0ItW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Oct 2019 04:49:22 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33273 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfJ0ItW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Oct 2019 04:49:22 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 5CAF53A072C
        for <netfilter-devel@vger.kernel.org>; Sun, 27 Oct 2019 19:49:07 +1100 (AEDT)
Received: (qmail 24337 invoked by uid 501); 27 Oct 2019 08:49:07 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnfnetlink v3 1/2] Minimally resurrect doxygen documentation
Date:   Sun, 27 Oct 2019 19:49:06 +1100
Message-Id: <20191027084907.24291-2-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191027084907.24291-1-duncan_roe@optusnet.com.au>
References: <20191027084907.24291-1-duncan_roe@optusnet.com.au>
In-Reply-To: <20191026051937.GA17407@dimstar.local.net>
References: <20191026051937.GA17407@dimstar.local.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=PO7r1zJSAAAA:8
        a=GzT2_UiCs8zCaKyc0egA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The documentation was written in the days before doxygen required groups or even
doxygen.cfg, so create doxygen.cfg.in and introduce one \defgroup per source
file, encompassing pretty-much the whole file.

Also add a tiny \mainpage.

Added:

 doxygen.cfg.in: Same as for libmnl except FILE_PATTERNS = *.c linux_list.h

Updated:

 configure.ac: Create doxygen.cfg

 include/linux_list.h: Add defgroup

 src/iftable.c: Add defgroup

 src/libnfnetlink.c: Add mainpage and defgroup

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 configure.ac         |   2 +-
 doxygen.cfg.in       | 180 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux_list.h |   9 +++
 src/iftable.c        |   9 +++
 src/libnfnetlink.c   |  17 ++++-
 5 files changed, 215 insertions(+), 2 deletions(-)
 create mode 100644 doxygen.cfg.in

diff --git a/configure.ac b/configure.ac
index b979772..922ec09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,6 +28,6 @@ dnl--------------------------------
 
 
 dnl Output the makefile
-AC_CONFIG_FILES([Makefile src/Makefile include/Makefile
+AC_CONFIG_FILES([Makefile src/Makefile include/Makefile doxygen.cfg
 	include/libnfnetlink/Makefile utils/Makefile libnfnetlink.pc])
 AC_OUTPUT
diff --git a/doxygen.cfg.in b/doxygen.cfg.in
new file mode 100644
index 0000000..43c8138
--- /dev/null
+++ b/doxygen.cfg.in
@@ -0,0 +1,180 @@
+DOXYFILE_ENCODING      = UTF-8
+PROJECT_NAME           = @PACKAGE@
+PROJECT_NUMBER         = @VERSION@
+OUTPUT_DIRECTORY       = doxygen
+CREATE_SUBDIRS         = NO
+OUTPUT_LANGUAGE        = English
+BRIEF_MEMBER_DESC      = YES
+REPEAT_BRIEF           = YES
+ABBREVIATE_BRIEF       = 
+ALWAYS_DETAILED_SEC    = NO
+INLINE_INHERITED_MEMB  = NO
+FULL_PATH_NAMES        = NO
+STRIP_FROM_PATH        = 
+STRIP_FROM_INC_PATH    = 
+SHORT_NAMES            = NO
+JAVADOC_AUTOBRIEF      = NO
+QT_AUTOBRIEF           = NO
+MULTILINE_CPP_IS_BRIEF = NO
+INHERIT_DOCS           = YES
+SEPARATE_MEMBER_PAGES  = NO
+TAB_SIZE               = 8
+ALIASES                = 
+OPTIMIZE_OUTPUT_FOR_C  = YES
+OPTIMIZE_OUTPUT_JAVA   = NO
+OPTIMIZE_FOR_FORTRAN   = NO
+OPTIMIZE_OUTPUT_VHDL   = NO
+BUILTIN_STL_SUPPORT    = NO
+CPP_CLI_SUPPORT        = NO
+SIP_SUPPORT            = NO
+DISTRIBUTE_GROUP_DOC   = NO
+SUBGROUPING            = YES
+TYPEDEF_HIDES_STRUCT   = NO
+EXTRACT_ALL            = NO
+EXTRACT_PRIVATE        = NO
+EXTRACT_STATIC         = NO
+EXTRACT_LOCAL_CLASSES  = YES
+EXTRACT_LOCAL_METHODS  = NO
+EXTRACT_ANON_NSPACES   = NO
+HIDE_UNDOC_MEMBERS     = NO
+HIDE_UNDOC_CLASSES     = NO
+HIDE_FRIEND_COMPOUNDS  = NO
+HIDE_IN_BODY_DOCS      = NO
+INTERNAL_DOCS          = NO
+CASE_SENSE_NAMES       = YES
+HIDE_SCOPE_NAMES       = NO
+SHOW_INCLUDE_FILES     = YES
+INLINE_INFO            = YES
+SORT_MEMBER_DOCS       = YES
+SORT_BRIEF_DOCS        = NO
+SORT_GROUP_NAMES       = NO
+SORT_BY_SCOPE_NAME     = NO
+GENERATE_TODOLIST      = YES
+GENERATE_TESTLIST      = YES
+GENERATE_BUGLIST       = YES
+GENERATE_DEPRECATEDLIST= YES
+ENABLED_SECTIONS       = 
+MAX_INITIALIZER_LINES  = 30
+SHOW_USED_FILES        = YES
+FILE_VERSION_FILTER    = 
+QUIET                  = NO
+WARNINGS               = YES
+WARN_IF_UNDOCUMENTED   = YES
+WARN_IF_DOC_ERROR      = YES
+WARN_NO_PARAMDOC       = NO
+WARN_FORMAT            = "$file:$line: $text"
+WARN_LOGFILE           = 
+INPUT                  = .
+INPUT_ENCODING         = UTF-8
+FILE_PATTERNS          = *.c linux_list.h
+RECURSIVE              = YES
+EXCLUDE                = 
+EXCLUDE_SYMLINKS       = NO
+EXCLUDE_PATTERNS       = */.git/* .*.d
+EXCLUDE_SYMBOLS        = EXPORT_SYMBOL
+EXAMPLE_PATH           = 
+EXAMPLE_PATTERNS       = 
+EXAMPLE_RECURSIVE      = NO
+IMAGE_PATH             = 
+INPUT_FILTER           = 
+FILTER_PATTERNS        = 
+FILTER_SOURCE_FILES    = NO
+SOURCE_BROWSER         = YES
+INLINE_SOURCES         = NO
+STRIP_CODE_COMMENTS    = YES
+REFERENCED_BY_RELATION = NO
+REFERENCES_RELATION    = NO
+REFERENCES_LINK_SOURCE = YES
+USE_HTAGS              = NO
+VERBATIM_HEADERS       = YES
+ALPHABETICAL_INDEX     = NO
+COLS_IN_ALPHA_INDEX    = 5
+IGNORE_PREFIX          = 
+GENERATE_HTML          = YES
+HTML_OUTPUT            = html
+HTML_FILE_EXTENSION    = .html
+HTML_HEADER            = 
+HTML_STYLESHEET        = 
+GENERATE_HTMLHELP      = NO
+GENERATE_DOCSET        = NO
+DOCSET_FEEDNAME        = "Doxygen generated docs"
+DOCSET_BUNDLE_ID       = org.doxygen.Project
+HTML_DYNAMIC_SECTIONS  = NO
+CHM_FILE               = 
+HHC_LOCATION           = 
+GENERATE_CHI           = NO
+BINARY_TOC             = NO
+TOC_EXPAND             = NO
+DISABLE_INDEX          = NO
+ENUM_VALUES_PER_LINE   = 4
+GENERATE_TREEVIEW      = NO
+TREEVIEW_WIDTH         = 250
+GENERATE_LATEX         = NO
+LATEX_OUTPUT           = latex
+LATEX_CMD_NAME         = latex
+MAKEINDEX_CMD_NAME     = makeindex
+COMPACT_LATEX          = NO
+PAPER_TYPE             = a4wide
+EXTRA_PACKAGES         = 
+LATEX_HEADER           = 
+PDF_HYPERLINKS         = YES
+USE_PDFLATEX           = YES
+LATEX_BATCHMODE        = NO
+LATEX_HIDE_INDICES     = NO
+GENERATE_RTF           = NO
+RTF_OUTPUT             = rtf
+COMPACT_RTF            = NO
+RTF_HYPERLINKS         = NO
+RTF_STYLESHEET_FILE    = 
+RTF_EXTENSIONS_FILE    = 
+GENERATE_MAN           = YES
+MAN_OUTPUT             = man
+MAN_EXTENSION          = .3
+MAN_LINKS              = NO
+GENERATE_XML           = NO
+XML_OUTPUT             = xml
+XML_PROGRAMLISTING     = YES
+GENERATE_AUTOGEN_DEF   = NO
+GENERATE_PERLMOD       = NO
+PERLMOD_LATEX          = NO
+PERLMOD_PRETTY         = YES
+PERLMOD_MAKEVAR_PREFIX = 
+ENABLE_PREPROCESSING   = YES
+MACRO_EXPANSION        = NO
+EXPAND_ONLY_PREDEF     = NO
+SEARCH_INCLUDES        = YES
+INCLUDE_PATH           = 
+INCLUDE_FILE_PATTERNS  = 
+PREDEFINED             = 
+EXPAND_AS_DEFINED      = 
+SKIP_FUNCTION_MACROS   = YES
+TAGFILES               = 
+GENERATE_TAGFILE       = 
+ALLEXTERNALS           = NO
+EXTERNAL_GROUPS        = YES
+PERL_PATH              = /usr/bin/perl
+CLASS_DIAGRAMS         = YES
+MSCGEN_PATH            = 
+HIDE_UNDOC_RELATIONS   = YES
+HAVE_DOT               = YES
+CLASS_GRAPH            = YES
+COLLABORATION_GRAPH    = YES
+GROUP_GRAPHS           = YES
+UML_LOOK               = NO
+TEMPLATE_RELATIONS     = NO
+INCLUDE_GRAPH          = YES
+INCLUDED_BY_GRAPH      = YES
+CALL_GRAPH             = NO
+CALLER_GRAPH           = NO
+GRAPHICAL_HIERARCHY    = YES
+DIRECTORY_GRAPH        = YES
+DOT_IMAGE_FORMAT       = png
+DOT_PATH               = 
+DOTFILE_DIRS           = 
+DOT_GRAPH_MAX_NODES    = 50
+MAX_DOT_GRAPH_DEPTH    = 0
+DOT_TRANSPARENT        = YES
+DOT_MULTI_TARGETS      = NO
+GENERATE_LEGEND        = YES
+DOT_CLEANUP            = YES
+SEARCHENGINE           = NO
diff --git a/include/linux_list.h b/include/linux_list.h
index de182a4..d296cfa 100644
--- a/include/linux_list.h
+++ b/include/linux_list.h
@@ -3,6 +3,11 @@
 
 #include <stddef.h>
 
+/**
+ * \defgroup linux_list Items defined in linux_list.h
+ * @{
+ */
+
 #undef offsetof
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 
@@ -724,4 +729,8 @@ static inline void hlist_add_after(struct hlist_node *n,
 		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
 	     pos = pos->next, ({ smp_read_barrier_depends(); 0; }) )
 
+/**
+ * @}
+ */
+
 #endif
diff --git a/src/iftable.c b/src/iftable.c
index 157f97b..6d1d135 100644
--- a/src/iftable.c
+++ b/src/iftable.c
@@ -24,6 +24,11 @@
 #include "rtnl.h"
 #include "linux_list.h"
 
+/**
+ * \defgroup iftable Functions in iftable.c
+ * @{
+ */
+
 struct ifindex_node {
 	struct list_head head;
 
@@ -333,3 +338,7 @@ int nlif_fd(struct nlif_handle *h)
 
 	return -1;
 }
+
+/**
+ * @}
+ */
diff --git a/src/libnfnetlink.c b/src/libnfnetlink.c
index df57533..3db21e0 100644
--- a/src/libnfnetlink.c
+++ b/src/libnfnetlink.c
@@ -52,6 +52,18 @@
 
 #include <libnfnetlink/libnfnetlink.h>
 
+/**
+ * \mainpage
+ *
+ * libnfnetlink is the bottom-level communication between the kernel and
+ * userspace
+ */
+
+/**
+ * \defgroup libnfnetlink Functions in libnfnetlink.c
+ * @{
+ */
+
 #ifndef NETLINK_ADD_MEMBERSHIP
 #define NETLINK_ADD_MEMBERSHIP 1
 #endif
@@ -60,7 +72,6 @@
 #define SOL_NETLINK 270
 #endif
 
-
 #define nfnl_error(format, args...) \
 	fprintf(stderr, "%s: " format "\n", __FUNCTION__, ## args)
 
@@ -1572,3 +1583,7 @@ int nfnl_query(struct nfnl_handle *h, struct nlmsghdr *nlh)
 
 	return nfnl_catch(h);
 }
+
+/**
+ * @}
+ */
-- 
2.14.5

