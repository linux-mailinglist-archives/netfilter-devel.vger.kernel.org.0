Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73711AB79
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Dec 2019 14:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfLKNCU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Dec 2019 08:02:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35924 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLKNCT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:02:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so23976819wru.3
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Dec 2019 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darbyshire-bryant.me.uk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5HXidfZ46ZdQhDZaHRRTXR/jvycy5mY3rZZPRcN3c8=;
        b=gosaB1UdfVk8aneQSyT4S5tZRvcIH39AnZsdhXGoUAsx6NVOy2JKotQYOffJRi8Ro/
         kszZj3kOYbJhh533aoyS9fz38h+ASD+YKiqLFIWD9oa7YR3N5mwK68rLnWm5WSASrmTU
         2QxZXfSUlDvjlu3wSzOvYc7t/wgTUqbS4crpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5HXidfZ46ZdQhDZaHRRTXR/jvycy5mY3rZZPRcN3c8=;
        b=lCpeFhUtfIRd7vY1Fp2RNuHLm/0EFswE9nqYpCFd48c31p422c2cjTuxC94MaW0pu0
         q3ocWocRN7uYgB/JHrRLRGJTTd4CuaORVumibY99RGj0t6wboN/oyoVOkBSu8gOXmOjp
         vX4VjEkKM8o8Y7RbtQyTssnoOC/sv4ww2/Q8Gaype+rZ3eyJMveofwz2Ixi8aK6FJtWg
         zFaAsYPGZistfs2BWptshR5pWrZ1U+FSs8ssNU+64tyE0Hs2gu5z+r22bVVTpI4TqkN3
         FN7lUG8MOqqiAP93v6mZHNvI7Qs1S2EHU0eQUBzgSxSDLSsrxpwkA1QFT6Fr0cfQx2S/
         lutQ==
X-Gm-Message-State: APjAAAURxbjqQjWL5OCye9dPSJDUsz2DaKoKarpgMM8XB1tkWL+ouLDm
        LiTXB/BxWcogpvkdfcgZl/Wg/Bg/xgmrgA==
X-Google-Smtp-Source: APXvYqyfRPclzCuGx5CbvvZxQXRDgb8hQ0WxRZpCzWLSqHN2+CrpK1v7jXnsQfavy5w+GqjWy68kTA==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4010043wrn.219.1576069336479;
        Wed, 11 Dec 2019 05:02:16 -0800 (PST)
Received: from Kevins-MBP.lan.darbyshire-bryant.me.uk ([2a02:c7f:1243:8e00::dc83])
        by smtp.gmail.com with ESMTPSA id r5sm2143452wrt.43.2019.12.11.05.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 05:02:15 -0800 (PST)
From:   Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
To:     ldir@darbyshire-bryant.me.uk
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v2] netfilter: connmark: introduce set-dscpmark
Date:   Wed, 11 Dec 2019 13:01:43 +0000
Message-Id: <20191211130142.34197-1-ldir@darbyshire-bryant.me.uk>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191203160652.44396-1-ldir@darbyshire-bryant.me.uk>
References: <20191203160652.44396-1-ldir@darbyshire-bryant.me.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

set-dscpmark is a method of storing the DSCP of an ip packet into
conntrack mark.  In combination with a suitable tc filter action
(act_ctinfo) DSCP values are able to be stored in the mark on egress and
restored on ingress across links that otherwise alter or bleach DSCP.

This is useful for qdiscs such as CAKE which are able to shape according
to policies based on DSCP.

Ingress classification is traditionally a challenging task since
iptables rules haven't yet run and tc filter/eBPF programs are pre-NAT
lookups, hence are unable to see internal IPv4 addresses as used on the
typical home masquerading gateway.

x_tables CONNMARK set-dscpmark target solves the problem of storing the
DSCP to the conntrack mark in a way suitable for the new act_ctinfo tc
action to restore.

The set-dscpmark option accepts 2 parameters, a 32bit 'dscpmask' and a
32bit 'statemask'.  The dscp mask must be 6 contiguous bits and
represents the area where the DSCP will be stored in the connmark.  The
state mask is a minimum 1 bit length mask that must not overlap with the
dscpmask.  It represents a flag which is set when the DSCP has been
stored in the conntrack mark. This is useful to implement a 'one shot'
iptables based classification where the 'complicated' iptables rules are
only run once to classify the connection on initial (egress) packet and
subsequent packets are all marked/restored with the same DSCP.  A state
mask of zero disables the setting of a status bit/s.

example syntax with a suitably modified iptables user space application:

iptables -A QOS_MARK_eth0 -t mangle -j CONNMARK --set-dscpmark 0xfc000000/0x01000000

Would store the DSCP in the top 6 bits of the 32bit mark field, and use
the LSB of the top byte as the 'DSCP has been stored' marker.

|----0xFC----conntrack mark----000000---|
| Bits 31-26 | bit 25 | bit24 |~~~ Bit 0|
| DSCP       | unused | flag  |unused   |
|-----------------------0x01---000000---|
      ^                   ^
      |                   |
      ---|             Conditional flag
         |             set this when dscp
|-ip diffserv-|        stored in mark
| 6 bits      |
|-------------|

an identically configured tc action to restore looks like:

tc filter show dev eth0 ingress
filter parent ffff: protocol all pref 10 u32 chain 0
filter parent ffff: protocol all pref 10 u32 chain 0 fh 800: ht divisor 1
filter parent ffff: protocol all pref 10 u32 chain 0 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1: not_in_hw
  match 00000000/00000000 at 0
	action order 1: ctinfo zone 0 pipe
	 index 2 ref 1 bind 1 dscp 0xfc000000/0x1000000

	action order 2: mirred (Egress Redirect to device ifb4eth0) stolen
	index 1 ref 1 bind 1

|----0xFC----conntrack mark----000000---|
| Bits 31-26 | bit 25 | bit24 |~~~ Bit 0|
| DSCP       | unused | flag  |unused   |
|-----------------------0x01---000000---|
      |                   |
      |                   |
      ---|             Conditional flag
         v             only restore if set
|-ip diffserv-|
| 6 bits      |
|-------------|

Signed-off-by: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
---
v2 - change BIT(n) to (1 << n) in xt_connmark header

 include/uapi/linux/netfilter/xt_connmark.h | 10 ++++
 net/netfilter/xt_connmark.c                | 57 ++++++++++++++++++----
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/netfilter/xt_connmark.h b/include/uapi/linux/netfilter/xt_connmark.h
index 1aa5c955ee1e..44ca3aaabb96 100644
--- a/include/uapi/linux/netfilter/xt_connmark.h
+++ b/include/uapi/linux/netfilter/xt_connmark.h
@@ -19,6 +19,11 @@ enum {
 	XT_CONNMARK_RESTORE
 };
 
+enum {
+	XT_CONNMARK_VALUE	= (1 << 0),
+	XT_CONNMARK_DSCP	= (1 << 1)
+};
+
 enum {
 	D_SHIFT_LEFT = 0,
 	D_SHIFT_RIGHT,
@@ -34,6 +39,11 @@ struct xt_connmark_tginfo2 {
 	__u8 shift_dir, shift_bits, mode;
 };
 
+struct xt_connmark_tginfo3 {
+	__u32 ctmark, ctmask, nfmask;
+	__u8 shift_dir, shift_bits, mode, func;
+};
+
 struct xt_connmark_mtinfo1 {
 	__u32 mark, mask;
 	__u8 invert;
diff --git a/net/netfilter/xt_connmark.c b/net/netfilter/xt_connmark.c
index eec2f3a88d73..188fd2495121 100644
--- a/net/netfilter/xt_connmark.c
+++ b/net/netfilter/xt_connmark.c
@@ -24,12 +24,13 @@ MODULE_ALIAS("ipt_connmark");
 MODULE_ALIAS("ip6t_connmark");
 
 static unsigned int
-connmark_tg_shift(struct sk_buff *skb, const struct xt_connmark_tginfo2 *info)
+connmark_tg_shift(struct sk_buff *skb, const struct xt_connmark_tginfo3 *info)
 {
 	enum ip_conntrack_info ctinfo;
 	u_int32_t new_targetmark;
 	struct nf_conn *ct;
 	u_int32_t newmark;
+	u_int8_t dscp;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct == NULL)
@@ -37,12 +38,24 @@ connmark_tg_shift(struct sk_buff *skb, const struct xt_connmark_tginfo2 *info)
 
 	switch (info->mode) {
 	case XT_CONNMARK_SET:
-		newmark = (ct->mark & ~info->ctmask) ^ info->ctmark;
-		if (info->shift_dir == D_SHIFT_RIGHT)
-			newmark >>= info->shift_bits;
-		else
-			newmark <<= info->shift_bits;
-
+		newmark = ct->mark;
+		if (info->func & XT_CONNMARK_VALUE) {
+			newmark = (newmark & ~info->ctmask) ^ info->ctmark;
+			if (info->shift_dir == D_SHIFT_RIGHT)
+				newmark >>= info->shift_bits;
+			else
+				newmark <<= info->shift_bits;
+		} else if (info->func & XT_CONNMARK_DSCP) {
+			if (skb->protocol == htons(ETH_P_IP))
+				dscp = ipv4_get_dsfield(ip_hdr(skb)) >> 2;
+			else if (skb->protocol == htons(ETH_P_IPV6))
+				dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> 2;
+			else	/* protocol doesn't have diffserv */
+				break;
+
+			newmark = (newmark & ~info->ctmark) |
+				  (info->ctmask | (dscp << info->shift_bits));
+		}
 		if (ct->mark != newmark) {
 			ct->mark = newmark;
 			nf_conntrack_event_cache(IPCT_MARK, ct);
@@ -81,20 +94,36 @@ static unsigned int
 connmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct xt_connmark_tginfo1 *info = par->targinfo;
-	const struct xt_connmark_tginfo2 info2 = {
+	const struct xt_connmark_tginfo3 info3 = {
 		.ctmark	= info->ctmark,
 		.ctmask	= info->ctmask,
 		.nfmask	= info->nfmask,
 		.mode	= info->mode,
+		.func	= XT_CONNMARK_VALUE
 	};
 
-	return connmark_tg_shift(skb, &info2);
+	return connmark_tg_shift(skb, &info3);
 }
 
 static unsigned int
 connmark_tg_v2(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct xt_connmark_tginfo2 *info = par->targinfo;
+	const struct xt_connmark_tginfo3 info3 = {
+		.ctmark	= info->ctmark,
+		.ctmask	= info->ctmask,
+		.nfmask	= info->nfmask,
+		.mode	= info->mode,
+		.func	= XT_CONNMARK_VALUE
+	};
+
+	return connmark_tg_shift(skb, &info3);
+}
+
+static unsigned int
+connmark_tg_v3(struct sk_buff *skb, const struct xt_action_param *par)
+{
+	const struct xt_connmark_tginfo3 *info = par->targinfo;
 
 	return connmark_tg_shift(skb, info);
 }
@@ -165,6 +194,16 @@ static struct xt_target connmark_tg_reg[] __read_mostly = {
 		.targetsize     = sizeof(struct xt_connmark_tginfo2),
 		.destroy        = connmark_tg_destroy,
 		.me             = THIS_MODULE,
+	},
+	{
+		.name           = "CONNMARK",
+		.revision       = 3,
+		.family         = NFPROTO_UNSPEC,
+		.checkentry     = connmark_tg_check,
+		.target         = connmark_tg_v3,
+		.targetsize     = sizeof(struct xt_connmark_tginfo3),
+		.destroy        = connmark_tg_destroy,
+		.me             = THIS_MODULE,
 	}
 };
 
-- 
2.21.0 (Apple Git-122.2)

