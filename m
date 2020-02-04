Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D74A151546
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Feb 2020 06:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgBDFTT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Feb 2020 00:19:19 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:19421 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDFTT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:19:19 -0500
Date:   Tue, 04 Feb 2020 05:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1580793556;
        bh=Zax6tKfFXaDReTKIEN/IKbiLjQfeJ87RgoDScaLjeCg=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=q+SvyvDoXPzT2Hu/cIGCQh1nEJ3rpqJSUfhDGcMcSAQN35XJsQZXdJXDrWrkPAz/y
         jScTCCe9XAU3Ay9uI6TaChPTCiy8cntGXoailWfq5ZyjxdcoyJWzBiJ0xH28961CLn
         EBUJUZZQr6MFqX3BtXrpjqVv4zXQgsRGSlSq3tI0=
To:     netfilter-devel@vger.kernel.org
From:   Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     Laurent Fasnacht <fasnacht@protonmail.ch>
Reply-To: Laurent Fasnacht <fasnacht@protonmail.ch>
Subject: [PATCH nft] tests: shell: add test for glob includes
Message-ID: <20200204051812.14851-1-fasnacht@protonmail.ch>
Feedback-ID: 67Kw-YMwrBchoIMLcnFuA64ZnJub6AgnNvfJUjsgbTTSp4dmymKgGy_PLLqmOsJ9F58iClONCeGYaqp9YPx84w==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_40,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Including more than MAX_INCLUDE_DEPTH file in one statement should succeed.

This reproduces bug #1243.

Signed-off-by: Laurent Fasnacht <fasnacht@protonmail.ch>
---
 .../include/0017glob_more_than_maxdepth_1     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100755 tests/shell/testcases/include/0017glob_more_than_maxdep=
th_1

diff --git a/tests/shell/testcases/include/0017glob_more_than_maxdepth_1 b/=
tests/shell/testcases/include/0017glob_more_than_maxdepth_1
new file mode 100755
index 00000000..6499bcc8
--- /dev/null
+++ b/tests/shell/testcases/include/0017glob_more_than_maxdepth_1
@@ -0,0 +1,39 @@
+#!/bin/bash
+
+set -e
+
+tmpfile=3D$(mktemp)
+if [ ! -w $tmpfile ] ; then
+        echo "Failed to create tmp file" >&2
+        exit 0
+fi
+
+tmpdir1=3D$(mktemp -d)
+if [ ! -d $tmpdir1 ] ; then
+        echo "Failed to create tmp directory" >&2
+        exit 0
+fi
+
+tmpfiles=3D""
+for i in `seq -w 1 32`; do
+        tmpfile2=3D$(mktemp -p $tmpdir1)
+        if [ ! -w $tmpfile2 ] ; then
+                echo "Failed to create tmp file" >&2
+                exit 0
+        fi
+        tmpfiles=3D"$tmpfiles $tmpfile2"
+done
+
+trap "rm -rf $tmpfile $tmpfiles && rmdir $tmpdir1" EXIT # cleanup if abort=
ed
+
+RULESET=3D" \
+include \"$tmpdir1/*\"
+"
+
+echo "$RULESET" > $tmpfile
+
+$NFT -f $tmpfile
+if [ $? -ne 0 ] ; then
+=09echo "E: unable to load good ruleset" >&2
+=09exit 1
+fi
--=20
2.20.1


