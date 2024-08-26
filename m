Return-Path: <netfilter-devel+bounces-3500-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A338095EC7D
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2024 10:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF4F1F22EAE
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2024 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60113E8AE;
	Mon, 26 Aug 2024 08:55:07 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96813C80F
	for <netfilter-devel@vger.kernel.org>; Mon, 26 Aug 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662507; cv=none; b=fEQ1npwtiENNHroe/bmQeiK8XDxwFie2Io2k1BseqxnsaHLPh0uJCxDO+f7lPzL0pIU57mLBD+iw9GWaaWq3lBcuZMCGldPGoW62knZAvLQwE8S34AM4oThIH5o14GCBcgq2ui6NmqPOP5iLHQEurLf0ZIGz0eV5SsRX1pkVxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662507; c=relaxed/simple;
	bh=WGVN9OQQ4E3ublc6hidnlqEbhajkvu5UoytRMWs31fs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2VI9UCqYZY5g+N/SMunF1NLnF69gZCEpwkMXhdRqS2HfghU8GrD1qQI0yuybUplVsE62TdlQuF0kKkEF1doTNfHLqb+xSlcLXyNm9sdZIr9x69XtRty5O5CIrkWhRBaHfQXyjTk25oHa8KvmQAyyRicPLwkb1uUtCqR3X5m27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 6/7] tests: shell: cover anonymous set with reset command
Date: Mon, 26 Aug 2024 10:54:54 +0200
Message-Id: <20240826085455.163392-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826085455.163392-1-pablo@netfilter.org>
References: <20240826085455.163392-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend existing test to reset counters for rules with anonymous set.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1763
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 .../testcases/rule_management/0011reset_0     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/shell/testcases/rule_management/0011reset_0 b/tests/shell/testcases/rule_management/0011reset_0
index 3fede56fb7d8..2004b17d5822 100755
--- a/tests/shell/testcases/rule_management/0011reset_0
+++ b/tests/shell/testcases/rule_management/0011reset_0
@@ -4,6 +4,27 @@
 
 set -e
 
+echo "loading ruleset with anonymous set"
+$NFT -f - <<EOF
+table t {
+        chain dns-nat-pre {
+                type nat hook prerouting priority filter; policy accept;
+                meta l4proto { tcp, udp } th dport 53 ip saddr 10.24.0.0/24 ip daddr != 10.25.0.1 counter packets 1000 bytes 1000 dnat to 10.25.0.1
+        }
+}
+EOF
+
+echo "resetting ruleset with anonymous set"
+$NFT reset rules
+EXPECT='table ip t {
+	chain dns-nat-pre {
+		type nat hook prerouting priority filter; policy accept;
+		meta l4proto { tcp, udp } th dport 53 ip saddr 10.24.0.0/24 ip daddr != 10.25.0.1 counter packets 0 bytes 0 dnat to 10.25.0.1
+	}
+}'
+$DIFF -u <(echo "$EXPECT") <($NFT list ruleset)
+$NFT flush ruleset
+
 echo "loading ruleset"
 $NFT -f - <<EOF
 table ip t {
-- 
2.30.2


