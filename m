Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790B01BB1FE
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 01:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0XZY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Apr 2020 19:25:24 -0400
Received: from correo.us.es ([193.147.175.20]:48900 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgD0XZX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:25:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 063AEDA885
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:25:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EC3E7DA736
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:25:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E1CDBBAC2F; Tue, 28 Apr 2020 01:25:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DBBB0DA736
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:25:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Apr 2020 01:25:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C749942EF9E0
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:25:19 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack-tools] conntrack: add support for the IPS_HW_OFFLOAD flag
Date:   Tue, 28 Apr 2020 01:25:16 +0200
Message-Id: <20200427232516.22559-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds support for the IPS_HW_OFFLOAD flag which specifies that
this conntrack entry has been offloaded into the hardware.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/nf_conntrack_common.h | 18 ++++++++++++++++--
 src/conntrack.c                               |  4 ++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_common.h b/include/linux/netfilter/nf_conntrack_common.h
index 8023e5b6572f..16d20a3b2ff0 100644
--- a/include/linux/netfilter/nf_conntrack_common.h
+++ b/include/linux/netfilter/nf_conntrack_common.h
@@ -97,6 +97,15 @@ enum ip_conntrack_status {
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
@@ -105,14 +114,19 @@ enum ip_conntrack_status {
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
diff --git a/src/conntrack.c b/src/conntrack.c
index f65926b298ad..fb4e5be86ed8 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -870,8 +870,8 @@ static struct parse_parameter {
 	size_t  size;
 	unsigned int value[8];
 } parse_array[PARSE_MAX] = {
-	{ {"ASSURED", "SEEN_REPLY", "UNSET", "FIXED_TIMEOUT", "EXPECTED", "OFFLOAD"}, 6,
-	  { IPS_ASSURED, IPS_SEEN_REPLY, 0, IPS_FIXED_TIMEOUT, IPS_EXPECTED, IPS_OFFLOAD} },
+	{ {"ASSURED", "SEEN_REPLY", "UNSET", "FIXED_TIMEOUT", "EXPECTED", "OFFLOAD", "HW_OFFLOAD"}, 7,
+	  { IPS_ASSURED, IPS_SEEN_REPLY, 0, IPS_FIXED_TIMEOUT, IPS_EXPECTED, IPS_OFFLOAD, IPS_HW_OFFLOAD} },
 	{ {"ALL", "NEW", "UPDATES", "DESTROY"}, 4,
 	  { CT_EVENT_F_ALL, CT_EVENT_F_NEW, CT_EVENT_F_UPD, CT_EVENT_F_DEL } },
 	{ {"xml", "extended", "timestamp", "id", "ktimestamp", "labels", "userspace" }, 7,
-- 
2.20.1

