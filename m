Return-Path: <netfilter-devel+bounces-11058-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NYqEJw3r2kPQQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11058-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 22:11:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C4C241703
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 22:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD598311DCBB
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2026 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9BF40F8D5;
	Mon,  9 Mar 2026 21:08:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234D40FD92;
	Mon,  9 Mar 2026 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090537; cv=none; b=nMXmLK4gKBlNWAYW4w9ITEwrsQlmjDJvaKxGO1sYXrscY7T9aJO3oXMx5R0XY49Oa1rLWAlV2gq7CLYdSz0OBKctTEg+v98OzF33QllUX9NNCRB5K2R/LrxO0eeExzbK+EDDuWrVLAgbk7wA8ruRB2TukEppL5qrr7nIi874TxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090537; c=relaxed/simple;
	bh=vpDW84VkZZPvlCCoOnVRCQ9HyLV3eJ3laKNPkd02lzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yywg5uAQQ7tIPinZGIXmr2kLNU5rpwWpYbavjHKM43McRsz+5qTVHS2PwDvOESuCfp84n71GPtFx1uYlVqMsVCS9XXmWm84vyqN6llhRCWszqqSSUaxq9Uxmq1JOiclIKtvtq8nGBRaW7FfT+zXOS3EyCibvZTgcDWPw101Q4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E6E8B60D2E; Mon, 09 Mar 2026 22:08:53 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 01/10] netfilter: nf_tables: Fix for duplicate device in netdev hooks
Date: Mon,  9 Mar 2026 22:08:36 +0100
Message-ID: <20260309210845.15657-2-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260309210845.15657-1-fw@strlen.de>
References: <20260309210845.15657-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87C4C241703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11058-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


