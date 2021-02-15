Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC431C039
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Feb 2021 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhBORNW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Feb 2021 12:13:22 -0500
Received: from correo.us.es ([193.147.175.20]:33098 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhBORMh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:12:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0F0C612BFEE
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Feb 2021 18:11:57 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B5FC0DA73F
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Feb 2021 18:11:56 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AAF88DA793; Mon, 15 Feb 2021 18:11:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8E900DA78B
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Feb 2021 18:11:54 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 15 Feb 2021 18:11:54 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 76F5A42DC700
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Feb 2021 18:11:54 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 2/3] netfilter: nftables: allow to release hooks of one single table
Date:   Mon, 15 Feb 2021 18:11:49 +0100
Message-Id: <20210215171150.4576-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210215171150.4576-1-pablo@netfilter.org>
References: <20210215171150.4576-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a function to release the hooks of one single table.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
initial patch version in this batch (preparation patch)

 net/netfilter/nf_tables_api.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c2b89116dcef..dffb4f8ef17f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8988,15 +8988,20 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
+static void __nft_release_hook(struct net *net, struct nft_table *table)
+{
+	struct nft_chain *chain;
+
+	list_for_each_entry(chain, &table->chains, list)
+		nf_tables_unregister_hook(net, table, chain);
+}
+
 static void __nft_release_hooks(struct net *net)
 {
 	struct nft_table *table;
-	struct nft_chain *chain;
 
-	list_for_each_entry(table, &net->nft.tables, list) {
-		list_for_each_entry(chain, &table->chains, list)
-			nf_tables_unregister_hook(net, table, chain);
-	}
+	list_for_each_entry(table, &net->nft.tables, list)
+		__nft_release_hook(net, table);
 }
 
 static void __nft_release_table(struct net *net, struct nft_table *table)
-- 
2.20.1

