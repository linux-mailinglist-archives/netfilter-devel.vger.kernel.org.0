Return-Path: <netfilter-devel+bounces-13096-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GG+LEUg/JWrAEwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13096-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:52:08 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3864F45F
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:52:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=phwPKHTc;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13096-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13096-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E3CD3041798
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2026 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129883876C3;
	Sun,  7 Jun 2026 09:50:13 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8037C10C;
	Sun,  7 Jun 2026 09:50:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825813; cv=none; b=N16a+huYl59yDwdXa4dDVIBiIF+brgwGa6LNQW03sMECyJ8Ce6ZnOE5YZ1T6YPfOYaYTqQRAJLS2vyfEckzYu0KJEJK4yfoA3XSzIRC0W5eA7Ypo2gAybpkNBZrafJ1Kl6BYP4qSABb7PA1NTl2QgRUhMsCR8rDY3/IeLavxwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825813; c=relaxed/simple;
	bh=qx8GuH5/5b97VXnNA/yVIitSLGoBEGcFkpxnZaASxJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6pSMJcNxqK7obALwPmqRMiJspSUejqXMrCtC+9IS+3svtSVGCrRyzvX+AZGPztkedUI5m3JDRqZ/wr4aRqYWpte4+YZvc/0N/i+Ll+WlXPY0P/MUQA7l5+P1ytDeiy02bCm99R98UrzYom0tvt8gaPau0dI0asigcpjsuMe1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=phwPKHTc; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id CE638601A1;
	Sun,  7 Jun 2026 11:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780825810;
	bh=5Arp9+w6bx65QFziv+folATQVHfzGxPyp+qXz+eAlnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phwPKHTcSb+FnfH1yTnSzeRX6WK6qIf8E7WZltevx1d6fWmFBItdFGLHd7f1etfBw
	 bMZrYC8Hz0sK6lI1Nt5KZIwxmvW11nUPM9kdyIYilaYpg8WTNC4hP6iY1MEgKf2mra
	 lzPrWjoevE/J9wTyvMyRDZYBGRBqTl/M9DH6S2+XGbMGfNwUhO3HFWkfYUfsMeMklT
	 q+qOuEwjRmp+r7EItWfRlEnf2Nl5I/B9vVS62qjkCkbbpRs+g2C9KV7DDG6f77Be62
	 +do0LKV04lRBL6xZHvLjszD6oFKlJuD/KjtG+xmRrVxiZ9i1LEfJoKAMnIFelf6t0F
	 o/3kVCY1Bp3/w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 06/15] netfilter: synproxy: fix unaligned memory access in timestamp adjustment
Date: Sun,  7 Jun 2026 11:49:45 +0200
Message-ID: <20260607094954.48892-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607094954.48892-1-pablo@netfilter.org>
References: <20260607094954.48892-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13096-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:mid,netfilter.org:dkim,netfilter.org:from_mime,netfilter.org:email,suse.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90D3864F45F

From: Fernando Fernandez Mancera <fmancera@suse.de>

Use get_unaligned_be32() and put_unaligned_be32() to safely read and
write the timestamp fields. This prevents performance degradation due to
unaligned memory access or even a crash on strict alignment
architectures.

This follows the implementation of timestamp parsing in the networking
stack at tcp_parse_options() and synproxy_parse_options().

Fixes: 48b1de4c110a ("netfilter: add SYNPROXY core/target")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_synproxy_core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index a0bcf188810d..acd360515972 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -191,7 +191,7 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 		       const struct nf_conn_synproxy *synproxy)
 {
 	unsigned int optoff, optend;
-	__be32 *ptr, old;
+	u32 new, old;
 
 	if (synproxy->tsoff == 0)
 		return true;
@@ -221,18 +221,17 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 			if (op[0] == TCPOPT_TIMESTAMP &&
 			    op[1] == TCPOLEN_TIMESTAMP) {
 				if (CTINFO2DIR(ctinfo) == IP_CT_DIR_REPLY) {
-					ptr = (__be32 *)&op[2];
-					old = *ptr;
-					*ptr = htonl(ntohl(*ptr) -
-						     synproxy->tsoff);
+					old = get_unaligned_be32(&op[2]);
+					new = old - synproxy->tsoff;
+					put_unaligned_be32(new, &op[2]);
 				} else {
-					ptr = (__be32 *)&op[6];
-					old = *ptr;
-					*ptr = htonl(ntohl(*ptr) +
-						     synproxy->tsoff);
+					old = get_unaligned_be32(&op[6]);
+					new = old + synproxy->tsoff;
+					put_unaligned_be32(new, &op[6]);
 				}
 				inet_proto_csum_replace4(&th->check, skb,
-							 old, *ptr, false);
+							 cpu_to_be32(old),
+							 cpu_to_be32(new), false);
 			}
 			optoff += op[1];
 		}
-- 
2.47.3


