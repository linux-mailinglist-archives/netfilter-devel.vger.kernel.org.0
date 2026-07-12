Return-Path: <netfilter-devel+bounces-13858-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2TqSOybxUmp6VgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13858-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 03:43:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CF7436E0
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 03:43:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dj+C22Tk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M8CGl84U;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dj+C22Tk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M8CGl84U;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13858-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13858-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15AA2302333C
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C4622AE48;
	Sun, 12 Jul 2026 01:41:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD955EAC7
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 01:41:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820511; cv=none; b=RumO8LG/oIrfJZdNUJ8zEaP2/byuDOF4TqyWV2fy2F1QdfqXwDO4IF4jqSyLwndaZY6DXqDAPAOrUXVSP8PR/NlpvfHtRSknEHqeDIZNj4WrXx5ij9wvlc09TkaMUKOY7kBE80PWEB5Y9s4xL1xKAOElIB71YJmyLfeSwSzug80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820511; c=relaxed/simple;
	bh=5JFS3ri3pJBkKVB2bX5ICnJ6rU9FwPt5YO9nXT+RTJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1N9X43tDLEgTGMMJFPad6QZcSyGUFFrfxVwc1wjLWbSq5dJ2m7C1rb+IZSNx2Xfl7ZvcBmD9gVL9gx6qSCb2JeHaBRp/YDz7YiSuKilfYnPKwD5pgUVk8WP0AJjhZGKFahNomdimyG6xSqm1Hk8KWinQdpQQPEIqGAzQFE3qL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dj+C22Tk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M8CGl84U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dj+C22Tk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M8CGl84U; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 442E57703C;
	Sun, 12 Jul 2026 01:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Du9DlVcQQtt019O5iWRp0rWx9LaK6o0scIR3nmxyuKY=;
	b=dj+C22Tkv+saUpN7jgZbq2kdnbb1UaAMBJiyqls+wIJtDj4dU/6TxNeJZjIIiXVwnwnC7P
	+ZMs2tSZuzuMMniHUq1aJE3QCqNmlGge5AMxSyvpUEWdKiAv9wAJsvgIH+KTimqPkjG+AK
	kM8WAIQr0Zq2Dr61hR7TtQjtYg0qSEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Du9DlVcQQtt019O5iWRp0rWx9LaK6o0scIR3nmxyuKY=;
	b=M8CGl84UhFqO4YgpYCIdPUzKWnUoA3VXr99MTLDj9UqvbMHnEDgfp5SthR7e6iIkjeO6eE
	Hf1m4ngYlEKPEPAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Du9DlVcQQtt019O5iWRp0rWx9LaK6o0scIR3nmxyuKY=;
	b=dj+C22Tkv+saUpN7jgZbq2kdnbb1UaAMBJiyqls+wIJtDj4dU/6TxNeJZjIIiXVwnwnC7P
	+ZMs2tSZuzuMMniHUq1aJE3QCqNmlGge5AMxSyvpUEWdKiAv9wAJsvgIH+KTimqPkjG+AK
	kM8WAIQr0Zq2Dr61hR7TtQjtYg0qSEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Du9DlVcQQtt019O5iWRp0rWx9LaK6o0scIR3nmxyuKY=;
	b=M8CGl84UhFqO4YgpYCIdPUzKWnUoA3VXr99MTLDj9UqvbMHnEDgfp5SthR7e6iIkjeO6eE
	Hf1m4ngYlEKPEPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59D3D779B5;
	Sun, 12 Jul 2026 01:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LLZEtvwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:47 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/13 RFC net-next] netfilter: ipv4: guard ip_route_me_harder() with CONFIG_IPV4
Date: Sun, 12 Jul 2026 03:39:10 +0200
Message-ID: <20260712013941.4570-13-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13858-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 882CF7436E0

To enable compiling the network stack without IPv4, IPv4 specific packet
rerouting logic inside netfilter must be bypassed. Therefore, guard
ip_route_me_harder() with IS_ENABLED(CONFIG_IPV4) so it returns
-EPROTONOSUPPORT when IPv4 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/netfilter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index ce9e1bfa4259..9576d91bb6a6 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -21,6 +21,7 @@
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
 int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, unsigned int addr_type)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct net_device *dev = skb_dst_dev(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
@@ -85,6 +86,9 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 		return -ENOMEM;
 
 	return 0;
+#else
+	return -EPROTONOSUPPORT;
+#endif
 }
 EXPORT_SYMBOL(ip_route_me_harder);
 
-- 
2.54.0


