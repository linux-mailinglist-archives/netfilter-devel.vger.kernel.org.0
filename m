Return-Path: <netfilter-devel+bounces-2977-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97592E395
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jul 2024 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EE71C20B11
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jul 2024 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CD815748D;
	Thu, 11 Jul 2024 09:40:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB25E093;
	Thu, 11 Jul 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690812; cv=none; b=eNlzydF1CM8QnoZSzQo8m3wwtqeUxXjW7rU6rzE0XQ/nf/fPoAzN+dhUQPu8BdhlhJYq6+F5qja0vvr/Bp8zSniWJOyc/XXS8Bks2FV25mhBD14A9v0HZ4RWqOXDjMeZuyu3Iojes84G1qFH3RJxTbbq6JF6s59QWUPqfZKeC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690812; c=relaxed/simple;
	bh=1OgQ7Nm3pV5YGvbAJyVg5lfJllgTxL8bxGiP9Jkfwvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKqMo9tbkmSTuxMaDU8aG33c1azlHeDrWXYu1x3xlQGFJDxZ6qXEiACvmYotlWt2l8Lc5tvcsMUvBARz3my5ayXIg/RYZn1CNLGuYnU07/LTbKMGsEuDtDUQp2uIoHT5VsiarplDGAczMyyC1S5MUPnDE2fBsA3F7h4Uc6HUXi8=
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
Subject: [PATCH net 1/2] netfilter: nfnetlink_queue: drop bogus WARN_ON
Date: Thu, 11 Jul 2024 11:39:47 +0200
Message-Id: <20240711093948.3816-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711093948.3816-1-pablo@netfilter.org>
References: <20240711093948.3816-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Happens when rules get flushed/deleted while packet is out, so remove
this WARN_ON.

This WARN exists in one form or another since v4.14, no need to backport
this to older releases, hence use a more recent fixes tag.

Fixes: 3f8019688894 ("netfilter: move nf_reinject into nfnetlink_queue modules")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407081453.11ac0f63-lkp@intel.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index f1c31757e496..55e28e1da66e 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -325,7 +325,7 @@ static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
 	i = entry->hook_index;
-	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
+	if (!hooks || i >= hooks->num_hook_entries) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
 		nf_queue_entry_free(entry);
 		return;
-- 
2.30.2


