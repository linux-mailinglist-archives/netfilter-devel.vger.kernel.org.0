Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD8B73D7F2
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jun 2023 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFZGsE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jun 2023 02:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFZGsB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:48:01 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE495E53;
        Sun, 25 Jun 2023 23:47:59 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net-next 8/8] netfilter: nf_tables: limit allowed range via nla_policy
Date:   Mon, 26 Jun 2023 08:47:49 +0200
Message-Id: <20230626064749.75525-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230626064749.75525-1-pablo@netfilter.org>
References: <20230626064749.75525-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

These NLA_U32 types get stored in u8 fields, reject invalid values
instead of silently casting to u8.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_bitwise.c    | 2 +-
 net/netfilter/nft_byteorder.c  | 6 +++---
 net/netfilter/nft_ct.c         | 2 +-
 net/netfilter/nft_dynset.c     | 2 +-
 net/netfilter/nft_exthdr.c     | 4 ++--
 net/netfilter/nft_fwd_netdev.c | 2 +-
 net/netfilter/nft_hash.c       | 2 +-
 net/netfilter/nft_meta.c       | 2 +-
 net/netfilter/nft_range.c      | 2 +-
 net/netfilter/nft_reject.c     | 2 +-
 net/netfilter/nft_rt.c         | 2 +-
 net/netfilter/nft_socket.c     | 4 ++--
 net/netfilter/nft_tproxy.c     | 2 +-
 net/netfilter/nft_tunnel.c     | 4 ++--
 net/netfilter/nft_xfrm.c       | 4 ++--
 15 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 84eae7cabc67..14e3c44ef959 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -86,7 +86,7 @@ static const struct nla_policy nft_bitwise_policy[NFTA_BITWISE_MAX + 1] = {
 	[NFTA_BITWISE_LEN]	= { .type = NLA_U32 },
 	[NFTA_BITWISE_MASK]	= { .type = NLA_NESTED },
 	[NFTA_BITWISE_XOR]	= { .type = NLA_NESTED },
-	[NFTA_BITWISE_OP]	= { .type = NLA_U32 },
+	[NFTA_BITWISE_OP]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_BITWISE_DATA]	= { .type = NLA_NESTED },
 };
 
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index b66647a5a171..9a85e797ed58 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -88,9 +88,9 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 static const struct nla_policy nft_byteorder_policy[NFTA_BYTEORDER_MAX + 1] = {
 	[NFTA_BYTEORDER_SREG]	= { .type = NLA_U32 },
 	[NFTA_BYTEORDER_DREG]	= { .type = NLA_U32 },
-	[NFTA_BYTEORDER_OP]	= { .type = NLA_U32 },
-	[NFTA_BYTEORDER_LEN]	= { .type = NLA_U32 },
-	[NFTA_BYTEORDER_SIZE]	= { .type = NLA_U32 },
+	[NFTA_BYTEORDER_OP]	= NLA_POLICY_MAX(NLA_BE32, 255),
+	[NFTA_BYTEORDER_LEN]	= NLA_POLICY_MAX(NLA_BE32, 255),
+	[NFTA_BYTEORDER_SIZE]	= NLA_POLICY_MAX(NLA_BE32, 255),
 };
 
 static int nft_byteorder_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index b9c84499438b..38958e067aa8 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -332,7 +332,7 @@ static void nft_ct_set_eval(const struct nft_expr *expr,
 
 static const struct nla_policy nft_ct_policy[NFTA_CT_MAX + 1] = {
 	[NFTA_CT_DREG]		= { .type = NLA_U32 },
-	[NFTA_CT_KEY]		= { .type = NLA_U32 },
+	[NFTA_CT_KEY]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_CT_DIRECTION]	= { .type = NLA_U8 },
 	[NFTA_CT_SREG]		= { .type = NLA_U32 },
 };
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index bd19c7aec92e..4fb34d76dbea 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -148,7 +148,7 @@ static const struct nla_policy nft_dynset_policy[NFTA_DYNSET_MAX + 1] = {
 	[NFTA_DYNSET_SET_NAME]	= { .type = NLA_STRING,
 				    .len = NFT_SET_MAXNAMELEN - 1 },
 	[NFTA_DYNSET_SET_ID]	= { .type = NLA_U32 },
-	[NFTA_DYNSET_OP]	= { .type = NLA_U32 },
+	[NFTA_DYNSET_OP]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_DYNSET_SREG_KEY]	= { .type = NLA_U32 },
 	[NFTA_DYNSET_SREG_DATA]	= { .type = NLA_U32 },
 	[NFTA_DYNSET_TIMEOUT]	= { .type = NLA_U64 },
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 671474e59817..7f856ceb3a66 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -487,9 +487,9 @@ static const struct nla_policy nft_exthdr_policy[NFTA_EXTHDR_MAX + 1] = {
 	[NFTA_EXTHDR_DREG]		= { .type = NLA_U32 },
 	[NFTA_EXTHDR_TYPE]		= { .type = NLA_U8 },
 	[NFTA_EXTHDR_OFFSET]		= { .type = NLA_U32 },
-	[NFTA_EXTHDR_LEN]		= { .type = NLA_U32 },
+	[NFTA_EXTHDR_LEN]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_EXTHDR_FLAGS]		= { .type = NLA_U32 },
-	[NFTA_EXTHDR_OP]		= { .type = NLA_U32 },
+	[NFTA_EXTHDR_OP]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_EXTHDR_SREG]		= { .type = NLA_U32 },
 };
 
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 7b9d4d1bd17c..a5268e6dd32f 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -40,7 +40,7 @@ static void nft_fwd_netdev_eval(const struct nft_expr *expr,
 static const struct nla_policy nft_fwd_netdev_policy[NFTA_FWD_MAX + 1] = {
 	[NFTA_FWD_SREG_DEV]	= { .type = NLA_U32 },
 	[NFTA_FWD_SREG_ADDR]	= { .type = NLA_U32 },
-	[NFTA_FWD_NFPROTO]	= { .type = NLA_U32 },
+	[NFTA_FWD_NFPROTO]	= NLA_POLICY_MAX(NLA_BE32, 255),
 };
 
 static int nft_fwd_netdev_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index ee8d487b69c0..92d47e469204 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -59,7 +59,7 @@ static void nft_symhash_eval(const struct nft_expr *expr,
 static const struct nla_policy nft_hash_policy[NFTA_HASH_MAX + 1] = {
 	[NFTA_HASH_SREG]	= { .type = NLA_U32 },
 	[NFTA_HASH_DREG]	= { .type = NLA_U32 },
-	[NFTA_HASH_LEN]		= { .type = NLA_U32 },
+	[NFTA_HASH_LEN]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_HASH_MODULUS]	= { .type = NLA_U32 },
 	[NFTA_HASH_SEED]	= { .type = NLA_U32 },
 	[NFTA_HASH_OFFSET]	= { .type = NLA_U32 },
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index e384e0de7a54..8fdc7318c03c 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -458,7 +458,7 @@ EXPORT_SYMBOL_GPL(nft_meta_set_eval);
 
 const struct nla_policy nft_meta_policy[NFTA_META_MAX + 1] = {
 	[NFTA_META_DREG]	= { .type = NLA_U32 },
-	[NFTA_META_KEY]		= { .type = NLA_U32 },
+	[NFTA_META_KEY]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_META_SREG]	= { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(nft_meta_policy);
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index 0566d6aaf1e5..51ae64cd268f 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -42,7 +42,7 @@ void nft_range_eval(const struct nft_expr *expr,
 
 static const struct nla_policy nft_range_policy[NFTA_RANGE_MAX + 1] = {
 	[NFTA_RANGE_SREG]		= { .type = NLA_U32 },
-	[NFTA_RANGE_OP]			= { .type = NLA_U32 },
+	[NFTA_RANGE_OP]			= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_RANGE_FROM_DATA]		= { .type = NLA_NESTED },
 	[NFTA_RANGE_TO_DATA]		= { .type = NLA_NESTED },
 };
diff --git a/net/netfilter/nft_reject.c b/net/netfilter/nft_reject.c
index f2addc844dd2..ed2e668474d6 100644
--- a/net/netfilter/nft_reject.c
+++ b/net/netfilter/nft_reject.c
@@ -18,7 +18,7 @@
 #include <linux/icmpv6.h>
 
 const struct nla_policy nft_reject_policy[NFTA_REJECT_MAX + 1] = {
-	[NFTA_REJECT_TYPE]		= { .type = NLA_U32 },
+	[NFTA_REJECT_TYPE]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_REJECT_ICMP_CODE]		= { .type = NLA_U8 },
 };
 EXPORT_SYMBOL_GPL(nft_reject_policy);
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 5990fdd7b3cc..35a2c28caa60 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -104,7 +104,7 @@ void nft_rt_get_eval(const struct nft_expr *expr,
 
 static const struct nla_policy nft_rt_policy[NFTA_RT_MAX + 1] = {
 	[NFTA_RT_DREG]		= { .type = NLA_U32 },
-	[NFTA_RT_KEY]		= { .type = NLA_U32 },
+	[NFTA_RT_KEY]		= NLA_POLICY_MAX(NLA_BE32, 255),
 };
 
 static int nft_rt_get_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 85f8df87efda..84def74698b7 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -138,9 +138,9 @@ static void nft_socket_eval(const struct nft_expr *expr,
 }
 
 static const struct nla_policy nft_socket_policy[NFTA_SOCKET_MAX + 1] = {
-	[NFTA_SOCKET_KEY]		= { .type = NLA_U32 },
+	[NFTA_SOCKET_KEY]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_SOCKET_DREG]		= { .type = NLA_U32 },
-	[NFTA_SOCKET_LEVEL]		= { .type = NLA_U32 },
+	[NFTA_SOCKET_LEVEL]		= NLA_POLICY_MAX(NLA_BE32, 255),
 };
 
 static int nft_socket_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index ea83f661417e..ae15cd693f0e 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -183,7 +183,7 @@ static void nft_tproxy_eval(const struct nft_expr *expr,
 }
 
 static const struct nla_policy nft_tproxy_policy[NFTA_TPROXY_MAX + 1] = {
-	[NFTA_TPROXY_FAMILY]   = { .type = NLA_U32 },
+	[NFTA_TPROXY_FAMILY]   = NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_TPROXY_REG_ADDR] = { .type = NLA_U32 },
 	[NFTA_TPROXY_REG_PORT] = { .type = NLA_U32 },
 };
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index b059aa541798..9f21953c7433 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -66,9 +66,9 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 }
 
 static const struct nla_policy nft_tunnel_policy[NFTA_TUNNEL_MAX + 1] = {
-	[NFTA_TUNNEL_KEY]	= { .type = NLA_U32 },
+	[NFTA_TUNNEL_KEY]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_TUNNEL_DREG]	= { .type = NLA_U32 },
-	[NFTA_TUNNEL_MODE]	= { .type = NLA_U32 },
+	[NFTA_TUNNEL_MODE]	= NLA_POLICY_MAX(NLA_BE32, 255),
 };
 
 static int nft_tunnel_get_init(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index c88fd078a9ae..452f8587adda 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -16,9 +16,9 @@
 #include <net/xfrm.h>
 
 static const struct nla_policy nft_xfrm_policy[NFTA_XFRM_MAX + 1] = {
-	[NFTA_XFRM_KEY]		= { .type = NLA_U32 },
+	[NFTA_XFRM_KEY]		= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_XFRM_DIR]		= { .type = NLA_U8 },
-	[NFTA_XFRM_SPNUM]	= { .type = NLA_U32 },
+	[NFTA_XFRM_SPNUM]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_XFRM_DREG]	= { .type = NLA_U32 },
 };
 
-- 
2.30.2

