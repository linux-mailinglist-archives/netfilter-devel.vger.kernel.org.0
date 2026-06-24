Return-Path: <netfilter-devel+bounces-13450-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EoeHKhclPGoBkggAu9opvQ
	(envelope-from <netfilter-devel+bounces-13450-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 20:42:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 591806C0C6C
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 20:42:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=H3R1Jzck;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13450-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13450-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFDEE303FB40
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFCD332913;
	Wed, 24 Jun 2026 18:42:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51A7331EA9
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 18:41:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326520; cv=pass; b=RCnPdgEiKklUt82i9U/Ikw1oLiVIB+5uBDnknYeqnlWYvMFWdTHtjx+KJuKiQyIBD273LjMxcPoUH2Y5Zz8zLG6bmME0pYS8Z5NjFRDUTQdRQctNgP2OiyZZYsfoV+DG800nc02doOziU9eFxieZbaRPcooMaQvAfFm2hEyrrE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326520; c=relaxed/simple;
	bh=+doOZHV7zTMOxE5pLmgv0kd7ME4wCMB4guw/Abc3ytk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9dhwh0QSsEjA47gU4MRnaCEbBLbWZb/iXl16TgfWHYNhqAiBgur/RKiKYXOBidH+Hbt3KZIssB0160SCBIUqKXelbeBc08TpG4kyRwr/uxcMEv6bwZVhosUNQPT1unt9QUkbED49OWi4G1CF+F0kJXgrYf/chL3refTMd0n0us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=H3R1Jzck; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1782326468; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dw9v22wV9Bo0ZfpWZ15urx7tVPTEy9VGs3r2qGWIHhQlJTdETfCbFeLCPKZpWSTAW9d3mi7hMxR33Rt2oUfGv0VHLTmkJfuBDJW101mycI+XofVbVy65GN+TQHmo267OoTX9I1OWP/CUxDC9eIpN/kWJpys7Jhqm4YMD1jddx8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1782326468; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WEoUmbuS1H4OXuhKXddsnI5lWKVDV5u1LMeOr2lxRrQ=; 
	b=Nba0zpiCRhVj8Hk+tMZAJZnny8cQUQmEZZn/X0m5NJn0BbdAaipKPVKrQ2blIeQNbc/nHexI9tPYyxVrtxOxTJ0gxqf9tkRNNQqnVIkKvfumGCosHVF3XbyBR/goTKR+OB+GFWoWP2esesawD7NweZ9pKp0+0dxISpWLVr8gwU8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782326468;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WEoUmbuS1H4OXuhKXddsnI5lWKVDV5u1LMeOr2lxRrQ=;
	b=H3R1JzckW2SQEMxd3+wuFs49lYPLNlwz8KkEtZtgraz58Aa0ud3kl3HfH7j5uOe6
	2wIHpW1l8J4ycoM+e1Itn8MQWIDvSJ42p2jdAyjU2PE8QpkErBMiMgkuN9bdjtqCAFS
	pfHGFOR+Zbya9iJACUJkpfu51O0qo8ncLq1X5Fs4=
Received: by mx.zoho.eu with SMTPS id 178232646578050.257016580389745;
	Wed, 24 Jun 2026 20:41:05 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next 1/4] netfilter: nf_conntrack_sane: replace u_int16_t with u16
Date: Wed, 24 Jun 2026 20:40:31 +0200
Message-ID: <20260624184036.71051-2-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624184036.71051-1-carlos@carlosgrillet.me>
References: <20260624184036.71051-1-carlos@carlosgrillet.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13450-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 591806C0C6C

Use preferred kernel integer type u16 instead of the POSIX u_int16_t
variant.

No functional change.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/nf_conntrack_sane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_sane.c b/net/netfilter/nf_conntrack_sane.c
index 39085acf7a71..130b3e68090e 100644
--- a/net/netfilter/nf_conntrack_sane.c
+++ b/net/netfilter/nf_conntrack_sane.c
@@ -35,7 +35,7 @@ MODULE_DESCRIPTION("SANE connection tracking helper");
 MODULE_ALIAS_NFCT_HELPER(HELPER_NAME);
 
 #define MAX_PORTS 8
-static u_int16_t ports[MAX_PORTS];
+static u16 ports[MAX_PORTS];
 static unsigned int ports_c;
 module_param_array(ports, ushort, &ports_c, 0400);
 
-- 
2.54.0


