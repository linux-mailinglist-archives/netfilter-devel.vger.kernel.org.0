Return-Path: <netfilter-devel+bounces-13704-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uR7gJwtZTWrfygEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13704-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 21:52:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE671F6B5
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 21:52:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=YcgUL602;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13704-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13704-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F1B2300B85D
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270CA3C553C;
	Tue,  7 Jul 2026 19:52:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD443BE16A;
	Tue,  7 Jul 2026 19:52:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453949; cv=pass; b=WRrWL2wv2UNuzvYD6w/x9WWXIPgda8MG9bbfkjIClcSLUxZlI9J6KFXZ/TxpwFJAhJZWNKpILpMQcJVIAo+qutzgr48AyrudOwbggIEsbhVzhIlH5w801GgZk1nzKcBfuf/SSBrE/VVPVGfGnCZZOz07CoIeCr4sPxQojfXQung=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453949; c=relaxed/simple;
	bh=kCudANBtGiV5T7jptIuz8pqxyLSpQUKq387uHza/Bak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdP8Hgk00S2NniRFTA74nAV+xB0RIA0R9mXZoyVhZl4/1F+JpyxTD2AVfoN/bdVTgyBKCY3kBg21ZmBZgDk/JF1pNf27/gcGGkGuiXI478DXjM+/noRKhjHVh2/ARO8ppPRZN+a5X67rwNZnJ+h7TKvYBmHhO47LD4AzS9nzVC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=YcgUL602; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783453888; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=h9H5irWI9/bgjSoY97OljlwHd/OmdSU/x0LHOruiu7vVlyqHjdk7XkI3xGbCO9WuPUwBzRm+eqMrLNSC85tAOx5qzL4uQdpPxHvTBEUI4cTpjd6AcbRg7CLvNdMOMbu6euq6JfhGoBV98wyStvxjoIZGwKM7qE5wARJ62OWtSKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783453888; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O7LzIaGXaXW2mRfZr0pOO8FkqoYCUO+P19vOSnpZkSE=; 
	b=hvW3K1+N5+v0vUStM0BvTPGap/nukly4fHFvkNy8GASB7WcqLfolweay923naxTmRGeXRBm13vdETuo1IWEpdE6eOmgo+eLQuGFgiR30CNljhpWUxXvNPipE8APotKD8W+W6W6DRicQcbO3uNnPHZjl3LeZEurKJPikJyOY2VZQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783453888;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O7LzIaGXaXW2mRfZr0pOO8FkqoYCUO+P19vOSnpZkSE=;
	b=YcgUL602JsgFw99gwSKLNuq01WCf40qU9kTzRpUcT6w2XH44xEbS6vRfMvPZDcGM
	jXjlb6meTN3ucM+gRv+c8kD2v2vzM5HfzNIzPqsXdp+h6AuMK+qY0jb0FUWRpnzGbYg
	UZZzHfKf8Zg9g2i61M9RSiZVFCDy4+R4HjTZsw0o=
Received: by mx.zoho.eu with SMTPS id 1783453886785522.5045739897042;
	Tue, 7 Jul 2026 21:51:26 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next 1/4] netfilter: ip_vs_core: replace u_int32_t with u32
Date: Tue,  7 Jul 2026 21:51:06 +0200
Message-ID: <20260707195111.34899-2-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707195111.34899-1-carlos@carlosgrillet.me>
References: <20260707195111.34899-1-carlos@carlosgrillet.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@verge.net.au,m:ja@ssi.bg,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13704-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,carlosgrillet.me:from_mime,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59BE671F6B5

Use preferred kernel integer type u32 instead of the POSIX u_int32_t
variant.

No functional change.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/ipvs/ip_vs_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index d40b404c1bf6..1ae997660148 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -882,7 +882,7 @@ static inline enum ip_defrag_users ip_vs_defrag_user(unsigned int hooknum)
 }
 
 static inline int ip_vs_gather_frags(struct netns_ipvs *ipvs,
-				     struct sk_buff *skb, u_int32_t user)
+				     struct sk_buff *skb, u32 user)
 {
 	int err;
 
-- 
2.55.0


