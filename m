Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEF3497EF
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Mar 2021 18:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCYRZt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Mar 2021 13:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCYRZg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:25:36 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7567C06174A
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Mar 2021 10:25:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lPTji-0004qT-DC; Thu, 25 Mar 2021 18:25:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     phil@nwl.cc, Florian Westphal <fw@strlen.de>
Subject: [PATCH 2/8] netfilter: nf_log_arp: merge with nf_log_syslog
Date:   Thu, 25 Mar 2021 18:25:06 +0100
Message-Id: <20210325172512.17729-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210325172512.17729-1-fw@strlen.de>
References: <20210325172512.17729-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

similar to previous change: nf_log_syslog now covers ARP logging
as well, the old nf_log_arp module is removed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/netfilter/Kconfig      |   5 +-
 net/ipv4/netfilter/Makefile     |   3 -
 net/ipv4/netfilter/nf_log_arp.c | 172 --------------------------------
 net/netfilter/nf_log_syslog.c   | 113 ++++++++++++++++++++-
 4 files changed, 115 insertions(+), 178 deletions(-)
 delete mode 100644 net/ipv4/netfilter/nf_log_arp.c

diff --git a/net/ipv4/netfilter/Kconfig b/net/ipv4/netfilter/Kconfig
index aadb98e43fb1..63cb953bd019 100644
--- a/net/ipv4/netfilter/Kconfig
+++ b/net/ipv4/netfilter/Kconfig
@@ -76,7 +76,10 @@ config NF_DUP_IPV4
 config NF_LOG_ARP
 	tristate "ARP packet logging"
 	default m if NETFILTER_ADVANCED=n
-	select NF_LOG_COMMON
+	select NF_LOG_SYSLOG
+	help
+	This is a backwards-compat option for the user's convenience
+	(e.g. when running oldconfig). It selects CONFIG_NF_LOG_SYSLOG.
 
 config NF_LOG_IPV4
 	tristate "IPv4 packet logging"
diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
index abd133048b42..f38fb1368ddb 100644
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -9,9 +9,6 @@ obj-$(CONFIG_NF_DEFRAG_IPV4) += nf_defrag_ipv4.o
 obj-$(CONFIG_NF_SOCKET_IPV4) += nf_socket_ipv4.o
 obj-$(CONFIG_NF_TPROXY_IPV4) += nf_tproxy_ipv4.o
 
-# logging
-obj-$(CONFIG_NF_LOG_ARP) += nf_log_arp.o
-
 # reject
 obj-$(CONFIG_NF_REJECT_IPV4) += nf_reject_ipv4.o
 
diff --git a/net/ipv4/netfilter/nf_log_arp.c b/net/ipv4/netfilter/nf_log_arp.c
deleted file mode 100644
index 136030ad2e54..000000000000
--- a/net/ipv4/netfilter/nf_log_arp.c
+++ /dev/null
@@ -1,172 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * (C) 2014 by Pablo Neira Ayuso <pablo@netfilter.org>
- *
- * Based on code from ebt_log from:
- *
- * Bart De Schuymer <bdschuym@pandora.be>
- * Harald Welte <laforge@netfilter.org>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/skbuff.h>
-#include <linux/if_arp.h>
-#include <linux/ip.h>
-#include <net/route.h>
-
-#include <linux/netfilter.h>
-#include <linux/netfilter/xt_LOG.h>
-#include <net/netfilter/nf_log.h>
-
-static const struct nf_loginfo default_loginfo = {
-	.type	= NF_LOG_TYPE_LOG,
-	.u = {
-		.log = {
-			.level	  = LOGLEVEL_NOTICE,
-			.logflags = NF_LOG_DEFAULT_MASK,
-		},
-	},
-};
-
-struct arppayload {
-	unsigned char mac_src[ETH_ALEN];
-	unsigned char ip_src[4];
-	unsigned char mac_dst[ETH_ALEN];
-	unsigned char ip_dst[4];
-};
-
-static void dump_arp_packet(struct nf_log_buf *m,
-			    const struct nf_loginfo *info,
-			    const struct sk_buff *skb, unsigned int nhoff)
-{
-	const struct arppayload *ap;
-	struct arppayload _arpp;
-	const struct arphdr *ah;
-	unsigned int logflags;
-	struct arphdr _arph;
-
-	ah = skb_header_pointer(skb, 0, sizeof(_arph), &_arph);
-	if (ah == NULL) {
-		nf_log_buf_add(m, "TRUNCATED");
-		return;
-	}
-
-	if (info->type == NF_LOG_TYPE_LOG)
-		logflags = info->u.log.logflags;
-	else
-		logflags = NF_LOG_DEFAULT_MASK;
-
-	if (logflags & NF_LOG_MACDECODE) {
-		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
-			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
-		nf_log_dump_vlan(m, skb);
-		nf_log_buf_add(m, "MACPROTO=%04x ",
-			       ntohs(eth_hdr(skb)->h_proto));
-	}
-
-	nf_log_buf_add(m, "ARP HTYPE=%d PTYPE=0x%04x OPCODE=%d",
-		       ntohs(ah->ar_hrd), ntohs(ah->ar_pro), ntohs(ah->ar_op));
-
-	/* If it's for Ethernet and the lengths are OK, then log the ARP
-	 * payload.
-	 */
-	if (ah->ar_hrd != htons(ARPHRD_ETHER) ||
-	    ah->ar_hln != ETH_ALEN ||
-	    ah->ar_pln != sizeof(__be32))
-		return;
-
-	ap = skb_header_pointer(skb, sizeof(_arph), sizeof(_arpp), &_arpp);
-	if (ap == NULL) {
-		nf_log_buf_add(m, " INCOMPLETE [%zu bytes]",
-			       skb->len - sizeof(_arph));
-		return;
-	}
-	nf_log_buf_add(m, " MACSRC=%pM IPSRC=%pI4 MACDST=%pM IPDST=%pI4",
-		       ap->mac_src, ap->ip_src, ap->mac_dst, ap->ip_dst);
-}
-
-static void nf_log_arp_packet(struct net *net, u_int8_t pf,
-			      unsigned int hooknum, const struct sk_buff *skb,
-			      const struct net_device *in,
-			      const struct net_device *out,
-			      const struct nf_loginfo *loginfo,
-			      const char *prefix)
-{
-	struct nf_log_buf *m;
-
-	/* FIXME: Disabled from containers until syslog ns is supported */
-	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
-		return;
-
-	m = nf_log_buf_open();
-
-	if (!loginfo)
-		loginfo = &default_loginfo;
-
-	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out, loginfo,
-				  prefix);
-	dump_arp_packet(m, loginfo, skb, 0);
-
-	nf_log_buf_close(m);
-}
-
-static struct nf_logger nf_arp_logger __read_mostly = {
-	.name		= "nf_log_arp",
-	.type		= NF_LOG_TYPE_LOG,
-	.logfn		= nf_log_arp_packet,
-	.me		= THIS_MODULE,
-};
-
-static int __net_init nf_log_arp_net_init(struct net *net)
-{
-	return nf_log_set(net, NFPROTO_ARP, &nf_arp_logger);
-}
-
-static void __net_exit nf_log_arp_net_exit(struct net *net)
-{
-	nf_log_unset(net, &nf_arp_logger);
-}
-
-static struct pernet_operations nf_log_arp_net_ops = {
-	.init = nf_log_arp_net_init,
-	.exit = nf_log_arp_net_exit,
-};
-
-static int __init nf_log_arp_init(void)
-{
-	int ret;
-
-	ret = register_pernet_subsys(&nf_log_arp_net_ops);
-	if (ret < 0)
-		return ret;
-
-	ret = nf_log_register(NFPROTO_ARP, &nf_arp_logger);
-	if (ret < 0) {
-		pr_err("failed to register logger\n");
-		goto err1;
-	}
-
-	return 0;
-
-err1:
-	unregister_pernet_subsys(&nf_log_arp_net_ops);
-	return ret;
-}
-
-static void __exit nf_log_arp_exit(void)
-{
-	unregister_pernet_subsys(&nf_log_arp_net_ops);
-	nf_log_unregister(&nf_arp_logger);
-}
-
-module_init(nf_log_arp_init);
-module_exit(nf_log_arp_exit);
-
-MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
-MODULE_DESCRIPTION("Netfilter ARP packet logging");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NF_LOGGER(3, 0);
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index e6fe156e77c7..c01769c6d641 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -31,6 +31,95 @@ static const struct nf_loginfo default_loginfo = {
 	},
 };
 
+struct arppayload {
+	unsigned char mac_src[ETH_ALEN];
+	unsigned char ip_src[4];
+	unsigned char mac_dst[ETH_ALEN];
+	unsigned char ip_dst[4];
+};
+
+static void noinline_for_stack
+dump_arp_packet(struct nf_log_buf *m,
+		const struct nf_loginfo *info,
+		const struct sk_buff *skb, unsigned int nhoff)
+{
+	const struct arppayload *ap;
+	struct arppayload _arpp;
+	const struct arphdr *ah;
+	unsigned int logflags;
+	struct arphdr _arph;
+
+	ah = skb_header_pointer(skb, 0, sizeof(_arph), &_arph);
+	if (!ah) {
+		nf_log_buf_add(m, "TRUNCATED");
+		return;
+	}
+
+	if (info->type == NF_LOG_TYPE_LOG)
+		logflags = info->u.log.logflags;
+	else
+		logflags = NF_LOG_DEFAULT_MASK;
+
+	if (logflags & NF_LOG_MACDECODE) {
+		nf_log_buf_add(m, "MACSRC=%pM MACDST=%pM ",
+			       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest);
+		nf_log_dump_vlan(m, skb);
+		nf_log_buf_add(m, "MACPROTO=%04x ",
+			       ntohs(eth_hdr(skb)->h_proto));
+	}
+
+	nf_log_buf_add(m, "ARP HTYPE=%d PTYPE=0x%04x OPCODE=%d",
+		       ntohs(ah->ar_hrd), ntohs(ah->ar_pro), ntohs(ah->ar_op));
+	/* If it's for Ethernet and the lengths are OK, then log the ARP
+	 * payload.
+	 */
+	if (ah->ar_hrd != htons(ARPHRD_ETHER) ||
+	    ah->ar_hln != ETH_ALEN ||
+	    ah->ar_pln != sizeof(__be32))
+		return;
+
+	ap = skb_header_pointer(skb, sizeof(_arph), sizeof(_arpp), &_arpp);
+	if (!ap) {
+		nf_log_buf_add(m, " INCOMPLETE [%zu bytes]",
+			       skb->len - sizeof(_arph));
+		return;
+	}
+	nf_log_buf_add(m, " MACSRC=%pM IPSRC=%pI4 MACDST=%pM IPDST=%pI4",
+		       ap->mac_src, ap->ip_src, ap->mac_dst, ap->ip_dst);
+}
+
+static void nf_log_arp_packet(struct net *net, u_int8_t pf,
+			      unsigned int hooknum, const struct sk_buff *skb,
+			      const struct net_device *in,
+			      const struct net_device *out,
+			      const struct nf_loginfo *loginfo,
+			      const char *prefix)
+{
+	struct nf_log_buf *m;
+
+	/* FIXME: Disabled from containers until syslog ns is supported */
+	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
+		return;
+
+	m = nf_log_buf_open();
+
+	if (!loginfo)
+		loginfo = &default_loginfo;
+
+	nf_log_dump_packet_common(m, pf, hooknum, skb, in, out, loginfo,
+				  prefix);
+	dump_arp_packet(m, loginfo, skb, 0);
+
+	nf_log_buf_close(m);
+}
+
+static struct nf_logger nf_arp_logger __read_mostly = {
+	.name		= "nf_log_arp",
+	.type		= NF_LOG_TYPE_LOG,
+	.logfn		= nf_log_arp_packet,
+	.me		= THIS_MODULE,
+};
+
 /* One level of recursion won't kill us */
 static noinline_for_stack void
 dump_ipv4_packet(struct net *net, struct nf_log_buf *m,
@@ -343,12 +432,23 @@ static struct nf_logger nf_ip_logger __read_mostly = {
 
 static int __net_init nf_log_syslog_net_init(struct net *net)
 {
-	return nf_log_set(net, NFPROTO_IPV4, &nf_ip_logger);
+	int ret = nf_log_set(net, NFPROTO_IPV4, &nf_ip_logger);
+
+	if (ret)
+		return ret;
+
+	ret = nf_log_set(net, NFPROTO_ARP, &nf_arp_logger);
+	if (ret)
+		goto err1;
+err1:
+	nf_log_unset(net, &nf_arp_logger);
+	return ret;
 }
 
 static void __net_exit nf_log_syslog_net_exit(struct net *net)
 {
 	nf_log_unset(net, &nf_ip_logger);
+	nf_log_unset(net, &nf_arp_logger);
 }
 
 static struct pernet_operations nf_log_syslog_net_ops = {
@@ -368,9 +468,15 @@ static int __init nf_log_syslog_init(void)
 	if (ret < 0)
 		goto err1;
 
-	return 0;
+	ret = nf_log_register(NFPROTO_ARP, &nf_arp_logger);
+	if (ret < 0)
+		goto err2;
 
+	return 0;
+err2:
+	nf_log_unregister(&nf_arp_logger);
 err1:
+	pr_err("failed to register logger\n");
 	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 	return ret;
 }
@@ -379,6 +485,7 @@ static void __exit nf_log_syslog_exit(void)
 {
 	unregister_pernet_subsys(&nf_log_syslog_net_ops);
 	nf_log_unregister(&nf_ip_logger);
+	nf_log_unregister(&nf_arp_logger);
 }
 
 module_init(nf_log_syslog_init);
@@ -387,5 +494,7 @@ module_exit(nf_log_syslog_exit);
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
 MODULE_DESCRIPTION("Netfilter syslog packet logging");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("nf_log_arp");
 MODULE_ALIAS("nf_log_ipv4");
 MODULE_ALIAS_NF_LOGGER(AF_INET, 0);
+MODULE_ALIAS_NF_LOGGER(3, 0);
-- 
2.26.3

