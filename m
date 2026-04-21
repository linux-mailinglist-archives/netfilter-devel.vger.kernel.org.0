Return-Path: <netfilter-devel+bounces-12104-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIEZHrRV52nz6gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12104-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 12:47:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3AC439B86
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E1EA3058E2D
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB03BD654;
	Tue, 21 Apr 2026 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wgjNRAle";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytXZh8GK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wgjNRAle";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ytXZh8GK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A223BD649
	for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2026 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768264; cv=none; b=RpMpzBEisZKmygI2fO72BmruIlt8Ejl2Isdo5HQ7VXrRX4HOQhqUn4eoyMzZgbQFTiFuDf6VkN9p9xf655dpCpnmkLJPEW8Pa4swqqUGSaQg/clrMCyC5gT+zwSfUxIw+vCHP1cHv3jtLB3czHOlG2Rsmd8kjM2deRwbuUMLfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768264; c=relaxed/simple;
	bh=jCGAbJcqZie1khDgn3UuLEEK7eaElN//qbAj/1davI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQatSwAUEXeuAjFTsKF9T0KUsRWT80x4M05ZWouEK6il7LSE+3AWPEl94JM0q/wQY0ylv0jQikyMMSD0vm81cVwfU1aMdxhM2bROu4KN/7Hq8XCZy9xj0na4V/bgej0YeT9WppzIWemK0EOjGQj2Jk09ejBSkfzrOzXM9mjDBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wgjNRAle; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytXZh8GK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wgjNRAle; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ytXZh8GK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A67575BD53;
	Tue, 21 Apr 2026 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776768260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=svQOENRHQ8RnEbPHv1nVUZshhRbtJGNdUhcT04uheuU=;
	b=wgjNRAleXLmDEzxjf5PAyVe9G9EJnBbPIiwmyD44d366UAd/EliO86Y7UEHnKyb7O5X9JN
	QXJ/c32RGj91Z0xe08jNJT2TF1HCupqd4XjLNZdUp5tGq9FZQbKzT9cboUv2x3AVVqm2LJ
	w4Ol55MeI42b1TmiglVpO42wkgiTvCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776768260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=svQOENRHQ8RnEbPHv1nVUZshhRbtJGNdUhcT04uheuU=;
	b=ytXZh8GKVBfhvx16N9WKeaBcs9yUmafN8ixBXJipy4N3PPcq3zxvL9vukJWHkDtMVtRgCR
	nNEoUWjbgQrz7fCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776768260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=svQOENRHQ8RnEbPHv1nVUZshhRbtJGNdUhcT04uheuU=;
	b=wgjNRAleXLmDEzxjf5PAyVe9G9EJnBbPIiwmyD44d366UAd/EliO86Y7UEHnKyb7O5X9JN
	QXJ/c32RGj91Z0xe08jNJT2TF1HCupqd4XjLNZdUp5tGq9FZQbKzT9cboUv2x3AVVqm2LJ
	w4Ol55MeI42b1TmiglVpO42wkgiTvCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776768260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=svQOENRHQ8RnEbPHv1nVUZshhRbtJGNdUhcT04uheuU=;
	b=ytXZh8GKVBfhvx16N9WKeaBcs9yUmafN8ixBXJipy4N3PPcq3zxvL9vukJWHkDtMVtRgCR
	nNEoUWjbgQrz7fCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EB1D593AF;
	Tue, 21 Apr 2026 10:44:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IbFJCARV52ljagAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Apr 2026 10:44:20 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	ecklm94@gmail.com,
	phil@nwl.cc,
	fw@strlen.de,
	pablo@netfilter.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/3 nf v3] netfilter: nf_socket: skip socket lookup for non-first fragments
Date: Tue, 21 Apr 2026 12:44:07 +0200
Message-ID: <20260421104409.5452-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12104-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,gmail.com,nwl.cc,strlen.de,suse.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: CE3AC439B86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both nft_socket and xt_socket relies on L4 headers to perform socket
lookup in the slow path. For fragmented packets, while the IP protocol
remains constant across all fragments, only the first fragment contains
the actual L4 header.

As the expression/match could be attached to a chain with a priority
lower than -400, it could bypass defragmentation.

Add a check for fragmentation in the lookup functions directly so the
problem is handled for both nft_socket and xt_socket at the same time.
In addition, future users of the functions would not need to care about
this.

Fixes: 902d6a4c2a4f ("netfilter: nf_defrag: Skip defrag if NOTRACK is set")
Fixes: 554ced0a6e29 ("netfilter: nf_tables: add support for native socket matching")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v3: added this patch to the series, I splitted this as the fix is
generic for both nft_socket and xt_socket
---
 net/ipv4/netfilter/nf_socket_ipv4.c | 3 +++
 net/ipv6/netfilter/nf_socket_ipv6.c | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nf_socket_ipv4.c b/net/ipv4/netfilter/nf_socket_ipv4.c
index 5080fa5fbf6a..f9c6755f5ec5 100644
--- a/net/ipv4/netfilter/nf_socket_ipv4.c
+++ b/net/ipv4/netfilter/nf_socket_ipv4.c
@@ -94,6 +94,9 @@ struct sock *nf_sk_lookup_slow_v4(struct net *net, const struct sk_buff *skb,
 #endif
 	int doff = 0;
 
+	if (ntohs(iph->frag_off) & IP_OFFSET)
+		return NULL;
+
 	if (iph->protocol == IPPROTO_UDP || iph->protocol == IPPROTO_TCP) {
 		struct tcphdr _hdr;
 		struct udphdr *hp;
diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
index ced8bd44828e..893f2aeb4711 100644
--- a/net/ipv6/netfilter/nf_socket_ipv6.c
+++ b/net/ipv6/netfilter/nf_socket_ipv6.c
@@ -100,6 +100,7 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 	const struct in6_addr *daddr = NULL, *saddr = NULL;
 	struct ipv6hdr *iph = ipv6_hdr(skb), ipv6_var;
 	struct sk_buff *data_skb = NULL;
+	unsigned short fragoff = 0;
 	int doff = 0;
 	int thoff = 0, tproto;
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
@@ -107,8 +108,8 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
 	struct nf_conn const *ct;
 #endif
 
-	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
-	if (tproto < 0) {
+	tproto = ipv6_find_hdr(skb, &thoff, -1, &fragoff, NULL);
+	if (tproto < 0 || fragoff) {
 		pr_debug("unable to find transport header in IPv6 packet, dropping\n");
 		return NULL;
 	}
-- 
2.53.0


