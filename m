Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE58210F3CB
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Dec 2019 01:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfLCAGH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 19:06:07 -0500
Received: from correo.us.es ([193.147.175.20]:50760 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfLCAGH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:06:07 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8A755C04EC
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Dec 2019 01:06:04 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7BDD0DA703
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Dec 2019 01:06:04 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 71663DA707; Tue,  3 Dec 2019 01:06:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 557A4DA703
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Dec 2019 01:06:02 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 03 Dec 2019 01:06:02 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 319454265A5A
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Dec 2019 01:06:02 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] include: include nf_tables_compat.h in tarball
Date:   Tue,  3 Dec 2019 01:06:00 +0100
Message-Id: <20191203000600.824483-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add it to Makefile.am so make distcheck includes it in tarballs.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/netfilter/Makefile.am b/include/linux/netfilter/Makefile.am
index 3227d4e83d79..04c9ab80a77c 100644
--- a/include/linux/netfilter/Makefile.am
+++ b/include/linux/netfilter/Makefile.am
@@ -3,6 +3,7 @@ noinst_HEADERS = 	nf_conntrack_common.h		\
 			nf_log.h			\
 			nf_nat.h			\
 			nf_tables.h			\
+			nf_tables_compat.h		\
 			nf_synproxy.h			\
 			nfnetlink_osf.h			\
 			nfnetlink.h
-- 
2.11.0

