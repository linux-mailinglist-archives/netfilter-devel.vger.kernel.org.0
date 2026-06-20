Return-Path: <netfilter-devel+bounces-13375-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VNVdIz4UN2okJAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13375-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:29:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA16A9D35
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="Ysgp/dYj";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13375-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13375-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B7E0301443D
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91C33ADB9;
	Sat, 20 Jun 2026 22:28:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D02D595D;
	Sat, 20 Jun 2026 22:28:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781994492; cv=none; b=SxvlQ/a1saavc0ixJ3TTwKNjjNjGiZoFPH4I/JPlKmnqC1g/L+KhL5Ubf1j1E19iA1AK9AzejnCrR84/uKEoyH8xyaCmdGKf+if8agp0KvnauPmuzypQK5vfuz7TSj2ZyybH+Ts5ivVuXNM5Hqef02MwnNgDb3lzRki2jgv5GnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781994492; c=relaxed/simple;
	bh=+AzXFo4T6v1RIfnmKcyx8E4CwWCiT/IWhQ4pCUw5fhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3bTfc87wpgUZA8HDSo6U6NLgsXXpmJxKxKsG3jR5JB3ry88SwnrB0rshL18iellQVXr286O+EZa+tUoy1Ilr99C4Ay4V/xDtyrmvWfmHet0uy0rhQrvq3mAfhI9S5au7zRkMvhI+T5EeNDIEmC4QdBYTjLhOlqCj1wWLCeNsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Ysgp/dYj; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id A3C0760195;
	Sun, 21 Jun 2026 00:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781994480;
	bh=eHVdHZQlyXs+DWFytBBQ6PjoF6DaLnKX3UNbyidQQqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ysgp/dYjMyLlvzzOmx8hwCvXq3SXSQ9JyvKer+zaCBUEC0PxMDEKfhXZ3BOfS0nhr
	 e1X6YI55pugBM3Aw18KV2p63IaZ5/znhBdHVq6uauqIUUdUaSyU3qtNumlp4LRX6SX
	 gB8xUbAhMNI0ZgyEHtMOKgB/b+odaCs/sAFr76oXg3D8GRb8DfZY8isL5L0iC055fh
	 kXGCb56z5XZ4gfzXSqkbwi/3tKr3B0WUXHAFgFtNOy9QPiHBlGd2rdtMDnh2OEgP6n
	 6/qpR5NTCIEwPbYUs6B6qiB1PvzUCN/Bsn/hOTzV4MuuPQlOb47J8PxUxPCjuhD6qx
	 W+/tslscQaA9g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 14/14] netfilter: nft_meta_bridge: fix NFT_META_BRI_IIFPVID stack leak
Date: Sun, 21 Jun 2026 00:27:38 +0200
Message-ID: <20260620222738.112506-15-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13375-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,strlen.de:email,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDDA16A9D35

From: Florian Westphal <fw@strlen.de>

This needs to test for nonzero retval.

Fixes: c54c7c685494 ("netfilter: nft_meta_bridge: add NFT_META_BRI_IIFPVID support")
Closes: https://sashiko.dev/#/patchset/20260618061631.21919-1-fw%40strlen.de
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/bridge/netfilter/nft_meta_bridge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 3d95f68e0906..e4c9aa1f64e2 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -44,7 +44,9 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		if (!br_dev || !br_vlan_enabled(br_dev))
 			goto err;
 
-		br_vlan_get_pvid_rcu(in, &p_pvid);
+		if (br_vlan_get_pvid_rcu(in, &p_pvid))
+			goto err;
+
 		nft_reg_store16(dest, p_pvid);
 		return;
 	}
-- 
2.47.3


