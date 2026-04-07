Return-Path: <netfilter-devel+bounces-11688-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PhWGA0T1Wm30AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11688-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:22:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E18EC3AFEEA
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37270300E60D
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FDA3B9D98;
	Tue,  7 Apr 2026 14:16:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F173B47C6;
	Tue,  7 Apr 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571400; cv=none; b=YaGXQx+lcC0RzbfAappkBa34cJi1y+vigOkp4BFpjGgijInceSSFREw+N8293SJuFjqT9o3KCOTHtpXKfFdAKZWHd4+Tx7gMaJSOfZWvssxTi0ipw0FYVe45NfNfe+IdF5l0hKcUVYQEsC1VlSIeLlXlT0r8j0XGSLozQgwwWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571400; c=relaxed/simple;
	bh=RnYusxmnXYLGLk2xiaHrhsJqhcasSqzbeBVNNG8P2Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWSsjXgj4KAzgXkPhpUTKpuTHG01hGWCAMeqx7JnH4J75qlsj3i4JoZROUskFLCqBymZ7pC2ZJP7i29wY/6PdcUUIYycVdDgzjb4XPgsDKyGkNhoATVxHR6hPnX4fjk5eyPFRaI/CyQ8lyvf7Eogy3kOA7hNxMNidBpe9PRFHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5D10A60681; Tue, 07 Apr 2026 16:16:37 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 12/13] netfilter: nf_tables_offload: add nft_flow_action_entry_next() and use it
Date: Tue,  7 Apr 2026 16:15:39 +0200
Message-ID: <20260407141540.11549-13-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407141540.11549-1-fw@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11688-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,strlen.de:email,strlen.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E18EC3AFEEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pablo Neira Ayuso <pablo@netfilter.org>

Add a new helper function to retrieve the next action entry in flow
rule, check if the maximum number of actions is reached, bail out in
such case.

Replace existing opencoded iteration on the action array by this
helper function.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables_offload.h | 10 ++++++++++
 net/netfilter/nf_dup_netdev.c             |  5 ++++-
 net/netfilter/nft_immediate.c             |  4 +++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
index 3568b6a2f5f0..14c427891ee6 100644
--- a/include/net/netfilter/nf_tables_offload.h
+++ b/include/net/netfilter/nf_tables_offload.h
@@ -67,6 +67,16 @@ struct nft_flow_rule {
 	struct flow_rule	*rule;
 };
 
+static inline struct flow_action_entry *
+nft_flow_action_entry_next(struct nft_offload_ctx *ctx,
+			   struct nft_flow_rule *flow)
+{
+	if (unlikely(ctx->num_actions >= flow->rule->action.num_entries))
+		return NULL;
+
+	return &flow->rule->action.entries[ctx->num_actions++];
+}
+
 void nft_flow_rule_set_addr_type(struct nft_flow_rule *flow,
 				 enum flow_dissector_key_id addr_type);
 
diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index fab8b9011098..e348fb90b8dc 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -95,7 +95,10 @@ int nft_fwd_dup_netdev_offload(struct nft_offload_ctx *ctx,
 	if (!dev)
 		return -EOPNOTSUPP;
 
-	entry = &flow->rule->action.entries[ctx->num_actions++];
+	entry = nft_flow_action_entry_next(ctx, flow);
+	if (!entry)
+		return -E2BIG;
+
 	entry->id = id;
 	entry->dev = dev;
 
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 1b733c7b1b0e..d00eb2eb30e4 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -279,7 +279,9 @@ static int nft_immediate_offload_verdict(struct nft_offload_ctx *ctx,
 	struct flow_action_entry *entry;
 	const struct nft_data *data;
 
-	entry = &flow->rule->action.entries[ctx->num_actions++];
+	entry = nft_flow_action_entry_next(ctx, flow);
+	if (!entry)
+		return -E2BIG;
 
 	data = &priv->data;
 	switch (data->verdict.code) {
-- 
2.52.0


