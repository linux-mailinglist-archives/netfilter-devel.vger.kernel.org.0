Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B471AFFDE
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2020 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDTCax (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Apr 2020 22:30:53 -0400
Received: from mail.redfish-solutions.com ([45.33.216.244]:50894 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgDTCax (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:30:53 -0400
X-Greylist: delayed 7975 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 22:30:53 EDT
Received: from son-of-builder.redfish-solutions.com (son-of-builder.redfish-solutions.com [192.168.1.56])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id 03JC3d8S010087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Apr 2020 06:03:39 -0600
From:   "Philip Prindeville" <philipp@redfish-solutions.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Philip Prindeville <philipp@redfish-solutions.com>
Subject: [PATCH v1 1/1] xtables-addons: geoip: Update download script for DBIP database
Date:   Sun, 19 Apr 2020 20:24:41 -0600
Message-Id: <20200420022441.10941-1-philipp@redfish-solutions.com>
X-Mailer: git-send-email 2.17.2
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Philip Prindeville <philipp@redfish-solutions.com>

Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>
---
 geoip/xt_geoip_dl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/geoip/xt_geoip_dl b/geoip/xt_geoip_dl
old mode 100755
new mode 100644
index 1de60442a8040f55d775d134d7a8ea707582d71e..91aa95b650a968fb8cd989ac5b08ec890a45f008
--- a/geoip/xt_geoip_dl
+++ b/geoip/xt_geoip_dl
@@ -1,7 +1,11 @@
 #!/bin/sh
 
-rm -rf GeoLite2-Country-CSV_*
+timestamp=$(date "+%Y-%m")
 
-wget -q http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country-CSV.zip
-unzip -q GeoLite2-Country-CSV.zip
-rm -f GeoLite2-Country-CSV.zip
+wget -q "https://download.db-ip.com/free/dbip-country-lite-${timestamp}.csv.gz"
+
+zcat dbip-country-lite-${timestamp}.csv.gz > dbip-country-lite.csv
+
+rm -f dbip-country-lite-${timestamp}.csv.gz
+
+exit 0
-- 
2.17.2

