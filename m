Return-Path: <netfilter-devel+bounces-13530-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HajwBG5MQ2q+WgoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13530-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 06:56:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5937C6E05D1
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 06:56:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13530-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13530-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62913033510
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 04:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F43E1732;
	Tue, 30 Jun 2026 04:53:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D53E1723;
	Tue, 30 Jun 2026 04:53:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795230; cv=none; b=YzmgPYmOLWzNT3i+MbQm6ZruyxJKFBuFOdmyVLZe0kFAuS+SINMbYGv3xvh4PeiEZ0EYsGRuJncgZPyAnozZNCUjqCuVC0FVoZ+mngfbQXZ9SPRmYm8y1sHiOd1LwNQJ6iGoRgfRZcCVkzNcf5UKgg/x9x0eyvGy52O3XE8TgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795230; c=relaxed/simple;
	bh=DpuCjn+o3xgg4pdLdqfgFn6WDg+mjA6VvoR1h/uDBfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuLkRkdEDJfmZj8AzaP3mhJU8x6DX+7pqbz02iRMz31HuLSQ1nNzOyvUcFIxlLce1kDgxdMdU7DZJdK5wEF5gIJAbGbWwLpA0G5iY/6dPpcaL9Zolget6sMZbIzOxYkxw/2b8m1xga6XgZSGcApmwB/NgVUrIxWVpUC8GB0Iv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2263260543; Tue, 30 Jun 2026 06:53:47 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 8/9] netfilter: nftables: restrict linklayer and network header writes
Date: Tue, 30 Jun 2026 06:52:42 +0200
Message-ID: <20260630045243.2657-9-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630045243.2657-1-fw@strlen.de>
References: <20260630045243.2657-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13530-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5937C6E05D1

Don't permit arbitrary writes to linklayer and network header data.
Several spots in network stack trust header validation performed in
ipv4/ipv6 before PRE_ROUTING hook.

For linklayer, allow writes for netdev ingress. For other hooks, only
allow link layer writes that do not spill into network header.

For network header, check the offset/length combinations:
 - changing dscp requires store at offset 0 for checsum fixups, so
 make sure ip version + length field isn't altered.
 - ip6 dscp starts directly after the version field, so make sure it
   remains 6.

Several of these checks could already be done at rule insertion time.
Risk is that this might cause ruleset load failures for existing
rulesets. With this change such writes are silently skipped and packet
passes unchanged.

Transport and inner header bases are not checked / restricted.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_payload.c | 170 ++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 345eff140d56..9c974df59b42 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -834,6 +834,172 @@ nft_payload_set_vlan(const u32 *src, struct sk_buff *skb, u16 offset, u8 len,
 	return true;
 }
 
+/* Ingress is very early, before l3 protocol handlers.
+ * There should be no in-tree code that trusts l3/l4 headers
+ * between ingress and NF_INET_PRE_ROUTING hooks.
+ */
+static bool nft_in_ingress(const struct nf_hook_state *s)
+{
+	return s->pf == NFPROTO_NETDEV && s->hook == NF_NETDEV_INGRESS;
+}
+
+static bool nft_nh_write_ok_ip4(const struct nft_pktinfo *pkt,
+				const struct nft_payload_set *priv,
+				const u32 *src)
+{
+	unsigned int offset = priv->offset + skb_network_offset(pkt->skb);
+	const u8 *new_octets = (const u8 *)src;
+	u8 old_octet;
+
+	switch (priv->offset) {
+	case 0: /* csum fixups does expand dscp/tos store to 2 bytes.
+		 * make sure ihl/version remain unchanged.
+		 */
+		if (skb_copy_bits(pkt->skb, offset, &old_octet, sizeof(old_octet)))
+			return false;
+
+		return priv->len == 2 &&
+		       *new_octets == old_octet;
+	case offsetof(struct iphdr, tos):
+		return priv->len == 1;
+	case offsetof(struct iphdr, id):
+		return priv->len == 2;
+	case offsetof(struct iphdr, ttl):
+		if (priv->len == 1)
+			return true;
+
+		if (priv->len != 2)
+			return false;
+
+		/* same, csum fixup does expand ttl store to two bytes.
+		 * check protocol is not altered.
+		 */
+		if (skb_copy_bits(pkt->skb, offset + 1, &old_octet, sizeof(old_octet)))
+			return false;
+
+		return new_octets[1] == old_octet;
+	case offsetof(struct iphdr, check):
+		return priv->len <= 2 + 4 + 4;
+	case offsetof(struct iphdr, saddr):
+		return priv->len <= 4 + 4;
+	case offsetof(struct iphdr, daddr):
+		return priv->len <= 4;
+	}
+
+	return false;
+}
+
+static bool nft_nh_write_ok_ip6(const struct nft_pktinfo *pkt,
+				const struct nft_payload_set *priv,
+				const u32 *src)
+{
+	const struct ipv6hdr *ih = (const void *)src;
+
+	switch (priv->offset) {
+	case 0: /* store to dscp must not alter ip6 version */
+		return priv->len <= 4 && ih->version == 6;
+	case 2:
+		return priv->len <= 2;
+	case offsetof(struct ipv6hdr, hop_limit):
+		return priv->len == 1;
+	case offsetof(struct ipv6hdr, saddr):
+		return priv->len <= 16 + 16;
+	case offsetof(struct ipv6hdr, daddr):
+		return priv->len <= 16;
+	}
+
+	return false;
+}
+
+static bool nft_nh_write_ok_arp(const struct nft_payload_set *priv)
+{
+	/* Variable size for standard ethernet arp */
+	const unsigned int eth_ip = 2 * (ETH_ALEN + 4);
+	unsigned int offset = priv->offset;
+
+	switch (offset) {
+	case offsetof(struct arphdr, ar_op):
+		return priv->len == 2;
+	default:
+		break;
+	}
+
+	/* permit writes post fixed arp header size. offset + len are
+	 * checked vs skb size via skb_ensure_writable.
+	 */
+	return offset >= sizeof(struct arphdr) && priv->len <= eth_ip;
+}
+
+static bool nft_nh_write_ok_netdev(const struct nft_pktinfo *pkt,
+				   const struct nft_payload_set *priv,
+				   const u32 *src)
+{
+#ifdef CONFIG_NF_TABLES_NETDEV
+	switch (pkt->skb->protocol) {
+	case htons(ETH_P_ARP):
+		return nft_nh_write_ok_arp(priv);
+	case htons(ETH_P_IP):
+		return nft_nh_write_ok_ip4(pkt, priv, src);
+	case htons(ETH_P_IPV6):
+		return nft_nh_write_ok_ip6(pkt, priv, src);
+	}
+#endif
+	/* default to false for now, relax later in case we have
+	 * use-cases that need inner header manipulation for
+	 * encapsulated traffic like vlan or PPPoE.
+	 */
+	return false;
+}
+
+static bool nft_nh_write_ok_bridge(const struct nft_pktinfo *pkt,
+				   const struct nft_payload_set *priv,
+				   const u32 *src)
+{
+#if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+	switch (pkt->ethertype) {
+	case htons(ETH_P_ARP):
+		return nft_nh_write_ok_arp(priv);
+	case htons(ETH_P_IP):
+		return nft_nh_write_ok_ip4(pkt, priv, src);
+	case htons(ETH_P_IPV6):
+		return nft_nh_write_ok_ip6(pkt, priv, src);
+	}
+#endif
+	/* see nft_nh_write_ok_netdev: default to false */
+	return false;
+}
+
+static bool nft_nh_write_ok(const struct nft_pktinfo *pkt,
+			    const struct nft_payload_set *priv,
+			    const u32 *src)
+{
+	switch (pkt->state->pf) {
+	case NFPROTO_ARP:
+		return nft_nh_write_ok_arp(priv);
+	case NFPROTO_BRIDGE:
+		return nft_nh_write_ok_bridge(pkt, priv, src);
+	case NFPROTO_IPV4:
+		return nft_nh_write_ok_ip4(pkt, priv, src);
+	case NFPROTO_IPV6:
+		return nft_nh_write_ok_ip6(pkt, priv, src);
+	case NFPROTO_NETDEV:
+		if (pkt->state->hook == NF_NETDEV_INGRESS)
+			return true;
+		return nft_nh_write_ok_netdev(pkt, priv, src);
+	}
+
+	return false;
+}
+
+/* check linklayer modifications don't spill into network header. */
+static bool nft_ll_write_ok(const struct nft_pktinfo *pkt, int offset)
+{
+	if (nft_in_ingress(pkt->state))
+		return true;
+
+	return offset <= skb_network_offset(pkt->skb);
+}
+
 static void nft_payload_set_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -861,8 +1027,12 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 		}
 
 		offset = skb_mac_header(skb) - skb->data - vlan_hlen;
+		if (!nft_ll_write_ok(pkt, priv->len + priv->offset + offset))
+			goto err;
 		break;
 	case NFT_PAYLOAD_NETWORK_HEADER:
+		if (!nft_nh_write_ok(pkt, priv, src))
+			goto err;
 		offset = skb_network_offset(skb);
 		break;
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
-- 
2.53.0


