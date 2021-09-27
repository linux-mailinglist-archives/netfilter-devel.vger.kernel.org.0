Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C87419724
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Sep 2021 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhI0PFy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Sep 2021 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhI0PFy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:05:54 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D990C061575
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Sep 2021 08:04:16 -0700 (PDT)
Received: from localhost ([::1]:43544 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mUsAw-0005i5-Nh; Mon, 27 Sep 2021 17:04:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 01/12] nft: Introduce builtin_tables_lookup()
Date:   Mon, 27 Sep 2021 17:03:05 +0200
Message-Id: <20210927150316.11516-2-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927150316.11516-1-phil@nwl.cc>
References: <20210927150316.11516-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The set of builtin tables to use is fully determined by the given family
so just look it up instead of having callers pass it explicitly.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c                | 19 +++++++++++++++++--
 iptables/nft.h                |  2 +-
 iptables/xtables-arp.c        |  2 +-
 iptables/xtables-eb.c         |  2 +-
 iptables/xtables-monitor.c    |  2 +-
 iptables/xtables-restore.c    |  7 +------
 iptables/xtables-save.c       |  6 +-----
 iptables/xtables-standalone.c |  2 +-
 iptables/xtables-translate.c  |  7 +------
 9 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index dc1f5160eb983..1d3f3a3da1cbb 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -863,7 +863,22 @@ int nft_restart(struct nft_handle *h)
 	return 0;
 }
 
-int nft_init(struct nft_handle *h, int family, const struct builtin_table *t)
+static const struct builtin_table *builtin_tables_lookup(int family)
+{
+	switch (family) {
+	case AF_INET:
+	case AF_INET6:
+		return xtables_ipv4;
+	case NFPROTO_ARP:
+		return xtables_arp;
+	case NFPROTO_BRIDGE:
+		return xtables_bridge;
+	default:
+		return NULL;
+	}
+}
+
+int nft_init(struct nft_handle *h, int family)
 {
 	memset(h, 0, sizeof(*h));
 
@@ -881,7 +896,7 @@ int nft_init(struct nft_handle *h, int family, const struct builtin_table *t)
 		xtables_error(PARAMETER_PROBLEM, "Unknown family");
 
 	h->portid = mnl_socket_get_portid(h->nl);
-	h->tables = t;
+	h->tables = builtin_tables_lookup(family);
 	h->cache = &h->__cache[0];
 	h->family = family;
 
diff --git a/iptables/nft.h b/iptables/nft.h
index ef79b018f7836..f189b03fbc6b9 100644
--- a/iptables/nft.h
+++ b/iptables/nft.h
@@ -123,7 +123,7 @@ extern const struct builtin_table xtables_bridge[NFT_TABLE_MAX];
 int mnl_talk(struct nft_handle *h, struct nlmsghdr *nlh,
 	     int (*cb)(const struct nlmsghdr *nlh, void *data),
 	     void *data);
-int nft_init(struct nft_handle *h, int family, const struct builtin_table *t);
+int nft_init(struct nft_handle *h, int family);
 void nft_fini(struct nft_handle *h);
 int nft_restart(struct nft_handle *h);
 
diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 9a079f06b948a..1d132bdf23546 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -397,7 +397,7 @@ int nft_init_arp(struct nft_handle *h, const char *pname)
 	init_extensionsa();
 #endif
 
-	if (nft_init(h, NFPROTO_ARP, xtables_arp) < 0)
+	if (nft_init(h, NFPROTO_ARP) < 0)
 		xtables_error(OTHER_PROBLEM,
 			      "Could not initialize nftables layer.");
 
diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index 23023ce13e4b8..1ed6bcd8a7877 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -672,7 +672,7 @@ int nft_init_eb(struct nft_handle *h, const char *pname)
 	init_extensionsb();
 #endif
 
-	if (nft_init(h, NFPROTO_BRIDGE, xtables_bridge) < 0)
+	if (nft_init(h, NFPROTO_BRIDGE) < 0)
 		xtables_error(OTHER_PROBLEM,
 			      "Could not initialize nftables layer.");
 
diff --git a/iptables/xtables-monitor.c b/iptables/xtables-monitor.c
index 21d4bec08fd9a..73dc80c24d722 100644
--- a/iptables/xtables-monitor.c
+++ b/iptables/xtables-monitor.c
@@ -631,7 +631,7 @@ int xtables_monitor_main(int argc, char *argv[])
 	init_extensions6();
 #endif
 
-	if (nft_init(&h, AF_INET, xtables_ipv4)) {
+	if (nft_init(&h, AF_INET)) {
 		fprintf(stderr, "%s/%s Failed to initialize nft: %s\n",
 			xtables_globals.program_name,
 			xtables_globals.program_version,
diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index 72832103d6bc3..86dcede395e07 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -281,7 +281,6 @@ void xtables_restore_parse(struct nft_handle *h,
 static int
 xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 {
-	const struct builtin_table *tables;
 	struct nft_xt_restore_parse p = {
 		.commit = true,
 		.cb = &restore_cb,
@@ -360,7 +359,6 @@ xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 	switch (family) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6: /* fallthough, same table */
-		tables = xtables_ipv4;
 #if defined(ALL_INCLUSIVE) || defined(NO_SHARED_LIBS)
 		init_extensions();
 		init_extensions4();
@@ -368,17 +366,14 @@ xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 #endif
 		break;
 	case NFPROTO_ARP:
-		tables = xtables_arp;
-		break;
 	case NFPROTO_BRIDGE:
-		tables = xtables_bridge;
 		break;
 	default:
 		fprintf(stderr, "Unknown family %d\n", family);
 		return 1;
 	}
 
-	if (nft_init(&h, family, tables) < 0) {
+	if (nft_init(&h, family) < 0) {
 		fprintf(stderr, "%s/%s Failed to initialize nft: %s\n",
 				xtables_globals.program_name,
 				xtables_globals.program_version,
diff --git a/iptables/xtables-save.c b/iptables/xtables-save.c
index f794e3ff1e318..c6ebb0ec94c4f 100644
--- a/iptables/xtables-save.c
+++ b/iptables/xtables-save.c
@@ -131,7 +131,6 @@ static int
 xtables_save_main(int family, int argc, char *argv[],
 		  const char *optstring, const struct option *longopts)
 {
-	const struct builtin_table *tables;
 	const char *tablename = NULL;
 	struct do_output_data d = {
 		.format = FMT_NOCOUNTS,
@@ -208,11 +207,9 @@ xtables_save_main(int family, int argc, char *argv[],
 		init_extensions4();
 		init_extensions6();
 #endif
-		tables = xtables_ipv4;
 		d.commit = true;
 		break;
 	case NFPROTO_ARP:
-		tables = xtables_arp;
 		break;
 	case NFPROTO_BRIDGE: {
 		const char *ctr = getenv("EBTABLES_SAVE_COUNTER");
@@ -223,7 +220,6 @@ xtables_save_main(int family, int argc, char *argv[],
 			d.format &= ~FMT_NOCOUNTS;
 			d.format |= FMT_C_COUNTS | FMT_EBT_SAVE;
 		}
-		tables = xtables_bridge;
 		break;
 	}
 	default:
@@ -231,7 +227,7 @@ xtables_save_main(int family, int argc, char *argv[],
 		return 1;
 	}
 
-	if (nft_init(&h, family, tables) < 0) {
+	if (nft_init(&h, family) < 0) {
 		fprintf(stderr, "%s/%s Failed to initialize nft: %s\n",
 				xtables_globals.program_name,
 				xtables_globals.program_version,
diff --git a/iptables/xtables-standalone.c b/iptables/xtables-standalone.c
index 1a6b7cf73a4bb..f4d40cda6ae43 100644
--- a/iptables/xtables-standalone.c
+++ b/iptables/xtables-standalone.c
@@ -60,7 +60,7 @@ xtables_main(int family, const char *progname, int argc, char *argv[])
 	init_extensions6();
 #endif
 
-	if (nft_init(&h, family, xtables_ipv4) < 0) {
+	if (nft_init(&h, family) < 0) {
 		fprintf(stderr, "%s/%s Failed to initialize nft: %s\n",
 				xtables_globals.program_name,
 				xtables_globals.program_version,
diff --git a/iptables/xtables-translate.c b/iptables/xtables-translate.c
index 2a00a85088e2c..086b85d2f9cef 100644
--- a/iptables/xtables-translate.c
+++ b/iptables/xtables-translate.c
@@ -465,7 +465,6 @@ static int xtables_xlate_main_common(struct nft_handle *h,
 				     int family,
 				     const char *progname)
 {
-	const struct builtin_table *tables;
 	int ret;
 
 	xtables_globals.program_name = progname;
@@ -485,20 +484,16 @@ static int xtables_xlate_main_common(struct nft_handle *h,
 	init_extensions4();
 	init_extensions6();
 #endif
-		tables = xtables_ipv4;
 		break;
 	case NFPROTO_ARP:
-		tables = xtables_arp;
-		break;
 	case NFPROTO_BRIDGE:
-		tables = xtables_bridge;
 		break;
 	default:
 		fprintf(stderr, "Unknown family %d\n", family);
 		return 1;
 	}
 
-	if (nft_init(h, family, tables) < 0) {
+	if (nft_init(h, family) < 0) {
 		fprintf(stderr, "%s/%s Failed to initialize nft: %s\n",
 				xtables_globals.program_name,
 				xtables_globals.program_version,
-- 
2.33.0

