Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E5C1E150D
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2020 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbgEYUGK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 May 2020 16:06:10 -0400
Received: from mail.redfish-solutions.com ([45.33.216.244]:46406 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388794AbgEYUGK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 May 2020 16:06:10 -0400
Received: from son-of-builder.redfish-solutions.com (son-of-builder.redfish-solutions.com [192.168.1.56])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id 04PK6535013880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 14:06:05 -0600
From:   "Philip Prindeville" <philipp@redfish-solutions.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Philip Prindeville <philipp@redfish-solutions.com>
Subject: [PATCH 1/1] geoip: add quiet flag to xt_geoip_build
Date:   Mon, 25 May 2020 14:05:42 -0600
Message-Id: <20200525200542.29000-1-philipp@redfish-solutions.com>
X-Mailer: git-send-email 2.17.2
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Philip Prindeville <philipp@redfish-solutions.com>

Conceivably someone might want to run a refresh of the geoip database
from within a script, particularly an unattended script such as a cron
job.  Don't generate output in that case.

Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>
---
 geoip/xt_geoip_build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/geoip/xt_geoip_build b/geoip/xt_geoip_build
index e7ad9bfdcc1e3b617ada77872f9be87e126b885f..84333892e61e463269790580b08ac5c33d994018 100644
--- a/geoip/xt_geoip_build
+++ b/geoip/xt_geoip_build
@@ -17,11 +17,14 @@ my $csv = Text::CSV_XS->new({
 	binary => 1,
 	eol => $/,
 }); # or Text::CSV
+
+my $quiet = 0;
 my $source_dir = ".";
 my $target_dir = ".";
 
 &Getopt::Long::Configure(qw(bundling));
 &GetOptions(
+	"q" => \$quiet,
 	"D=s" => \$target_dir,
 	"S=s" => \$source_dir,
 );
@@ -63,12 +66,12 @@ sub collect
 			$country{$cc}->{pool_v6}->add_range($range);
 		}
 
-		if ($. % 4096 == 0) {
+		if (!$quiet && $. % 4096 == 0) {
 			print STDERR "\r\e[2K$. entries";
 		}
 	}
 
-	print STDERR "\r\e[2K$. entries total\n";
+	print STDERR "\r\e[2K$. entries total\n" unless ($quiet);
 
 	close($fh);
 
@@ -106,7 +109,7 @@ sub writeCountry
 	printf "%5u IPv%s ranges for %s\n",
 		scalar(@ranges),
 		($family == AF_INET ? '4' : '6'),
-		$iso_code;
+		$iso_code unless ($quiet);
 
 	my $file = "$target_dir/".uc($iso_code).".iv".($family == AF_INET ? '4' : '6');
 	if (!open($fh, '>', $file)) {
-- 
2.17.2

