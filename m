Return-Path: <netfilter-devel+bounces-3264-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD311951893
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2024 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779491F23A41
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2024 10:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FAE1586D3;
	Wed, 14 Aug 2024 10:21:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCEF14264C
	for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630865; cv=none; b=WW6Fw1Fp/bk2RMIERfLGsFtysH1ScQCOkL/nJmYM1IFy9Lof8EJIKH7sePrMA9IhwYWv92RNUPQ7LsMkCCTY1lHz7DcmnNT98sftLWUW0NSdEWIecJg+wabwn09++ueeZsS0zv3eKY7/UQMgoYnF8heaoaAbbyPZbJFuHffcITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630865; c=relaxed/simple;
	bh=Hy0yYREpMU1GQF0ZJTpiJN5rpbkqXn0fCqkHy5+X3CY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DXa6CwCC+5aYBUlg4QRf94Fc7aw0/GS0zH115c8nXA9/KYmSH1LMnBkIiBxfXmdutqoeOPZ4s60TuV/o/RHDZ9rKq2JAj1C1okol1jkkBpe/n938YbAxSKpY0SseyUAtrq5qUdRwx0N4n4xVnQBil8Gwt45rEp4L3W7Xssirqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH] tests: shell: skip vlan mangling testcase if egress is not support
Date: Wed, 14 Aug 2024 12:20:55 +0200
Message-Id: <20240814102055.202090-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dependency on egress hook to skip this test in older kernels.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/packetpath/vlan_mangling | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/shell/testcases/packetpath/vlan_mangling b/tests/shell/testcases/packetpath/vlan_mangling
index b3f87c66ddec..e3fd443ebcf9 100755
--- a/tests/shell/testcases/packetpath/vlan_mangling
+++ b/tests/shell/testcases/packetpath/vlan_mangling
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_netdev_egress)
+
 rnd=$(mktemp -u XXXXXXXX)
 ns1="nft1ifname-$rnd"
 ns2="nft2ifname-$rnd"
-- 
2.30.2


