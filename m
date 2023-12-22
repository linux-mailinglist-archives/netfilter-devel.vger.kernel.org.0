Return-Path: <netfilter-devel+bounces-471-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76281C864
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Dec 2023 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE14F1C25054
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Dec 2023 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715C5171D9;
	Fri, 22 Dec 2023 10:42:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D34156D0;
	Fri, 22 Dec 2023 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 1/2] netfilter: nf_tables: set transport offset from mac header for netdev/egress
Date: Fri, 22 Dec 2023 11:42:04 +0100
Message-Id: <20231222104205.354606-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222104205.354606-1-pablo@netfilter.org>
References: <20231222104205.354606-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this patch, transport offset (pkt->thoff) provides an offset
relative to the network header. This is fine for the inet families
because skb->data points to the network header in such case. However,
from netdev/egress, skb->data points to the mac header (if available),
thus, pkt->thoff is missing the mac header length.

Add skb_network_offset() to the transport offset (pkt->thoff) for
netdev, so transport header mangling works as expected. Adjust payload
fast eval function to use skb->data now that pkt->thoff provides an
absolute offset. This explains why users report that matching on
egress/netdev works but payload mangling does not.

This patch implicitly fixes payload mangling for IPv4 packets in
netdev/egress given skb_store_bits() requires an offset from skb->data
to reach the transport header.

I suspect that nft_exthdr and the trace infra were also broken from
netdev/egress because they also take skb->data as start, and pkt->thoff
was not correct.

Note that IPv6 is fine because ipv6_find_hdr() already provides a
transport offset starting from skb->data, which includes
skb_network_offset().

The bridge family also uses nft_set_pktinfo_ipv4_validate(), but there
skb_network_offset() is zero, so the update in this patch does not alter
the existing behaviour.

Fixes: 42df6e1d221d ("netfilter: Introduce egress hook")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables_ipv4.h | 2 +-
 net/netfilter/nf_tables_core.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
index 947973623dc7..60a7d0ce3080 100644
--- a/include/net/netfilter/nf_tables_ipv4.h
+++ b/include/net/netfilter/nf_tables_ipv4.h
@@ -30,7 +30,7 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 		return -1;
 
 	len = iph_totlen(pkt->skb, iph);
-	thoff = iph->ihl * 4;
+	thoff = skb_network_offset(pkt->skb) + (iph->ihl * 4);
 	if (pkt->skb->len < len)
 		return -1;
 	else if (len < thoff)
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 8b536d7ef6c2..c3e635364701 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -158,7 +158,7 @@ static bool nft_payload_fast_eval(const struct nft_expr *expr,
 	else {
 		if (!(pkt->flags & NFT_PKTINFO_L4PROTO))
 			return false;
-		ptr = skb_network_header(skb) + nft_thoff(pkt);
+		ptr = skb->data + nft_thoff(pkt);
 	}
 
 	ptr += priv->offset;
-- 
2.30.2


