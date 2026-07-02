Return-Path: <netfilter-devel+bounces-13590-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LStrOYZDRmqGNAsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13590-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 12:55:02 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA26F6413
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 12:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13590-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13590-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7976E306B3EB
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65FF3C2B8F;
	Thu,  2 Jul 2026 10:50:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C93C661A;
	Thu,  2 Jul 2026 10:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989440; cv=none; b=SwKpj8kLpGeBhXd+g6WLXJ32J3XHCH3yWrikV+h09zyOjI4MF23bNPeo8E/bEGvrM5blOmiHmcffVpXMRHFS330BpZaPJ/NYxo4Vjm9EDeZTs/w2EoidSHXE8I5lCVGpTLPpTv0DEkNu09ukp4lzQbHaGBAg6YDq5S5MGFDYR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989440; c=relaxed/simple;
	bh=BEVLRaNL3omsuuBN1cVn05yN0wyxjrfpJAQTZBNgMQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1v4/h9qHDIVb2gbg3hWlInDzJtq5UPKEUDaFPwtrCE6SIshDzfOZ2tb6PJV9f1qOie/Dqp0Dj2fhLqi7Bz/FO73T1TzuMk+HOOgRAvy7wJWyMXFiVae6BJs73lpxLFvm1ad5t4zcntIlnnllGWhdZFHAuuPAceQ1yYDt2lW+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3876B601F0; Thu, 02 Jul 2026 12:50:38 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 06/12] netfilter: xt_tcpmss: add checkentry for parameter validation
Date: Thu,  2 Jul 2026 12:49:57 +0200
Message-ID: <20260702105003.13550-7-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702105003.13550-1-fw@strlen.de>
References: <20260702105003.13550-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13590-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,strlen.de:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76EA26F6413

From: Feng Wu <wufengwufengwufeng@gmail.com>

Add tcpmss_mt_check() that validates mss_min <= mss_max and
invert <= 1.

Signed-off-by: Feng Wu <wufengwufengwufeng@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_tcpmss.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/xt_tcpmss.c b/net/netfilter/xt_tcpmss.c
index b9da8269161d..b08b077d7f0a 100644
--- a/net/netfilter/xt_tcpmss.c
+++ b/net/netfilter/xt_tcpmss.c
@@ -78,10 +78,23 @@ tcpmss_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return false;
 }
 
+static int tcpmss_mt_check(const struct xt_mtchk_param *par)
+{
+	const struct xt_tcpmss_match_info *info = par->matchinfo;
+
+	if (info->mss_min > info->mss_max)
+		return -EINVAL;
+	if (info->invert > 1)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct xt_match tcpmss_mt_reg[] __read_mostly = {
 	{
 		.name		= "tcpmss",
 		.family		= NFPROTO_IPV4,
+		.checkentry	= tcpmss_mt_check,
 		.match		= tcpmss_mt,
 		.matchsize	= sizeof(struct xt_tcpmss_match_info),
 		.proto		= IPPROTO_TCP,
-- 
2.54.0


