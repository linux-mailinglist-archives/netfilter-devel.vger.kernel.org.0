Return-Path: <netfilter-devel+bounces-13447-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yNn4BfskPGr4kQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13447-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 20:42:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540F6C0C52
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 20:42:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=ead6uOhT;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13447-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13447-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F893025C3B
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 18:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA8F331EC2;
	Wed, 24 Jun 2026 18:41:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01E331EBC
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 18:41:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326518; cv=pass; b=HpCOQDFi1YCPg7XtjPZL/7rc+t6F8ClopZJoeJ3Uvsb5zc/4ScZxv4lEYn99EEr3RCXzBXBxkyOxcXttefabgv1Bzodi6Oga2FaUkj3HqXvJ3BF069sPhWE2LSNpN4SwDAFZZLZknh5fEerMhlnI3T4VO7cULsZK72+eClNOSjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326518; c=relaxed/simple;
	bh=KPpc7i/23DreElerp/UeAsY+MqGXG+BwpFEAEmgejoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYrvQrbIMVL2rW5RdnmoRCF3Y0IEeuLiXfDHTkZ6UeTP6/eEqz7Vhgcqa8Pl3UndaE9AMno6BRA56ARNuTvMRiXe+j4WtI2cWu9Z9Q1HLNvRxbe/wxfxqY0ihK9JI/41g/qXo/T7TEYCOyjdR6NWLcVFrRduM6hcQpojf2Y9HGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=ead6uOhT; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1782326470; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XDtxOWQsz35xSZgTCVWCjOADT0Mvc5gCKZRt9+kgZH0zZs242+mmmcdN4VW2oEy0cCwnah0N0b/H73BkOvo7kZzYMyPI67aaFpwvjBKmsv0WDJy2wpy1Qo5dVBT2Yirsoi9oKHHnFhW1CxzSn0kSe9AGElDITXuvAReBzol1QS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1782326470; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mb8IAQf7krbnOGdDD44jfLQUWRAI45q8hD7SpkKN8CQ=; 
	b=WjlwXTFyX6F1O96jY4Hx9GKgW+f7VbtU/SLD3hHR7mn1vzZaN1CxNlmj48dpuwLkGB+evCvGJXZrOx5NSnqMb3Ci5lX1bfk8JfJsDQFZN4euztyCcYVsVpNzm0Z5nLJH7/Zxd3tpWTPqGHCd+rhDXyw/e5V9/lQH5qiLbNRhfhg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782326470;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mb8IAQf7krbnOGdDD44jfLQUWRAI45q8hD7SpkKN8CQ=;
	b=ead6uOhTKiwEqc2NaiTAZv4h1CymQw9jEbRZ3p07XMdfV02SfHKBfXZ9dX85RdaK
	KkJG65PBZWJtA4NjfanvTt5ZC3Vl5mHpWdsBMHSdSsXpfz1ACOgwb3C0ke62xF1btIb
	flQLXftNrql6DrujP+nJ5erbFub3m5D7T+k+C5wc=
Received: by mx.zoho.eu with SMTPS id 1782326469670120.96491153838167;
	Wed, 24 Jun 2026 20:41:09 +0200 (CEST)
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
Subject: [PATCH nf-next 3/4] netfilter: nf_conntrack_amanda: replace u_int16_t with u16
Date: Wed, 24 Jun 2026 20:40:33 +0200
Message-ID: <20260624184036.71051-4-carlos@carlosgrillet.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13447-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6540F6C0C52

Use preferred kernel integer type u16 instead of the POSIX u_int16_t
variant.

No functional change.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/nf_conntrack_amanda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_conntrack_amanda.c
index ddafbdfc96dc..f10ac2c49f4b 100644
--- a/net/netfilter/nf_conntrack_amanda.c
+++ b/net/netfilter/nf_conntrack_amanda.c
@@ -89,7 +89,7 @@ static int amanda_help(struct sk_buff *skb,
 	struct nf_conntrack_tuple *tuple;
 	unsigned int dataoff, start, stop, off, i;
 	char pbuf[sizeof("65535")], *tmp;
-	u_int16_t len;
+	u16 len;
 	__be16 port;
 	int ret = NF_ACCEPT;
 	nf_nat_amanda_hook_fn *nf_nat_amanda;
-- 
2.54.0


