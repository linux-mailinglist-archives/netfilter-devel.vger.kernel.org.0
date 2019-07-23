Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C2171B86
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jul 2019 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfGWPYw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 11:24:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48678 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfGWPYv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:24:51 -0400
Received: from localhost ([::1]:33536 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hpweo-0001cU-C9; Tue, 23 Jul 2019 17:24:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/2] doc: Install nft-variant man pages only if enabled
Date:   Tue, 23 Jul 2019 17:24:40 +0200
Message-Id: <20190723152441.7360-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Man pages relevant for nftables backend only (xtables-*, *-translate.8)
were installed even if --disable-nftables was given at configure time.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/Makefile.am | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/iptables/Makefile.am b/iptables/Makefile.am
index 3ff85893b2fa8..11abb23977e8c 100644
--- a/iptables/Makefile.am
+++ b/iptables/Makefile.am
@@ -58,13 +58,13 @@ sbin_PROGRAMS	+= xtables-nft-multi
 endif
 man_MANS         = iptables.8 iptables-restore.8 iptables-save.8 \
                    iptables-xml.1 ip6tables.8 ip6tables-restore.8 \
-                   ip6tables-save.8 iptables-extensions.8 \
-                   xtables-nft.8 xtables-translate.8 xtables-legacy.8 \
-                   iptables-translate.8 ip6tables-translate.8 \
-                   xtables-monitor.8
+                   ip6tables-save.8 iptables-extensions.8
 if ENABLE_NFTABLES
-man_MANS	+= arptables-nft.8 arptables-nft-restore.8 arptables-nft-save.8 \
-		   ebtables-nft.8
+man_MANS	+= xtables-nft.8 xtables-translate.8 xtables-legacy.8 \
+                   iptables-translate.8 ip6tables-translate.8 \
+                   xtables-monitor.8 \
+                   arptables-nft.8 arptables-nft-restore.8 arptables-nft-save.8 \
+                   ebtables-nft.8
 endif
 CLEANFILES       = iptables.8 xtables-monitor.8 \
 		   iptables-translate.8 ip6tables-translate.8 \
-- 
2.22.0

