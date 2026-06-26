Return-Path: <netfilter-devel+bounces-13489-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QxDqAGn8PmrkNwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13489-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 00:25:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D96D06CB
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 00:25:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.org header.s=fm1 header.b=PVy3YdjP;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="f 3xj5qK";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13489-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13489-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A05DD301426F
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458583C3BFF;
	Fri, 26 Jun 2026 22:25:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558603B38B8;
	Fri, 26 Jun 2026 22:25:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512742; cv=none; b=LtzwFtxteIMVwgXDntXTnMrApEKa/PrM8YJpjvi2/9prn3w6sZDA3b7KaghuDmBRyoeMbcC8rDtn4mX561QVScv9VKvoJCzb82xe9rh+j+AEtUkpq1aWXGr87bRcyLSM2c3yjWp/F4KhiHU2SN1uoHvFPCdY1kBXkPjFx6chm8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512742; c=relaxed/simple;
	bh=vgDKgT9uPApyvwNlNEZ/Du+NvYzSfUH0Tk2CQR8Wug4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jf+hpNC7oRvsa0EmHYYFS6UoRZ36x8b+5+VfeTthDNVhnQMkNj8cq/tSUCrcgDXlrdax+Xxu42s/Ch9fgvxaQh2pTAmYRJGMEpUAM+//+oQ+HrFfhMrNIdKwyfrhOytiMBMKYHr7lTNy15lcvf/cdK+/+wZ6Tkl9jkidj7B81sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=PVy3YdjP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3xj5qKH; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 8358A1380B55;
	Fri, 26 Jun 2026 18:25:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 26 Jun 2026 18:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1782512739; x=1782516339; bh=cGRv315Cbhujrk3ajUjuJc2y+xKABgI1
	tmsYebXq2Rs=; b=PVy3YdjP0xGS9JXgzVhwdL8zbFEqDGo+T3qYkGUwkKZYI4XB
	b5+KIzoHQMzCXV8crc2OW3Qf4+Wsgt3WtwRwP97Y5svyIOZTrQzqajDKBiDebrBy
	ZnS6eFulhUj861cnpmPUkpA2d9Z4P7XMG2nfRGChoNLfJ6b8p/p9LxuH58HCGTXg
	tCTQNb0PQVSe9xgDhH94u5n3DHu7f7MtdisNd+3PdyT8C6vBXxgMhu884yAcE09V
	Nqxf8zBPF2AA6SLozMJ7WjTFNsA2uw3W714jOVfTKBu5c7s0Qc+9VyWE+IeLcigC
	ETvoObuTxtBWKv5w18vZdJXKx+0FypC8R4Qy1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782512739; x=
	1782516339; bh=cGRv315Cbhujrk3ajUjuJc2y+xKABgI1tmsYebXq2Rs=; b=f
	3xj5qKHxzmEXdyNuBxc15S30oCoQW1D2vhel7WQrs/1s+X0BqXv0uJUSWA0VemrI
	y1tAFPE9NpSQXn5p0NpE/AKtbKPPnRgGJOi1vVt9pYdauDCW99t0dZda0wfUjybH
	qtkMR7568emK6WUPttHWqRT+LyO3dSPJYYhOGjuoxhYz/9PCs/le1rlQD2+m2Avl
	385DA+i4rOXQLt/VyZd3rsroxjwr/LtJpqlbj24nwvcSEX9aozAEqQ5vSyP7De6H
	Njx4qbTAfGCKhDU5fLI88clmVbHUXSfHggUxzNqlFoq+xt8Fett55AAZrWaJhNHD
	4udyJJTI4ObfGVDa3poIQ==
X-ME-Sender: <xms:Yvw-an6VUjP_ztk2gtzxYOKewwUneEFgLGBSgp5CfBxGBXhMO4pvxg>
    <xme:Yvw-agnOZr4US9hevPcb-sIMTE2UbB7pMokrWWGrXoLK1XWjmaoD8083pNQFvpvdf
    U8JPhD_sQy5ElqZSBASW2yZR0KsJwp310lBqZ-q3PSXXrtfTi-lyQ>
X-ME-Received: <xmr:Yvw-anEdpfR16TuLXsPrU4ehwEXXWDWmcfScuoHbUR8vCbw6NFoKeKuk2mE>
X-ME-Proxy-Cause: dmFkZTFJ4t6kJJZBgwBaMYrW5AHeBXgQlxFOy0ryBa5zDYkt8CcAmz71lse8hLmF0n9qAg
    FuiIN9Slpe1JVI3fyjhnVSDAIBFtqiFlGwlL40G4SZp7Hzfkr3yvtZaUbvWCXNoYc3Rsyx
    hGhrNCgrhNEFCwWFif4bUPCnXandSDVR9JDi7WFPlcJRQH71qLQOaTLfIw9L8WPfNX5O1V
    zYm/Qe9wKR2kTZ9E5nysSGymXXyzzlPYwpRhrtM+bxbC9GD9HGtig5AY7nrLUBbfir2ODp
    38aEOQwXz2erzhNsSYxZRB3Z4JbglhFVsqBwnm85MjaiMPvO8I7wexwLlqN/WoKw06P3WT
    ddhJz0I/EmJQrhajK07a9CwP/8b0mIRPHX66uwhRbWaBSna4xfUpYlvDY7fjmSpIw40fPN
    YHY2PVahgZRK8kjMWsfQ6R2lfoKwcquWJApIs8kXLzZWbNy4lOJhHdB7MXYgd/yEo+pO9J
    uEy25y+Bz3e3/NmoP9bSMZQF3Kf0qiTxBvJcMoOPcDuGn4Lw0f1PVskt0h9s10uHQmgnUK
    6xq1dLp5agfVUT5HIZyV84yoyQxB2VUHCfPpua6OylT5S4uD53vq04Jpl5eFN1c7ILs8Xu
    C8nsLaX9j2xoDpub69hg2w/JxBzISqE3/emJhfHhjJ1EnsN7c9nDETINBE3A
X-ME-Proxy: <xmx:Yvw-aphWbdXyJ_vq0bh_Wl8kUU2zPPQdhDLHBBX2rbj9SFJblryQMQ>
    <xmx:Yvw-asj25N7aTamkhBQtRj9V7EZOtPDK9H0dXyi35rWSp-UnqEQwKQ>
    <xmx:Yvw-akkCsytRBSjlCLPTg8C0xrB0sBLS69R0RH4Z13O6KjbSy2AWrQ>
    <xmx:Yvw-aoYiDbseyCgPzaUe8JS52Vj4xZSQuJzIIJINN8Hjh30YEbi5vw>
    <xmx:Y_w-annenn_MeFCvGiBZF2hGjXl8jIWNpdEOgabxw7evwv0-UVjReUj8>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 18:25:37 -0400 (EDT)
Date: Fri, 26 Jun 2026 17:25:35 -0500
From: Ian Bridges <icb@fastmail.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] netfilter: x_tables: replace strlcat() with snprintf()
Message-ID: <aj78X4Cjqcpbb8Co@dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[fastmail.org:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13489-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[icb@fastmail.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[fastmail.org:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[icb@fastmail.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev:mid,vger.kernel.org:from_smtp,messagingengine.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 478D96D06CB

In preparation for removing the deprecated strlcat() API[1], replace the
strscpy()/strlcat() pairs in xt_proto_init() and xt_proto_fini() with
snprintf(), which builds each /proc file name in a single call.

Each name is "<prefix><suffix>", where <prefix> is the address-family
string xt_prefix[af] and <suffix> is one of the FORMAT_TABLES,
FORMAT_MATCHES or FORMAT_TARGETS literals. snprintf() with a "%s%s"
format produces the same NUL-terminated, length-bounded string as the
strscpy()/strlcat() chain it replaces, so the proc entry names are
unchanged.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
 net/netfilter/x_tables.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 4e6708c23922..56f4546be336 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -2033,8 +2033,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
 	root_uid = make_kuid(net->user_ns, 0);
 	root_gid = make_kgid(net->user_ns, 0);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TABLES, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TABLES);
 	proc = proc_create_net_data(buf, 0440, net->proc_net, &xt_table_seq_ops,
 			sizeof(struct seq_net_private),
 			(void *)(unsigned long)af);
@@ -2043,8 +2042,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
 	if (uid_valid(root_uid) && gid_valid(root_gid))
 		proc_set_user(proc, root_uid, root_gid);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_MATCHES);
 	proc = proc_create_seq_private(buf, 0440, net->proc_net,
 			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
 			(void *)(unsigned long)af);
@@ -2053,8 +2051,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
 	if (uid_valid(root_uid) && gid_valid(root_gid))
 		proc_set_user(proc, root_uid, root_gid);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TARGETS);
 	proc = proc_create_seq_private(buf, 0440, net->proc_net,
 			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
 			 (void *)(unsigned long)af);
@@ -2068,13 +2065,11 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 #ifdef CONFIG_PROC_FS
 out_remove_matches:
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_MATCHES);
 	remove_proc_entry(buf, net->proc_net);
 
 out_remove_tables:
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TABLES, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TABLES);
 	remove_proc_entry(buf, net->proc_net);
 out:
 	return -1;
@@ -2087,16 +2082,13 @@ void xt_proto_fini(struct net *net, u_int8_t af)
 #ifdef CONFIG_PROC_FS
 	char buf[XT_FUNCTION_MAXNAMELEN];
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TABLES, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TABLES);
 	remove_proc_entry(buf, net->proc_net);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_TARGETS);
 	remove_proc_entry(buf, net->proc_net);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s%s", xt_prefix[af], FORMAT_MATCHES);
 	remove_proc_entry(buf, net->proc_net);
 #endif /*CONFIG_PROC_FS*/
 }
-- 
2.47.3


