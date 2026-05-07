Return-Path: <netfilter-devel+bounces-12496-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCG8MeMk/Wn6YAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12496-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 01:48:51 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE614F046D
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6F8307DA1E
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 May 2026 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39295366045;
	Thu,  7 May 2026 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="HPfI1hFi"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D735E95A;
	Thu,  7 May 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197530; cv=none; b=pYEO8MEtxqmZReM5WRXxj6WGwQBwKM4tEJ2Y+MSVxB9Z49xB1qjcAxRu8kMV4rnps1MtVUdvA+LUF7p2R7q8ADyY8dFOouX6oy6MSZyVhAVvJPsQvTlV+46lHosIWm5HS72c2ubVjgkB9b8yUtpyWf8DVsJ/0AkMU2gfi4stcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197530; c=relaxed/simple;
	bh=xEoN9r4xQUaIH726LoUjyfal0U2pLfWtydADIX+AjIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf7kUjG8lWxY1KYpB2dUEA6FD45vJ2SjNITfuj9OylwUWVLyhQAmP6JIeEnFGK2+vdInEWI6r+olZ8ozh4oPBE/NfvuT/FfETnfFDTOkBuZysh0I718pfJMZKd1bfx+PvIfZjL9XjsKSoDfSgcYUhj8jQaw8RjE2duAozn7F9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=HPfI1hFi; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id AEF2C600BA;
	Fri,  8 May 2026 01:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778197527;
	bh=FMvTuSk5lRXPIupiOq7lvTYDrNpIOGaK4S/rQMxNnNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPfI1hFi2uVc2ieTL8lgvNk0qgfeQ5fKo1bIZySQQlLF6I7orM//xKqZnqk3+zHr0
	 2FzCt0heTE/3uB3ZJ9DLMiBCJG7NDqrDLW5CGrJmKM+r1YC3goj2UK4xh+BKYuYHqg
	 yv42oWtFV+4RevHrh/iViTEhah17aqbL0/rDn0aJotCZPek3CHl7An1kUbNox9p0Hz
	 1v/0lCO7QAPmRrIBDoaIKsVDreiHWcrTmlRlApROq7JMhF21d8dh2LUBo2AuQotejh
	 mTmI92KfHiguQ73Kjf8Xdc8/XwF7/7XeIXnKG73MPX+7Q/D33WsDQ4rk7syvxS/4DM
	 k7Qkacg1HxE+w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 09/13] netfilter: bridge: eb_tables: close module init race
Date: Fri,  8 May 2026 01:45:05 +0200
Message-ID: <20260507234509.603182-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507234509.603182-1-pablo@netfilter.org>
References: <20260507234509.603182-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6AE614F046D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12496-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:mid,netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]
X-Rspamd-Action: no action

From: Florian Westphal <fw@strlen.de>

sashiko reports for unrelated patch:
 Does the core ebtables initialization in ebtables.c suffer from a similar race?
 Once nf_register_sockopt() completes, the sockopts are exposed globally.

sockopt has to be registered last, just like in ip/ip6/arptables.

Fixes: 5b53951cfc85 ("netfilter: ebtables: use net_generic infra")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/bridge/netfilter/ebtables.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 3578ffbc14ae..b9f4daac09af 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2583,19 +2583,20 @@ static int __init ebtables_init(void)
 {
 	int ret;
 
-	ret = xt_register_target(&ebt_standard_target);
+	ret = register_pernet_subsys(&ebt_net_ops);
 	if (ret < 0)
 		return ret;
-	ret = nf_register_sockopt(&ebt_sockopts);
+
+	ret = xt_register_target(&ebt_standard_target);
 	if (ret < 0) {
-		xt_unregister_target(&ebt_standard_target);
+		unregister_pernet_subsys(&ebt_net_ops);
 		return ret;
 	}
 
-	ret = register_pernet_subsys(&ebt_net_ops);
+	ret = nf_register_sockopt(&ebt_sockopts);
 	if (ret < 0) {
-		nf_unregister_sockopt(&ebt_sockopts);
 		xt_unregister_target(&ebt_standard_target);
+		unregister_pernet_subsys(&ebt_net_ops);
 		return ret;
 	}
 
-- 
2.47.3


