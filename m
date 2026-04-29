Return-Path: <netfilter-devel+bounces-12282-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFMkC4Sj8WnxjAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12282-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 08:21:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED748FB67
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 08:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09E95300A7DF
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956763750AC;
	Wed, 29 Apr 2026 06:21:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E537B007
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2026 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443712; cv=none; b=UnBL0AhzLVpsuGV65U3wdB8za/L5gF5VPwMN935V0YZeAKgUS8CtJ9Nh9eoaP0NRAVfZQuZ8brgbwalunEJWw4+YeMJ2veGOOtQJlmNcH/dYz1n3Vwsgs4KFo2Zx4DGHOUZ87L4rBZ4hXOqhXrJHUOk9mxlu+9cyZcOiK0tU5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443712; c=relaxed/simple;
	bh=M+oYmqtCO26emISCdDhdGOHAZL4H/4wNXWifpheiMik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hawDtOpg/BlwnyRrKbAm0zvvuc0Zz5PxsW3oHelMyndRFdA9RgJwngNNIU1IXalsY0YZmfU20mt3kVZJLs89IuG9PjsmTXsloChNHmcVzPX3tRedf23+PVQd9WU12SIig9RyJUivoR8hqfmWyT+L9uC73R5U30N/E6EZrwTxdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 50E6560420; Wed, 29 Apr 2026 08:21:48 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_tables: fix netdev hook allocation memleak with dormant tables
Date: Wed, 29 Apr 2026 08:21:35 +0200
Message-ID: <20260429062138.22767-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82ED748FB67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.368];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12282-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[]

sashiko says:
 could the related code in __nf_tables_abort() leak the struct nft_hook objects when the table is dormant?

 In __nf_tables_abort(), when rolling back a NEWCHAIN transaction that
 updates hooks, the code conditionally unregisters and frees the hooks only
 if the table is not dormant [..]
            if (!(table->flags & NFT_TABLE_F_DORMANT)) {
                nft_netdev_unregister_hooks(net,
                                            &nft_trans_chain_hooks(trans),
                                            true);
            }
            ...
            nft_trans_destroy(trans);

Unfortunately netdev family mixes hook registration and allocation.
Push table struct down and only check for the flag to unregister.

Fixes: 216e7bf7402c ("netfilter: nf_tables: skip netdev hook unregistration if table is dormant")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d20ce5c36d31..ae5984b62ac3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -407,6 +407,7 @@ static void nft_netdev_unregister_trans_hook(struct net *net,
 }
 
 static void nft_netdev_unregister_hooks(struct net *net,
+					const struct nft_table *table,
 					struct list_head *hook_list,
 					bool release_netdev)
 {
@@ -414,8 +415,10 @@ static void nft_netdev_unregister_hooks(struct net *net,
 	struct nf_hook_ops *ops;
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
-		list_for_each_entry(ops, &hook->ops_list, list)
-			nf_unregister_net_hook(net, ops);
+		if (!(table->flags & NFT_TABLE_F_DORMANT)) {
+			list_for_each_entry(ops, &hook->ops_list, list)
+				nf_unregister_net_hook(net, ops);
+		}
 		if (release_netdev)
 			nft_netdev_hook_unlink_free_rcu(hook);
 	}
@@ -452,20 +455,25 @@ static void __nf_tables_unregister_hook(struct net *net,
 	struct nft_base_chain *basechain;
 	const struct nf_hook_ops *ops;
 
-	if (table->flags & NFT_TABLE_F_DORMANT ||
-	    !nft_is_base_chain(chain))
+	if (!nft_is_base_chain(chain))
 		return;
 	basechain = nft_base_chain(chain);
 	ops = &basechain->ops;
 
+	/* must also be called for dormant tables */
+	if (nft_base_chain_netdev(table->family, basechain->ops.hooknum)) {
+		nft_netdev_unregister_hooks(net, table, &basechain->hook_list,
+					    release_netdev);
+		return;
+	}
+
+	if (table->flags & NFT_TABLE_F_DORMANT)
+		return;
+
 	if (basechain->type->ops_unregister)
 		return basechain->type->ops_unregister(net, ops);
 
-	if (nft_base_chain_netdev(table->family, basechain->ops.hooknum))
-		nft_netdev_unregister_hooks(net, &basechain->hook_list,
-					    release_netdev);
-	else
-		nf_unregister_net_hook(net, &basechain->ops);
+	nf_unregister_net_hook(net, &basechain->ops);
 }
 
 static void nf_tables_unregister_hook(struct net *net,
@@ -11281,11 +11289,9 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			break;
 		case NFT_MSG_NEWCHAIN:
 			if (nft_trans_chain_update(trans)) {
-				if (!(table->flags & NFT_TABLE_F_DORMANT)) {
-					nft_netdev_unregister_hooks(net,
-								    &nft_trans_chain_hooks(trans),
-								    true);
-				}
+				nft_netdev_unregister_hooks(net, table,
+							    &nft_trans_chain_hooks(trans),
+							    true);
 				free_percpu(nft_trans_chain_stats(trans));
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
-- 
2.54.0


