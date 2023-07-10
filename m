Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455074CB6C
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jul 2023 06:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjGJEwa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jul 2023 00:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGJEw3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:52:29 -0400
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [24.116.100.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5230BD
        for <netfilter-devel@vger.kernel.org>; Sun,  9 Jul 2023 21:52:27 -0700 (PDT)
Received: from ubuntu22.redfish-solutions.com (ubuntu22.redfish-solutions.com [192.168.8.33])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.17.1/8.16.1) with ESMTPSA id 36A4bnAQ060316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 9 Jul 2023 22:37:50 -0600
From:   "Philip Prindeville" <philipp@redfish-solutions.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Philip Prindeville <philipp@redfish-solutions.com>
Subject: [PATCH 1/1] xt_asn: fix download script
Date:   Sun,  9 Jul 2023 22:37:49 -0600
Message-Id: <20230710043749.2682083-1-philipp@redfish-solutions.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 192.168.8.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Philip Prindeville <philipp@redfish-solutions.com>

If the server ever existed, it's been retired now.  Use the download
server instead.

Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>
---
 asn/xt_asn_dl | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/asn/xt_asn_dl b/asn/xt_asn_dl
index 42320365b059bec993767b81d722c589b46ca23d..60bd598e04ad8350a9bac10fbf8839ab4b7a4485 100755
--- a/asn/xt_asn_dl
+++ b/asn/xt_asn_dl
@@ -1,5 +1,16 @@
 #!/bin/sh
+
+if [ $# -eq 1 ]; then
+    exec <$1
+elif [ $# -ne 0 ]; then
+    echo $(basename $0) [ licence_key_file ] 1>&2
+    exit 1
+fi
+
+read licence_key
+
 rm -rf GeoLite2-ASN-CSV_*
-wget -q http://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN-CSV.zip
+
+wget -q -OGeoLite2-ASN-CSV.zip "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN-CSV&license_key=${licence_key}&suffix=zip"
 unzip -q GeoLite2-ASN-CSV.zip
 rm -f GeoLite2-ASN-CSV.zip
-- 
2.34.1

