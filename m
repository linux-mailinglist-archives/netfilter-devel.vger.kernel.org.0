Return-Path: <netfilter-devel+bounces-11993-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FerG+8D4mna0QAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11993-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 11:57:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E0419AF1
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 11:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722E232D8005
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0D3B47D0;
	Fri, 17 Apr 2026 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="TWDUfoM7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84BE39FCD7;
	Fri, 17 Apr 2026 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418791; cv=none; b=CJmtxu2SGjPiGeLIHsq4XkbLITywKY/wMjOQ/63rZI0uSeZQgHZExQPsBV7f2TEjSxJOBFOKzpq6Dh49y4aIBgS2J7zMhw5Xt6ObSe09LucFZvLJp6ecm3MdpZE4pA6DH8OfevpVohdLWFkRY6OocJfwXHcoWYdU1qBBf/oe5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418791; c=relaxed/simple;
	bh=xmd2hzciTwVzSqbHDFMrGp3srlpG4qtDYgLqOaimVyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdYPoxhf1Zv3UzvVSGMTcOfUth07JhVgf5hM9z9Nrnh2BR4lApwzOv0yP9q1R07w1gGGexOJ+DvJ0jor72aO/qmGYXLTKJwshGuuIq1QOkJnwx2EUimNmFLp8jG6UKaYQSpBHvJGF3qzC/N4ivbW0LULIksCEDL9X2XGftRn1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=TWDUfoM7; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 64B4E600B5;
	Fri, 17 Apr 2026 11:39:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776418787;
	bh=h2MWbITL9VolBoQW8hM9drqz63UdDNLY6Jnn4Sz2JYc=;
	h=From:To:Cc:Subject:Date:From;
	b=TWDUfoM7jZiB7Ak7G1bNeTnpqfDpHlioK60clSZg0bcAZiLsqMtNcT1lxZUlo56Ik
	 yuKtRXdPFPofY9AMoXCayu2Becl7yFLuxCOhQtLuLDVw+Ls//AiO/RwTQ4YTO10U42
	 diG+enJrkQ+SQLoV5Xp6OpBDtKDHArBkiEeQWl0Gd1PLfm5KGVxMINhaIW7q6uGXnt
	 3jQI61kG1qimieG4Xrsnib8Y2TtzO6PBGpWM5X7uyH17eEvsneYwnca16uFO6gOIJZ
	 IU7wSp1c7LDK0Z1/AX1MVl1SG3Wk3zaIlZ8lZheRRhXP+/uw0uQ4OfEZ3m9PEcMJCA
	 I/BuUp7TiThDw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	fw@strlen.de
Subject: [PATCH nf,v6 1/4] netfilter: nf_tables: use list_del_rcu for netlink hooks
Date: Fri, 17 Apr 2026 11:39:39 +0200
Message-ID: <20260417093942.373885-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11993-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: F20E0419AF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Florian Westphal <fw@strlen.de>

nft_netdev_unregister_hooks and __nft_unregister_flowtable_net_hooks need
to use list_del_rcu(), this list can be walked by concurrent dumpers.

Add a new helper and use it consistently.

Fixes: f9a43007d3f7 ("netfilter: nf_tables: double hook unregistration in netns path")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v6: - missing fundamental patch dependency in v5
    - just a rebase on top of net-next, net is still behind.

 net/netfilter/nf_tables_api.c | 44 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8537b94653d3..07e151245765 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -374,6 +374,12 @@ static void nft_netdev_hook_free_rcu(struct nft_hook *hook)
 	call_rcu(&hook->rcu, __nft_netdev_hook_free_rcu);
 }
 
+static void nft_netdev_hook_unlink_free_rcu(struct nft_hook *hook)
+{
+	list_del_rcu(&hook->list);
+	nft_netdev_hook_free_rcu(hook);
+}
+
 static void nft_netdev_unregister_hooks(struct net *net,
 					struct list_head *hook_list,
 					bool release_netdev)
@@ -384,10 +390,8 @@ static void nft_netdev_unregister_hooks(struct net *net,
 	list_for_each_entry_safe(hook, next, hook_list, list) {
 		list_for_each_entry(ops, &hook->ops_list, list)
 			nf_unregister_net_hook(net, ops);
-		if (release_netdev) {
-			list_del(&hook->list);
-			nft_netdev_hook_free_rcu(hook);
-		}
+		if (release_netdev)
+			nft_netdev_hook_unlink_free_rcu(hook);
 	}
 }
 
@@ -2271,10 +2275,8 @@ void nf_tables_chain_destroy(struct nft_chain *chain)
 
 		if (nft_base_chain_netdev(table->family, basechain->ops.hooknum)) {
 			list_for_each_entry_safe(hook, next,
-						 &basechain->hook_list, list) {
-				list_del_rcu(&hook->list);
-				nft_netdev_hook_free_rcu(hook);
-			}
+						 &basechain->hook_list, list)
+				nft_netdev_hook_unlink_free_rcu(hook);
 		}
 		module_put(basechain->type->owner);
 		if (rcu_access_pointer(basechain->stats)) {
@@ -2974,6 +2976,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 				list_for_each_entry(ops, &h->ops_list, list)
 					nf_unregister_net_hook(ctx->net, ops);
 			}
+			/* hook.list is on stack, no need for list_del_rcu() */
 			list_del(&h->list);
 			nft_netdev_hook_free_rcu(h);
 		}
@@ -8852,10 +8855,8 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 	list_for_each_entry_safe(hook, next, hook_list, list) {
 		list_for_each_entry(ops, &hook->ops_list, list)
 			nft_unregister_flowtable_ops(net, flowtable, ops);
-		if (release_netdev) {
-			list_del(&hook->list);
-			nft_netdev_hook_free_rcu(hook);
-		}
+		if (release_netdev)
+			nft_netdev_hook_unlink_free_rcu(hook);
 	}
 }
 
@@ -8926,8 +8927,7 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 
 			nft_unregister_flowtable_ops(net, flowtable, ops);
 		}
-		list_del_rcu(&hook->list);
-		nft_netdev_hook_free_rcu(hook);
+		nft_netdev_hook_unlink_free_rcu(hook);
 	}
 
 	return err;
@@ -8937,10 +8937,8 @@ static void nft_hooks_destroy(struct list_head *hook_list)
 {
 	struct nft_hook *hook, *next;
 
-	list_for_each_entry_safe(hook, next, hook_list, list) {
-		list_del_rcu(&hook->list);
-		nft_netdev_hook_free_rcu(hook);
-	}
+	list_for_each_entry_safe(hook, next, hook_list, list)
+		nft_netdev_hook_unlink_free_rcu(hook);
 }
 
 static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
@@ -9028,8 +9026,7 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 				nft_unregister_flowtable_ops(ctx->net,
 							     flowtable, ops);
 		}
-		list_del_rcu(&hook->list);
-		nft_netdev_hook_free_rcu(hook);
+		nft_netdev_hook_unlink_free_rcu(hook);
 	}
 
 	return err;
@@ -9535,13 +9532,8 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 
 static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 {
-	struct nft_hook *hook, *next;
-
 	flowtable->data.type->free(&flowtable->data);
-	list_for_each_entry_safe(hook, next, &flowtable->hook_list, list) {
-		list_del_rcu(&hook->list);
-		nft_netdev_hook_free_rcu(hook);
-	}
+	nft_hooks_destroy(&flowtable->hook_list);
 	kfree(flowtable->name);
 	module_put(flowtable->data.type->owner);
 	kfree(flowtable);
-- 
2.47.3


