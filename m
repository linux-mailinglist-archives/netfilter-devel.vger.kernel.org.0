Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E363C1BB1F7
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 01:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgD0XXD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Apr 2020 19:23:03 -0400
Received: from correo.us.es ([193.147.175.20]:48200 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgD0XXD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:23:03 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D0ADCDA7F0
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:23:01 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C2F7CDA736
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:23:01 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B893FDA7B2; Tue, 28 Apr 2020 01:23:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B4811BAAA3
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:22:59 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Apr 2020 01:22:59 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A1A7842EF9E0
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:22:59 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack] src: add IPS_HW_OFFLOAD flag
Date:   Tue, 28 Apr 2020 01:22:56 +0200
Message-Id: <20200427232256.22466-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This flags specifies that this conntrack entry is in hardware.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../linux_nf_conntrack_common.h                | 18 ++++++++++++++++--
 src/conntrack/snprintf_default.c               |  4 +++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/libnetfilter_conntrack/linux_nf_conntrack_common.h b/include/libnetfilter_conntrack/linux_nf_conntrack_common.h
index 32efa357c8db..131ca258a904 100644
--- a/include/libnetfilter_conntrack/linux_nf_conntrack_common.h
+++ b/include/libnetfilter_conntrack/linux_nf_conntrack_common.h
@@ -102,6 +102,15 @@ enum ip_conntrack_status {
 	IPS_UNTRACKED_BIT = 12,
 	IPS_UNTRACKED = (1 << IPS_UNTRACKED_BIT),
 
+#ifdef __KERNEL__
+	/* Re-purposed for in-kernel use:
+	 * Tags a conntrack entry that clashed with an existing entry
+	 * on insert.
+	 */
+	IPS_NAT_CLASH_BIT = IPS_UNTRACKED_BIT,
+	IPS_NAT_CLASH = IPS_UNTRACKED,
+#endif
+
 	/* Conntrack got a helper explicitly attached via CT target. */
 	IPS_HELPER_BIT = 13,
 	IPS_HELPER = (1 << IPS_HELPER_BIT),
@@ -110,14 +119,19 @@ enum ip_conntrack_status {
 	IPS_OFFLOAD_BIT = 14,
 	IPS_OFFLOAD = (1 << IPS_OFFLOAD_BIT),
 
+	/* Conntrack has been offloaded to hardware. */
+	IPS_HW_OFFLOAD_BIT = 15,
+	IPS_HW_OFFLOAD = (1 << IPS_HW_OFFLOAD_BIT),
+
 	/* Be careful here, modifying these bits can make things messy,
 	 * so don't let users modify them directly.
 	 */
 	IPS_UNCHANGEABLE_MASK = (IPS_NAT_DONE_MASK | IPS_NAT_MASK |
 				 IPS_EXPECTED | IPS_CONFIRMED | IPS_DYING |
-				 IPS_SEQ_ADJUST | IPS_TEMPLATE | IPS_OFFLOAD),
+				 IPS_SEQ_ADJUST | IPS_TEMPLATE | IPS_UNTRACKED |
+				 IPS_OFFLOAD | IPS_HW_OFFLOAD),
 
-	__IPS_MAX_BIT = 15,
+	__IPS_MAX_BIT = 16,
 };
 
 /* Connection tracking event types */
diff --git a/src/conntrack/snprintf_default.c b/src/conntrack/snprintf_default.c
index 765ce726ea7d..2f2f91864d39 100644
--- a/src/conntrack/snprintf_default.c
+++ b/src/conntrack/snprintf_default.c
@@ -184,7 +184,9 @@ static int __snprintf_status_assured(char *buf,
 {
 	int size = 0;
 
-	if (ct->status & IPS_OFFLOAD)
+	if (ct->status & IPS_HW_OFFLOAD)
+		size = snprintf(buf, len, "[HW_OFFLOAD] ");
+	else if (ct->status & IPS_OFFLOAD)
 		size = snprintf(buf, len, "[OFFLOAD] ");
 	else if (ct->status & IPS_ASSURED)
 		size = snprintf(buf, len, "[ASSURED] ");
-- 
2.20.1

