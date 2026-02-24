Return-Path: <netfilter-devel+bounces-10858-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OMYJN8PnmlBTQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10858-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 21:53:51 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105A18C845
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 21:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD41E3006948
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6CC33B6FE;
	Tue, 24 Feb 2026 20:51:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE333B6E7;
	Tue, 24 Feb 2026 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966290; cv=none; b=pTzITOhult82Qd2XU7OmKEdfmsMwGl6N3aB0UQyioZ8R8CsWRJ5EgWTIn4sfRqiuMWw30HJr61Oibg3z7ClmeEsOQH9v+itSI/s2KBrCnE562GdAB2hlcGLnvSEOaGuK4wRi9nZhkzarRWOU808drcl7NablzzGmCIhJZ1Sm/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966290; c=relaxed/simple;
	bh=Qjm4OiegaImTM6Wvnh4vdsay+zWcdKyi9KIlRneHFyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUT652YEK1OLoZj7WBbSuDYOc66aR5q9Z8CwOPvmm8r+BjZKcJ7GKrHqGhNeR87vBbnFtD02yAAuD2iAl8buinOjCoM2Mxa1Hj0AglwcUBUof0RImPKtQuN3qC9LB6OQN9BW0nEaflfUTNFcbbS4J9rP2LGJ1wsr2Z397+/8kQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7B04660D01; Tue, 24 Feb 2026 21:51:27 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 8/9] netfilter: nf_tables: drop obsolete EXPORT_SYMBOLs
Date: Tue, 24 Feb 2026 21:50:47 +0100
Message-ID: <20260224205048.4718-9-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224205048.4718-1-fw@strlen.de>
References: <20260224205048.4718-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10858-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3105A18C845
X-Rspamd-Action: no action

These are no longer required, calling objects are nowadays
baked into nf_tables.ko itself.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0c5a4855b97d..23ef775897a4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4128,7 +4128,6 @@ int nft_chain_validate(const struct nft_ctx *ctx, struct nft_chain *chain)
 	nft_chain_vstate_update(ctx, chain);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nft_chain_validate);
 
 static int nft_table_validate(struct net *net, const struct nft_table *table)
 {
@@ -4745,7 +4744,6 @@ struct nft_set *nft_set_lookup_global(const struct net *net,
 	}
 	return set;
 }
-EXPORT_SYMBOL_GPL(nft_set_lookup_global);
 
 static int nf_tables_set_alloc_name(struct nft_ctx *ctx, struct nft_set *set,
 				    const char *name)
@@ -5818,7 +5816,6 @@ int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nf_tables_bind_set);
 
 static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 				 struct nft_set_binding *binding, bool event)
@@ -5898,7 +5895,6 @@ void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 
 	nft_use_inc_restore(&set->use);
 }
-EXPORT_SYMBOL_GPL(nf_tables_activate_set);
 
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
@@ -5938,14 +5934,12 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 				     phase == NFT_TRANS_COMMIT);
 	}
 }
-EXPORT_SYMBOL_GPL(nf_tables_deactivate_set);
 
 void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	if (list_empty(&set->bindings) && nft_set_is_anonymous(set))
 		nft_set_destroy(ctx, set);
 }
-EXPORT_SYMBOL_GPL(nf_tables_destroy_set);
 
 const struct nft_set_ext_type nft_set_ext_types[] = {
 	[NFT_SET_EXT_KEY]		= {
@@ -6783,7 +6777,6 @@ void nft_set_elem_destroy(const struct nft_set *set,
 
 	__nft_set_elem_destroy(&ctx, set, elem_priv, destroy_expr);
 }
-EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
 /* Drop references and destroy. Called from abort path. */
 static void nft_trans_set_elem_destroy(const struct nft_ctx *ctx, struct nft_trans_elem *te)
@@ -6910,7 +6903,6 @@ struct nft_set_ext *nft_set_catchall_lookup(const struct net *net,
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
@@ -8038,7 +8030,6 @@ struct nft_object *nft_obj_lookup(const struct net *net,
 	rcu_read_unlock();
 	return ERR_PTR(-ENOENT);
 }
-EXPORT_SYMBOL_GPL(nft_obj_lookup);
 
 static struct nft_object *nft_obj_lookup_byhandle(const struct nft_table *table,
 						  const struct nlattr *nla,
@@ -11860,7 +11851,6 @@ void nft_data_release(const struct nft_data *data, enum nft_data_types type)
 		WARN_ON(1);
 	}
 }
-EXPORT_SYMBOL_GPL(nft_data_release);
 
 int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 		  enum nft_data_types type, unsigned int len)
@@ -11887,7 +11877,6 @@ int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 	nla_nest_end(skb, nest);
 	return err;
 }
-EXPORT_SYMBOL_GPL(nft_data_dump);
 
 static void __nft_release_hook(struct net *net, struct nft_table *table)
 {
-- 
2.52.0


