Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF213707CA0
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 11:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjERJSV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjERJST (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 05:18:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D6372108
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:18:08 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrackd 1/3] build: don't suppress various warnings
Date:   Thu, 18 May 2023 11:17:59 +0200
Message-Id: <20230518091803.90494-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Sam James <sam@gentoo.org>

These will become fatal with Clang 16 and GCC 14 anyway, but let's
address the real problem (followup commit).

We do have to keep one wrt yyerror() & const char * though, but
the issue is contained to the code Bison generates.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1637
Signed-off-by: Sam James <sam@gentoo.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
posted via https://bugzilla.netfilter.org/show_bug.cgi?id=1637

 src/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index a1a91a0c8df6..2986ab3b4d4f 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -61,7 +61,7 @@ conntrackd_SOURCES += systemd.c
 endif
 
 # yacc and lex generate dirty code
-read_config_yy.o read_config_lex.o: AM_CFLAGS += -Wno-missing-prototypes -Wno-missing-declarations -Wno-implicit-function-declaration -Wno-nested-externs -Wno-undef -Wno-redundant-decls -Wno-sign-compare
+read_config_yy.o read_config_lex.o: AM_CFLAGS += -Wno-incompatible-pointer-types -Wno-discarded-qualifiers
 
 conntrackd_LDADD = ${LIBMNL_LIBS} ${LIBNETFILTER_CONNTRACK_LIBS} \
 		   ${libdl_LIBS} ${LIBNFNETLINK_LIBS}
-- 
2.30.2

