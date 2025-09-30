Return-Path: <netfilter-devel+bounces-8968-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B53BAE471
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Sep 2025 20:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AEA174D71
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Sep 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AC26F280;
	Tue, 30 Sep 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truschnigg.info header.i=@truschnigg.info header.b="HmniHRcC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from truschnigg.info (truschnigg.info [78.41.115.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F972617
	for <netfilter-devel@vger.kernel.org>; Tue, 30 Sep 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.41.115.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255718; cv=none; b=TDvahf8PEfjObVTx0DdgQ9l4o3KW5iHmx67zk0NvLvSCWIrSq37g/wxt4/o0crq0kqNF8Bqkecce+3Pj+05INY0a93H74ZAcu6ClZRQewVpkrIWMfrXR67jQjgl76P0z8Eu4LjpeYIaxkb93Lj9W7Vnn3K4Y4xSw63vBEjsmouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255718; c=relaxed/simple;
	bh=gu0dR83a6XXAca9dtZOcylvWaErWaHExoxBfy3Vzx7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt42uzchURoomy72d8cMUzrRJZOztTmrPghzNQEvzmJMk5sHhTymjcHYLuEJDq6HCH+VkRKrGqPTLvo+BVE+rXNDbdS0EA8y3PJ5QEpcF+LfsvNnjqiT1NNFYPXBPO4vBNF24W7mIdUzGZl1I9qAm7uzTOJG5gmUgIxKMlcUbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=truschnigg.info; spf=pass smtp.mailfrom=truschnigg.info; dkim=pass (2048-bit key) header.d=truschnigg.info header.i=@truschnigg.info header.b=HmniHRcC; arc=none smtp.client-ip=78.41.115.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=truschnigg.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truschnigg.info
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=truschnigg.info;
	s=m22; t=1759255708;
	bh=gu0dR83a6XXAca9dtZOcylvWaErWaHExoxBfy3Vzx7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=HmniHRcCY6u9/f4gkHaNxS934sDhAJkG44Ia9qbjjaSY6cQaAh2RGyyxd4XCilta6
	 AOgsWu6PdXorLkrDg5kdDEHvZ9uiXtaTZFykmbctEkmt4MCRBXfrpn7jqgx/KrhBTi
	 s4mRMTQiC33zEG592CLzJbud1Js3rrxKC78oHdpCryBd8YeoGqNMigblSA5q0nxiPe
	 9TrZdw5Pv1lBbtA0auO49znYWUmwNyxmdRT8i32vXZJ4ErpbPDjfc1kL/WLJ5PhCDu
	 iL/68IPn8j7hU2NNrv9xq6DJ6llCc/qj1Xbbp3TTNHyd0G/DpIZwG0a2yM6YT7xRHn
	 2RYI4RpPI/91w==
Received: from ryzealot.forensik.justiz.gv.at (unknown [IPv6:2a02:1748:fafe:cf3f:526d:1663:49ad:7fac])
	by truschnigg.info (Postfix) with ESMTPSA id B30D13F2B8;
	Tue, 30 Sep 2025 18:08:28 +0000 (UTC)
From: Johannes Truschnigg <johannes@truschnigg.info>
To: netfilter-devel@vger.kernel.org
Cc: Johannes Truschnigg <johannes@truschnigg.info>
Subject: [PATCH v2] Don't shell out for getting current date and table names
Date: Tue, 30 Sep 2025 20:06:16 +0200
Message-ID: <20250930180809.2095030-2-johannes@truschnigg.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930180809.2095030-1-johannes@truschnigg.info>
References: <aNuvKZN9WM8bVRkn@strlen.de>
 <20250930180809.2095030-1-johannes@truschnigg.info>
Reply-To: Johannes Truschnigg <johannes@truschnigg.info>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also use a sane timestamp format (ISO 8601) in the output.

Signed-off-by: Johannes Truschnigg <johannes@truschnigg.info>
---
 ebtables-save.in | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/ebtables-save.in b/ebtables-save.in
index 17924a2..4438050 100644
--- a/ebtables-save.in
+++ b/ebtables-save.in
@@ -7,11 +7,14 @@
 # It can be used to store active configuration to /etc/sysconfig/ebtables
 
 use strict;
+use POSIX qw(strftime);
 my $table;
 my $ebtables = "@sbindir@/ebtables";
 my $cnt = "";
-my $version = "1.0";
+my $version = "1.1";
 my $table_name;
+my $modulesfh;
+my @tables;
 
 # ========================================================
 # Process filter table
@@ -50,11 +53,21 @@ sub process_table {
 # ========================================================
 
 unless (-x $ebtables) { exit -1 };
-print "# Generated by ebtables-save v$version (legacy) on " . `date`;
+
+open $modulesfh, '<', '/proc/modules' or die "Failed to open /proc/modules: $!";
+while( my $line = <$modulesfh>) {
+    if($line =~ /^ebtable_([^ ]+)/) {
+        push @tables, $1;
+    }
+}
+close $modulesfh;
+
+printf("# Generated by ebtables-save v$version (legacy) on %s\n", strftime("%a %FT%TZ", gmtime));
 if (defined($ENV{'EBTABLES_SAVE_COUNTER'}) && $ENV{'EBTABLES_SAVE_COUNTER'} eq "yes") {
     $cnt = "--Lc";
 }
-foreach $table_name (split("\n", `grep -E '^ebtable_' /proc/modules | cut -f1 -d' ' | sed s/ebtable_//`)) {
+
+foreach $table_name (@tables) {
     $table =`$ebtables -t $table_name -L $cnt`;
     unless ($? == 0) { print $table; exit -1 };
     &process_table($table);
-- 
2.51.0


