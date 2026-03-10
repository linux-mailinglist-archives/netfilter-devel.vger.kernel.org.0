Return-Path: <netfilter-devel+bounces-11080-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJkfBXArsGl7gwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11080-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 15:32:16 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7625209D
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 15:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D28A35FE3A8
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BBB3A1689;
	Tue, 10 Mar 2026 13:21:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7D39BFF7;
	Tue, 10 Mar 2026 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148866; cv=none; b=BwXNmQQqa4/6lRbhYNeC2XkCAvn6lMQCQFSRvI7IMHrUC3stqRlGhbUt1jxMuGq4+EmbshYCNp5Z+PzkAPUOytaZCyVCm+SaSS+anb/bPOvHUWDz+qlHTQ9l5xLHKoWwpRBH5qsMwxvFntzYhKcisGOnHxu4ZFKV/Ow58LlDNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148866; c=relaxed/simple;
	bh=vpDW84VkZZPvlCCoOnVRCQ9HyLV3eJ3laKNPkd02lzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kT0mCQtlHOi7S/YA5RswG0rTdtJJ1WjV6lnLoOV6uDhsAL7NEZ8LiZF6jNip5WJWLu/1hZh8K/dinssgv94Uss5N7XuZMLJNdpXbZuSkM8kCwCf4JI0rvJwR91bLnteu8f9lafMztDD7Xe3yGbqJ64RXOV4Y91iHTKCcNEf85lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1B8556052A; Tue, 10 Mar 2026 14:21:03 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net v2 1/7] netfilter: nf_tables: Fix for duplicate device in netdev hooks
Date: Tue, 10 Mar 2026 14:20:43 +0100
Message-ID: <20260310132050.630-2-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310132050.630-1-fw@strlen.de>
References: <20260310132050.630-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78D7625209D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11080-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:email,strlen.de:mid,strlen.de:email,syzkaller.appspot.com:url,igalia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

From: Phil Sutter <phil@nwl.cc>

When handling NETDEV_REGISTER notification, duplicate device
registration must be avoided since the device may have been added by
nft_netdev_hook_alloc() already when creating the hook.

Suggested-by: Florian Westphal <fw@strlen.de>
Reported-by: syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bb9127e278fa198e110c
Fixes: a331b78a5525 ("netfilter: nf_tables: Respect NETDEV_REGISTER events")
Tested-by: Helen Koike <koike@igalia.com>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c    | 2 +-
 net/netfilter/nft_chain_filter.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1862bd7fe804..710f0ee21a34 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9688,7 +9688,7 @@ static int nft_flowtable_event(unsigned long event, struct net_device *dev,
 			break;
 		case NETDEV_REGISTER:
 			/* NOP if not matching or already registered */
-			if (!match || (changename && ops))
+			if (!match || ops)
 				continue;
 
 			ops = kzalloc_obj(struct nf_hook_ops,
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd..041426e3bdbf 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -344,7 +344,7 @@ static int nft_netdev_event(unsigned long event, struct net_device *dev,
 			break;
 		case NETDEV_REGISTER:
 			/* NOP if not matching or already registered */
-			if (!match || (changename && ops))
+			if (!match || ops)
 				continue;
 
 			ops = kmemdup(&basechain->ops,
-- 
2.52.0


