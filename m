Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C939232F1
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfETLny (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 07:43:54 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35314 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfETLnx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 07:43:53 -0400
Received: from localhost ([::1]:48404 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hSghr-0008AA-Px; Mon, 20 May 2019 13:43:51 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] Revert "build: don't include tests in released tarball"
Date:   Mon, 20 May 2019 13:43:57 +0200
Message-Id: <20190520114357.4905-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts commit 4b187eeed49dc507d38438affabe90d36847412d.

Having the testsuites available in release tarball is helpful for
SRPM-based CI at least. The other two suites are included already, so
it's actually 2:1 keep or drop.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 044f6461abf5a..b1ba015ffe8e6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -26,7 +26,7 @@ tarball:
 	rm -Rf /tmp/${PACKAGE_TARNAME}-${PACKAGE_VERSION};
 	pushd ${top_srcdir} && git archive --prefix=${PACKAGE_TARNAME}-${PACKAGE_VERSION}/ HEAD | tar -C /tmp -x && popd;
 	pushd /tmp/${PACKAGE_TARNAME}-${PACKAGE_VERSION} && ./autogen.sh && popd;
-	tar --exclude=*.t --exclude=iptables-test.py -C /tmp -cjf ${PACKAGE_TARNAME}-${PACKAGE_VERSION}.tar.bz2 --owner=root --group=root ${PACKAGE_TARNAME}-${PACKAGE_VERSION}/;
+	tar -C /tmp -cjf ${PACKAGE_TARNAME}-${PACKAGE_VERSION}.tar.bz2 --owner=root --group=root ${PACKAGE_TARNAME}-${PACKAGE_VERSION}/;
 	rm -Rf /tmp/${PACKAGE_TARNAME}-${PACKAGE_VERSION};
 
 config.status: extensions/GNUmakefile.in \
-- 
2.21.0

