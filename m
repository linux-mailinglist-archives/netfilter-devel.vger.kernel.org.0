Return-Path: <netfilter-devel+bounces-13635-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id olEpNLbjR2p/hAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13635-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 18:30:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E027043F9
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 18:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=000ty.net header.s=protonmail2 header.b=dskk8800;
	dmarc=pass (policy=quarantine) header.from=000ty.net;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13635-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13635-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B66F1301F309
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06E3054EF;
	Fri,  3 Jul 2026 16:23:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6E2BF3F4
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jul 2026 16:23:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095796; cv=none; b=AyVbNkMy2YmZ0/zGM5sHFxzfvlYu+T/4+NmePFcq302Yo6+ugZYjpzgfdBnuOa3CGQXqF+yd34YLOeAq+dnhyHkeFRRCPcXUMaaDlBneB+TD+bRdt+gd1EUwzzRbWoa7IpwNq5/HISXRSTVL4gh112PRM0uFI1G2czsbkPptZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095796; c=relaxed/simple;
	bh=3fNP+/zhDoQQN+AleySyX48n4L6zg+eKgmfA9mM2ozk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dzpuG0Jka8ztKtLdOz+uHNsd8UAT6ThKa0Y8M3PBcqCkK+BT1C9ucGev28Euj2X8SN20oEpFxP2tUGZfW3LyS8k++SKhhHOb7ZHV87dOeZlYuhCKI6up/cEVCqvH8lg2sH+MjQcclWCNokZc6OeI48p7VJeVvv1Nx8wrM0zkwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=000ty.net; spf=pass smtp.mailfrom=000ty.net; dkim=pass (2048-bit key) header.d=000ty.net header.i=@000ty.net header.b=dskk8800; arc=none smtp.client-ip=185.70.43.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=000ty.net;
	s=protonmail2; t=1783095784; x=1783354984;
	bh=3fNP+/zhDoQQN+AleySyX48n4L6zg+eKgmfA9mM2ozk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dskk8800l+FGMVrhcxSgclDRX9C0LG04hVGuirxyhKHQzeSPTLxBq4wGOkOiA1kco
	 MHdItaV30VkTx96ioiMrRC55TN1cFkQ5JUuoiHDzXeZec+fZcy0A6wagJ5p6PgQfyD
	 hxcFl0vhY0CFX6CwyKj6M8olVWUEwR4noHmesqWxNUraDpfuaF8pYoqkUZqBpTrj2O
	 wBSzGJW9COqnfxEy3U6jgmdoJTMCRihwIRQcrpWPH7VNhCWej+VAw5LEQLBmb+eA39
	 /dDH/Ti2848k/hvmqrjTIS1/1PTnYokEdBZmXdKaiLqze/gYVPzyv/9SW+EWehDZQS
	 ultt7riBGHH1A==
Date: Fri, 03 Jul 2026 16:22:57 +0000
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
From: Tamaki Yanagawa <ty@000ty.net>
Cc: Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-kernel@vger.kernel.org, Tamaki Yanagawa <ty@000ty.net>
Subject: [PATCH] netfilter: nft_lookup: fix catchall element handling with inverted lookups
Message-ID: <20260703162207.1496-1-ty@000ty.net>
Feedback-ID: 168296199:user:proton
X-Pm-Message-ID: e9869464d393b60f04f1bdb31252075f4c1752a1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[000ty.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[000ty.net:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13635-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:ty@000ty.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ty@000ty.net,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ty@000ty.net,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[000ty.net:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,000ty.net:from_mime,000ty.net:email,000ty.net:mid,000ty.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40E027043F9

nft_lookup_eval() decides whether a lookup matched (`found`) from the
direct set lookup and priv->invert before falling back to the
catchall element used by interval sets (e.g. nft_set_rbtree) for the
open-ended default range. Since `found` is never recomputed after
`ext` is replaced by the catchall lookup, inverted lookups
(NFT_LOOKUP_F_INV, "!=3D @set") can wrongly match or wrongly skip the
catchall element, producing the wrong verdict. Fold the catchall
lookup into `ext` before computing `found`, matching the order
already used by nft_objref_map_eval().

Signed-off-by: Tamaki Yanagawa <ty@000ty.net>
Assisted-by: Claude:claude-sonnet-5
---
 net/netfilter/nft_lookup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index ba512e94b..198874398 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -103,13 +103,13 @@ void nft_lookup_eval(const struct nft_expr *expr,
 =09bool found;
=20
 =09ext =3D nft_set_do_lookup(net, set, &regs->data[priv->sreg]);
+=09if (!ext)
+=09=09ext =3D nft_set_catchall_lookup(net, set);
+
 =09found =3D !!ext ^ priv->invert;
 =09if (!found) {
-=09=09ext =3D nft_set_catchall_lookup(net, set);
-=09=09if (!ext) {
-=09=09=09regs->verdict.code =3D NFT_BREAK;
-=09=09=09return;
-=09=09}
+=09=09regs->verdict.code =3D NFT_BREAK;
+=09=09return;
 =09}
=20
 =09if (ext) {

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.52.0.windows.1



