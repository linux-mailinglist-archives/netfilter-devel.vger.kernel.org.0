Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D879932CAAF
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Mar 2021 04:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCDDFd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Mar 2021 22:05:33 -0500
Received: from correo.us.es ([193.147.175.20]:37336 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbhCDDFb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:05:31 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0F616DA72B
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Mar 2021 04:04:50 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F1AE6DA704
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Mar 2021 04:04:49 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E6863DA72F; Thu,  4 Mar 2021 04:04:49 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AC4DFDA704
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Mar 2021 04:04:47 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 04 Mar 2021 04:04:47 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 9881B42DC6E3
        for <netfilter-devel@vger.kernel.org>; Thu,  4 Mar 2021 04:04:47 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/2,v2] netfilter: nftables: fix possible double hook unregistration with table owner
Date:   Thu,  4 Mar 2021 04:04:43 +0100
Message-Id: <20210304030444.4312-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Skip hook unregistration of owner tables from the netns exit path,
nft_rcv_nl_event() unregisters the table hooks before tearing down
the table content.

Fixes: 6001a930ce03 ("netfilter: nftables: introduce table ownership")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no need for portID to be specified.

 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b07703e19108..796ce86ef7eb 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9028,8 +9028,12 @@ static void __nft_release_hooks(struct net *net)
 {
 	struct nft_table *table;
 
-	list_for_each_entry(table, &net->nft.tables, list)
+	list_for_each_entry(table, &net->nft.tables, list) {
+		if (nft_table_has_owner(table))
+			continue;
+
 		__nft_release_hook(net, table);
+	}
 }
 
 static void __nft_release_table(struct net *net, struct nft_table *table)
-- 
2.20.1

