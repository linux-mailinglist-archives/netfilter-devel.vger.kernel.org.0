Return-Path: <netfilter-devel+bounces-12767-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K/MKJ81EGoaVAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12767-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:53:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094235B2869
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7994030DC784
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5143E024E;
	Fri, 22 May 2026 10:43:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54B3D8910;
	Fri, 22 May 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446630; cv=none; b=Q10OJhwRAqqUIDnjRymTRSDpuTRhYXIj8qEO0bGq/exq8yhfuQOiUlz9lXxfgWtNF0/xb66bvHAqgDn4R6PUgKEsX2EXydgs5IYjijlU+mpbYJo/c6gC79ucf40UPmDZbnuOoQQ864VH6rPi6uIEGRHnRrFo8nMMRJn3G4RMqzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446630; c=relaxed/simple;
	bh=4b1L+oyxq+TV5Z+SvySWMP2YDp06kBI7OOkc7DCJY+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx0PWQvGZiLrhkz/qW5xtBPeurMWx8A1/QaLa2WpQhcJfljWybHd3LKxc586kXDFcK57GabVRsu71WM+pRDs6MfT+lSKYXxFBdYvcY8NuMM/CUozOchinbNvQfE8qIZqoIJsLcHIXPr1Hd3JXu+0pqyKC36/p9BoC3erQye5+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7EF7E607BD; Fri, 22 May 2026 12:43:46 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 10/10] netfilter: nf_tables: fix dst corruption in same register operation
Date: Fri, 22 May 2026 12:42:57 +0200
Message-ID: <20260522104257.2008-11-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522104257.2008-1-fw@strlen.de>
References: <20260522104257.2008-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12767-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:email,suse.de:email,azazel.net:email]
X-Rspamd-Queue-Id: 094235B2869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fernando Fernandez Mancera <fmancera@suse.de>

For lshift and rshift, the shift operations are performed in a loop over
32-bit words. The loop calculates the shifted value and write it to dst,
and then immediately reads from src to calculate the carry for the next
iteration. Because src and dst could point to the same memory location,
the carry is incorrectly calculated using the newly modified dst value
instead of the original src value.

Adding a temporary local variable to cache the original value before
writing to dst and using it for the carry calculation solves the
problem. In addition, partial overlap is rejected from control plane for
all kind of operations including byteorder. This was tested with the
following bytecode:

table test_table ip flags 0 use 1 handle 1
ip test_table test_chain use 3 type filter hook input prio 0 policy accept packets 0 bytes 0 flags 1
ip test_table test_chain 2
  [ immediate reg 1 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
  [ cmp eq reg 1 0x66443322 0x00887766 ]
  [ counter pkts 0 bytes 0 ]
ip test_table test_chain 4 3
  [ immediate reg 1 0x44332211 0x88776655 ]
  [ bitwise reg 1 = ( reg 1 << 0x08000000 ) ]
  [ cmp eq reg 1 0x55443322 0x00887766 ]
  [ counter pkts 21794 bytes 1917798 ]

Fixes: 567d746b55bc ("netfilter: bitwise: add support for shifts.")
Acked-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h |  7 +++++++
 net/netfilter/nft_bitwise.c       | 18 ++++++++++++++----
 net/netfilter/nft_byteorder.c     | 13 ++++++++++---
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index cff7b773e972..9d844354c4d9 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -180,6 +180,13 @@ static inline u64 nft_reg_load64(const u32 *sreg)
 	return get_unaligned((u64 *)sreg);
 }
 
+static inline bool nft_reg_overlap(u8 src, u8 dst, u32 len)
+{
+	unsigned int n = DIV_ROUND_UP(len, sizeof(u32));
+
+	return src != dst && src < dst + n && dst < src + n;
+}
+
 static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
 				 unsigned int len)
 {
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 94dccdcfa06b..785b8e9731d1 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -43,8 +43,10 @@ static void nft_bitwise_eval_lshift(u32 *dst, const u32 *src,
 	u32 carry = 0;
 
 	for (i = DIV_ROUND_UP(priv->len, sizeof(u32)); i > 0; i--) {
-		dst[i - 1] = (src[i - 1] << shift) | carry;
-		carry = src[i - 1] >> (BITS_PER_TYPE(u32) - shift);
+		u32 tmp_src = src[i - 1];
+
+		dst[i - 1] = (tmp_src << shift) | carry;
+		carry = tmp_src >> (BITS_PER_TYPE(u32) - shift);
 	}
 }
 
@@ -56,8 +58,10 @@ static void nft_bitwise_eval_rshift(u32 *dst, const u32 *src,
 	u32 carry = 0;
 
 	for (i = 0; i < DIV_ROUND_UP(priv->len, sizeof(u32)); i++) {
-		dst[i] = carry | (src[i] >> shift);
-		carry = src[i] << (BITS_PER_TYPE(u32) - shift);
+		u32 tmp_src = src[i];
+
+		dst[i] = carry | (tmp_src >> shift);
+		carry = tmp_src << (BITS_PER_TYPE(u32) - shift);
 	}
 }
 
@@ -235,6 +239,9 @@ static int nft_bitwise_init_bool(const struct nft_ctx *ctx,
 					      &priv->sreg2, priv->len);
 		if (err < 0)
 			return err;
+
+		if (nft_reg_overlap(priv->sreg2, priv->dreg, priv->len))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -265,6 +272,9 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+		return -EINVAL;
+
 	if (tb[NFTA_BITWISE_OP]) {
 		priv->op = ntohl(nla_get_be32(tb[NFTA_BITWISE_OP]));
 		switch (priv->op) {
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index e00dddfa2fc0..2316c77f4228 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -144,9 +144,16 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	return nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
-					&priv->dreg, NULL, NFT_DATA_VALUE,
-					priv->len);
+	err = nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
+				       &priv->dreg, NULL, NFT_DATA_VALUE,
+				       priv->len);
+	if (err < 0)
+		return err;
+
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int nft_byteorder_dump(struct sk_buff *skb,
-- 
2.53.0


