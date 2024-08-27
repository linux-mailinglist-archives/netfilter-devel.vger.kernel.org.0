Return-Path: <netfilter-devel+bounces-3526-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD189613B5
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2024 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691C32813BF
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2024 16:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D911C8FBB;
	Tue, 27 Aug 2024 16:12:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F264A
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775157; cv=none; b=jyNVbyhVJqykbkn1pGyEMFPlNdqRnnGBMDyuAJXoqvmq7XteuK/gof3ychFyaKXHdvLB94oR/y1tzCOAO41Cs3cmbqaf/oDojqJqQI6duQ9wrXWOAynCXvV3MhNEuNBYU5Cz/kRjUuJdmuUAMbklw3lm8Ztj7EH6NSso4fUDnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775157; c=relaxed/simple;
	bh=l9zo+Siqyxe9QxRtclTXrGVatTjo4P7Ba7yEVR4Ua58=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hQhF7EBYsC+mEBJ1ZoETtrNf3GZTr9ce4YABokDmyEyzHAisl60CaoeKeZazgOaUErmypP4dNCMDzMVipP3kM9zNcHAL0GtHSPKn2zyxo0+ho5PwLM2xO6oMWUZXuONAMhY59TC1yTX5lo0LNYRQBUbp6O1xjsI8qklcOKmFMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables_ipv6: consider network offset in netdev/egress validation
Date: Tue, 27 Aug 2024 18:12:22 +0200
Message-Id: <20240827161222.332203-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From netdev/egress, skb->len can include the ethernet header, therefore,
subtract network offset from skb->len when validating IPv6 packet length.

Fixes: 42df6e1d221d ("netfilter: Introduce egress hook")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables_ipv6.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index 467d59b9e533..a0633eeaec97 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -31,8 +31,8 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	struct ipv6hdr *ip6h, _ip6h;
 	unsigned int thoff = 0;
 	unsigned short frag_off;
+	u32 pkt_len, skb_len;
 	int protohdr;
-	u32 pkt_len;
 
 	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb),
 				  sizeof(*ip6h), &_ip6h);
@@ -43,7 +43,8 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 		return -1;
 
 	pkt_len = ntohs(ip6h->payload_len);
-	if (pkt_len + sizeof(*ip6h) > pkt->skb->len)
+	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
+	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
 
 	protohdr = ipv6_find_hdr(pkt->skb, &thoff, -1, &frag_off, &flags);
-- 
2.30.2


