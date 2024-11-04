Return-Path: <netfilter-devel+bounces-4870-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C49BB015
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2024 10:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278A3281100
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2024 09:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFD1AE006;
	Mon,  4 Nov 2024 09:44:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250CA1AE877
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713473; cv=none; b=Qp5mNVE5vqg6CLVN4YqsoC+nWgcQmJBF2sDbQgzpl0FoN7p9UuvHXVhpBIuDCe7FcBiEgue0VbcPBtcsDOyY2z29BgpzZIikT0OkRBWeUnQjavgKnbiLVmliIWg5PVHIwF5obGWvDv+eSRr2R8nulUtsTxjS0uHd0MlB737PJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713473; c=relaxed/simple;
	bh=QhKHTb4EHg5ecl2RGyVUjJZXa2ezH4VZ7Vj9h+bpn1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7iWV7jXjdB5gl2frruVDRQstkl4h6molh4diSeBZFB2iknKPK4dZ/KVhEik+XMI8DCfu9kglLTPyfJGQbGBuaOy1+wRnh9lPm3yioqzsEnuCpa/yxd4V+qgiehc9cTn2plqX6AXrV+BQ84g8JBUx3t4O8M4Tj+5E+v0SWIKI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1t7tdO-0003d2-IW; Mon, 04 Nov 2024 10:44:30 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v3 5/7] netfilter: nf_tables: avoid false-positive lockdep splats with basechain hook
Date: Mon,  4 Nov 2024 10:41:17 +0100
Message-ID: <20241104094126.16917-6-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104094126.16917-1-fw@strlen.de>
References: <20241104094126.16917-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like previous patches: iteration is ok if the list cannot be altered in
parallel.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 9e367e134691..3b5154f2dd79 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1824,7 +1824,8 @@ static int nft_dump_stats(struct sk_buff *skb, struct nft_stats __percpu *stats)
 	return -ENOSPC;
 }
 
-static int nft_dump_basechain_hook(struct sk_buff *skb, int family,
+static int nft_dump_basechain_hook(struct sk_buff *skb,
+				   const struct net *net, int family,
 				   const struct nft_base_chain *basechain,
 				   const struct list_head *hook_list)
 {
@@ -1849,7 +1850,8 @@ static int nft_dump_basechain_hook(struct sk_buff *skb, int family,
 		if (!hook_list)
 			hook_list = &basechain->hook_list;
 
-		list_for_each_entry_rcu(hook, hook_list, list) {
+		list_for_each_entry_rcu(hook, hook_list, list,
+					lockdep_commit_lock_is_held(net)) {
 			if (!first)
 				first = hook;
 
@@ -1900,7 +1902,7 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 		const struct nft_base_chain *basechain = nft_base_chain(chain);
 		struct nft_stats __percpu *stats;
 
-		if (nft_dump_basechain_hook(skb, family, basechain, hook_list))
+		if (nft_dump_basechain_hook(skb, net, family, basechain, hook_list))
 			goto nla_put_failure;
 
 		if (nla_put_be32(skb, NFTA_CHAIN_POLICY,
-- 
2.45.2


