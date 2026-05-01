Return-Path: <netfilter-devel+bounces-12385-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M8DGFSb9GloCwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12385-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 14:23:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F29894AC575
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B41DF301843C
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2026 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783ED3A1E7F;
	Fri,  1 May 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Tx4dK0pG"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C653A2551;
	Fri,  1 May 2026 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638186; cv=none; b=kPLDJ1e7Dy6zBzAfviUFEgcw3/YCbP79xdEDhMKFERxw4y61ugqFTgdXhImAoXO2cXjhjYrBIWzE/abr/BiFJkp4VP6MvnBm5HiBku6ptyhAaEa38WeTqxBgD8PlVqt0yE3JPV8TfGoRObZ0woZcyFrUAnCmXyPqqpp4xf9Wd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638186; c=relaxed/simple;
	bh=eZX95da61jVvKmEIf5EIzD0chI2RN4sF1ujn1IDP5Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EagkA954YAji6F/kAw04/+eWaYJSTd8o0jIrrTNi++1oA2pEoaMAmuELjk5+il8leYaUGj8+BvxE8p8j2+HjMXHCtDWXFxmxIzPConbf9YcCiCmI3S5vRdnfXP8c7lFP6ugk/zuT01hviqaeCn66Yn4g38HKzNiXwzPzGjCVir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Tx4dK0pG; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E3A0260253;
	Fri,  1 May 2026 14:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777638180;
	bh=/eAFwjpRQs6IKf8l7Uq5+8LYAhM8liveI/Pt/FDQG3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tx4dK0pGaTY9crPEOEeVjtHuppSkGxK14h2TfrTsXpCGLt/a/PHR8HAcHB0eQhHRZ
	 tuKr3uPw3sbG1EHvnpWDbGhc0oEa3TryKFTiFXHZ05psHLGLyc2p/SIe4WY296HNcw
	 L07O896WH5+8jNufShpMamrm+AIWU5E1u7Kf7IlQPaJKQhjIKEplzZVajD1QB7ATk1
	 ekcC2k/KH7MtQjK3yRUJPPgfLniaQpyHgmN7twVcTqxoJseNHaQpYAiUqdZqAKwo0u
	 trurBKMjnphDGPSEc9u4YqXlQ6TvkkHqjE6dBfOYiV/Jc9jnkJPmnQBjjyMq6jOOau
	 hGUgDE7+UOylg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 14/14] netfilter: flowtable: use skb_pull_rcsum() to pop vlan/pppoe header
Date: Fri,  1 May 2026 14:22:37 +0200
Message-ID: <20260501122237.296262-15-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501122237.296262-1-pablo@netfilter.org>
References: <20260501122237.296262-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F29894AC575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12385-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This adjusts the checksum, if required, after pulling the layer 2
header, either the pppoe header or the inner vlan header in the
double-tagged vlan packets.

Fixes: 4cd91f7c290f ("netfilter: flowtable: add vlan support")
Fixes: 72efd585f714 ("netfilter: flowtable: add pppoe support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_ip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 2eba64eb393a..9c05a50d6013 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -445,13 +445,13 @@ static void nf_flow_encap_pop(struct nf_flowtable_ctx *ctx,
 		switch (skb->protocol) {
 		case htons(ETH_P_8021Q):
 			vlan_hdr = (struct vlan_hdr *)skb->data;
-			__skb_pull(skb, VLAN_HLEN);
+			skb_pull_rcsum(skb, VLAN_HLEN);
 			vlan_set_encap_proto(skb, vlan_hdr);
 			skb_reset_network_header(skb);
 			break;
 		case htons(ETH_P_PPP_SES):
 			skb->protocol = __nf_flow_pppoe_proto(skb);
-			skb_pull(skb, PPPOE_SES_HLEN);
+			skb_pull_rcsum(skb, PPPOE_SES_HLEN);
 			skb_reset_network_header(skb);
 			break;
 		}
-- 
2.47.3


