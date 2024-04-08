Return-Path: <netfilter-devel+bounces-1664-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD7B89CD4B
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Apr 2024 23:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4663F281E0B
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Apr 2024 21:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCE1474AF;
	Mon,  8 Apr 2024 21:15:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C14147C62
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Apr 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610952; cv=none; b=GaQUwD8agyX8xp4YUSf0dZIISqF1Kk7lysZ7s2BucAXhQ80WBRZj3pS5xOV8hWBta/KmmvezfkUyv8hz3/n8H4zxo0GbMTwbQ66WT+nPntj276CB4OiB/r+Ct+xHfVCLxjY+pQolDY6HadsFT3ebcRkjk2sVvSjP0EdovlCp4rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610952; c=relaxed/simple;
	bh=NbCo8qWKfFydRTJf4ohsZ2YhIIKqHppCoCwVmVALuIw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FefjpWZLrV67qcNPvcclbS35JCg9FDW6J97o9+xrIWIgUamEwdjNOoOd7VN9pc3FrpmgdXb0UoZDO9s2pjiNpxKAXCzqHmHxdE5xU6pyDFQYFVW5+MGJBpdYOQQsivrjBKXSvnLT8jAsTPow6s4CQYjEhQhOcUaZGUIEWXhE8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 4/4] tests: shell: check for reset tcp options support
Date: Mon,  8 Apr 2024 23:15:40 +0200
Message-Id: <20240408211540.311822-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240408211540.311822-1-pablo@netfilter.org>
References: <20240408211540.311822-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 59a33d08ab3a ("parser: tcpopt: fix tcp option parsing with NUM + length field")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/features/reset_tcp_options.nft   | 5 +++++
 tests/shell/testcases/packetpath/tcp_options | 2 ++
 2 files changed, 7 insertions(+)
 create mode 100644 tests/shell/features/reset_tcp_options.nft

diff --git a/tests/shell/features/reset_tcp_options.nft b/tests/shell/features/reset_tcp_options.nft
new file mode 100644
index 000000000000..47d1c7b8c5a9
--- /dev/null
+++ b/tests/shell/features/reset_tcp_options.nft
@@ -0,0 +1,5 @@
+table inet t {
+        chain c {
+		reset tcp option fastopen
+	}
+}
diff --git a/tests/shell/testcases/packetpath/tcp_options b/tests/shell/testcases/packetpath/tcp_options
index 88552226ee3a..57e228c5990e 100755
--- a/tests/shell/testcases/packetpath/tcp_options
+++ b/tests/shell/testcases/packetpath/tcp_options
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_reset_tcp_options)
+
 have_socat="no"
 socat -h > /dev/null && have_socat="yes"
 
-- 
2.30.2


