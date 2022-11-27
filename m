Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5C63990D
	for <lists+netfilter-devel@lfdr.de>; Sun, 27 Nov 2022 01:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiK0AX0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 26 Nov 2022 19:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiK0AXZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 26 Nov 2022 19:23:25 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7DADEF2
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Nov 2022 16:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TRL1FyQAmKfiFiDbr8dzhdY2V7eYUkY8cBpBlR9G1dU=; b=goEa9P3ies95+EMcbAUcun/T0u
        BinkHSpH8QRIc1R+EqGNjNiiG9OQj5NfmK8ODvYKXbEOJU6zQXNkqlKCobE6vmYPhTe4lYCKAHR+B
        4z5AZKlctQz1HDFJ8mBIu0iEcdD6uTcaBYAFHSDxnSNvIDJaL/P2OjpA6zHoKK3T7kxXuUtSz3Eb2
        jZLhKr8vyUB7EZUwGZEjrhUmYtiMVpgth7Waa4zxQY8hqQw1/ThqEohaI+P+jFZ/h0wSt4iiaC7WO
        /x1TyyTKc2UXyfF9TAtuTitQ7pIoEsw4bn2VNXxRsGbrYbdkkT/+fbl1cL+1k6bC4qZGeZ4udQjpp
        /2cgPCgg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1oz5S3-00Aj1L-8j; Sun, 27 Nov 2022 00:23:19 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     Robert O'Brien <robrien@foxtrot-research.com>
Subject: [PATCH ulogd2 3/3] src: keep IPv4 addresses internally in IPv4-in-IPv6 format
Date:   Sun, 27 Nov 2022 00:23:00 +0000
Message-Id: <20221127002300.191936-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221127002300.191936-1-jeremy@azazel.net>
References: <20221127002300.191936-1-jeremy@azazel.net>
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

Hitherto, some plug-ins have converted converted IP addresses to
host-endianness or assumed that they already have been, and several have
assumed that all IP addresses are IPv4.  This can lead to garbled output
if the expectations of plug-ins in a stack do not match.  Convert all IP
addresses to IPv6, using IPv4-inIPv6 for IPv4.  Convert IPv4 addresses
back for formatting.

Move a couple of `ULOGD_RET_BOOL` cases for consistency.

Reported-by: Robert O'Brien <robrien@foxtrot-research.com>
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 filter/raw2packet/ulogd_raw2packet_BASE.c | 24 ++++++++---
 filter/ulogd_filter_IP2BIN.c              | 35 ++++-----------
 filter/ulogd_filter_IP2HBIN.c             | 13 +++---
 filter/ulogd_filter_IP2STR.c              |  5 +--
 include/ulogd/ulogd.h                     | 52 +++++++++++++++++++++++
 input/flow/ulogd_inpflow_NFCT.c           | 24 +++++++----
 output/ipfix/ulogd_output_IPFIX.c         |  4 +-
 output/sqlite3/ulogd_output_SQLITE3.c     | 24 ++++++++---
 output/ulogd_output_GPRINT.c              | 34 ++++++++++-----
 output/ulogd_output_OPRINT.c              | 40 ++++++++++-------
 src/ulogd.c                               |  3 +-
 util/db.c                                 | 18 ++++++--
 12 files changed, 186 insertions(+), 90 deletions(-)

diff --git a/filter/raw2packet/ulogd_raw2packet_BASE.c b/filter/raw2packet/ulogd_raw2packet_BASE.c
index 9117d27da09a..b81860222e54 100644
--- a/filter/raw2packet/ulogd_raw2packet_BASE.c
+++ b/filter/raw2packet/ulogd_raw2packet_BASE.c
@@ -629,6 +629,7 @@ static int _interp_icmp(struct ulogd_pluginstance *pi, struct icmphdr *icmph,
 			uint32_t len)
 {
 	struct ulogd_key *ret = pi->output.keys;
+	struct in6_addr gateway;
 
 	if (len < sizeof(struct icmphdr))
 		return ULOGD_IRET_OK;
@@ -645,7 +646,8 @@ static int _interp_icmp(struct ulogd_pluginstance *pi, struct icmphdr *icmph,
 		break;
 	case ICMP_REDIRECT:
 	case ICMP_PARAMETERPROB:
-		okey_set_u32(&ret[KEY_ICMP_GATEWAY], ntohl(icmph->un.gateway));
+		u32_to_ipv6(&gateway, icmph->un.gateway);
+		okey_set_u128(&ret[KEY_ICMP_GATEWAY], &gateway);
 		break;
 	case ICMP_DEST_UNREACH:
 		if (icmph->code == ICMP_FRAG_NEEDED) {
@@ -715,16 +717,19 @@ static int _interp_ahesp(struct ulogd_pluginstance *pi, void *protoh,
 static int _interp_iphdr(struct ulogd_pluginstance *pi, uint32_t len)
 {
 	struct ulogd_key *ret = pi->output.keys;
-	struct iphdr *iph =
-		ikey_get_ptr(&pi->input.keys[INKEY_RAW_PCKT]);
+	struct iphdr *iph = ikey_get_ptr(&pi->input.keys[INKEY_RAW_PCKT]);
+	struct in6_addr saddr, daddr;
 	void *nexthdr;
 
 	if (len < sizeof(struct iphdr) || len <= (uint32_t)(iph->ihl * 4))
 		return ULOGD_IRET_OK;
 	len -= iph->ihl * 4;
 
-	okey_set_u32(&ret[KEY_IP_SADDR], iph->saddr);
-	okey_set_u32(&ret[KEY_IP_DADDR], iph->daddr);
+	u32_to_ipv6(&saddr, iph->saddr);
+	u32_to_ipv6(&daddr, iph->daddr);
+
+	okey_set_u128(&ret[KEY_IP_SADDR], &saddr);
+	okey_set_u128(&ret[KEY_IP_DADDR], &daddr);
 	okey_set_u8(&ret[KEY_IP_PROTOCOL], iph->protocol);
 	okey_set_u8(&ret[KEY_IP_TOS], iph->tos);
 	okey_set_u8(&ret[KEY_IP_TTL], iph->ttl);
@@ -896,6 +901,7 @@ static int _interp_arp(struct ulogd_pluginstance *pi, uint32_t len)
 	struct ulogd_key *ret = pi->output.keys;
 	const struct ether_arp *arph =
 		ikey_get_ptr(&pi->input.keys[INKEY_RAW_PCKT]);
+	struct in6_addr spa, tpa;
 
 	if (len < sizeof(struct ether_arp))
 		return ULOGD_IRET_OK;
@@ -904,10 +910,14 @@ static int _interp_arp(struct ulogd_pluginstance *pi, uint32_t len)
 	okey_set_u16(&ret[KEY_ARP_PTYPE], ntohs(arph->arp_pro));
 	okey_set_u16(&ret[KEY_ARP_OPCODE], ntohs(arph->arp_op));
 
+	u32_to_ipv6(&spa, *(uint32_t *) arph->arp_spa);
+	u32_to_ipv6(&tpa, *(uint32_t *) arph->arp_tpa);
+
+	okey_set_u128(&ret[KEY_ARP_SPA], &spa);
+	okey_set_u128(&ret[KEY_ARP_TPA], &tpa);
+
 	okey_set_ptr(&ret[KEY_ARP_SHA], (void *)&arph->arp_sha);
-	okey_set_ptr(&ret[KEY_ARP_SPA], (void *)&arph->arp_spa);
 	okey_set_ptr(&ret[KEY_ARP_THA], (void *)&arph->arp_tha);
-	okey_set_ptr(&ret[KEY_ARP_TPA], (void *)&arph->arp_tpa);
 
 	return ULOGD_IRET_OK;
 }
diff --git a/filter/ulogd_filter_IP2BIN.c b/filter/ulogd_filter_IP2BIN.c
index ee1238ff4940..0a7309c2f680 100644
--- a/filter/ulogd_filter_IP2BIN.c
+++ b/filter/ulogd_filter_IP2BIN.c
@@ -116,25 +116,12 @@ static struct ulogd_key ip2bin_keys[] = {
 
 static char ipbin_array[MAX_KEY-START_KEY][IPADDR_LENGTH];
 
-/**
- * Convert IPv4 address (as 32-bit unsigned integer) to IPv6 address:
- * add 96 bits prefix "::ffff:" to get IPv6 address "::ffff:a.b.c.d".
- */
-static inline void uint32_to_ipv6(const uint32_t ipv4, struct in6_addr *ipv6)
-{
-	ipv6->s6_addr32[0] = 0x00000000;
-	ipv6->s6_addr32[1] = 0x00000000;
-	ipv6->s6_addr32[2] = htonl(0xffff);
-	ipv6->s6_addr32[3] = ipv4;
-}
-
 static int ip2bin(struct ulogd_key* inp, int index, int oindex)
 {
 	char family = ikey_get_u8(&inp[KEY_OOB_FAMILY]);
 	char convfamily = family;
 	unsigned char *addr8;
 	struct in6_addr *addr;
-	struct in6_addr ip4_addr;
 	char *buffer;
 	int i, written;
 
@@ -162,18 +149,14 @@ static int ip2bin(struct ulogd_key* inp, int index, int oindex)
 	}
 
 	switch (convfamily) {
-		case AF_INET6:
-			addr = (struct in6_addr *)ikey_get_u128(&inp[index]);
-			break;
-		case AF_INET:
-			/* Convert IPv4 to IPv4 in IPv6 */
-			addr = &ip4_addr;
-			uint32_to_ipv6(ikey_get_u32(&inp[index]), addr);
-			break;
-		default:
-			/* TODO handle error */
-			ulogd_log(ULOGD_NOTICE, "Unknown protocol family\n");
-			return ULOGD_IRET_ERR;
+	case AF_INET6:
+	case AF_INET:
+		addr = ikey_get_u128(&inp[index]);
+		break;
+	default:
+		/* TODO handle error */
+		ulogd_log(ULOGD_NOTICE, "Unknown protocol family\n");
+		return ULOGD_IRET_ERR;
 	}
 
 	buffer = ipbin_array[oindex];
@@ -184,7 +167,7 @@ static int ip2bin(struct ulogd_key* inp, int index, int oindex)
 	addr8 = &addr->s6_addr[0];
 	for (i = 0; i < 4; i++) {
 		written = sprintf(buffer, "%02x%02x%02x%02x",
-				addr8[0], addr8[1], addr8[2], addr8[3]);
+				  addr8[0], addr8[1], addr8[2], addr8[3]);
 		if (written != 2 * 4) {
 			buffer[0] = 0;
 			return ULOGD_IRET_ERR;
diff --git a/filter/ulogd_filter_IP2HBIN.c b/filter/ulogd_filter_IP2HBIN.c
index 087e824ae94b..5381dcd75ce9 100644
--- a/filter/ulogd_filter_IP2HBIN.c
+++ b/filter/ulogd_filter_IP2HBIN.c
@@ -156,14 +156,13 @@ static int interp_ip2hbin(struct ulogd_pluginstance *pi)
 	for(i = START_KEY; i < MAX_KEY; i++) {
 		if (pp_is_valid(inp, i)) {
 			switch (convfamily) {
-			case AF_INET:
-				okey_set_u32(&ret[i-START_KEY],
-					ntohl(ikey_get_u32(&inp[i])));
-				break;
-			case AF_INET6:
-				okey_set_ptr(&ret[i-START_KEY],
-					(struct in6_addr *)ikey_get_u128(&inp[i]));
+			case AF_INET: {
+				uint32_t ipv4;
+
+				ipv4 = ipv6_to_u32(ikey_get_u128(&inp[i]));
+				okey_set_u32(&ret[i-START_KEY], ntohl(ipv4));
 				break;
+			}
 			default:
 				;
 				break;
diff --git a/filter/ulogd_filter_IP2STR.c b/filter/ulogd_filter_IP2STR.c
index 66324b0b3b22..8f7cd690f069 100644
--- a/filter/ulogd_filter_IP2STR.c
+++ b/filter/ulogd_filter_IP2STR.c
@@ -170,12 +170,11 @@ static int ip2str(struct ulogd_key *inp, int index, int oindex)
 	switch (convfamily) {
 		uint32_t ip;
 	case AF_INET6:
-		inet_ntop(AF_INET6,
-			  ikey_get_u128(&inp[index]),
+		inet_ntop(AF_INET6, ikey_get_u128(&inp[index]),
 			  ipstr_array[oindex], sizeof(ipstr_array[oindex]));
 		break;
 	case AF_INET:
-		ip = ikey_get_u32(&inp[index]);
+		ip = ipv6_to_u32(ikey_get_u128(&inp[index]));
 		inet_ntop(AF_INET, &ip,
 			  ipstr_array[oindex], sizeof(ipstr_array[oindex]));
 		break;
diff --git a/include/ulogd/ulogd.h b/include/ulogd/ulogd.h
index 092d9f521a70..64765cc571b7 100644
--- a/include/ulogd/ulogd.h
+++ b/include/ulogd/ulogd.h
@@ -14,10 +14,12 @@
 #include <ulogd/linuxlist.h>
 #include <ulogd/conffile.h>
 #include <ulogd/ipfix_protocol.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <signal.h>	/* need this because of extension-sighandler */
 #include <sys/types.h>
 #include <inttypes.h>
+#include <netinet/in.h>
 #include <string.h>
 #include <config.h>
 
@@ -202,6 +204,56 @@ static inline void *ikey_get_ptr(struct ulogd_key *key)
 	return key->u.source->u.value.ptr;
 }
 
+/**
+ * Convert IPv4 address (as 32-bit unsigned integer) to IPv6 address:
+ * add 96 bits prefix "::ffff:" to get IPv6 address "::ffff:a.b.c.d".
+ */
+static inline struct in6_addr *
+u32_to_ipv6(struct in6_addr *ipv6, uint32_t ipv4)
+{
+	static const uint8_t IPV4_IN_IPV6_PREFIX[12] = {
+		[10] = 0xff,
+		[11] = 0xff,
+	};
+	uint8_t *p = ipv6->s6_addr;
+
+	memcpy(p, IPV4_IN_IPV6_PREFIX, sizeof(IPV4_IN_IPV6_PREFIX));
+	p += sizeof(IPV4_IN_IPV6_PREFIX);
+	memcpy(p, &ipv4, sizeof(ipv4));
+
+	return ipv6;
+}
+
+static inline struct in6_addr *
+ipv4_to_ipv6(struct in6_addr *ipv6, const struct in_addr *ipv4)
+{
+	return u32_to_ipv6(ipv6, ipv4->s_addr);
+}
+
+static inline uint32_t
+ipv6_to_u32(const struct in6_addr *ipv6)
+{
+	return *((uint32_t *) ipv6->s6_addr + 3);
+}
+
+static inline struct in_addr
+ipv6_to_ipv4(const struct in6_addr *ipv6)
+{
+	return (struct in_addr) { .s_addr = (in_addr_t) ipv6_to_u32(ipv6) };
+}
+
+static inline bool
+ipv4_in_ipv6(const struct in6_addr *ipv6)
+{
+	static const uint8_t IPV4_IN_IPV6_PREFIX[12] = {
+		[10] = 0xff,
+		[11] = 0xff,
+	};
+
+	return memcmp(IPV4_IN_IPV6_PREFIX, ipv6->s6_addr,
+		      sizeof(IPV4_IN_IPV6_PREFIX)) == 0;
+}
+
 struct ulogd_pluginstance_stack;
 struct ulogd_pluginstance;
 
diff --git a/input/flow/ulogd_inpflow_NFCT.c b/input/flow/ulogd_inpflow_NFCT.c
index 899b7e3b8039..e4f2a18b8333 100644
--- a/input/flow/ulogd_inpflow_NFCT.c
+++ b/input/flow/ulogd_inpflow_NFCT.c
@@ -501,16 +501,22 @@ static int propagate_ct(struct ulogd_pluginstance *main_upi,
 	okey_set_u8(&ret[NFCT_OOB_PROTOCOL], 0); /* FIXME */
 
 	switch (nfct_get_attr_u8(ct, ATTR_L3PROTO)) {
-	case AF_INET:
-		okey_set_u32(&ret[NFCT_ORIG_IP_SADDR],
-			     nfct_get_attr_u32(ct, ATTR_ORIG_IPV4_SRC));
-		okey_set_u32(&ret[NFCT_ORIG_IP_DADDR],
-			     nfct_get_attr_u32(ct, ATTR_ORIG_IPV4_DST));
-		okey_set_u32(&ret[NFCT_REPLY_IP_SADDR],
-			     nfct_get_attr_u32(ct, ATTR_REPL_IPV4_SRC));
-		okey_set_u32(&ret[NFCT_REPLY_IP_DADDR],
-			     nfct_get_attr_u32(ct, ATTR_REPL_IPV4_DST));
+	case AF_INET: {
+		struct in6_addr addr;
+
+		u32_to_ipv6(&addr, nfct_get_attr_u32(ct, ATTR_ORIG_IPV4_SRC));
+		okey_set_u128(&ret[NFCT_ORIG_IP_SADDR], addr.s6_addr);
+
+		u32_to_ipv6(&addr, nfct_get_attr_u32(ct, ATTR_ORIG_IPV4_DST));
+		okey_set_u128(&ret[NFCT_ORIG_IP_DADDR], addr.s6_addr);
+
+		u32_to_ipv6(&addr, nfct_get_attr_u32(ct, ATTR_REPL_IPV4_SRC));
+		okey_set_u128(&ret[NFCT_REPLY_IP_SADDR], addr.s6_addr);
+
+		u32_to_ipv6(&addr, nfct_get_attr_u32(ct, ATTR_REPL_IPV4_DST));
+		okey_set_u128(&ret[NFCT_REPLY_IP_DADDR], addr.s6_addr);
 		break;
+	}
 	case AF_INET6:
 		okey_set_u128(&ret[NFCT_ORIG_IP_SADDR],
 			      nfct_get_attr(ct, ATTR_ORIG_IPV6_SRC));
diff --git a/output/ipfix/ulogd_output_IPFIX.c b/output/ipfix/ulogd_output_IPFIX.c
index 4863d008562e..1c281fe89c74 100644
--- a/output/ipfix/ulogd_output_IPFIX.c
+++ b/output/ipfix/ulogd_output_IPFIX.c
@@ -453,8 +453,8 @@ again:
 		goto again;
 	}
 
-	data->saddr.s_addr = ikey_get_u32(&pi->input.keys[InIpSaddr]);
-	data->daddr.s_addr = ikey_get_u32(&pi->input.keys[InIpDaddr]);
+	data->saddr = ipv6_to_ipv4(ikey_get_u128(&pi->input.keys[InIpSaddr]));
+	data->daddr = ipv6_to_ipv4(ikey_get_u128(&pi->input.keys[InIpDaddr]));
 
 	data->packets = htonl((uint32_t) (ikey_get_u64(&pi->input.keys[InRawInPktCount])
 						+ ikey_get_u64(&pi->input.keys[InRawOutPktCount])));
diff --git a/output/sqlite3/ulogd_output_SQLITE3.c b/output/sqlite3/ulogd_output_SQLITE3.c
index 0a9ad67edcff..70eae85c22f0 100644
--- a/output/sqlite3/ulogd_output_SQLITE3.c
+++ b/output/sqlite3/ulogd_output_SQLITE3.c
@@ -145,6 +145,10 @@ sqlite3_interp(struct ulogd_pluginstance *pi)
 		}
 
 		switch (f->key->type) {
+		case ULOGD_RET_BOOL:
+			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.b);
+			break;
+
 		case ULOGD_RET_INT8:
 			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.i8);
 			break;
@@ -160,11 +164,11 @@ sqlite3_interp(struct ulogd_pluginstance *pi)
 		case ULOGD_RET_INT64:
 			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.i64);
 			break;
-			
+
 		case ULOGD_RET_UINT8:
 			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.ui8);
 			break;
-			
+
 		case ULOGD_RET_UINT16:
 			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.ui16);
 			break;
@@ -173,18 +177,26 @@ sqlite3_interp(struct ulogd_pluginstance *pi)
 			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.ui32);
 			break;
 
-		case ULOGD_RET_IPADDR:
 		case ULOGD_RET_UINT64:
 			ret = sqlite3_bind_int64(priv->p_stmt, i, k_ret->u.value.ui64);
 			break;
 
-		case ULOGD_RET_BOOL:
-			ret = sqlite3_bind_int(priv->p_stmt, i, k_ret->u.value.b);
+		case ULOGD_RET_IPADDR: {
+			struct in6_addr ipv6addr;
+
+			memcpy(ipv6addr.s6_addr, k_ret->u.value.ui128,
+			       sizeof(ipv6addr.s6_addr));
+			if (ipv4_in_ipv6(&ipv6addr))
+				ret = sqlite3_bind_int(priv->p_stmt, i,
+						       ipv6_to_u32(&ipv6addr));
+			else
+				ret = sqlite3_bind_null(priv->p_stmt, i);
 			break;
+		}
 
 		case ULOGD_RET_STRING:
 			ret = sqlite3_bind_text(priv->p_stmt, i, k_ret->u.value.ptr,
-									strlen(k_ret->u.value.ptr), SQLITE_STATIC);
+						strlen(k_ret->u.value.ptr), SQLITE_STATIC);
 			break;
 
 		default:
diff --git a/output/ulogd_output_GPRINT.c b/output/ulogd_output_GPRINT.c
index eeeec6ac3eb0..7fa26ddee88b 100644
--- a/output/ulogd_output_GPRINT.c
+++ b/output/ulogd_output_GPRINT.c
@@ -27,6 +27,7 @@
 #include <time.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <arpa/inet.h>
 #include <ulogd/ulogd.h>
 #include <ulogd/conffile.h>
 
@@ -69,12 +70,6 @@ static struct config_keyset gprint_kset = {
 	},
 };
 
-#define NIPQUAD(addr) \
-        ((unsigned char *)&addr)[0], \
-        ((unsigned char *)&addr)[1], \
-        ((unsigned char *)&addr)[2], \
-        ((unsigned char *)&addr)[3]
-
 static int gprint_interp(struct ulogd_pluginstance *upi)
 {
 	struct gprint_priv *opi = (struct gprint_priv *) &upi->private;
@@ -158,20 +153,39 @@ static int gprint_interp(struct ulogd_pluginstance *upi)
 			rem -= ret;
 			size += ret;
 			break;
-		case ULOGD_RET_IPADDR:
+		case ULOGD_RET_IPADDR: {
+			int family;
+			struct in6_addr ipv6addr;
+			struct in_addr ipv4addr;
+			void *addr;
+
 			ret = snprintf(buf+size, rem, "%s=", key->name);
 			if (ret < 0)
 				break;
 			rem -= ret;
 			size += ret;
 
-			ret = snprintf(buf+size, rem, "%u.%u.%u.%u,",
-				NIPQUAD(key->u.value.ui32));
-			if (ret < 0)
+			memcpy(ipv6addr.s6_addr, key->u.value.ui128,
+			       sizeof(ipv6addr.s6_addr));
+
+			if (ipv4_in_ipv6(&ipv6addr)) {
+				family = AF_INET;
+				ipv4addr = ipv6_to_ipv4(&ipv6addr);
+				addr = &ipv4addr;
+				ret = INET_ADDRSTRLEN;
+			} else {
+				family = AF_INET6;
+				addr = &ipv6addr;
+				ret = INET6_ADDRSTRLEN;
+			}
+
+			if (!inet_ntop(family, addr, buf + size, rem))
 				break;
+
 			rem -= ret;
 			size += ret;
 			break;
+		}
 		default:
 			/* don't know how to interpret this key. */
 			break;
diff --git a/output/ulogd_output_OPRINT.c b/output/ulogd_output_OPRINT.c
index 8617203237c3..1d97eebe2d85 100644
--- a/output/ulogd_output_OPRINT.c
+++ b/output/ulogd_output_OPRINT.c
@@ -24,6 +24,7 @@
 #include <string.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <arpa/inet.h>
 #include <ulogd/ulogd.h>
 #include <ulogd/conffile.h>
 
@@ -31,18 +32,6 @@
 #define ULOGD_OPRINT_DEFAULT	"/var/log/ulogd_oprint.log"
 #endif
 
-#define NIPQUAD(addr) \
-	((unsigned char *)&addr)[0], \
-	((unsigned char *)&addr)[1], \
-        ((unsigned char *)&addr)[2], \
-        ((unsigned char *)&addr)[3]
-
-#define HIPQUAD(addr) \
-        ((unsigned char *)&addr)[3], \
-        ((unsigned char *)&addr)[2], \
-        ((unsigned char *)&addr)[1], \
-        ((unsigned char *)&addr)[0]
-
 struct oprint_priv {
 	FILE *of;
 };
@@ -86,10 +75,31 @@ static int oprint_interp(struct ulogd_pluginstance *upi)
 		case ULOGD_RET_UINT64:
 			fprintf(opi->of, "%" PRIu64 "\n", ret->u.value.ui64);
 			break;
-		case ULOGD_RET_IPADDR:
-			fprintf(opi->of, "%u.%u.%u.%u\n",
-				HIPQUAD(ret->u.value.ui32));
+		case ULOGD_RET_IPADDR: {
+			int family;
+			struct in6_addr ipv6addr;
+			struct in_addr ipv4addr;
+			void *addr;
+			char addrbuf[INET6_ADDRSTRLEN + 1] = "";
+
+			memcpy(ipv6addr.s6_addr, ret->u.value.ui128,
+			       sizeof(ipv6addr.s6_addr));
+
+			if (ipv4_in_ipv6(&ipv6addr)) {
+				family = AF_INET;
+				ipv4addr = ipv6_to_ipv4(&ipv6addr);
+				addr = &ipv4addr;
+			} else {
+				family = AF_INET6;
+				addr = &ipv6addr;
+			}
+
+			if (!inet_ntop(family, addr, addrbuf, sizeof(addrbuf)))
+				break;
+
+			fprintf(opi->of, "%s\n", addrbuf);
 			break;
+		}
 		case ULOGD_RET_NONE:
 			fprintf(opi->of, "<none>\n");
 			break;
diff --git a/src/ulogd.c b/src/ulogd.c
index b02f2602a895..eae384dea70d 100644
--- a/src/ulogd.c
+++ b/src/ulogd.c
@@ -182,13 +182,14 @@ int ulogd_key_size(struct ulogd_key *key)
 		break;
 	case ULOGD_RET_INT32:
 	case ULOGD_RET_UINT32:
-	case ULOGD_RET_IPADDR:
 		ret = 4;
 		break;
 	case ULOGD_RET_INT64:
 	case ULOGD_RET_UINT64:
 		ret = 8;
 		break;
+	case ULOGD_RET_IPADDR: // We keep IPv4 addresses in IPv4-in-IPv6
+			       // internally.
 	case ULOGD_RET_IP6ADDR:
 		ret = 16;
 		break;
diff --git a/util/db.c b/util/db.c
index c1d24365239f..7d21a812ab07 100644
--- a/util/db.c
+++ b/util/db.c
@@ -344,6 +344,9 @@ static void __format_query_db(struct ulogd_pluginstance *upi, char *start)
 		}
 
 		switch (res->type) {
+		case ULOGD_RET_BOOL:
+			sprintf(stmt_ins, "'%d',", res->u.value.b);
+			break;
 		case ULOGD_RET_INT8:
 			sprintf(stmt_ins, "%d,", res->u.value.i8);
 			break;
@@ -362,17 +365,24 @@ static void __format_query_db(struct ulogd_pluginstance *upi, char *start)
 		case ULOGD_RET_UINT16:
 			sprintf(stmt_ins, "%u,", res->u.value.ui16);
 			break;
-		case ULOGD_RET_IPADDR:
-			/* fallthrough when logging IP as uint32_t */
 		case ULOGD_RET_UINT32:
 			sprintf(stmt_ins, "%u,", res->u.value.ui32);
 			break;
 		case ULOGD_RET_UINT64:
 			sprintf(stmt_ins, "%" PRIu64 ",", res->u.value.ui64);
 			break;
-		case ULOGD_RET_BOOL:
-			sprintf(stmt_ins, "'%d',", res->u.value.b);
+		case ULOGD_RET_IPADDR: {
+			struct in6_addr ipv6addr;
+
+			memcpy(ipv6addr.s6_addr, res->u.value.ui128,
+			       sizeof(ipv6addr.s6_addr));
+			if (ipv4_in_ipv6(&ipv6addr))
+				sprintf(stmt_ins, "%" PRIu32 ",",
+					ipv6_to_u32(&ipv6addr));
+			else
+				sprintf(stmt_ins, "NULL,");
 			break;
+		}
 		case ULOGD_RET_STRING:
 			*(stmt_ins++) = '\'';
 			if (res->u.value.ptr) {
-- 
2.35.1

