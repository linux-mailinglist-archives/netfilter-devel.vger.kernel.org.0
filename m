Return-Path: <netfilter-devel+bounces-4430-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B26E99BB4F
	for <lists+netfilter-devel@lfdr.de>; Sun, 13 Oct 2024 21:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315F11C209DD
	for <lists+netfilter-devel@lfdr.de>; Sun, 13 Oct 2024 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2114A4EB;
	Sun, 13 Oct 2024 19:41:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB214A4F5
	for <netfilter-devel@vger.kernel.org>; Sun, 13 Oct 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728848495; cv=none; b=Wxr3P2kAJ51ORsEPFSU0m3oNKez66Th2Kywd+8/lZjormjOqBDB62TOHWlflsRA4e7mph1VitJjRBeiu0wkYSzh8gIhUXU9ykgDp0nlh2xSWMT8rkPWyzGPB4c3cU9gXmh0+OPeC6euxYzfEVNEKfGqKir4ucoyig1neiGcJP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728848495; c=relaxed/simple;
	bh=GVAXlUgfSLdWA/7CguLpYYoLv0+Dveiz43Y0LrA1Xq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j0x2pXFhJIxjJXhQ7BQAdqRqgJ3e2L6LkzyLiiIAIVad5T+87YDBh4g+ArVx1MqIWLDCnyUjgpNtzKlRdEBnMtPx35u2SJAX0r/XjndpXq2cgfaRrn2ofRXZVjj9FzCvb+0FNOhZlKcrXm7hI/Yug8XQvmJ/QoD2g5mV+z8GQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc
Subject: [PATCH libmnl,v2] build: do not build documentation automatically
Date: Sun, 13 Oct 2024 21:41:18 +0200
Message-Id: <20241013194118.3608-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it optional. After this update it is still possible to build the
documentation via:

	./configure --with-doxygen=yes

if ./configure finds doxygen. Update README to include this information.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 README       | 11 +++++++++++
 configure.ac |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 317a2c6ad1d6..4a2ccab00647 100644
--- a/README
+++ b/README
@@ -18,6 +18,17 @@ on top of this library.
 is reduced, i.e. the library provides many helpers, but the programmer is not
 forced to use them.
 
+= Documentation =
+
+If doxygen is installed on your system, you can enable it via:
+
+       ./configure --with-doxygen=yes
+
+then type `make`.
+
+To access the doxygen documentation, open the doxygen/html/index.html file with
+a web browser.
+
 = Example files =
 
 You can find several example files under examples/ that you can compile by
diff --git a/configure.ac b/configure.ac
index 4698aec055b7..9305766f6390 100644
--- a/configure.ac
+++ b/configure.ac
@@ -45,7 +45,7 @@ AC_CONFIG_FILES([Makefile
 
 AC_ARG_WITH([doxygen], [AS_HELP_STRING([--with-doxygen],
 	    [create doxygen documentation])],
-	    [with_doxygen="$withval"], [with_doxygen=yes])
+	    [with_doxygen="$withval"], [with_doxygen=no])
 
 AS_IF([test "x$with_doxygen" != xno], [
 	AC_CHECK_PROGS([DOXYGEN], [doxygen])
-- 
2.30.2


