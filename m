Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEE30C39C
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Feb 2021 16:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhBBPYT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Feb 2021 10:24:19 -0500
Received: from correo.us.es ([193.147.175.20]:50264 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235414AbhBBPXc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:23:32 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 69B4FD28D0
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Feb 2021 16:22:50 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5BCE0DA78A
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Feb 2021 16:22:50 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 51544DA7B6; Tue,  2 Feb 2021 16:22:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 18F11DA72F;
        Tue,  2 Feb 2021 16:22:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 02 Feb 2021 16:22:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id F00B7426CC85;
        Tue,  2 Feb 2021 16:22:47 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf] netfilter: nftables: fix possible UAF over chains from packet path in netns
Date:   Tue,  2 Feb 2021 16:22:43 +0100
Message-Id: <20210202152243.26165-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Although hooks are released via call_rcu(), chain and rule objects are
immediately released while packets are still walking over these bits.

This patch adds the .pre_exit callback which is invoked before
synchronize_rcu() in the netns framework to stay safe.

Remove a comment which is not valid anymore since the core does not use
synchronize_net() anymore since 8c873e219970 ("netfilter: core: free
hooks with call_rcu").

Suggested-by: Florian Westphal <fw@strlen.de>
Fixes: df05ef874b28 ("netfilter: nf_tables: release objects on netns destruction")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8d3aa97b52e7..43fe80f10313 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8949,6 +8949,17 @@ int __nft_release_basechain(struct nft_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
+static void __nft_release_hooks(struct net *net)
+{
+	struct nft_table *table;
+	struct nft_chain *chain;
+
+	list_for_each_entry(table, &net->nft.tables, list) {
+		list_for_each_entry(chain, &table->chains, list)
+			nf_tables_unregister_hook(net, table, chain);
+	}
+}
+
 static void __nft_release_tables(struct net *net)
 {
 	struct nft_flowtable *flowtable, *nf;
@@ -8964,10 +8975,6 @@ static void __nft_release_tables(struct net *net)
 
 	list_for_each_entry_safe(table, nt, &net->nft.tables, list) {
 		ctx.family = table->family;
-
-		list_for_each_entry(chain, &table->chains, list)
-			nf_tables_unregister_hook(net, table, chain);
-		/* No packets are walking on these chains anymore. */
 		ctx.table = table;
 		list_for_each_entry(chain, &table->chains, list) {
 			ctx.chain = chain;
@@ -9016,6 +9023,11 @@ static int __net_init nf_tables_init_net(struct net *net)
 	return 0;
 }
 
+static void __net_exit nf_tables_pre_exit_net(struct net *net)
+{
+	__nft_release_hooks(net);
+}
+
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	mutex_lock(&net->nft.commit_mutex);
@@ -9029,8 +9041,9 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 }
 
 static struct pernet_operations nf_tables_net_ops = {
-	.init	= nf_tables_init_net,
-	.exit	= nf_tables_exit_net,
+	.init		= nf_tables_init_net,
+	.pre_exit	= nf_tables_pre_exit_net,
+	.exit		= nf_tables_exit_net,
 };
 
 static int __init nf_tables_module_init(void)
-- 
2.20.1

