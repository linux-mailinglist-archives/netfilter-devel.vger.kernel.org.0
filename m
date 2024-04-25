Return-Path: <netfilter-devel+bounces-1962-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06A8B1D43
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Apr 2024 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37871F2414A
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Apr 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6384A23;
	Thu, 25 Apr 2024 09:02:13 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46971DFE1;
	Thu, 25 Apr 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035733; cv=none; b=n+1l27HO/SdZ39uEhh9RUK5ru+dQol2VXzGp8KD7N/oborTWbPb9wZ3VAv8S/dxh4a/8eYNUDEmhwUEvIg4p0DZq95ILmae+JcBsSNFZeno99ID6oC2iNPkIs27FdgNAg5OFCMnzvOjJZlEEc9RhpXPthpq4tUFAq99tX30xxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035733; c=relaxed/simple;
	bh=lXJ/0YBz6Wj1peIwJxFzmOY9k77PCFrbneWoDNEkUzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jP3yRKETC2xIDO6lLhfa5G0iNOHZgpeVLj/IXVfvc36k029PwRZJ6FeP8eEp12BGaHTNCTJkZSxoTxK6/RMnAVnpUwDzU8xvfnn6Lgn9ArSz/u81bQ02NPq/6ySuGQ/1m+DK1jcY2zEsSrzdpjJDgOXQz6Yyp7FUpqSYePq5JJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 2/2] netfilter: nf_tables: honor table dormant flag from netdev release event path
Date: Thu, 25 Apr 2024 11:01:49 +0200
Message-Id: <20240425090149.1359547-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425090149.1359547-1-pablo@netfilter.org>
References: <20240425090149.1359547-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for table dormant flag otherwise netdev release event path tries
to unregister an already unregistered hook.

[524854.857999] ------------[ cut here ]------------
[524854.858010] WARNING: CPU: 0 PID: 3386599 at net/netfilter/core.c:501 __nf_unregister_net_hook+0x21a/0x260
[...]
[524854.858848] CPU: 0 PID: 3386599 Comm: kworker/u32:2 Not tainted 6.9.0-rc3+ #365
[524854.858869] Workqueue: netns cleanup_net
[524854.858886] RIP: 0010:__nf_unregister_net_hook+0x21a/0x260
[524854.858903] Code: 24 e8 aa 73 83 ff 48 63 43 1c 83 f8 01 0f 85 3d ff ff ff e8 98 d1 f0 ff 48 8b 3c 24 e8 8f 73 83 ff 48 63 43 1c e9 26 ff ff ff <0f> 0b 48 83 c4 18 48 c7 c7 00 68 e9 82 5b 5d 41 5c 41 5d 41 5e 41
[524854.858914] RSP: 0018:ffff8881e36d79e0 EFLAGS: 00010246
[524854.858926] RAX: 0000000000000000 RBX: ffff8881339ae790 RCX: ffffffff81ba524a
[524854.858936] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8881c8a16438
[524854.858945] RBP: ffff8881c8a16438 R08: 0000000000000001 R09: ffffed103c6daf34
[524854.858954] R10: ffff8881e36d79a7 R11: 0000000000000000 R12: 0000000000000005
[524854.858962] R13: ffff8881c8a16000 R14: 0000000000000000 R15: ffff8881351b5a00
[524854.858971] FS:  0000000000000000(0000) GS:ffff888390800000(0000) knlGS:0000000000000000
[524854.858982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[524854.858991] CR2: 00007fc9be0f16f4 CR3: 00000001437cc004 CR4: 00000000001706f0
[524854.859000] Call Trace:
[524854.859006]  <TASK>
[524854.859013]  ? __warn+0x9f/0x1a0
[524854.859027]  ? __nf_unregister_net_hook+0x21a/0x260
[524854.859044]  ? report_bug+0x1b1/0x1e0
[524854.859060]  ? handle_bug+0x3c/0x70
[524854.859071]  ? exc_invalid_op+0x17/0x40
[524854.859083]  ? asm_exc_invalid_op+0x1a/0x20
[524854.859100]  ? __nf_unregister_net_hook+0x6a/0x260
[524854.859116]  ? __nf_unregister_net_hook+0x21a/0x260
[524854.859135]  nf_tables_netdev_event+0x337/0x390 [nf_tables]
[524854.859304]  ? __pfx_nf_tables_netdev_event+0x10/0x10 [nf_tables]
[524854.859461]  ? packet_notifier+0xb3/0x360
[524854.859476]  ? _raw_spin_unlock_irqrestore+0x11/0x40
[524854.859489]  ? dcbnl_netdevice_event+0x35/0x140
[524854.859507]  ? __pfx_nf_tables_netdev_event+0x10/0x10 [nf_tables]
[524854.859661]  notifier_call_chain+0x7d/0x140
[524854.859677]  unregister_netdevice_many_notify+0x5e1/0xae0

Fixes: d54725cd11a5 ("netfilter: nf_tables: support for multiple devices per netdev hook")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_chain_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 274b6f7e6bb5..d170758a1eb5 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -338,7 +338,9 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		return;
 
 	if (n > 1) {
-		nf_unregister_net_hook(ctx->net, &found->ops);
+		if (!(ctx->chain->table->flags & NFT_TABLE_F_DORMANT))
+			nf_unregister_net_hook(ctx->net, &found->ops);
+
 		list_del_rcu(&found->list);
 		kfree_rcu(found, rcu);
 		return;
-- 
2.30.2


