Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E45ED09F
	for <lists+netfilter-devel@lfdr.de>; Sat,  2 Nov 2019 22:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKBVBW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 2 Nov 2019 17:01:22 -0400
Received: from mx1.riseup.net ([198.252.153.129]:40074 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfKBVBW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 2 Nov 2019 17:01:22 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 475BKd5864zFcD2
        for <netfilter-devel@vger.kernel.org>; Sat,  2 Nov 2019 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1572728481; bh=WX1PUK921vAPoIQq2SYStbjSMDyOUYqxHwcpf7A4xwc=;
        h=From:To:Cc:Subject:Date:From;
        b=VECb6/q96CTnU+fJLD7FV+X9S3NX70Z0/8E9kyCuDJdNbJLmCpTG3KWtKoSGIOeM7
         YM1qlg0Ar2qeo6ZvvR9ab7WKC/PkLt4J2b/NNRnBWn+YXRPI8WnAMn07k873jrUngh
         AsggV6ITuWl0P4IbRd9sce8Qo5Up8Wkv4WRxaLqM=
X-Riseup-User-ID: 93401DAAF15783170FA5DBEAB7DA962382FD7D1EFE546612F52155CAD692623F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 475BKc6Q3hz8srF;
        Sat,  2 Nov 2019 14:00:36 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nft] tests: add stateful object update operation test
Date:   Sat,  2 Nov 2019 22:00:25 +0100
Message-Id: <20191102210024.22311-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 .../optionals/update_object_handles_0         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 tests/shell/testcases/optionals/update_object_handles_0

diff --git a/tests/shell/testcases/optionals/update_object_handles_0 b/tests/shell/testcases/optionals/update_object_handles_0
new file mode 100755
index 0000000..17c0c86
--- /dev/null
+++ b/tests/shell/testcases/optionals/update_object_handles_0
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+set -e
+$NFT add table test-ip
+$NFT add counter test-ip traffic-counter
+$NFT add counter test-ip traffic-counter
+$NFT add quota test-ip traffic-quota 25 mbytes
+$NFT add quota test-ip traffic-quota 50 mbytes
+
+EXPECTED="table ip test-ip {
+	counter traffic-counter {
+		packets 0 bytes 0
+	}
+
+	quota traffic-quota {
+		50 mbytes
+	}
+}"
+
+GET="$($NFT list ruleset)"
+if [ "$EXPECTED" != "$GET" ] ; then
+	DIFF="$(which diff)"
+	[ -x $DIFF ] && $DIFF -u <(echo "$EXPECTED") <(echo "$GET")
+	exit 1
+fi
-- 
2.20.1

