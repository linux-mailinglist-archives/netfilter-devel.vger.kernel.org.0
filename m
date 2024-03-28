Return-Path: <netfilter-devel+bounces-1536-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F788F5D5
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Mar 2024 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86D7B239EF
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Mar 2024 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884EC364DA;
	Thu, 28 Mar 2024 03:19:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B871DA53;
	Thu, 28 Mar 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595945; cv=none; b=XDavyaDLbJhyLCtJ/8juwF6WBOuioeC/IHwPVmFmjAcA0SPY3+yxg7YQWwQk8iqeju5oKp4k4yAaa/Zs2GAxJvpbtD5hXsF8o+4z5cYbTVe8IMpqi1aNYAZ05ZzyFPzDEjbAA2l1/nYKuazSdotztdyD+joCt/Z4dcqZaPGrQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595945; c=relaxed/simple;
	bh=xnq6PTA782IrkdjaAPoz+sqXtpLSoiYM5pB3COSET54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2aOc965hKs6e8+KHo3dSbj6Gp9fkLWTt6JyLoBaQFRUYnNeGf6sXzwTwq8m2RdfMHlGoCU+bk50aXgI53IPVB75FMz97jm6ubPXUAziPGjiA0Zgoz7feuCyRiKtg2R3Ncd1ecB1FWULuv5/LjYX7gYh7mTPvIHY5V0WasnHQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 3/4] netfilter: nf_tables: skip netdev hook unregistration if table is dormant
Date: Thu, 28 Mar 2024 04:18:54 +0100
Message-Id: <20240328031855.2063-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240328031855.2063-1-pablo@netfilter.org>
References: <20240328031855.2063-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip hook unregistration when adding or deleting devices from an
existing netdev basechain. Otherwise, commit/abort path try to
unregister hooks which not enabled.

Fixes: b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Fixes: 7d937b107108 ("netfilter: nf_tables: support for deleting devices in an existing netdev chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 086d85fffeb1..fd86f2720c9e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10212,9 +10212,11 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			if (nft_trans_chain_update(trans)) {
 				nf_tables_chain_notify(&trans->ctx, NFT_MSG_DELCHAIN,
 						       &nft_trans_chain_hooks(trans));
-				nft_netdev_unregister_hooks(net,
-							    &nft_trans_chain_hooks(trans),
-							    true);
+				if (!(trans->ctx.table->flags & NFT_TABLE_F_DORMANT)) {
+					nft_netdev_unregister_hooks(net,
+								    &nft_trans_chain_hooks(trans),
+								    true);
+				}
 			} else {
 				nft_chain_del(trans->ctx.chain);
 				nf_tables_chain_notify(&trans->ctx, NFT_MSG_DELCHAIN,
@@ -10490,9 +10492,11 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			break;
 		case NFT_MSG_NEWCHAIN:
 			if (nft_trans_chain_update(trans)) {
-				nft_netdev_unregister_hooks(net,
-							    &nft_trans_chain_hooks(trans),
-							    true);
+				if (!(trans->ctx.table->flags & NFT_TABLE_F_DORMANT)) {
+					nft_netdev_unregister_hooks(net,
+								    &nft_trans_chain_hooks(trans),
+								    true);
+				}
 				free_percpu(nft_trans_chain_stats(trans));
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
-- 
2.30.2


