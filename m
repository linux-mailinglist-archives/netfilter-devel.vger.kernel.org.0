Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537932AE7C
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Mar 2021 03:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhCBXh0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Mar 2021 18:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384529AbhCBPFT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:19 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EDBC061794
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Mar 2021 06:30:26 -0800 (PST)
Received: from localhost ([::1]:36450 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lH62a-0003RV-P0; Tue, 02 Mar 2021 15:30:24 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/2] xtables-translate: Fix translation of odd netmasks
Date:   Tue,  2 Mar 2021 15:30:09 +0100
Message-Id: <20210302143010.3362-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Iptables supports netmasks which are not prefixes to match on (or
ignore) arbitrary bits in an address. Yet nftables' prefix notation is
available for real prefixes only, so translation is not as trivial -
print bitmask syntax for those cases.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/generic.txlate   | 48 +++++++++++++++++++++++++++++++++++++
 extensions/libxt_standard.t | 12 ++++++++++
 iptables/nft-ipv4.c         | 42 ++++++++++++++++++++++----------
 iptables/nft-ipv6.c         | 19 ++++++++++++---
 4 files changed, 106 insertions(+), 15 deletions(-)

diff --git a/extensions/generic.txlate b/extensions/generic.txlate
index 0e256c3727559..9ae9a5b54c1b9 100644
--- a/extensions/generic.txlate
+++ b/extensions/generic.txlate
@@ -10,6 +10,54 @@ nft insert rule ip filter INPUT iifname "iifname" ip saddr 10.0.0.0/8 counter
 iptables-translate -A INPUT -i iif+ ! -d 10.0.0.0/8
 nft add rule ip filter INPUT iifname "iif*" ip daddr != 10.0.0.0/8 counter
 
+iptables-translate -I INPUT -s 10.11.12.13/255.255.0.0
+nft insert rule ip filter INPUT ip saddr 10.11.0.0/16 counter
+
+iptables-translate -I INPUT -s 10.11.12.13/255.0.255.0
+nft insert rule ip filter INPUT ip saddr & 255.0.255.0 == 10.0.12.0 counter
+
+iptables-translate -I INPUT -s 10.11.12.13/0.255.0.255
+nft insert rule ip filter INPUT ip saddr & 0.255.0.255 == 0.11.0.13 counter
+
+iptables-translate -I INPUT ! -s 10.11.12.13/0.255.0.255
+nft insert rule ip filter INPUT ip saddr & 0.255.0.255 != 0.11.0.13 counter
+
+iptables-translate -I INPUT -s 0.0.0.0/16
+nft insert rule ip filter INPUT ip saddr 0.0.0.0/16 counter
+
+iptables-translate -I INPUT -s 0.0.0.0/0
+nft insert rule ip filter INPUT counter
+
+iptables-translate -I INPUT ! -s 0.0.0.0/0
+nft insert rule ip filter INPUT ip saddr != 0.0.0.0/0 counter
+
+ip6tables-translate -I INPUT -i iifname -s feed::/16
+nft insert rule ip6 filter INPUT iifname "iifname" ip6 saddr feed::/16 counter
+
+ip6tables-translate -A INPUT -i iif+ ! -d feed::/16
+nft add rule ip6 filter INPUT iifname "iif*" ip6 daddr != feed::/16 counter
+
+ip6tables-translate -I INPUT -s feed:babe::1/ffff:ff00::
+nft insert rule ip6 filter INPUT ip6 saddr feed:ba00::/24 counter
+
+ip6tables-translate -I INPUT -s feed:babe:c0ff:ee00:c0be:1234:5678:90ab/ffff:0:ffff:0:ffff:0:ffff:0
+nft insert rule ip6 filter INPUT ip6 saddr & ffff:0:ffff:0:ffff:0:ffff:0 == feed:0:c0ff:0:c0be:0:5678:0 counter
+
+ip6tables-translate -I INPUT -s feed:babe:c0ff:ee00:c0be:1234:5678:90ab/0:ffff:0:ffff:0:ffff:0:ffff
+nft insert rule ip6 filter INPUT ip6 saddr & 0:ffff:0:ffff:0:ffff:0:ffff == 0:babe:0:ee00:0:1234:0:90ab counter
+
+ip6tables-translate -I INPUT ! -s feed:babe:c0ff:ee00:c0be:1234:5678:90ab/0:ffff:0:ffff:0:ffff:0:ffff
+nft insert rule ip6 filter INPUT ip6 saddr & 0:ffff:0:ffff:0:ffff:0:ffff != 0:babe:0:ee00:0:1234:0:90ab counter
+
+ip6tables-translate -I INPUT -s ::/16
+nft insert rule ip6 filter INPUT ip6 saddr ::/16 counter
+
+ip6tables-translate -I INPUT -s ::/0
+nft insert rule ip6 filter INPUT counter
+
+ip6tables-translate -I INPUT ! -s ::/0
+nft insert rule ip6 filter INPUT ip6 saddr != ::/0 counter
+
 ebtables-translate -I INPUT -i iname --logical-in ilogname -s 0:0:0:0:0:0
 nft insert rule bridge filter INPUT iifname "iname" meta ibrname "ilogname" ether saddr 00:00:00:00:00:00 counter
 
diff --git a/extensions/libxt_standard.t b/extensions/libxt_standard.t
index 4313f7b7bac9d..56d6da2e5884e 100644
--- a/extensions/libxt_standard.t
+++ b/extensions/libxt_standard.t
@@ -9,3 +9,15 @@
 -j ACCEPT;=;OK
 -j RETURN;=;OK
 ! -p 0 -j ACCEPT;=;FAIL
+-s 10.11.12.13/8;-s 10.0.0.0/8;OK
+-s 10.11.12.13/9;-s 10.0.0.0/9;OK
+-s 10.11.12.13/10;-s 10.0.0.0/10;OK
+-s 10.11.12.13/11;-s 10.0.0.0/11;OK
+-s 10.11.12.13/12;-s 10.0.0.0/12;OK
+-s 10.11.12.13/30;-s 10.11.12.12/30;OK
+-s 10.11.12.13/31;-s 10.11.12.12/31;OK
+-s 10.11.12.13/32;-s 10.11.12.13/32;OK
+-s 10.11.12.13/255.0.0.0;-s 10.0.0.0/8;OK
+-s 10.11.12.13/255.128.0.0;-s 10.0.0.0/9;OK
+-s 10.11.12.13/255.0.255.0;-s 10.0.12.0/255.0.255.0;OK
+-s 10.11.12.13/255.0.12.0;-s 10.0.12.0/255.0.12.0;OK
diff --git a/iptables/nft-ipv4.c b/iptables/nft-ipv4.c
index fdc15c6f04066..0d32a30010519 100644
--- a/iptables/nft-ipv4.c
+++ b/iptables/nft-ipv4.c
@@ -383,6 +383,32 @@ static void nft_ipv4_post_parse(int command,
 			      " source or destination IP addresses");
 }
 
+static void xlate_ipv4_addr(const char *selector, const struct in_addr *addr,
+			    const struct in_addr *mask,
+			    bool inv, struct xt_xlate *xl)
+{
+	const char *op = inv ? "!= " : "";
+	int cidr;
+
+	if (!inv && !addr->s_addr && !mask->s_addr)
+		return;
+
+	cidr = xtables_ipmask_to_cidr(mask);
+	switch (cidr) {
+	case -1:
+		/* inet_ntoa() is not reentrant */
+		xt_xlate_add(xl, "%s & %s ", selector, inet_ntoa(*mask));
+		xt_xlate_add(xl, "%s %s ", inv ? "!=" : "==", inet_ntoa(*addr));
+		break;
+	case 32:
+		xt_xlate_add(xl, "%s %s%s ", selector, op, inet_ntoa(*addr));
+		break;
+	default:
+		xt_xlate_add(xl, "%s %s%s/%d ", selector, op, inet_ntoa(*addr),
+			     cidr);
+	}
+}
+
 static int nft_ipv4_xlate(const void *data, struct xt_xlate *xl)
 {
 	const struct iptables_command_state *cs = data;
@@ -417,18 +443,10 @@ static int nft_ipv4_xlate(const void *data, struct xt_xlate *xl)
 		}
 	}
 
-	if (cs->fw.ip.src.s_addr != 0) {
-		xt_xlate_add(xl, "ip saddr %s%s%s ",
-			   cs->fw.ip.invflags & IPT_INV_SRCIP ? "!= " : "",
-			   inet_ntoa(cs->fw.ip.src),
-			   xtables_ipmask_to_numeric(&cs->fw.ip.smsk));
-	}
-	if (cs->fw.ip.dst.s_addr != 0) {
-		xt_xlate_add(xl, "ip daddr %s%s%s ",
-			   cs->fw.ip.invflags & IPT_INV_DSTIP ? "!= " : "",
-			   inet_ntoa(cs->fw.ip.dst),
-			   xtables_ipmask_to_numeric(&cs->fw.ip.dmsk));
-	}
+	xlate_ipv4_addr("ip saddr", &cs->fw.ip.src, &cs->fw.ip.smsk,
+			cs->fw.ip.invflags & IPT_INV_SRCIP, xl);
+	xlate_ipv4_addr("ip daddr", &cs->fw.ip.dst, &cs->fw.ip.dmsk,
+			cs->fw.ip.invflags & IPT_INV_DSTIP, xl);
 
 	ret = xlate_matches(cs, xl);
 	if (!ret)
diff --git a/iptables/nft-ipv6.c b/iptables/nft-ipv6.c
index 130ad3e6e7c44..46008fc5e762a 100644
--- a/iptables/nft-ipv6.c
+++ b/iptables/nft-ipv6.c
@@ -337,14 +337,27 @@ static void xlate_ipv6_addr(const char *selector, const struct in6_addr *addr,
 			    const struct in6_addr *mask,
 			    int invert, struct xt_xlate *xl)
 {
+	const char *op = invert ? "!= " : "";
 	char addr_str[INET6_ADDRSTRLEN];
+	int cidr;
 
-	if (!invert && IN6_IS_ADDR_UNSPECIFIED(addr))
+	if (!invert && IN6_IS_ADDR_UNSPECIFIED(addr) && IN6_IS_ADDR_UNSPECIFIED(mask))
 		return;
 
 	inet_ntop(AF_INET6, addr, addr_str, INET6_ADDRSTRLEN);
-	xt_xlate_add(xl, "%s %s%s%s ", selector, invert ? "!= " : "", addr_str,
-			xtables_ip6mask_to_numeric(mask));
+	cidr = xtables_ip6mask_to_cidr(mask);
+	switch (cidr) {
+	case -1:
+		xt_xlate_add(xl, "%s & %s %s %s ", selector,
+			     xtables_ip6addr_to_numeric(mask),
+			     invert ? "!=" : "==", addr_str);
+		break;
+	case 128:
+		xt_xlate_add(xl, "%s %s%s ", selector, op, addr_str);
+		break;
+	default:
+		xt_xlate_add(xl, "%s %s%s/%d ", selector, op, addr_str, cidr);
+	}
 }
 
 static int nft_ipv6_xlate(const void *data, struct xt_xlate *xl)
-- 
2.28.0

