Return-Path: <netfilter-devel+bounces-13372-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cKOhE7kUN2o9JAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13372-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:31:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C2D6A9D61
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:31:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=jXsD8tNK;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13372-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13372-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270F33043FEF
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C0374A14;
	Sat, 20 Jun 2026 22:27:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DC347BD9;
	Sat, 20 Jun 2026 22:27:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781994477; cv=none; b=ludvWGlv/nJGIlET8LwoDQgAUsM9mWXZCYWxrNm6tnL7igci//eU6NCpt6D0Fl+7+F/unfy37MfDvemWwEmMz/lpfg0Er5xj1exqlNCoMms6iY7qAuwRJv3n4spqPkMx3Hv8vcfI5Lg5+oqYTgzgQi0RcvmhpUNbiLUFMBMQDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781994477; c=relaxed/simple;
	bh=RsDaxyPuvOrBmPdJ6FVONCDxwowu3uBw/KYyrv/aet4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzRGnQfqjoIPLeZRDSAJ6X6kKBmHfz7ThQaopr83KKdVsR0J1buAyCmYmuAFy5uMU47aL/ia+YS8KBckQVvq7okKMBK6FVhKb2pdaQ6tMS3sE0Ij/rbAXxG5ogNq7nE/YogPPR0GAVqr/gtrFHAknSlweRXACEfihNRTzYRcfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=jXsD8tNK; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id EF64F60195;
	Sun, 21 Jun 2026 00:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781994475;
	bh=UBi8nAYVNxDOC9Fca/g+kEvutyyeLg3iui/uJTcXf3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXsD8tNKLhkGaB5+PhkVY/suggDzRvj4ymkM0jt1I565Ib/rPPLsAMJ4gOhbRmRh7
	 HZU8XZnhXAoVKymSNobxETV7hrn+WfhQvMYS/QSc/R+y5FdeFf9v0BZs5UYD/5DahY
	 +XZDj2s9yUKO7ZidWP3ofIl82ebcqkL6qjzTOWASTltpQxJa6HUdN8RzbW0NBmsREI
	 jrxkD/GNxOol/mr7UCAlkPDdeGm+flqBJf/rVZRb7TSA6cn+Km/nC5+Z5mQr9gqtjl
	 /TOqGRDFIVRkkkSbYUMaSH2/RQQucKrbed1C91jYEpleJrdvuMbs2WKMUocz0A7Dea
	 XZNKzCDVOdWSg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 11/14] netfilter: nft_flow_offload: zero device address for non-ether case
Date: Sun, 21 Jun 2026 00:27:35 +0200
Message-ID: <20260620222738.112506-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620222738.112506-1-pablo@netfilter.org>
References: <20260620222738.112506-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13372-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,strlen.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3C2D6A9D61

From: Florian Westphal <fw@strlen.de>

LLM points out that the skip causes unitialised stack array to
propagate down into dev_fill_forward_path().  Its not clear to me that
there is a guarantee that a later ctx.dev->netdev_ops->ndo_fill_forward_path()
would always fix this up.

Cc: Felix Fietkau <nbd@nbd.name>
Fixes: 45ca3e61999e ("netfilter: nft_flow_offload: skip dst neigh lookup for ppp devices")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_path.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 1e7e216b9f89..98c03b487f52 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -53,8 +53,10 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 	struct neighbour *n;
 	u8 nud_state;
 
-	if (!nft_is_valid_ether_device(dev))
+	if (!nft_is_valid_ether_device(dev)) {
+		eth_zero_addr(ha);
 		goto out;
+	}
 
 	n = dst_neigh_lookup(dst_cache, daddr);
 	if (!n)
-- 
2.47.3


