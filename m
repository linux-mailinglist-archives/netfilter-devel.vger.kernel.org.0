Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9245C32053
	for <lists+netfilter-devel@lfdr.de>; Sat,  1 Jun 2019 20:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFASYI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Jun 2019 14:24:08 -0400
Received: from mail.us.es ([193.147.175.20]:40014 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfFASYH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Jun 2019 14:24:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 949B9B60E8
        for <netfilter-devel@vger.kernel.org>; Sat,  1 Jun 2019 20:24:00 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6C6C5DA701
        for <netfilter-devel@vger.kernel.org>; Sat,  1 Jun 2019 20:24:00 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AF3F0FF148; Sat,  1 Jun 2019 20:23:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 12FEDDA716;
        Sat,  1 Jun 2019 20:23:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 01 Jun 2019 20:23:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [31.4.178.197])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A10224265A32;
        Sat,  1 Jun 2019 20:23:49 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 03/15] ipvs: strip udp tunnel headers from icmp errors
Date:   Sat,  1 Jun 2019 20:23:28 +0200
Message-Id: <20190601182340.2662-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190601182340.2662-1-pablo@netfilter.org>
References: <20190601182340.2662-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Julian Anastasov <ja@ssi.bg>

Recognize UDP tunnels in received ICMP errors and
properly strip the tunnel headers. GUE is what we
have for now.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipvs/ip_vs_core.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 4447ee512b88..d1d7b2483fd7 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -39,6 +39,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <net/icmp.h>                   /* for icmp_send */
+#include <net/gue.h>
 #include <net/route.h>
 #include <net/ip6_checksum.h>
 #include <net/netns/generic.h>		/* net_generic() */
@@ -1579,6 +1580,41 @@ ip_vs_try_to_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
 	return 1;
 }
 
+/* Check the UDP tunnel and return its header length */
+static int ipvs_udp_decap(struct netns_ipvs *ipvs, struct sk_buff *skb,
+			  unsigned int offset, __u16 af,
+			  const union nf_inet_addr *daddr, __u8 *proto)
+{
+	struct udphdr _udph, *udph;
+	struct ip_vs_dest *dest;
+
+	udph = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
+	if (!udph)
+		goto unk;
+	offset += sizeof(struct udphdr);
+	dest = ip_vs_find_tunnel(ipvs, af, daddr, udph->dest);
+	if (!dest)
+		goto unk;
+	if (dest->tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
+		struct guehdr _gueh, *gueh;
+
+		gueh = skb_header_pointer(skb, offset, sizeof(_gueh), &_gueh);
+		if (!gueh)
+			goto unk;
+		if (gueh->control != 0 || gueh->version != 0)
+			goto unk;
+		/* Later we can support also IPPROTO_IPV6 */
+		if (gueh->proto_ctype != IPPROTO_IPIP)
+			goto unk;
+		*proto = gueh->proto_ctype;
+		return sizeof(struct udphdr) + sizeof(struct guehdr) +
+		       (gueh->hlen << 2);
+	}
+
+unk:
+	return 0;
+}
+
 /*
  *	Handle ICMP messages in the outside-to-inside direction (incoming).
  *	Find any that might be relevant, check against existing connections,
@@ -1658,6 +1694,30 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
 		if (cih == NULL)
 			return NF_ACCEPT; /* The packet looks wrong, ignore */
 		ipip = true;
+	} else if (cih->protocol == IPPROTO_UDP &&	/* Can be UDP encap */
+		   /* Error for our tunnel must arrive at LOCAL_IN */
+		   (skb_rtable(skb)->rt_flags & RTCF_LOCAL)) {
+		__u8 iproto;
+		int ulen;
+
+		/* Non-first fragment has no UDP header */
+		if (unlikely(cih->frag_off & htons(IP_OFFSET)))
+			return NF_ACCEPT;
+		offset2 = offset + cih->ihl * 4;
+		ulen = ipvs_udp_decap(ipvs, skb, offset2, AF_INET, raddr,
+				      &iproto);
+		if (ulen > 0) {
+			/* Skip IP and UDP tunnel headers */
+			offset = offset2 + ulen;
+			/* Now we should be at the original IP header */
+			cih = skb_header_pointer(skb, offset, sizeof(_ciph),
+						 &_ciph);
+			if (cih && cih->version == 4 && cih->ihl >= 5 &&
+			    iproto == IPPROTO_IPIP)
+				ipip = true;
+			else
+				return NF_ACCEPT;
+		}
 	}
 
 	pd = ip_vs_proto_data_get(ipvs, cih->protocol);
-- 
2.11.0

