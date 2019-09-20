Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7119CB90E0
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2019 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfITNoc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Sep 2019 09:44:32 -0400
Received: from correo.us.es ([193.147.175.20]:44900 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbfITNoc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:44:32 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B1C49508CD3
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A37CFB7FFB
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 990A7B7FF9; Fri, 20 Sep 2019 15:44:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9D2696D289
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Sep 2019 15:44:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [5.182.56.138])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 4CA424265A5A
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:26 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack-tools 2/2] conntrackd: incorrect filtering of Address with cidr /0
Date:   Fri, 20 Sep 2019 15:44:21 +0200
Message-Id: <20190920134421.11628-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190920134421.11628-1-pablo@netfilter.org>
References: <20190920134421.11628-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Set an all zero mask when cidr /0 is specified.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cidr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/cidr.c b/src/cidr.c
index 91025b6091ed..6ef85c74a626 100644
--- a/src/cidr.c
+++ b/src/cidr.c
@@ -24,6 +24,9 @@
 /* returns the netmask in host byte order */
 uint32_t ipv4_cidr2mask_host(uint8_t cidr)
 {
+	if (cidr == 0)
+		return 0;
+
 	return 0xFFFFFFFF << (32 - cidr);
 }
 
@@ -42,10 +45,13 @@ void ipv6_cidr2mask_host(uint8_t cidr, uint32_t *res)
 		res[i] = 0xFFFFFFFF;
 		cidr -= 32;
 	}
-	res[i] = 0xFFFFFFFF << (32 - cidr);
-	for (j = i+1; j < 4; j++) {
+	if (cidr == 0)
+		res[i] = 0;
+	else
+		res[i] = 0xFFFFFFFF << (32 - cidr);
+
+	for (j = i + 1; j < 4; j++)
 		res[j] = 0;
-	}
 }
 
 void ipv6_cidr2mask_net(uint8_t cidr, uint32_t *res)
-- 
2.11.0

