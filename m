Return-Path: <netfilter-devel+bounces-13820-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jDuyAF2nUGrC2wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13820-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 10:03:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBD738405
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 10:03:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=XzLImhaA;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13820-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13820-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C27830125E7
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB293D9035;
	Fri, 10 Jul 2026 07:54:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762D2F362B
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 07:54:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670057; cv=none; b=Hv2gFxpW0zAduvRqL93xbURwYSM6yGwVHwcOrPd8o7o2RvdiQHLJwnw9f7pCA8LNXZE1yFCeD5Vn0AZGlXDHQ+VMMBZojb2Wzd6w5gn/qebBTrdm9Gsz38n1ncs3oF0agntBOaGbwLgibziXA9u3xZaz+CuMNWHJXHOBVSWO5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670057; c=relaxed/simple;
	bh=GNNxGv3mAnO4ZOpKayseRheWzsnEbK5XRTYD77xd7r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1SjihYh3D/2HY8vVDxGWgvbmwezuh5/eDsYtXVHErMhDvl6xpr6SVNGLeCUAgFaiqZ7UuFx/OmG9uj44KljB+UWgknh2HzRG7tR3bftYjVyIZZ0nEq6up2a9ouUgtg85uvqdvd1b3E2OIYW8gZEYfUUImzNuw3YVVdNUesdr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=XzLImhaA; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 263E46057F;
	Fri, 10 Jul 2026 09:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783670053;
	bh=lzZBUWFcLpOLTDR/bzU/zzZneWiV51oOZ7Fqy5H87nk=;
	h=From:To:Cc:Subject:Date:From;
	b=XzLImhaAXShkLSJvqVD1jJgjnezQIzGDsl76tu2A//8f01FLN9Q1Sobxg+0GFa2+8
	 L+KksmnLX8w/UmqfmRM+e4N7JhR7cFxEkKdEeV4saarEu5SVWUL9r/XrwmqpS5ayaS
	 /++P9Ckr/hQjvvU0x4T18XWQkljY7JhXU3jbZpkZg749lny+NNgK1dB8tV+sSGFZvG
	 gJ+OHtqQKblu7LkiqI9YZ0wOLb96SvH11i+oOkV13EFgVHAxXSsbmFgz83uf6cCsgy
	 pjr7a99SIVW3l+U61Kwq96h0eXebyQmq1duw5OVpMO3HgxemerUsLGO+m1izxOA3oe
	 R+WiwM6Ouxmew==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: anzaki@gmail.com
Subject: [PATCH nf,v2] netfilter: flowtable: tear down flow entries with stale dst from GC
Date: Fri, 10 Jul 2026 09:54:09 +0200
Message-ID: <20260710075409.1360085-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
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
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13820-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:anzaki@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[netfilter-devel@vger.kernel.org:query timed out,pablo.netfilter.org:query timed out];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:from_mime,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95BBD738405

In case of route updates, tear down flow entries with stale dst to give
them a chance to obtain a fresh route.

This is specifically useful for hardware offloaded entries, where the
flowtable software dataplane sees no packet, where the existing check
for stale dst entries does not help.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - reuse nf_flow_dst_check(), move it to .h file
    - use correct logic in nf_flow_dst_check() from GC step

This patch has been repurposed to the nf.git tree, because net-next.git is
still missing a recent fix and I would like sashiko kicks it for review.
So I am still leaning towards including this in nf-next.

 include/net/netfilter/nf_flow_table.h | 8 ++++++++
 net/netfilter/nf_flow_table_core.c    | 2 ++
 net/netfilter/nf_flow_table_ip.c      | 8 --------
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index ce414118962f..a090ec3ffef2 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -310,6 +310,14 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 void flow_offload_refresh(struct nf_flowtable *flow_table,
 			  struct flow_offload *flow, bool force);
 
+static inline bool nf_flow_dst_check(struct flow_offload_tuple *tuple)
+{
+	if (!tuple->dst_cache)
+		return true;
+
+	return dst_check(tuple->dst_cache, tuple->dst_cookie);
+}
+
 struct flow_offload_tuple_rhash *flow_offload_lookup(struct nf_flowtable *flow_table,
 						     struct flow_offload_tuple *tuple);
 void nf_flow_table_gc_run(struct nf_flowtable *flow_table);
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 2a829b5e8240..fe655e5e3b06 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -571,6 +571,8 @@ static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
+	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple) ||
+	    !nf_flow_dst_check(&flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple) ||
 	    nf_flow_custom_gc(flow_table, flow)) {
 		flow_offload_teardown(flow);
 		teardown = true;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 44f4d74f2982..55f6a0dedb03 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -297,14 +297,6 @@ static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
 	return true;
 }
 
-static inline bool nf_flow_dst_check(struct flow_offload_tuple *tuple)
-{
-	if (!tuple->dst_cache)
-		return true;
-
-	return dst_check(tuple->dst_cache, tuple->dst_cookie);
-}
-
 static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 				      const struct nf_hook_state *state,
 				      struct dst_entry *dst)
-- 
2.47.3


