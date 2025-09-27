Return-Path: <netfilter-devel+bounces-8950-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E613BBA5F8C
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Sep 2025 15:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6B43A55E1
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Sep 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438E1D88A4;
	Sat, 27 Sep 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=truschnigg.info header.i=@truschnigg.info header.b="qTD5lA0s"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from truschnigg.info (truschnigg.info [78.41.115.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816F1D6193
	for <netfilter-devel@vger.kernel.org>; Sat, 27 Sep 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.41.115.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758978926; cv=none; b=feLa+wmdYtfBUyjmVQ3K3XDYdFry40ctRfrpFdYGgJcVlYvEo6F9kjR/Omr/NKNsLs7dfiTrtAZcWPNAwvElTHYQ1FSGAvcoNCmRdN1A+AdGlr3En6zedvR/14f5d9G/fxoHfTmjHf+lTVYcVl6gdSkIQi0v3bhyi+To9tNEQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758978926; c=relaxed/simple;
	bh=FB6MONNauj3BovmS9kU6/BPB+sATBPX+NIEpxS/V8fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5XM/kUfsh+2RxWfbEBFAfIekz33U8+2Ea4zbMX5MSU0k0a9QzrD6wY0o9FXk9TAzFH/6MJh1v9hwyTYavnHeYz9O0KxC6kTgx5UpiMXbJrd1/SO531vwk37MUB36MKHeYYoerTG5GMZySh3XDDtxzODAOCB1Zv+J+ChsGqxpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=truschnigg.info; spf=pass smtp.mailfrom=truschnigg.info; dkim=pass (2048-bit key) header.d=truschnigg.info header.i=@truschnigg.info header.b=qTD5lA0s; arc=none smtp.client-ip=78.41.115.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=truschnigg.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truschnigg.info
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=truschnigg.info;
	s=m22; t=1758978922;
	bh=FB6MONNauj3BovmS9kU6/BPB+sATBPX+NIEpxS/V8fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTD5lA0sGS0tx5yQTJI2vixVQRMmIpod4xFVBaoBTGTDOBY5SJloDgSxp7PveZJi7
	 GpSO/39UabTDh3M5wqGNV8LThR/o9amJgSy1ulcMWCgKKdQQfy5WjGt9PlvF7vAed4
	 4EHIkY94RET1gX65+hGnR9V2zocFbCokLoPX/yMGpTKiK7ioxQtqqropMPfuRQxVh0
	 j+tGZoroa3CENSDxtDRlF8LJXov5UuooqxQlLThoTgqECvs5nrob4by4qh6iB6fJVI
	 RuTWBGCMNrcElLUZl2m3og20PNjH2HcqHXsNLmOVT8I3ttyWV7j4aDgBlX9ExKlWgs
	 6U7EOV7zcTlKw==
Received: from ryzealot.forensik.justiz.gv.at (unknown [IPv6:2a02:1748:fafe:cf3f:aea0:d9c0:c637:21a1])
	by truschnigg.info (Postfix) with ESMTPSA id A9D1F3F2B7;
	Sat, 27 Sep 2025 13:15:22 +0000 (UTC)
From: Johannes Truschnigg <johannes@truschnigg.info>
To: netfilter-devel@vger.kernel.org
Cc: Johannes Truschnigg <johannes@truschnigg.info>
Subject: [PATCH] Don't shell out for getting current date and table names
Date: Sat, 27 Sep 2025 15:00:39 +0200
Message-ID: <20250927131421.24756-3-johannes@truschnigg.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927131421.24756-2-johannes@truschnigg.info>
References: <20250927131421.24756-2-johannes@truschnigg.info>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also use a sane timestamp format (ISO 8601) in the output.
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


