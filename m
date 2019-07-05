Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9C5F687
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jul 2019 12:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGDKWv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Jul 2019 06:22:51 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48276 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbfGDKWu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:22:50 -0400
Received: from localhost ([::1]:33134 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hiyt7-0004nT-DA; Thu, 04 Jul 2019 12:22:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] files: Add inet family nat config
Date:   Thu,  4 Jul 2019 12:22:45 +0200
Message-Id: <20190704102245.20372-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 files/nftables/Makefile.am    | 1 +
 files/nftables/all-in-one.nft | 1 +
 files/nftables/inet-nat.nft   | 8 ++++++++
 3 files changed, 10 insertions(+)
 create mode 100755 files/nftables/inet-nat.nft

diff --git a/files/nftables/Makefile.am b/files/nftables/Makefile.am
index a93b7978f62d4..2a511cd1729c1 100644
--- a/files/nftables/Makefile.am
+++ b/files/nftables/Makefile.am
@@ -3,6 +3,7 @@ dist_pkgsysconf_DATA =	all-in-one.nft		\
 			arp-filter.nft		\
 			bridge-filter.nft	\
 			inet-filter.nft		\
+			inet-nat.nft		\
 			ipv4-filter.nft		\
 			ipv4-mangle.nft		\
 			ipv4-nat.nft		\
diff --git a/files/nftables/all-in-one.nft b/files/nftables/all-in-one.nft
index 4ccc043259c10..d3aa7f37f29f1 100755
--- a/files/nftables/all-in-one.nft
+++ b/files/nftables/all-in-one.nft
@@ -13,6 +13,7 @@ flush ruleset
 
 # native dual stack IPv4 & IPv6 family
 include "./inet-filter.nft"
+include "./inet-nat.nft"
 
 # netdev family at ingress hook. Attached to a given NIC
 include "./netdev-ingress.nft"
diff --git a/files/nftables/inet-nat.nft b/files/nftables/inet-nat.nft
new file mode 100755
index 0000000000000..52fcdb543ddab
--- /dev/null
+++ b/files/nftables/inet-nat.nft
@@ -0,0 +1,8 @@
+#!@sbindir@nft -f
+
+table inet nat {
+	chain prerouting	{ type nat hook prerouting priority -100; }
+	chain input		{ type nat hook input priority 100; }
+	chain output		{ type nat hook output priority -100; }
+	chain postrouting	{ type nat hook postrouting priority 100; }
+}
-- 
2.21.0

