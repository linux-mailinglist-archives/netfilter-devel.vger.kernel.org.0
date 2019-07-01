Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659941ADE5
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2019 21:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfELTBO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 May 2019 15:01:14 -0400
Received: from mail.us.es ([193.147.175.20]:50728 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfELTBO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 May 2019 15:01:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EB17D1A098C
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 21:01:11 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DDFB3DA703
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 21:01:11 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D3CE1DA702; Sun, 12 May 2019 21:01:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0730DA704
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 21:01:09 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 12 May 2019 21:01:09 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C04354265A31
        for <netfilter-devel@vger.kernel.org>; Sun, 12 May 2019 21:01:09 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: incorrect definition for NFT_LOGLEVEL_MAX
Date:   Sun, 12 May 2019 21:01:06 +0200
Message-Id: <20190512190106.13971-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: 7eced5ab5a73 ("netfilter: nf_tables: add NFT_LOGLEVEL_* enumeration and use it")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 9232dd47ff2f..7501d4662a56 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1140,7 +1140,7 @@ enum nft_log_level {
 	NFT_LOGLEVEL_AUDIT,
 	__NFT_LOGLEVEL_MAX
 };
-#define NFT_LOGLEVEL_MAX	(__NFT_LOGLEVEL_MAX + 1)
+#define NFT_LOGLEVEL_MAX	(__NFT_LOGLEVEL_MAX - 1)
 
 /**
  * enum nft_queue_attributes - nf_tables queue expression netlink attributes
-- 
2.11.0

