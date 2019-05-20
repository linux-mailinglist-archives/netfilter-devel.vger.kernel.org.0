Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E336232F3
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 13:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfETLoD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 07:44:03 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35326 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfETLoD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 07:44:03 -0400
Received: from localhost ([::1]:48416 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hSgi1-0008AX-S7; Mon, 20 May 2019 13:44:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] Drop release.sh
Date:   Mon, 20 May 2019 13:44:07 +0200
Message-Id: <20190520114407.4973-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Last change in 2010, version number hardcoded - strong evidence this
script is not used anymore.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 release.sh | 31 -------------------------------
 1 file changed, 31 deletions(-)
 delete mode 100644 release.sh

diff --git a/release.sh b/release.sh
deleted file mode 100644
index 7c76423ebdaf7..0000000000000
--- a/release.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#! /bin/sh
-#
-set -e
-
-VERSION=1.4.7
-PREV_VERSION=1.4.6
-TMPDIR=/tmp/ipt-release
-IPTDIR="$TMPDIR/iptables-$VERSION"
-
-PATCH="patch-iptables-$PREV_VERSION-$VERSION.bz2";
-TARBALL="iptables-$VERSION.tar.bz2";
-CHANGELOG="changes-iptables-$PREV_VERSION-$VERSION.txt";
-
-mkdir -p "$TMPDIR"
-git shortlog "v$PREV_VERSION..v$VERSION" > "$TMPDIR/$CHANGELOG"
-git diff "v$PREV_VERSION..v$VERSION" | bzip2 > "$TMPDIR/$PATCH"
-git archive --prefix="iptables-$VERSION/" "v$VERSION" | tar -xC "$TMPDIR/"
-
-cd "$IPTDIR" && {
-	sh autogen.sh
-	cd ..
-}
-
-tar -cjf "$TARBALL" "iptables-$VERSION";
-gpg -u "Netfilter Core Team" -sb "$TARBALL";
-md5sum "$TARBALL" >"$TARBALL.md5sum";
-sha1sum "$TARBALL" >"$TARBALL.sha1sum";
-
-gpg -u "Netfilter Core Team" -sb "$PATCH";
-md5sum "$PATCH" >"$PATCH.md5sum";
-sha1sum "$PATCH" >"$PATCH.sha1sum";
-- 
2.21.0

