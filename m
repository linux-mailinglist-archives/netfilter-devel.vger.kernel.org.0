Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1062D249
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 May 2019 01:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfE1XNj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 May 2019 19:13:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38996 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1XNj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 May 2019 19:13:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so119943pgi.6;
        Tue, 28 May 2019 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BI7Du5iAm9w0yP+GB/oFh20PQ+Dje/x5TifIT+xhg3o=;
        b=SKDhhaQj6evLNiumlwkxYXyxxyhy7/quyu3pM9dn/tkIrSpSD3RMJ/0+I9+UlH7xRO
         EUSZGtPEpyHlYQNdZXyq6VBfCl6ZJtcVu75mhqjB7YZFqKSATepvPYDRDSUBLyiMPVoV
         xpBz9YdTV8DQThrjs0zqsIPce09s1YwKwhlD8vp2O7PdkzmtVwsNT0ZJOLoZ2eLAWdME
         qPUgrA9Zf9al9NDcZAm/LXCNeuT7GALU0THUlJa8JJJOloO6mpu2DC3axj9QNd+MoQ5C
         z1/5Uoug6Wf+UprQQ0K2Ji3kh9IXdHA1mwyUxApokw60VuEiYks5CXPPCIXF1uAU32vk
         1Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BI7Du5iAm9w0yP+GB/oFh20PQ+Dje/x5TifIT+xhg3o=;
        b=Q74mhoBgr5zCLX94s99Vs4fh6OlUMIV6CcFfIumCXTwdNjX9umly1y5ufUOyf42VQ1
         m3aQcmMq49m/jIqtATzAjCtKxMmRaZolepkaSXaeMt+y+LC2dqsJcJDzTKTwqVhugi11
         jXy0/fFd2UAnJ6j7DEWUyEXJIAMX7Mplw5ZZFnj6CZguPUmIVgdhSc6Braa3jY3/qyV3
         c0eUNw/EjK5cM0b4HQiXHUdsrqeVJIl3WcvxCGgShZ8pdW10g+FtApDkmCWClQNktgFN
         95UIqgvT9pEf3pHdWx6y0sFSyijdnitQ1esVoPmAWlGzVVg1gY6nAxIPhBaC5z2EeNPV
         tZXw==
X-Gm-Message-State: APjAAAWvVmYWGpaDORyy+oI3QfG6lYymGSdgTgm/BdAPgDKgpcTheSMj
        rHJl+wzZTMeTBuv2ayOU7Q==
X-Google-Smtp-Source: APXvYqyDM7f+GBwFCz7qPkr8GK8cRgMx5PiozNiFRiqpO12tsZRArtT9aFBvcrh5rmqdcf/9XURcXQ==
X-Received: by 2002:a63:2844:: with SMTP id o65mr48959788pgo.297.1559085217901;
        Tue, 28 May 2019 16:13:37 -0700 (PDT)
Received: from localhost (2.172.220.35.bc.googleusercontent.com. [35.220.172.2])
        by smtp.gmail.com with ESMTPSA id l141sm19191876pfd.24.2019.05.28.16.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 16:13:36 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     hengqing.hu@gmail.com
Cc:     jacky.hu@walmart.com, jason.niesz@walmart.com,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH v3] ipvs: add checksum support for gue encapsulation
Date:   Wed, 29 May 2019 07:11:07 +0800
Message-Id: <20190528231107.14197-1-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add checksum support for gue encapsulation with the tun_flags parameter,
which could be one of the values below:
IP_VS_TUNNEL_ENCAP_FLAG_NOCSUM
IP_VS_TUNNEL_ENCAP_FLAG_CSUM
IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM

Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
---
v3->v2:
  1) fixed CHECK: spaces preferred around that '<<' (ctx:VxV)

v2->v1:
  1) removed unnecessary changes to ip_vs_core.c
  2) use correct nla_get/put function for tun_flags
  3) use correct gue hdrlen for skb_push in ipvs_gue_encap
  4) moved declaration of gue_hdrlen and gue_optlen

 include/net/ip_vs.h             |   2 +
 include/uapi/linux/ip_vs.h      |   7 ++
 net/netfilter/ipvs/ip_vs_ctl.c  |  11 ++-
 net/netfilter/ipvs/ip_vs_xmit.c | 142 ++++++++++++++++++++++++++++----
 4 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index b01a94ebfc0e..cb1ad0cc5c7b 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -603,6 +603,7 @@ struct ip_vs_dest_user_kern {
 
 	u16			tun_type;	/* tunnel type */
 	__be16			tun_port;	/* tunnel port */
+	u16			tun_flags;	/* tunnel flags */
 };
 
 
@@ -665,6 +666,7 @@ struct ip_vs_dest {
 	atomic_t		last_weight;	/* server latest weight */
 	__u16			tun_type;	/* tunnel type */
 	__be16			tun_port;	/* tunnel port */
+	__u16			tun_flags;	/* tunnel flags */
 
 	refcount_t		refcnt;		/* reference counter */
 	struct ip_vs_stats      stats;          /* statistics */
diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
index e34f436fc79d..e4f18061a4fd 100644
--- a/include/uapi/linux/ip_vs.h
+++ b/include/uapi/linux/ip_vs.h
@@ -131,6 +131,11 @@ enum {
 	IP_VS_CONN_F_TUNNEL_TYPE_MAX,
 };
 
+/* Tunnel encapsulation flags */
+#define IP_VS_TUNNEL_ENCAP_FLAG_NOCSUM		(0)
+#define IP_VS_TUNNEL_ENCAP_FLAG_CSUM		(1 << 0)
+#define IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM		(1 << 1)
+
 /*
  *	The struct ip_vs_service_user and struct ip_vs_dest_user are
  *	used to set IPVS rules through setsockopt.
@@ -403,6 +408,8 @@ enum {
 
 	IPVS_DEST_ATTR_TUN_PORT,	/* tunnel port */
 
+	IPVS_DEST_ATTR_TUN_FLAGS,	/* tunnel flags */
+
 	__IPVS_DEST_ATTR_MAX,
 };
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index d5847e06350f..ad19ac08622f 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -893,6 +893,7 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
 	/* set the tunnel info */
 	dest->tun_type = udest->tun_type;
 	dest->tun_port = udest->tun_port;
+	dest->tun_flags = udest->tun_flags;
 
 	/* set the IP_VS_CONN_F_NOOUTPUT flag if not masquerading/NAT */
 	if ((conn_flags & IP_VS_CONN_F_FWD_MASK) != IP_VS_CONN_F_MASQ) {
@@ -2967,6 +2968,7 @@ static const struct nla_policy ip_vs_dest_policy[IPVS_DEST_ATTR_MAX + 1] = {
 	[IPVS_DEST_ATTR_ADDR_FAMILY]	= { .type = NLA_U16 },
 	[IPVS_DEST_ATTR_TUN_TYPE]	= { .type = NLA_U8 },
 	[IPVS_DEST_ATTR_TUN_PORT]	= { .type = NLA_U16 },
+	[IPVS_DEST_ATTR_TUN_FLAGS]	= { .type = NLA_U16 },
 };
 
 static int ip_vs_genl_fill_stats(struct sk_buff *skb, int container_type,
@@ -3273,6 +3275,8 @@ static int ip_vs_genl_fill_dest(struct sk_buff *skb, struct ip_vs_dest *dest)
 		       dest->tun_type) ||
 	    nla_put_be16(skb, IPVS_DEST_ATTR_TUN_PORT,
 			 dest->tun_port) ||
+	    nla_put_u16(skb, IPVS_DEST_ATTR_TUN_FLAGS,
+			dest->tun_flags) ||
 	    nla_put_u32(skb, IPVS_DEST_ATTR_U_THRESH, dest->u_threshold) ||
 	    nla_put_u32(skb, IPVS_DEST_ATTR_L_THRESH, dest->l_threshold) ||
 	    nla_put_u32(skb, IPVS_DEST_ATTR_ACTIVE_CONNS,
@@ -3393,7 +3397,8 @@ static int ip_vs_genl_parse_dest(struct ip_vs_dest_user_kern *udest,
 	/* If a full entry was requested, check for the additional fields */
 	if (full_entry) {
 		struct nlattr *nla_fwd, *nla_weight, *nla_u_thresh,
-			      *nla_l_thresh, *nla_tun_type, *nla_tun_port;
+			      *nla_l_thresh, *nla_tun_type, *nla_tun_port,
+			      *nla_tun_flags;
 
 		nla_fwd		= attrs[IPVS_DEST_ATTR_FWD_METHOD];
 		nla_weight	= attrs[IPVS_DEST_ATTR_WEIGHT];
@@ -3401,6 +3406,7 @@ static int ip_vs_genl_parse_dest(struct ip_vs_dest_user_kern *udest,
 		nla_l_thresh	= attrs[IPVS_DEST_ATTR_L_THRESH];
 		nla_tun_type	= attrs[IPVS_DEST_ATTR_TUN_TYPE];
 		nla_tun_port	= attrs[IPVS_DEST_ATTR_TUN_PORT];
+		nla_tun_flags	= attrs[IPVS_DEST_ATTR_TUN_FLAGS];
 
 		if (!(nla_fwd && nla_weight && nla_u_thresh && nla_l_thresh))
 			return -EINVAL;
@@ -3416,6 +3422,9 @@ static int ip_vs_genl_parse_dest(struct ip_vs_dest_user_kern *udest,
 
 		if (nla_tun_port)
 			udest->tun_port = nla_get_be16(nla_tun_port);
+
+		if (nla_tun_flags)
+			udest->tun_flags = nla_get_u16(nla_tun_flags);
 	}
 
 	return 0;
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 8d6f94b67772..d3392b5b243f 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -40,6 +40,7 @@
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
 #include <net/ip_tunnels.h>
+#include <net/ip6_checksum.h>
 #include <net/addrconf.h>
 #include <linux/icmpv6.h>
 #include <linux/netfilter.h>
@@ -385,8 +386,13 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 		mtu = dst_mtu(&rt->dst) - sizeof(struct iphdr);
 		if (!dest)
 			goto err_put;
-		if (dest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
+		if (dest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 			mtu -= sizeof(struct udphdr) + sizeof(struct guehdr);
+			if ((dest->tun_flags &
+			     IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+			    skb->ip_summed == CHECKSUM_PARTIAL)
+				mtu -= GUE_PLEN_REMCSUM + GUE_LEN_PRIV;
+		}
 		if (mtu < 68) {
 			IP_VS_DBG_RL("%s(): mtu less than 68\n", __func__);
 			goto err_put;
@@ -540,8 +546,13 @@ __ip_vs_get_out_rt_v6(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 		mtu = dst_mtu(&rt->dst) - sizeof(struct ipv6hdr);
 		if (!dest)
 			goto err_put;
-		if (dest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
+		if (dest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 			mtu -= sizeof(struct udphdr) + sizeof(struct guehdr);
+			if ((dest->tun_flags &
+			     IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+			    skb->ip_summed == CHECKSUM_PARTIAL)
+				mtu -= GUE_PLEN_REMCSUM + GUE_LEN_PRIV;
+		}
 		if (mtu < IPV6_MIN_MTU) {
 			IP_VS_DBG_RL("%s(): mtu less than %d\n", __func__,
 				     IPV6_MIN_MTU);
@@ -1006,17 +1017,55 @@ ipvs_gue_encap(struct net *net, struct sk_buff *skb,
 	__be16 sport = udp_flow_src_port(net, skb, 0, 0, false);
 	struct udphdr  *udph;	/* Our new UDP header */
 	struct guehdr  *gueh;	/* Our new GUE header */
+	size_t hdrlen, optlen = 0;
+	void *data;
+	bool need_priv = false;
+
+	if ((cp->dest->tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+	    skb->ip_summed == CHECKSUM_PARTIAL) {
+		optlen += GUE_PLEN_REMCSUM + GUE_LEN_PRIV;
+		need_priv = true;
+	}
 
-	skb_push(skb, sizeof(struct guehdr));
+	hdrlen = sizeof(struct guehdr) + optlen;
+
+	skb_push(skb, hdrlen);
 
 	gueh = (struct guehdr *)skb->data;
 
 	gueh->control = 0;
 	gueh->version = 0;
-	gueh->hlen = 0;
+	gueh->hlen = optlen >> 2;
 	gueh->flags = 0;
 	gueh->proto_ctype = *next_protocol;
 
+	data = &gueh[1];
+
+	if (need_priv) {
+		__be32 *flags = data;
+		u16 csum_start = skb_checksum_start_offset(skb);
+		__be16 *pd = data;
+
+		gueh->flags |= GUE_FLAG_PRIV;
+		*flags = 0;
+		data += GUE_LEN_PRIV;
+
+		if (csum_start < hdrlen)
+			return -EINVAL;
+
+		csum_start -= hdrlen;
+		pd[0] = htons(csum_start);
+		pd[1] = htons(csum_start + skb->csum_offset);
+
+		if (!skb_is_gso(skb)) {
+			skb->ip_summed = CHECKSUM_NONE;
+			skb->encapsulation = 0;
+		}
+
+		*flags |= GUE_PFLAG_REMCSUM;
+		data += GUE_PLEN_REMCSUM;
+	}
+
 	skb_push(skb, sizeof(struct udphdr));
 	skb_reset_transport_header(skb);
 
@@ -1070,6 +1119,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	unsigned int max_headroom;		/* The extra header space needed */
 	int ret, local;
 	int tun_type, gso_type;
+	int tun_flags;
 
 	EnterFunction(10);
 
@@ -1092,9 +1142,19 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct iphdr);
 
 	tun_type = cp->dest->tun_type;
+	tun_flags = cp->dest->tun_flags;
 
-	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
-		max_headroom += sizeof(struct udphdr) + sizeof(struct guehdr);
+	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		size_t gue_hdrlen, gue_optlen = 0;
+
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+		    skb->ip_summed == CHECKSUM_PARTIAL) {
+			gue_optlen += GUE_PLEN_REMCSUM + GUE_LEN_PRIV;
+		}
+		gue_hdrlen = sizeof(struct guehdr) + gue_optlen;
+
+		max_headroom += sizeof(struct udphdr) + gue_hdrlen;
+	}
 
 	/* We only care about the df field if sysctl_pmtu_disc(ipvs) is set */
 	dfp = sysctl_pmtu_disc(ipvs) ? &df : NULL;
@@ -1105,8 +1165,17 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 		goto tx_error;
 
 	gso_type = __tun_gso_type_mask(AF_INET, cp->af);
-	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
-		gso_type |= SKB_GSO_UDP_TUNNEL;
+	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_CSUM) ||
+		    (tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM))
+			gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			gso_type |= SKB_GSO_UDP_TUNNEL;
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+		    skb->ip_summed == CHECKSUM_PARTIAL) {
+			gso_type |= SKB_GSO_TUNNEL_REMCSUM;
+		}
+	}
 
 	if (iptunnel_handle_offloads(skb, gso_type))
 		goto tx_error;
@@ -1115,8 +1184,19 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 
 	skb_set_inner_ipproto(skb, next_protocol);
 
-	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
-		ipvs_gue_encap(net, skb, cp, &next_protocol);
+	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		bool check = false;
+
+		if (ipvs_gue_encap(net, skb, cp, &next_protocol))
+			goto tx_error;
+
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_CSUM) ||
+		    (tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM))
+			check = true;
+
+		udp_set_csum(!check, skb, saddr, cp->daddr.ip, skb->len);
+	}
+
 
 	skb_push(skb, sizeof(struct iphdr));
 	skb_reset_network_header(skb);
@@ -1174,6 +1254,7 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 	unsigned int max_headroom;	/* The extra header space needed */
 	int ret, local;
 	int tun_type, gso_type;
+	int tun_flags;
 
 	EnterFunction(10);
 
@@ -1197,9 +1278,19 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr);
 
 	tun_type = cp->dest->tun_type;
+	tun_flags = cp->dest->tun_flags;
 
-	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
-		max_headroom += sizeof(struct udphdr) + sizeof(struct guehdr);
+	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		size_t gue_hdrlen, gue_optlen = 0;
+
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+		    skb->ip_summed == CHECKSUM_PARTIAL) {
+			gue_optlen += GUE_PLEN_REMCSUM + GUE_LEN_PRIV;
+		}
+		gue_hdrlen = sizeof(struct guehdr) + gue_optlen;
+
+		max_headroom += sizeof(struct udphdr) + gue_hdrlen;
+	}
 
 	skb = ip_vs_prepare_tunneled_skb(skb, cp->af, max_headroom,
 					 &next_protocol, &payload_len,
@@ -1208,8 +1299,17 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 		goto tx_error;
 
 	gso_type = __tun_gso_type_mask(AF_INET6, cp->af);
-	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
-		gso_type |= SKB_GSO_UDP_TUNNEL;
+	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_CSUM) ||
+		    (tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM))
+			gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			gso_type |= SKB_GSO_UDP_TUNNEL;
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM) &&
+		    skb->ip_summed == CHECKSUM_PARTIAL) {
+			gso_type |= SKB_GSO_TUNNEL_REMCSUM;
+		}
+	}
 
 	if (iptunnel_handle_offloads(skb, gso_type))
 		goto tx_error;
@@ -1218,8 +1318,18 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 
 	skb_set_inner_ipproto(skb, next_protocol);
 
-	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE)
-		ipvs_gue_encap(net, skb, cp, &next_protocol);
+	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		bool check = false;
+
+		if (ipvs_gue_encap(net, skb, cp, &next_protocol))
+			goto tx_error;
+
+		if ((tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_CSUM) ||
+		    (tun_flags & IP_VS_TUNNEL_ENCAP_FLAG_REMCSUM))
+			check = true;
+
+		udp6_set_csum(!check, skb, &saddr, &cp->daddr.in6, skb->len);
+	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
-- 
2.21.0

