Return-Path: <netfilter-devel+bounces-13126-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 96+8F8DmJmormwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13126-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 17:58:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E96586ED
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 17:58:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13126-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13126-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C9A230FB2A6
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465D3FA5C7;
	Mon,  8 Jun 2026 15:23:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519F3F9A09
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2026 15:23:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932229; cv=none; b=ni29qJ05mW42tmqihr8CX9KhfoTa3dHus7+asbYLezWy71i3rsiB6LYAcfoCRHzWddC3erKkEoOohBZg97v84c8R0bf8ZBXtb6F1J6QZefSRaKR6A4MhH5VzEuoJ87v+dcamZe0I3QoaMLdCRTBIOFXAVZv0lySSCeIJp4QJe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932229; c=relaxed/simple;
	bh=t/x8KOreOiBA9X1BaDpQ4QqLSbLKoDnwEcRp/eTMTtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cczcUujHMRFdIZX2kqsIFq8+h3FaGZ3Mg3BM8A9iQlZNeWh0nJvyWs90qAbwZpwrfK9ZXCjlLCVaR9XFgSj88BbyyX5Gue035tkw/fd1VdDh91OhopMPBj/a040VFcCr1Gc+wO2Mpf03cn/5rTprxTXypANMlKC48NIEE2QF9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 01BF2602F8; Mon, 08 Jun 2026 17:23:46 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 3/3] netfilter: nftables: restrict checkum update offset
Date: Mon,  8 Jun 2026 17:23:19 +0200
Message-ID: <20260608152324.20700-5-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152324.20700-1-fw@strlen.de>
References: <20260608152324.20700-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13126-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA2E96586ED

After previous patch, writes to network header are restricted.
However, there is another way to manipulate the l3 header: The
checksum update function.

Restrict this for network header writes, only the ipv4 header is
allowed.  This needs run-time checks because BRIDGE, INET, NETDEV
families can carry l3 headers other than IP.

checksum updates to the udp/tcp (l4) headers are not restricted.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_payload.c | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 8e4388bee459..a8ba9dacde62 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -990,6 +990,83 @@ static bool nft_ll_write_ok(const struct nft_pktinfo *pkt, int offset)
 	return offset <= skb_network_offset(pkt->skb);
 }
 
+static bool nft_payload_validate_inet_csum_offset(const struct nft_ctx *ctx,
+						  const struct nft_payload_set *priv)
+{
+	switch (priv->base) {
+	case NFT_PAYLOAD_LL_HEADER:
+		break;
+	case NFT_PAYLOAD_NETWORK_HEADER:
+		if (ctx->family == NFPROTO_IPV4) {
+			if (offsetof(struct iphdr, check) == priv->csum_offset)
+				return true;
+
+			return false;
+		}
+		return true; /* run time validation required */
+	case NFT_PAYLOAD_TRANSPORT_HEADER:
+		if (priv->csum_flags) /* makes no sense, asks for "re-update" of L4 checksum */
+			return false;
+
+		/* no further check here; offset can't be negative so bogus
+		 * offsets can corrupt L4 or payload but not l3 headers.
+		 * We already allow arbitrary l4/inner payload writes.
+		 */
+		return true;
+	case NFT_PAYLOAD_INNER_HEADER:
+		return true;
+	case NFT_PAYLOAD_TUN_HEADER:
+		break;
+	}
+
+	return false;
+}
+
+/* do not allow arbitrary network header mangling via bogus csum_off.
+ * We only support ipv4.  Only NFPROTO_IPV4 can be checked from control
+ * plane.
+ */
+static bool nft_payload_csum_nh_write_ok(const struct nft_payload_set *priv,
+					 const struct nft_pktinfo *pkt)
+{
+	switch (pkt->state->pf) {
+	case NFPROTO_IPV4:
+		/* Warning: NFPROTO_INET was not checked; we can't return true here. */
+		return priv->csum_offset == offsetof(struct iphdr, check);
+	case NFPROTO_IPV6:
+		return false;
+	case NFPROTO_BRIDGE:
+		return pkt->ethertype == htons(ETH_P_IP) &&
+		       priv->csum_offset == offsetof(struct iphdr, check);
+	case NFPROTO_NETDEV:
+		return pkt->skb->protocol == htons(ETH_P_IP) &&
+		       priv->csum_offset == offsetof(struct iphdr, check);
+	}
+
+	return false;
+}
+
+static bool nft_payload_csum_write_ok(const struct nft_pktinfo *pkt,
+				      const struct nft_payload_set *priv)
+{
+	switch (priv->base) {
+	case NFT_PAYLOAD_LL_HEADER:
+		break;
+	case NFT_PAYLOAD_NETWORK_HEADER:
+		return nft_payload_csum_nh_write_ok(priv, pkt);
+	case NFT_PAYLOAD_TRANSPORT_HEADER:
+	case NFT_PAYLOAD_INNER_HEADER:
+		/* neither offsets are validated, offsets cannot be
+		 * negative so real l3 headers cannot be mangled.
+		 */
+		return true;
+	case NFT_PAYLOAD_TUN_HEADER:
+		break;
+	}
+
+	return false;
+}
+
 static void nft_payload_set_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -1054,6 +1131,7 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 		tsum = csum_partial(src, priv->len, 0);
 
 		if (priv->csum_type == NFT_PAYLOAD_CSUM_INET &&
+		    nft_payload_csum_write_ok(pkt, priv) &&
 		    nft_payload_csum_inet(skb, src, fsum, tsum, csum_offset))
 			goto err;
 
@@ -1120,7 +1198,26 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 
 	switch (csum_type) {
 	case NFT_PAYLOAD_CSUM_NONE:
+		if (priv->csum_offset) /* nonsensical */
+			return -EINVAL;
+
+		if (priv->csum_flags == 0)
+			break;
+
+		/* Userspace requests L4 checksum update, e.g.:
+		 * - IPv6 stateless NAT (no l3 csum)
+		 * - transport header mangling
+		 * - inner data mangling
+		 */
+		if (priv->base == NFT_PAYLOAD_NETWORK_HEADER ||
+		    priv->base == NFT_PAYLOAD_TRANSPORT_HEADER ||
+		    priv->base == NFT_PAYLOAD_INNER_HEADER)
+			break;
+
+		return -EINVAL;
 	case NFT_PAYLOAD_CSUM_INET:
+		if (!nft_payload_validate_inet_csum_offset(ctx, priv))
+			return -EINVAL;
 		break;
 	case NFT_PAYLOAD_CSUM_SCTP:
 		if (priv->base != NFT_PAYLOAD_TRANSPORT_HEADER)
@@ -1128,6 +1225,9 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 
 		if (priv->csum_offset != offsetof(struct sctphdr, checksum))
 			return -EINVAL;
+
+		if (priv->csum_flags)
+			return -EINVAL;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.53.0


