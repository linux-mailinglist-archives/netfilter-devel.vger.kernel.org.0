Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC49198418
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2020 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgC3TWB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Mar 2020 15:22:01 -0400
Received: from correo.us.es ([193.147.175.20]:48516 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgC3TWA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:22:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E4685B5063
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2020 21:21:56 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7727123974
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2020 21:21:56 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 44D5310218A; Mon, 30 Mar 2020 21:21:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C26CE207A0;
        Mon, 30 Mar 2020 21:21:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Mar 2020 21:21:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 9C63C42EF4E0;
        Mon, 30 Mar 2020 21:21:40 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 02/28] netfilter: nf_tables: pass context to nft_set_destroy()
Date:   Mon, 30 Mar 2020 21:21:10 +0200
Message-Id: <20200330192136.230459-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330192136.230459-1-pablo@netfilter.org>
References: <20200330192136.230459-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The patch that adds support for stateful expressions in set definitions
require this.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4f6245e7988e..df046cd97fa7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4126,7 +4126,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-static void nft_set_destroy(struct nft_set *set)
+static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (WARN_ON(set->use > 0))
 		return;
@@ -4271,7 +4271,7 @@ EXPORT_SYMBOL_GPL(nf_tables_deactivate_set);
 void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (list_empty(&set->bindings) && nft_set_is_anonymous(set))
-		nft_set_destroy(set);
+		nft_set_destroy(ctx, set);
 }
 EXPORT_SYMBOL_GPL(nf_tables_destroy_set);
 
@@ -7020,7 +7020,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_DELSET:
-		nft_set_destroy(nft_trans_set(trans));
+		nft_set_destroy(&trans->ctx, nft_trans_set(trans));
 		break;
 	case NFT_MSG_DELSETELEM:
 		nf_tables_set_elem_destroy(&trans->ctx,
@@ -7451,7 +7451,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
 		break;
 	case NFT_MSG_NEWSET:
-		nft_set_destroy(nft_trans_set(trans));
+		nft_set_destroy(&trans->ctx, nft_trans_set(trans));
 		break;
 	case NFT_MSG_NEWSETELEM:
 		nft_set_elem_destroy(nft_trans_elem_set(trans),
@@ -8177,7 +8177,7 @@ static void __nft_release_tables(struct net *net)
 		list_for_each_entry_safe(set, ns, &table->sets, list) {
 			list_del(&set->list);
 			table->use--;
-			nft_set_destroy(set);
+			nft_set_destroy(&ctx, set);
 		}
 		list_for_each_entry_safe(obj, ne, &table->objects, list) {
 			nft_obj_del(obj);
-- 
2.11.0

