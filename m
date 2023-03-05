Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BE6AAF8C
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Mar 2023 13:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCEMkp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Mar 2023 07:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMkp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:40:45 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845BEF8B
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Mar 2023 04:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/4VKMk6uwLvIw/LyHAnfdNXE1ONll2qDbERYg/oDv2k=; b=STykAjN36bEUrztEMImZ78s2Ks
        IFl3GnThKbHhHMH4q8DuAREnVYmgh+K1fziMSx/MMHNgoZjPGdvRGYrtOY+gXScTw4VJ/GpCt4XDe
        11QGPTXCrN9RyvB/2HLjWBhMjdzzE6yoPrbgzGfoAENQR0yEBiubO06nD/vFeWBFqtgb7YRt6uzr9
        bxMq8OpAzkOj6QgXaZwL2xcCnoNTYN3ZYjoua1pnQhR8XDece9n2STMdNfcSE5zEH1HdXIlGp/HJ4
        jmCqQg2V01LaJlrulsHEGtpCGKHHKecWZXtBe8Ob3JqeMLcuiOERPkYpt2FXwuNY9vhBVgM3aJsQK
        Cxk818hw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1pYnZ7-00E3og-BP
        for netfilter-devel@vger.kernel.org; Sun, 05 Mar 2023 12:34:13 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 10/13] netfilter: nf_nat_redirect: use `struct nf_nat_range2` in ipv4 API
Date:   Sun,  5 Mar 2023 12:18:14 +0000
Message-Id: <20230305121817.2234734-11-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305121817.2234734-1-jeremy@azazel.net>
References: <20230305121817.2234734-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

`nf_nat_redirect_ipv4` takes a `struct nf_nat_ipv4_multi_range_compat`,
but converts it internally to a `struct nf_nat_range2`.  Change the
function to take the latter, factor out the code now shared with
`nf_nat_redirect_ipv6`, move the conversion to the xt_REDIRECT module,
and update the ipv4 range initialization in the nft_redir module.

Replace a bare hex constant for 127.0.0.1 with a macro.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_nat_redirect.h |  3 +-
 net/netfilter/nf_nat_redirect.c         | 58 ++++++++++++-------------
 net/netfilter/nft_redir.c               | 15 ++++---
 net/netfilter/xt_REDIRECT.c             | 10 ++++-
 4 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/include/net/netfilter/nf_nat_redirect.h b/include/net/netfilter/nf_nat_redirect.h
index 2418653a66db..279380de904c 100644
--- a/include/net/netfilter/nf_nat_redirect.h
+++ b/include/net/netfilter/nf_nat_redirect.h
@@ -6,8 +6,7 @@
 #include <uapi/linux/netfilter/nf_nat.h>
 
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum);
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
diff --git a/net/netfilter/nf_nat_redirect.c b/net/netfilter/nf_nat_redirect.c
index f91579c821e9..54ce8e6113ed 100644
--- a/net/netfilter/nf_nat_redirect.c
+++ b/net/netfilter/nf_nat_redirect.c
@@ -10,6 +10,7 @@
 
 #include <linux/if.h>
 #include <linux/inetdevice.h>
+#include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -24,25 +25,38 @@
 #include <net/netfilter/nf_nat.h>
 #include <net/netfilter/nf_nat_redirect.h>
 
+static unsigned int
+nf_nat_redirect(struct sk_buff *skb, const struct nf_nat_range2 *range,
+		const union nf_inet_addr *newdst)
+{
+	struct nf_nat_range2 newrange;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	ct = nf_ct_get(skb, &ctinfo);
+	WARN_ON(!(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED)));
+
+	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
+	newrange.min_addr	= *newdst;
+	newrange.max_addr	= *newdst;
+	newrange.min_proto	= range->min_proto;
+	newrange.max_proto	= range->max_proto;
+
+	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+}
+
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_conn *ct;
-	enum ip_conntrack_info ctinfo;
 	__be32 newdst;
-	struct nf_nat_range2 newrange;
 
 	WARN_ON(hooknum != NF_INET_PRE_ROUTING &&
 		hooknum != NF_INET_LOCAL_OUT);
 
-	ct = nf_ct_get(skb, &ctinfo);
-	WARN_ON(!(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED)));
-
 	/* Local packets: make them go to loopback */
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = htonl(0x7F000001);
+		newdst = htonl(INADDR_LOOPBACK);
 	} else {
 		const struct in_device *indev;
 
@@ -61,17 +75,8 @@ nf_nat_redirect_ipv4(struct sk_buff *skb,
 			return NF_DROP;
 	}
 
-	/* Transfer from original range. */
-	memset(&newrange.min_addr, 0, sizeof(newrange.min_addr));
-	memset(&newrange.max_addr, 0, sizeof(newrange.max_addr));
-	newrange.flags	     = mr->range[0].flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.ip = newdst;
-	newrange.max_addr.ip = newdst;
-	newrange.min_proto   = mr->range[0].min;
-	newrange.max_proto   = mr->range[0].max;
-
-	/* Hand modified range to generic setup. */
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range,
+			       &(union nf_inet_addr) { .ip = newdst });
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv4);
 
@@ -81,12 +86,8 @@ unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_nat_range2 newrange;
 	struct in6_addr newdst;
-	enum ip_conntrack_info ctinfo;
-	struct nf_conn *ct;
 
-	ct = nf_ct_get(skb, &ctinfo);
 	if (hooknum == NF_INET_LOCAL_OUT) {
 		newdst = loopback_addr;
 	} else {
@@ -109,12 +110,7 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 			return NF_DROP;
 	}
 
-	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.in6	= newdst;
-	newrange.max_addr.in6	= newdst;
-	newrange.min_proto	= range->min_proto;
-	newrange.max_proto	= range->max_proto;
-
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range,
+			       &(union nf_inet_addr) { .in6 = newdst });
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv6);
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index aa8545775ae7..2f300e0eec32 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -104,20 +104,21 @@ static void nft_redir_ipv4_eval(const struct nft_expr *expr,
 				const struct nft_pktinfo *pkt)
 {
 	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_ipv4_multi_range_compat mr;
+	struct nf_nat_range2 range;
 
-	memset(&mr, 0, sizeof(mr));
+	memset(&range, 0, sizeof(range));
 	if (priv->sreg_proto_min) {
-		mr.range[0].min.all = (__force __be16)nft_reg_load16(
+		range.min_proto.all = (__force __be16)nft_reg_load16(
 			&regs->data[priv->sreg_proto_min]);
-		mr.range[0].max.all = (__force __be16)nft_reg_load16(
+		range.max_proto.all = (__force __be16)nft_reg_load16(
 			&regs->data[priv->sreg_proto_max]);
-		mr.range[0].flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
-	mr.range[0].flags |= priv->flags;
+	range.flags |= priv->flags;
 
-	regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &mr, nft_hook(pkt));
+	regs->verdict.code =
+		nf_nat_redirect_ipv4(pkt->skb, &range, nft_hook(pkt));
 }
 
 static void
diff --git a/net/netfilter/xt_REDIRECT.c b/net/netfilter/xt_REDIRECT.c
index 353ca7801251..ff66b56a3f97 100644
--- a/net/netfilter/xt_REDIRECT.c
+++ b/net/netfilter/xt_REDIRECT.c
@@ -46,7 +46,6 @@ static void redirect_tg_destroy(const struct xt_tgdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-/* FIXME: Take multiple ranges --RR */
 static int redirect_tg4_check(const struct xt_tgchk_param *par)
 {
 	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
@@ -65,7 +64,14 @@ static int redirect_tg4_check(const struct xt_tgchk_param *par)
 static unsigned int
 redirect_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	return nf_nat_redirect_ipv4(skb, par->targinfo, xt_hooknum(par));
+	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
+	struct nf_nat_range2 range = {
+		.flags       = mr->range[0].flags,
+		.min_proto   = mr->range[0].min,
+		.max_proto   = mr->range[0].max,
+	};
+
+	return nf_nat_redirect_ipv4(skb, &range, xt_hooknum(par));
 }
 
 static struct xt_target redirect_tg_reg[] __read_mostly = {
-- 
2.39.2

