Return-Path: <netfilter-devel+bounces-11806-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INanEf7d2GnHjAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11806-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 13:24:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5723D61F9
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 13:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1749302B951
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Apr 2026 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2190F39E180;
	Fri, 10 Apr 2026 11:24:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC31448E0;
	Fri, 10 Apr 2026 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820283; cv=none; b=gXDrgk13h7OxBE2/sXmwWPhZlpm+upLiJ8Gder9xxx2J1CKxE5yaiKG0EPUTE7lCQlltBicmrafqdrWnc7/2Zj8ZNkKVAuDPuWD/d7LynXRZ2UNp81bJ+i38T6Lqf31KS54CxDXMe94sibt1shGugmY2N9DaQe6Y0mzwMrUizjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820283; c=relaxed/simple;
	bh=74pLfbiC3+10J2yOI2W9lhehhyjzUrjwVtrtoFchtWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7cez1trrtUmPIHcjyRxbOAicWZfWgytyO5cS43kHDh/RgWCMoC9keMmihl52WRlygbNfT1ZnvJIgGQoTZ82VN70AfQxI8tCYp6YzpNINKWto3EtmxfQgR2mBJgnmqjG6fVHnjoSPPTI6YFltlbVYdGEzcNpX097D/vpW8Mgo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 836FE60C68; Fri, 10 Apr 2026 13:24:39 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 10/11] netfilter: nft_fwd_netdev: check ttl/hl before forwarding
Date: Fri, 10 Apr 2026 13:23:51 +0200
Message-ID: <20260410112352.23599-11-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410112352.23599-1-fw@strlen.de>
References: <20260410112352.23599-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11806-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A5723D61F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Drop packets if their ttl/hl is too small for forwarding.

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_fwd_netdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index ad48dcd45abe..4bce36c3a6a0 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -116,6 +116,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 			goto out;
 		}
 		iph = ip_hdr(skb);
+		if (iph->ttl <= 1) {
+			verdict = NF_DROP;
+			goto out;
+		}
+
 		ip_decrease_ttl(iph);
 		neigh_table = NEIGH_ARP_TABLE;
 		break;
@@ -132,6 +137,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 			goto out;
 		}
 		ip6h = ipv6_hdr(skb);
+		if (ip6h->hop_limit <= 1) {
+			verdict = NF_DROP;
+			goto out;
+		}
+
 		ip6h->hop_limit--;
 		neigh_table = NEIGH_ND_TABLE;
 		break;
-- 
2.52.0


