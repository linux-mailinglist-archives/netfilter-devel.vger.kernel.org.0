Return-Path: <netfilter-devel+bounces-11935-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDi5Gc/k32n9ZwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11935-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 21:19:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D402A407580
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D4A30616E1
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF46383C8C;
	Wed, 15 Apr 2026 19:18:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9061DED40
	for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2026 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280725; cv=none; b=PbOMFe+vJwnb5fd3aHia10VCSoB7y2UQ06vXalSB2Oj6DmWhCVYiEKpoRpshbx51s19/XylqOYBNliYy71tgKg4T0GEKNmOsW8X+m+E9i7bbpPoV50+sHD8NUNemmU2husNJr6IybOKtOX/qlX1jqj5k3EhqU2wFBQ9pjrksws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280725; c=relaxed/simple;
	bh=Nk/0BYekiXYE1BQz+V5PgegkBrqZ26wMKA3K/zSmOOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRVwG6ndV+u2UfCwxLVTK+KL+l2IxS5uCNj3VnAPQJR3XguJVaSycy9qCuN005IFGQVDhg4bi0XdPk9+HNbt7ckrwe8DazFIZ+MRtKAFTaWSCaVxAfQ9+FwEu3+V26Jhq5oXX98cnI5fJWt3DiNm7JFPhlsdLtZlY6rViXQa6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E4F2E60640; Wed, 15 Apr 2026 21:18:41 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_tables: use list_del_rcu for netlink hooks
Date: Wed, 15 Apr 2026 21:18:33 +0200
Message-ID: <20260415191837.21663-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11935-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D402A407580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nft_netdev_unregister_hooks and __nft_unregister_flowtable_net_hooks need
to use list_del_rcu(), this list can be walked by concurrent dumpers.

Add a new helper and use it consistently.

Fixes: f9a43007d3f7 ("netfilter: nf_tables: double hook unregistration in netns path")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Sorry for late send, this was spotted by LLM after re-prompting
 based on findings from a different patch.

 net/netfilter/nf_tables_api.c | 44 ++++++++++++++---------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8c42247a176c..090d4d688a33 100644
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
 
@@ -2323,10 +2327,8 @@ void nf_tables_chain_destroy(struct nft_chain *chain)
 
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
@@ -3026,6 +3028,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 				list_for_each_entry(ops, &h->ops_list, list)
 					nf_unregister_net_hook(ctx->net, ops);
 			}
+			/* hook.list is on stack, no need for list_del_rcu() */
 			list_del(&h->list);
 			nft_netdev_hook_free_rcu(h);
 		}
@@ -8903,10 +8906,8 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
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
 
@@ -8977,8 +8978,7 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 
 			nft_unregister_flowtable_ops(net, flowtable, ops);
 		}
-		list_del_rcu(&hook->list);
-		nft_netdev_hook_free_rcu(hook);
+		nft_netdev_hook_unlink_free_rcu(hook);
 	}
 
 	return err;
@@ -8988,10 +8988,8 @@ static void nft_hooks_destroy(struct list_head *hook_list)
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
@@ -9079,8 +9077,7 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 				nft_unregister_flowtable_ops(ctx->net,
 							     flowtable, ops);
 		}
-		list_del_rcu(&hook->list);
-		nft_netdev_hook_free_rcu(hook);
+		nft_netdev_hook_unlink_free_rcu(hook);
 	}
 
 	return err;
@@ -9586,13 +9583,8 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 
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
2.52.0


