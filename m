Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EA52A065F
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Oct 2020 14:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3NZF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Oct 2020 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJ3NZE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:25:04 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8775C0613CF
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 06:25:04 -0700 (PDT)
Received: from localhost ([::1]:37598 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kYUOt-0004oE-7i; Fri, 30 Oct 2020 14:25:03 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 1/2] nft: Optimize class-based IP prefix matches
Date:   Fri, 30 Oct 2020 14:24:48 +0100
Message-Id: <20201030132449.5576-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Payload expression works on byte-boundaries, leverage this with suitable
prefix lengths.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Fix prefix printing in arptables, it uses add_addr() as well.
---
 iptables/nft-arp.c    | 11 ++++++++---
 iptables/nft-ipv4.c   |  6 ++++--
 iptables/nft-ipv6.c   |  6 ++++--
 iptables/nft-shared.c | 14 ++++++++++----
 iptables/nft-shared.h |  4 ++++
 5 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/iptables/nft-arp.c b/iptables/nft-arp.c
index 67f4529d93652..952f0c6916e59 100644
--- a/iptables/nft-arp.c
+++ b/iptables/nft-arp.c
@@ -303,7 +303,8 @@ static bool nft_arp_parse_devaddr(struct nft_xt_ctx *ctx,
 		memcpy(info->mask, ctx->bitwise.mask, ETH_ALEN);
 		ctx->flags &= ~NFT_XT_CTX_BITWISE;
 	} else {
-		memset(info->mask, 0xff, ETH_ALEN);
+		memset(info->mask, 0xff,
+		       min(ctx->payload.len, ETH_ALEN));
 	}
 
 	return inv;
@@ -360,7 +361,9 @@ static void nft_arp_parse_payload(struct nft_xt_ctx *ctx,
 				parse_mask_ipv4(ctx, &fw->arp.smsk);
 				ctx->flags &= ~NFT_XT_CTX_BITWISE;
 			} else {
-				fw->arp.smsk.s_addr = 0xffffffff;
+				memset(&fw->arp.smsk, 0xff,
+				       min(ctx->payload.len,
+					   sizeof(struct in_addr)));
 			}
 
 			if (inv)
@@ -380,7 +383,9 @@ static void nft_arp_parse_payload(struct nft_xt_ctx *ctx,
 				parse_mask_ipv4(ctx, &fw->arp.tmsk);
 				ctx->flags &= ~NFT_XT_CTX_BITWISE;
 			} else {
-				fw->arp.tmsk.s_addr = 0xffffffff;
+				memset(&fw->arp.tmsk, 0xff,
+				       min(ctx->payload.len,
+					   sizeof(struct in_addr)));
 			}
 
 			if (inv)
diff --git a/iptables/nft-ipv4.c b/iptables/nft-ipv4.c
index afdecf9711e64..ce702041af0f4 100644
--- a/iptables/nft-ipv4.c
+++ b/iptables/nft-ipv4.c
@@ -199,7 +199,8 @@ static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
 			parse_mask_ipv4(ctx, &cs->fw.ip.smsk);
 			ctx->flags &= ~NFT_XT_CTX_BITWISE;
 		} else {
-			cs->fw.ip.smsk.s_addr = 0xffffffff;
+			memset(&cs->fw.ip.smsk, 0xff,
+			       min(ctx->payload.len, sizeof(struct in_addr)));
 		}
 
 		if (inv)
@@ -212,7 +213,8 @@ static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
 			parse_mask_ipv4(ctx, &cs->fw.ip.dmsk);
 			ctx->flags &= ~NFT_XT_CTX_BITWISE;
 		} else {
-			cs->fw.ip.dmsk.s_addr = 0xffffffff;
+			memset(&cs->fw.ip.dmsk, 0xff,
+			       min(ctx->payload.len, sizeof(struct in_addr)));
 		}
 
 		if (inv)
diff --git a/iptables/nft-ipv6.c b/iptables/nft-ipv6.c
index 4008b7eab4f2a..c877ec6d10887 100644
--- a/iptables/nft-ipv6.c
+++ b/iptables/nft-ipv6.c
@@ -146,7 +146,8 @@ static void nft_ipv6_parse_payload(struct nft_xt_ctx *ctx,
 			parse_mask_ipv6(ctx, &cs->fw6.ipv6.smsk);
 			ctx->flags &= ~NFT_XT_CTX_BITWISE;
 		} else {
-			memset(&cs->fw6.ipv6.smsk, 0xff, sizeof(struct in6_addr));
+			memset(&cs->fw6.ipv6.smsk, 0xff,
+			       min(ctx->payload.len, sizeof(struct in6_addr)));
 		}
 
 		if (inv)
@@ -159,7 +160,8 @@ static void nft_ipv6_parse_payload(struct nft_xt_ctx *ctx,
 			parse_mask_ipv6(ctx, &cs->fw6.ipv6.dmsk);
 			ctx->flags &= ~NFT_XT_CTX_BITWISE;
 		} else {
-			memset(&cs->fw6.ipv6.dmsk, 0xff, sizeof(struct in6_addr));
+			memset(&cs->fw6.ipv6.dmsk, 0xff,
+			       min(ctx->payload.len, sizeof(struct in6_addr)));
 		}
 
 		if (inv)
diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 7741d23befc5a..545e9c60fa015 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -166,16 +166,22 @@ void add_addr(struct nftnl_rule *r, int offset,
 	      void *data, void *mask, size_t len, uint32_t op)
 {
 	const unsigned char *m = mask;
+	bool bitwise = false;
 	int i;
 
-	add_payload(r, offset, len, NFT_PAYLOAD_NETWORK_HEADER);
-
 	for (i = 0; i < len; i++) {
-		if (m[i] != 0xff)
+		if (m[i] != 0xff) {
+			bitwise = m[i] != 0;
 			break;
+		}
 	}
 
-	if (i != len)
+	if (!bitwise)
+		len = i;
+
+	add_payload(r, offset, len, NFT_PAYLOAD_NETWORK_HEADER);
+
+	if (bitwise)
 		add_bitwise(r, mask, len);
 
 	add_cmp_ptr(r, op, data, len);
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index 4440fd17bfeac..a52463342b30a 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -247,4 +247,8 @@ void xtables_restore_parse(struct nft_handle *h,
 			   const struct nft_xt_restore_parse *p);
 
 void nft_check_xt_legacy(int family, bool is_ipt_save);
+
+#define min(x, y) ((x) < (y) ? (x) : (y))
+#define max(x, y) ((x) > (y) ? (x) : (y))
+
 #endif
-- 
2.28.0

