Return-Path: <netfilter-devel+bounces-7336-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AADDAC4365
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 May 2025 19:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B75D17652B
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 May 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9123E320;
	Mon, 26 May 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="cxAfC3go"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azazel.net (taras.nevrast.org [35.176.194.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D37483
	for <netfilter-devel@vger.kernel.org>; Mon, 26 May 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.176.194.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279993; cv=none; b=fx2duDtQhDEywBUQkGI4oO9es0IrOyyEBhAgLjerxr2OxT7vdtlfhPx+TssADtVoeXMLBNerl6Hc0aSLy/ADcGyZvb6XA8YPXkh0MxZ5X2bxdu64yq6/g0/oCugSuf4aWcPQqYjBK7RbimgGkQnHOMCqMcl9waaUfCE9KG+k9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279993; c=relaxed/simple;
	bh=s2e2m4gyc0y+GKmsPpTIKC3WC3wE4iiSWJ0mPNdFurM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZKMjUxMQR+ODLBKCUIhXzFX9GJ3Y+IdQmQilJFA8giACUX+DhBPPtT4WP/86fRsylPhzYt6qqqwDfrb1/G4P6ALr+tEcSS4ZFjFEfKmC7dqWj0Amoj/DNlf26E/MN3Z255tu5K3l2SoZ1STpyaq1wyiDtD7PajCflU+Z0LDFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=azazel.net; spf=pass smtp.mailfrom=azazel.net; dkim=pass (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b=cxAfC3go; arc=none smtp.client-ip=35.176.194.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=azazel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azazel.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
	s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Xxb3pTXQy5bynke0jlOQqWbZ1SIi9W5BlDQJwLMHgd4=; b=cxAfC3goIRY0yr+dtRhz/nYd1/
	yjAIY3YEEi9g6hUUz1CMDjbb8WlI0Q9wf/q7gacqH2+0R3NC7j3wwJlOxzdcaPuZwyGMTkFB9BIXB
	L9iSCATq5aEXfutwXMIJuZlXb3JAS+3Qao//swCJTUa3pEF+4Z7wgel/40pSLOlfQ9ZYsmD/7nYDW
	vdwCVi7mVbaOuU++gtP20VFDtxZDLUuSpXolhNODkESfvoMACLzYuPolv6tvtgGDy9+eq/lb116YQ
	WpnsKSXRu51wCoBpM72F9O43DdHOcg0jIpXphtgjpFg9Fu3NZ0/g3c6Ehbiebi0cimShbRvGfJvRK
	23p8jUjw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
	by taras.nevrast.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jeremy@azazel.net>)
	id 1uJbUK-000rKJ-1g;
	Mon, 26 May 2025 18:19:48 +0100
From: Jeremy Sowden <jeremy@azazel.net>
To: Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc: Slavko <linux@slavino.sk>
Subject: [PATCH ulogd2 v2 3/4] Use `NFPROTO_*` constants for protocol families
Date: Mon, 26 May 2025 18:19:03 +0100
Message-ID: <20250526171904.1733009-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250526171904.1733009-1-jeremy@azazel.net>
References: <20250526171904.1733009-1-jeremy@azazel.net>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on taras.nevrast.org); SAEximRunCond expanded to false

Netfilter has a set of `NFPROTO_*` constants for the protocol families that it
supports, in part because it supports protocols and pseudo-protocols that do not
have `PF_*` (and `AF_*`) constants.  Currently, ulogd uses `AF_*` constants for
protocol families, because it does not support any families which do not have
`AF_*` constants.  Switch to `NFPROTO_*` constants instead, so we can add ARP
support later.

In the IP2* filters, retain `AF_*` for address family variables.

Remove a stray semicolon.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 filter/raw2packet/ulogd_raw2packet_BASE.c |  9 +++++----
 filter/ulogd_filter_IP2BIN.c              | 17 ++++++++++-------
 filter/ulogd_filter_IP2HBIN.c             | 17 ++++++++++-------
 filter/ulogd_filter_IP2STR.c              | 17 ++++++++++-------
 input/flow/ulogd_inpflow_NFCT.c           | 23 ++++++++++++-----------
 input/packet/ulogd_inppkt_UNIXSOCK.c      |  7 ++++---
 util/printpkt.c                           |  7 ++++---
 7 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/filter/raw2packet/ulogd_raw2packet_BASE.c b/filter/raw2packet/ulogd_raw2packet_BASE.c
index 09e931349acf..4b6096421b71 100644
--- a/filter/raw2packet/ulogd_raw2packet_BASE.c
+++ b/filter/raw2packet/ulogd_raw2packet_BASE.c
@@ -44,6 +44,7 @@
 #include <ulogd/ipfix_protocol.h>
 #include <netinet/if_ether.h>
 #include <string.h>
+#include <linux/netfilter.h>
 #include <linux/types.h>
 
 enum input_keys {
@@ -937,7 +938,7 @@ static int _interp_bridge(struct ulogd_pluginstance *pi, uint32_t len)
 		_interp_arp(pi, len);
 		break;
 	/* ETH_P_8021Q ?? others? */
-	};
+	}
 
 	return ULOGD_IRET_OK;
 }
@@ -953,11 +954,11 @@ static int _interp_pkt(struct ulogd_pluginstance *pi)
 		     ikey_get_u16(&pi->input.keys[INKEY_OOB_PROTOCOL]));
 
 	switch (family) {
-	case AF_INET:
+	case NFPROTO_IPV4:
 		return _interp_iphdr(pi, len);
-	case AF_INET6:
+	case NFPROTO_IPV6:
 		return _interp_ipv6hdr(pi, len);
-	case AF_BRIDGE:
+	case NFPROTO_BRIDGE:
 		return _interp_bridge(pi, len);
 	}
 	return ULOGD_IRET_OK;
diff --git a/filter/ulogd_filter_IP2BIN.c b/filter/ulogd_filter_IP2BIN.c
index 2667a2a7f717..9bbeebbb711e 100644
--- a/filter/ulogd_filter_IP2BIN.c
+++ b/filter/ulogd_filter_IP2BIN.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <arpa/inet.h>
+#include <linux/netfilter.h>
 #include <ulogd/ulogd.h>
 #include <netinet/if_ether.h>
 
@@ -145,14 +146,16 @@ static int interp_ip2bin(struct ulogd_pluginstance *pi)
 	proto_family = ikey_get_u8(&inp[KEY_OOB_FAMILY]);
 
 	switch (proto_family) {
-	case AF_INET6:
-	case AF_INET:
-		addr_family = proto_family;
+	case NFPROTO_IPV6:
+		addr_family = AF_INET6;
+		break;
+	case NFPROTO_IPV4:
+		addr_family = AF_INET;
 		break;
-	case AF_BRIDGE:
+	case NFPROTO_BRIDGE:
 		if (!pp_is_valid(inp, KEY_OOB_PROTOCOL)) {
 			ulogd_log(ULOGD_NOTICE,
-				  "No protocol inside AF_BRIDGE packet\n");
+				  "No protocol inside NFPROTO_BRIDGE packet\n");
 			return ULOGD_IRET_ERR;
 		}
 		switch (ikey_get_u16(&inp[KEY_OOB_PROTOCOL])) {
@@ -165,13 +168,13 @@ static int interp_ip2bin(struct ulogd_pluginstance *pi)
 			break;
 		default:
 			ulogd_log(ULOGD_NOTICE,
-				  "Unknown protocol inside AF_BRIDGE packet\n");
+				  "Unexpected protocol inside NFPROTO_BRIDGE packet\n");
 			return ULOGD_IRET_ERR;
 		}
 		break;
 	default:
 		/* TODO handle error */
-		ulogd_log(ULOGD_NOTICE, "Unknown protocol family\n");
+		ulogd_log(ULOGD_NOTICE, "Unexpected protocol family\n");
 		return ULOGD_IRET_ERR;
 	}
 
diff --git a/filter/ulogd_filter_IP2HBIN.c b/filter/ulogd_filter_IP2HBIN.c
index 42ffc9497584..081b757a6f1a 100644
--- a/filter/ulogd_filter_IP2HBIN.c
+++ b/filter/ulogd_filter_IP2HBIN.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <arpa/inet.h>
+#include <linux/netfilter.h>
 #include <ulogd/ulogd.h>
 #include <netinet/if_ether.h>
 
@@ -135,14 +136,16 @@ static int interp_ip2hbin(struct ulogd_pluginstance *pi)
 	proto_family = ikey_get_u8(&inp[KEY_OOB_FAMILY]);
 
 	switch (proto_family) {
-	case AF_INET6:
-	case AF_INET:
-		addr_family = proto_family;
+	case NFPROTO_IPV6:
+		addr_family = AF_INET6;
+		break;
+	case NFPROTO_IPV4:
+		addr_family = AF_INET;
 		break;
-	case AF_BRIDGE:
+	case NFPROTO_BRIDGE:
 		if (!pp_is_valid(inp, KEY_OOB_PROTOCOL)) {
 			ulogd_log(ULOGD_NOTICE,
-				  "No protocol inside AF_BRIDGE packet\n");
+				  "No protocol inside NFPROTO_BRIDGE packet\n");
 			return ULOGD_IRET_ERR;
 		}
 		switch (ikey_get_u16(&inp[KEY_OOB_PROTOCOL])) {
@@ -155,13 +158,13 @@ static int interp_ip2hbin(struct ulogd_pluginstance *pi)
 			break;
 		default:
 			ulogd_log(ULOGD_NOTICE,
-				  "Unknown protocol inside AF_BRIDGE packet\n");
+				  "Unexpected protocol inside NFPROTO_BRIDGE packet\n");
 			return ULOGD_IRET_ERR;
 		}
 		break;
 	default:
 		/* TODO handle error */
-		ulogd_log(ULOGD_NOTICE, "Unknown protocol family\n");
+		ulogd_log(ULOGD_NOTICE, "Unexpected protocol family\n");
 		return ULOGD_IRET_ERR;
 	}
 
diff --git a/filter/ulogd_filter_IP2STR.c b/filter/ulogd_filter_IP2STR.c
index 194a8b103272..3d4d6e9dc897 100644
--- a/filter/ulogd_filter_IP2STR.c
+++ b/filter/ulogd_filter_IP2STR.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <arpa/inet.h>
+#include <linux/netfilter.h>
 #include <ulogd/ulogd.h>
 #include <netinet/if_ether.h>
 
@@ -170,14 +171,16 @@ static int interp_ip2str(struct ulogd_pluginstance *pi)
 	proto_family = ikey_get_u8(&inp[KEY_OOB_FAMILY]);
 
 	switch (proto_family) {
-	case AF_INET6:
-	case AF_INET:
-		addr_family = proto_family;
+	case NFPROTO_IPV6:
+		addr_family = AF_INET6;
+		break;
+	case NFPROTO_IPV4:
+		addr_family = AF_INET;
 		break;
-	case AF_BRIDGE:
+	case NFPROTO_BRIDGE:
 		if (!pp_is_valid(inp, KEY_OOB_PROTOCOL)) {
 			ulogd_log(ULOGD_NOTICE,
-				  "No protocol inside AF_BRIDGE packet\n");
+				  "No protocol inside NFPROTO_BRIDGE packet\n");
 			return ULOGD_IRET_ERR;
 		}
 		switch (ikey_get_u16(&inp[KEY_OOB_PROTOCOL])) {
@@ -190,13 +193,13 @@ static int interp_ip2str(struct ulogd_pluginstance *pi)
 			break;
 		default:
 			ulogd_log(ULOGD_NOTICE,
-				  "Unknown protocol inside AF_BRIDGE packet\n");
+				  "Unexpected protocol inside NFPROTO_BRIDGE packet\n");
 			return ULOGD_IRET_ERR;
 		}
 		break;
 	default:
 		/* TODO error handling */
-		ulogd_log(ULOGD_NOTICE, "Unknown protocol family\n");
+		ulogd_log(ULOGD_NOTICE, "Unexpected protocol family\n");
 		return ULOGD_IRET_ERR;
 	}
 
diff --git a/input/flow/ulogd_inpflow_NFCT.c b/input/flow/ulogd_inpflow_NFCT.c
index 8746b881a3ab..82dc83a8a440 100644
--- a/input/flow/ulogd_inpflow_NFCT.c
+++ b/input/flow/ulogd_inpflow_NFCT.c
@@ -48,6 +48,7 @@
 #include <ulogd/namespace.h>
 
 #include <libnetfilter_conntrack/libnetfilter_conntrack.h>
+#include <linux/netfilter.h>
 
 #ifndef NSEC_PER_SEC
 #define NSEC_PER_SEC    1000000000L
@@ -491,14 +492,14 @@ static uint32_t hash(const void *data, const struct hashtable *table)
 	const struct nf_conntrack *ct = data;
 
 	switch(nfct_get_attr_u8(ct, ATTR_L3PROTO)) {
-		case AF_INET:
-			ret = __hash4(ct, table);
-			break;
-		case AF_INET6:
-			ret = __hash6(ct, table);
-			break;
-		default:
-			break;
+	case NFPROTO_IPV4:
+		ret = __hash4(ct, table);
+		break;
+	case NFPROTO_IPV6:
+		ret = __hash6(ct, table);
+		break;
+	default:
+		break;
 	}
 
 	return ret;
@@ -528,7 +529,7 @@ static int propagate_ct(struct ulogd_pluginstance *main_upi,
 	okey_set_u8(&ret[NFCT_OOB_PROTOCOL], 0); /* FIXME */
 
 	switch (nfct_get_attr_u8(ct, ATTR_L3PROTO)) {
-	case AF_INET:
+	case NFPROTO_IPV4:
 		okey_set_u32(&ret[NFCT_ORIG_IP_SADDR],
 			     nfct_get_attr_u32(ct, ATTR_ORIG_IPV4_SRC));
 		okey_set_u32(&ret[NFCT_ORIG_IP_DADDR],
@@ -538,7 +539,7 @@ static int propagate_ct(struct ulogd_pluginstance *main_upi,
 		okey_set_u32(&ret[NFCT_REPLY_IP_DADDR],
 			     nfct_get_attr_u32(ct, ATTR_REPL_IPV4_DST));
 		break;
-	case AF_INET6:
+	case NFPROTO_IPV6:
 		okey_set_u128(&ret[NFCT_ORIG_IP_SADDR],
 			      nfct_get_attr(ct, ATTR_ORIG_IPV6_SRC));
 		okey_set_u128(&ret[NFCT_ORIG_IP_DADDR],
@@ -549,7 +550,7 @@ static int propagate_ct(struct ulogd_pluginstance *main_upi,
 			      nfct_get_attr(ct, ATTR_REPL_IPV6_DST));
 		break;
 	default:
-		ulogd_log(ULOGD_NOTICE, "Unknown protocol family (%d)\n",
+		ulogd_log(ULOGD_NOTICE, "Unexpected protocol family (%d)\n",
 			  nfct_get_attr_u8(ct, ATTR_L3PROTO));
 	}
 	okey_set_u8(&ret[NFCT_ORIG_IP_PROTOCOL],
diff --git a/input/packet/ulogd_inppkt_UNIXSOCK.c b/input/packet/ulogd_inppkt_UNIXSOCK.c
index 0d9ba60768cc..bed5ccc6940f 100644
--- a/input/packet/ulogd_inppkt_UNIXSOCK.c
+++ b/input/packet/ulogd_inppkt_UNIXSOCK.c
@@ -32,6 +32,7 @@
 #include <pwd.h>
 #include <grp.h>
 #include <errno.h>
+#include <linux/netfilter.h>
 
 #include <ulogd/ulogd.h>
 
@@ -388,11 +389,11 @@ static int handle_packet(struct ulogd_pluginstance *upi, struct ulogd_unixsock_p
 	payload_len = ntohs(pkt->payload_length);
 
 	if (ip_version == 4)
-		oob_family = AF_INET;
+		oob_family = NFPROTO_IPV4;
 	else if (ip_version == 6)
-		oob_family = AF_INET6;
+		oob_family = NFPROTO_IPV6;
 	else
-		oob_family = 0;
+		oob_family = NFPROTO_UNSPEC;
 
 	okey_set_u8(&ret[UNIXSOCK_KEY_OOB_FAMILY], oob_family);
 	okey_set_ptr(&ret[UNIXSOCK_KEY_RAW_PCKT], &pkt->payload);
diff --git a/util/printpkt.c b/util/printpkt.c
index 09a219417f91..2fecd50e233c 100644
--- a/util/printpkt.c
+++ b/util/printpkt.c
@@ -35,6 +35,7 @@
 #include <ulogd/conffile.h>
 #include <ulogd/printpkt.h>
 #include <netinet/if_ether.h>
+#include <linux/netfilter.h>
 
 struct ulogd_key printpkt_keys[] = {
 	[KEY_OOB_FAMILY]	= { .name = "oob.family", },
@@ -457,13 +458,13 @@ int printpkt_print(struct ulogd_key *res, char *buf)
 		buf_cur += sprintf(buf_cur, "MAC= ");
 
 	switch (ikey_get_u8(&res[KEY_OOB_FAMILY])) {
-	case AF_INET:
+	case NFPROTO_IPV4:
 		buf_cur += printpkt_ipv4(res, buf_cur);
 		break;
-	case AF_INET6:
+	case NFPROTO_IPV6:
 		buf_cur += printpkt_ipv6(res, buf_cur);
 		break;
-	case AF_BRIDGE:
+	case NFPROTO_BRIDGE:
 		buf_cur += printpkt_bridge(res, buf_cur);
 		break;
 	}
-- 
2.47.2


