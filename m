Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2012C374
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 May 2019 11:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfE1Jny (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 May 2019 05:43:54 -0400
Received: from a3.inai.de ([88.198.85.195]:40428 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfE1Jny (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 May 2019 05:43:54 -0400
Received: by a3.inai.de (Postfix, from userid 65534)
        id BDF3F3BACCB5; Tue, 28 May 2019 11:43:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.1
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 959723BB6EF6;
        Tue, 28 May 2019 11:43:28 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH 2/2] build: avoid unnecessary rebuild of iptables when rerunning configure
Date:   Tue, 28 May 2019 11:43:27 +0200
Message-Id: <20190528094327.20496-3-jengelh@inai.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528094327.20496-1-jengelh@inai.de>
References: <20190528094327.20496-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Running configure always touches xtables/xtables-version.h, which
causes parts to rebuild even when the configuration has not changed.
(`./configure; make; ./configure; make;`).

This can be avoided if the AC_CONFIG_FILES mechanism is replaced by
one that does a compare and leaves an existing xtables-version.h
unmodified if the sed result stays the same when it re-runs.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 Makefile.am  | 8 ++++++--
 configure.ac | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 799bf8b8..2e29bb5d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -29,5 +29,9 @@ tarball:
 	tar -C /tmp -cjf ${PACKAGE_TARNAME}-${PACKAGE_VERSION}.tar.bz2 --owner=root --group=root ${PACKAGE_TARNAME}-${PACKAGE_VERSION}/;
 	rm -Rf /tmp/${PACKAGE_TARNAME}-${PACKAGE_VERSION};
 
-config.status: extensions/GNUmakefile.in \
-	include/xtables-version.h.in
+config.status: extensions/GNUmakefile.in
+
+include/xtables-version.h: include/xtables-version.h.in
+	${AM_V_GEN} sed -e 's|@@libxtables_vmajor@@|${libxtables_vmajor}|g' <$< >include/.xtables-version.tmp; \
+	cmp include/xtables-version.h include/.xtables-version.tmp || \
+		mv include/.xtables-version.tmp include/xtables-version.h
diff --git a/configure.ac b/configure.ac
index c922f7a0..2767c911 100644
--- a/configure.ac
+++ b/configure.ac
@@ -245,7 +245,6 @@ AC_CONFIG_FILES([Makefile extensions/GNUmakefile include/Makefile
 	libiptc/Makefile libiptc/libiptc.pc
 	libiptc/libip4tc.pc libiptc/libip6tc.pc
 	libxtables/Makefile utils/Makefile
-	include/xtables-version.h
 	iptables/xtables-monitor.8
 	utils/nfnl_osf.8
 	utils/nfbpf_compile.8])
-- 
2.21.0

