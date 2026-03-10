Return-Path: <netfilter-devel+bounces-11081-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOr5LMowsGkShAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11081-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 15:55:06 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B218A252A0E
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02E5D31DCECC
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12393A3E66;
	Tue, 10 Mar 2026 13:21:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642623A3E63;
	Tue, 10 Mar 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148870; cv=none; b=WRhHzGuZMR76Y8RrqXMqM+uXqjtSBjxK2syDWs5SI9PeruT9421H0ZMlrFGsGsmbMBvId98PFPGQS0OwdaJ702HWG737RkcJjBNv7qyshiduVvcTRsyGagExRhtHiCmdMam6KqAgDnKNRDs1x3gE44YIdzJ8fmhOrZER5P3ILfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148870; c=relaxed/simple;
	bh=YNWVfFLnqV+YQDTvfmDQZiSpb/Ras8f4F8fh+DJEhSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSnLix9KZ9vGHU8EHgD6rt7TX6bwKJaxAWxIZTp5qoQv3aQ8E/3Hspsy/c1HUMVCCv9Rvl23/IlnCF2XQglEdmdvF49Gv2EYiLB46fF0ZptxajYanA61HX7fGxiBUWaWuJEWW2M8tuswHjkzFm+WTqh3WleZ+m2K4IsfDZL2Csg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 723B06052A; Tue, 10 Mar 2026 14:21:07 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net v2 2/7] netfilter: nf_tables: always walk all pending catchall elements
Date: Tue, 10 Mar 2026 14:20:44 +0100
Message-ID: <20260310132050.630-3-fw@strlen.de>
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
X-Rspamd-Queue-Id: B218A252A0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11081-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

During transaction processing we might have more than one catchall element:
1 live catchall element and 1 pending element that is coming as part of the
new batch.

If the map holding the catchall elements is also going away, its
required to toggle all catchall elements and not just the first viable
candidate.

Otherwise, we get:
 WARNING: ./include/net/netfilter/nf_tables.h:1281 at nft_data_release+0xb7/0xe0 [nf_tables], CPU#2: nft/1404
 RIP: 0010:nft_data_release+0xb7/0xe0 [nf_tables]
 [..]
 __nft_set_elem_destroy+0x106/0x380 [nf_tables]
 nf_tables_abort_release+0x348/0x8d0 [nf_tables]
 nf_tables_abort+0xcf2/0x3ac0 [nf_tables]
 nfnetlink_rcv_batch+0x9c9/0x20e0 [..]

Fixes: 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 710f0ee21a34..dacec5f8a11c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -829,7 +829,6 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 
 		nft_set_elem_change_active(ctx->net, set, ext);
 		nft_setelem_data_deactivate(ctx->net, set, catchall->elem);
-		break;
 	}
 }
 
@@ -5873,7 +5872,6 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 
 		nft_clear(ctx->net, ext);
 		nft_setelem_data_activate(ctx->net, set, catchall->elem);
-		break;
 	}
 }
 
-- 
2.52.0


