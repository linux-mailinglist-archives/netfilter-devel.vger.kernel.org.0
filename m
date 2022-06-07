Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C6534059
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 May 2022 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiEYP0j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 May 2022 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbiEYP0g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 May 2022 11:26:36 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B285FCD
        for <netfilter-devel@vger.kernel.org>; Wed, 25 May 2022 08:26:34 -0700 (PDT)
Received: (Authenticated sender: ben@demerara.io)
        by mail.gandi.net (Postfix) with ESMTPSA id 05BCF200009
        for <netfilter-devel@vger.kernel.org>; Wed, 25 May 2022 15:26:32 +0000 (UTC)
From:   Ben Brown <ben@demerara.io>
To:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2] build: Fix error during out of tree build
Date:   Wed, 25 May 2022 16:26:13 +0100
Message-Id: <20220525152613.152899-1-ben@demerara.io>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes the following error:

    ../../libxtables/xtables.c:52:10: fatal error: libiptc/linux_list.h: No such file or directory
       52 | #include <libiptc/linux_list.h>

Fixes: f58b0d7406451 ("libxtables: Implement notargets hash table")

Signed-off-by: Ben Brown <ben@demerara.io>
---
 libxtables/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libxtables/Makefile.am b/libxtables/Makefile.am
index 8ff6b0ca..3bfded85 100644
--- a/libxtables/Makefile.am
+++ b/libxtables/Makefile.am
@@ -1,7 +1,7 @@
 # -*- Makefile -*-
 
 AM_CFLAGS   = ${regular_CFLAGS}
-AM_CPPFLAGS = ${regular_CPPFLAGS} -I${top_builddir}/include -I${top_srcdir}/include -I${top_srcdir}/iptables ${kinclude_CPPFLAGS}
+AM_CPPFLAGS = ${regular_CPPFLAGS} -I${top_builddir}/include -I${top_srcdir}/include -I${top_srcdir}/iptables -I${top_srcdir} ${kinclude_CPPFLAGS}
 
 lib_LTLIBRARIES       = libxtables.la
 libxtables_la_SOURCES = xtables.c xtoptions.c getethertype.c
-- 
2.36.1

