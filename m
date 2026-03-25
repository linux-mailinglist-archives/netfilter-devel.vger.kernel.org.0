Return-Path: <netfilter-devel+bounces-11411-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEJeA0oRxGl8vwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11411-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 17:46:02 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C42E532949B
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 17:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD3D8307DA5C
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 16:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91463F210F;
	Wed, 25 Mar 2026 16:41:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0C3BED0C
	for <netfilter-devel@vger.kernel.org>; Wed, 25 Mar 2026 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456919; cv=none; b=kIvn30I7UL/rRvlNX+Nmp7TX8sOfJFw8mYL9NbzM8V54ndpxxgOit7HC3bCjfxxuOdL3In84m9BzDddo+9dhppI3wnOlRZzKkNvinA6+Eqk2GioBqliKR++NYr6BLOb0SFaT6jGXJAltqpJj9bMgcysBTiv/AX8pLH4fkE4Pbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456919; c=relaxed/simple;
	bh=JY2glMILN4+/CG1ObBikjiO/jIVgnDBytAotRygH+Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dkc5F5OHh1hvQgUxrmzkk6sf4TFc8qO7/0Nj0z0NqmmjRNX/xQjq6PGR3QXnPWFggvWv9YMEnclaphUmUPezNlNhAj7mGk1k1zhegM1GBUg2VgrNO7r7TRM//NWY4+wFzes8OmoJgD4ZR0JvsSLJVEOfQbenpWMd6FDAp7NxIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0A5716080C; Wed, 25 Mar 2026 17:41:56 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH nf] netfilter: nf_tables: reject requests exceeding NF_FLOW_RULE_ACTION_MAX actions
Date: Wed, 25 Mar 2026 17:41:27 +0100
Message-ID: <20260325164130.29060-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[strlen.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-11411-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C42E532949B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nf_flow_offload_rule_alloc() allocates space for NF_FLOW_RULE_ACTION_MAX
entries.  Make sure userspace passes more entries to us.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Can also route via nf-next if thats deemed the better tree.

 include/net/netfilter/nf_flow_table.h | 2 ++
 net/netfilter/nf_flow_table_offload.c | 2 --
 net/netfilter/nf_tables_offload.c     | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index b09c11c048d5..0b2fb1467b3f 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -13,6 +13,8 @@
 #include <linux/if_pppox.h>
 #include <linux/ppp_defs.h>
 
+#define NF_FLOW_RULE_ACTION_MAX	16
+
 struct nf_flowtable;
 struct nf_flow_rule;
 struct flow_offload;
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 9b677e116487..11463682bbfa 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -727,8 +727,6 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 }
 EXPORT_SYMBOL_GPL(nf_flow_rule_route_ipv6);
 
-#define NF_FLOW_RULE_ACTION_MAX	16
-
 static struct nf_flow_rule *
 nf_flow_offload_rule_alloc(struct net *net,
 			   const struct flow_offload_work *offload,
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 9101b1703b52..a2f7966bc201 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -88,10 +88,11 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 					   const struct nft_rule *rule)
 {
+	unsigned int num_actions = 0;
 	struct nft_offload_ctx *ctx;
 	struct nft_flow_rule *flow;
-	int num_actions = 0, err;
 	struct nft_expr *expr;
+	int err;
 
 	expr = nft_expr_first(rule);
 	while (nft_expr_more(rule, expr)) {
@@ -102,7 +103,7 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 		expr = nft_expr_next(expr);
 	}
 
-	if (num_actions == 0)
+	if (num_actions == 0 || num_actions > NF_FLOW_RULE_ACTION_MAX)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	flow = nft_flow_rule_alloc(num_actions);
-- 
2.52.0


