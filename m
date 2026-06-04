Return-Path: <netfilter-devel+bounces-13049-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryqdJ3QZIWqf/AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13049-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:21:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7B463D3A0
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:21:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=ObYQbwT8;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13049-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13049-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E00D63016182
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 06:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176E3D6CA4;
	Thu,  4 Jun 2026 06:21:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4A3D6CCD
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 06:21:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554089; cv=none; b=Sy3N/Hvvz+cfhfZHHvbo0mADOZFF2ExvyetC//pNe9YhFsqbMldG3V3/mJBMpLpu2xa9wFGiUmPdIuBQOPbxEOQb646At4WDZy4BpWR33QtZqHgzsfdI7mQZew6jatIpkNocTH/RkAlm3rnTdTRGfmWGChP2QD9AtcVX9Aju+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554089; c=relaxed/simple;
	bh=QjWqEpYuCHa78eGbhw/ERhlgPRdIZOXJ7CGixLYYaVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKF9swNvptQtEz+uupLzwAZXw3Ea5eJQ2UzeZOkpu6ZARVnCLAW8VTlRruc2vvHR+x+wR5WT47RuwNVAecZnisPcz7nbpsYJpVcDDb+8gDIpYRh94zi6JpxPXrHJVidqOaqK+IxZmFGSlxWFZhjduj9MrFSJEYrEFFDjR+YsyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ObYQbwT8; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id A071B6019B
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 08:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780554086;
	bh=LoZCsN9XsVupK8Jm7QIoy4Hp1kzyerE7WyNxhLKp6Gg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ObYQbwT8pkNFQ4fEaa/6YtPl7e0dblzpf0Wlhp5JSow30Uq8XpuIlhBmOdDSfTkSm
	 oSRivY1t4AEW0kpbDoBzHEcghaP+wo6+j5cdgYhtk+BW4lvj09mK4Mc+dU9MFzbPVi
	 k7mT8xkr9z8Opf+sJI2Wo2h7Jk7MeBhAOIN/G7REnyHsy4O5XlQyVLqIBasMo9JixM
	 QwTPLHb/tTstQEJO93AiiBA4hiCUFBcQqNzRXyvmrLN3+5K/gpo+/8eDXlJUG5WWUY
	 YCBqA2mJQNionx9q+SAO308K+MSJVK2QeCZ/trMNZMXRGHmoKmxXs9I8Dey1pnYe/i
	 t+IJHJeco1aEw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v5 6/7] netfilter: conntrack: call nf_ct_gre_keymap_destroy() if master helper is pptp
Date: Thu,  4 Jun 2026 08:21:13 +0200
Message-ID: <20260604062114.832273-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604062114.832273-1-pablo@netfilter.org>
References: <20260604062114.832273-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13049-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:mid,netfilter.org:dkim,netfilter.org:from_mime,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E7B463D3A0

For GRE flows, validate that the ct master helper (if any) is pptp
before calling nf_ct_gre_keymap_destroy(), so the helper data area
can be accessed safely. Note that only the pptp helper provides a
.destroy callback.

Fixes: e56894356f60 ("netfilter: conntrack: remove l4proto destroy hook")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v5: no changes

 net/netfilter/nf_conntrack_core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index bae96b37287e..856cda473a14 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -562,9 +562,23 @@ static void destroy_gre_conntrack(struct nf_conn *ct)
 {
 #ifdef CONFIG_NF_CT_PROTO_GRE
 	struct nf_conn *master = ct->master;
+	struct nf_conn_help *help;
+
+	if (!master)
+		return;
+
+	help = nfct_help(master);
+	if (help) {
+		struct nf_conntrack_helper *helper;
 
-	if (master)
-		nf_ct_gre_keymap_destroy(master);
+		rcu_read_lock();
+		helper = rcu_dereference(help->helper);
+		/* Only pptp helper has a destroy callback. */
+		if (helper && helper->destroy)
+			nf_ct_gre_keymap_destroy(master);
+
+		rcu_read_unlock();
+	}
 #endif
 }
 
-- 
2.47.3


