Return-Path: <netfilter-devel+bounces-8014-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A28B0F6DE
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jul 2025 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A085D3A9DB1
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jul 2025 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131122F2C44;
	Wed, 23 Jul 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="iIqQusM/"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388EC2F49E7
	for <netfilter-devel@vger.kernel.org>; Wed, 23 Jul 2025 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283879; cv=none; b=BxyBT00a6pv/CsBYg/DnNHgeLwgQSPGAnV3bOLjVNcfCPWuTDy0Kkf0Xv8qaVCHA8G25lKjzne+wTOTGHLUQ4oGSqiDJTYSvtogRErKNdudKQkaVgvjLO1Gxk+USD1rNq0aMo/w4WMh12o/KUI8eAdZaryJwXQkdl205Thq6N6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283879; c=relaxed/simple;
	bh=h7sm+lyc0pxce2RSLDqm5CYxQXekJ+iMwkDNg+mVup8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClDZFTlG51E2fztKi5Fi4paLq1t57Ycpt1dGFU05LGqArLE0Qffe22Z3cKzXDhTHxENNj3J8mfqWU4mBmq/9IsOr7k3KY390GuhA5ew0KioBG8amCjNb/Bmm/NK1OKwYlKAc1eeH6Qd/gqqAiFUsY3NbSLLS4JspzNc6EmsK4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=iIqQusM/; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6EfI6oeV1vuB1P49YF1bTAd8z3TjFPwfd0Bkd7/kkf8=; b=iIqQusM/OKT5MTDsgnhAU4EuQ7
	t2+6GUNkgUiFtpuQVm+a0kRczYPRWyzKwWrwkm0OQa/XR4vSlbQDA91LWpQrWbEpsLY5uwzJTVkpw
	uhtXCRLt5CHeMCfunsZ3pGB0R2fT5duEiJnEDEruDsJbxgutyNUYaVGZWocoDR86oNMg7ls+JxTwp
	apGP81jiQPZ3f7JrHhLtW0j+IXF4If7ipMhu7Bjz6m6n8Ryp06LgOFAewUEjGvrWGst/I0xe8LQW2
	F8bQkzGYrGXCbKTGc1jTGkmRamH30+/ZC8mpDmvNuyM8uja26fLH6asuYhJkL8bcX75o48Jtd9AZH
	6E1Oa0Vw==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1uebEA-000000000bZ-0f1u;
	Wed, 23 Jul 2025 17:17:54 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: [nf PATCH] selftests: netfilter: Ignore tainted kernels in interface stress test
Date: Wed, 23 Jul 2025 17:17:48 +0200
Message-ID: <20250723151748.17084-1-phil@nwl.cc>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complain about kernel taint value only if it wasn't set at start
already.

Fixes: 73db1b5dab6f ("selftests: netfilter: Torture nftables netdev hooks")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../testing/selftests/net/netfilter/nft_interface_stress.sh  | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_interface_stress.sh b/tools/testing/selftests/net/netfilter/nft_interface_stress.sh
index 5ff7be9daeee..c0fffaa6dbd9 100755
--- a/tools/testing/selftests/net/netfilter/nft_interface_stress.sh
+++ b/tools/testing/selftests/net/netfilter/nft_interface_stress.sh
@@ -10,6 +10,8 @@ source lib.sh
 checktool "nft --version" "run test without nft tool"
 checktool "iperf3 --version" "run test without iperf3 tool"
 
+read kernel_tainted < /proc/sys/kernel/tainted
+
 # how many seconds to torture the kernel?
 # default to 80% of max run time but don't exceed 48s
 TEST_RUNTIME=$((${kselftest_timeout:-60} * 8 / 10))
@@ -135,7 +137,8 @@ else
 	wait
 fi
 
-[[ $(</proc/sys/kernel/tainted) -eq 0 ]] || {
+
+[[ $kernel_tainted -eq 0 && $(</proc/sys/kernel/tainted) -ne 0 ]] && {
 	echo "FAIL: Kernel is tainted!"
 	exit $ksft_fail
 }
-- 
2.49.0


