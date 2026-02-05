Return-Path: <netfilter-devel+bounces-10665-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FGxL7x6hGlU3AMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10665-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 12:10:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4BF1B31
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 12:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65E183020008
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9603ACA4D;
	Thu,  5 Feb 2026 11:09:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02939E6F7;
	Thu,  5 Feb 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289773; cv=none; b=i3VAnv36V/g7kraIceVx3pCletESrtOfUcIcvJE6U+gDeMAvEBQS3l5QTCXPMGJJL3J//gW81sas5x1GZjzPMDVXdkL+iLxJl38smyGXYLcYj47wBlRa2IBza6QdlwIA+RrzZzYTv962j+B3xjyw3N9L8qc/N0+ne+Wa0nL62sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289773; c=relaxed/simple;
	bh=EiOrpYCePP9Ke4k3ZF7JsQg4zb8Wlo3IOG4c2sDvaDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehg3JYefaP/DOd2DOMkQjDI7XuuB0iCAu8NRmPwsyNRpJAxKQskRQBqx85S0aMST291WerjZSo46JbXYOCTexZalptdM9Hl794oTCecO3WjpvdFh64cXUHx4tYVUQ1sa7P2qjAPzQmRH7k3RQwzrxPr6fBgFqWQPFZtcHNatkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3991E60610; Thu, 05 Feb 2026 12:09:32 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 04/11] netfilter: flowtable: dedicated slab for flow entry
Date: Thu,  5 Feb 2026 12:08:58 +0100
Message-ID: <20260205110905.26629-5-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205110905.26629-1-fw@strlen.de>
References: <20260205110905.26629-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10665-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 1FD4BF1B31
X-Rspamd-Action: no action

From: Qingfang Deng <dqfext@gmail.com>

The size of `struct flow_offload` has grown beyond 256 bytes on 64-bit
kernels (currently 280 bytes) because of the `flow_offload_tunnel`
member added recently. So kmalloc() allocates from the kmalloc-512 slab,
causing significant memory waste per entry.

Introduce a dedicated slab cache for flow entries to reduce memory
footprint. Results in a reduction from 512 bytes to 320 bytes per entry
on x86_64 kernels.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_flow_table_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 06e8251a6644..2c4140e6f53c 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -16,6 +16,7 @@
 
 static DEFINE_MUTEX(flowtable_lock);
 static LIST_HEAD(flowtables);
+static __read_mostly struct kmem_cache *flow_offload_cachep;
 
 static void
 flow_offload_fill_dir(struct flow_offload *flow,
@@ -56,7 +57,7 @@ struct flow_offload *flow_offload_alloc(struct nf_conn *ct)
 	if (unlikely(nf_ct_is_dying(ct)))
 		return NULL;
 
-	flow = kzalloc(sizeof(*flow), GFP_ATOMIC);
+	flow = kmem_cache_zalloc(flow_offload_cachep, GFP_ATOMIC);
 	if (!flow)
 		return NULL;
 
@@ -812,9 +813,13 @@ static int __init nf_flow_table_module_init(void)
 {
 	int ret;
 
+	flow_offload_cachep = KMEM_CACHE(flow_offload, SLAB_HWCACHE_ALIGN);
+	if (!flow_offload_cachep)
+		return -ENOMEM;
+
 	ret = register_pernet_subsys(&nf_flow_table_net_ops);
 	if (ret < 0)
-		return ret;
+		goto out_pernet;
 
 	ret = nf_flow_table_offload_init();
 	if (ret)
@@ -830,6 +835,8 @@ static int __init nf_flow_table_module_init(void)
 	nf_flow_table_offload_exit();
 out_offload:
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
+out_pernet:
+	kmem_cache_destroy(flow_offload_cachep);
 	return ret;
 }
 
@@ -837,6 +844,7 @@ static void __exit nf_flow_table_module_exit(void)
 {
 	nf_flow_table_offload_exit();
 	unregister_pernet_subsys(&nf_flow_table_net_ops);
+	kmem_cache_destroy(flow_offload_cachep);
 }
 
 module_init(nf_flow_table_module_init);
-- 
2.52.0


