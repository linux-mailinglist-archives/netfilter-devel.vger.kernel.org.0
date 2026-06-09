Return-Path: <netfilter-devel+bounces-13161-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3LOLxlqKGobDwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13161-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 21:31:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C758663BB7
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 21:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13161-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13161-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D64730F785C
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6544EA38C;
	Tue,  9 Jun 2026 19:14:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D944EA379
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 19:14:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032496; cv=none; b=hDDXpeR5Qjk6rSI4Gb6EPwCWsolSy9a7LbaFljBnOAng/S2jPfnECBJAkWFDJ0djGbj5R66YHVgtkRYBMHMXxjOA75yuT8KCGSQf0G8sUU1ELBJRQQX+k65ddreW4ARK36GtkGM9F1ghk0zB4WIHUFTs9sEZyv99q+Mr4RqT6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032496; c=relaxed/simple;
	bh=dHAKZi6xVvWLow+xJhzncq8jY2kEo/Av82Sj5zUo04E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WQp4ADm1Zct10Sfez6MXzhvO8IBLBoLfZwsEqlajo2kjflVOMFFnDKaV7x752UGxnIBAelkO0IjAwlMLuVGA1eSLVH/x2Hn13gOi0eJiWUjJbzyrqXEGmg6DsW0OC+ebI54tN/gAbtqCg8kVOjWchvo6H+gxHQstfwJQ4Xh1lS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D4FB360C94; Tue, 09 Jun 2026 21:14:52 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Subject: [PATCH v2 nf] netfilter: nft_exthdr: fix register tracking for F_PRESENT flag
Date: Tue,  9 Jun 2026 21:14:37 +0200
Message-ID: <20260609191447.16376-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13161-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C758663BB7

nft_exthdr_init() passes user-controlled priv->len to
nft_parse_register_store(), which marks that many bytes in the
register bitmap as initialized.  However, when NFT_EXTHDR_F_PRESENT
is set, the eval paths write only 1 byte (nft_reg_store8) or
4 bytes (*dest = 0 on TCP/DCCP error path).  When len > 4,
registers beyond the first are never written, retaining
uninitialized stack data from nft_regs.

Bail out if userspace requests too much data when F_PRESENT is set.

Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Fixes: c078ca3b0c5b ("netfilter: nft_exthdr: Add support for existence check")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: reject rule add instead of silent 'len = 1'.

 net/netfilter/nft_exthdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index e6a07c0df207..b6cca7c947a2 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -532,6 +532,9 @@ static int nft_exthdr_init(const struct nft_ctx *ctx,
 			return err;
 	}
 
+	if ((priv->flags & NFT_EXTHDR_F_PRESENT) && len != 1)
+		return -EINVAL;
+
 	priv->type   = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
 	priv->offset = offset;
 	priv->len    = len;
-- 
2.53.0


