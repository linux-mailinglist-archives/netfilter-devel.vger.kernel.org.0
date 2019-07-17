Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BAF6C193
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 21:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfGQTia (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 15:38:30 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:55462 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQTia (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:38:30 -0400
Received: from localhost ([::1]:40320 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hnpkx-0004QV-Os; Wed, 17 Jul 2019 21:38:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [nf PATCH] net: nf_tables: Support auto-loading for inet nat
Date:   Wed, 17 Jul 2019 21:38:19 +0200
Message-Id: <20190717193819.8392-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Trying to create an inet family nat chain would not cause
nft_chain_nat.ko module to auto-load due to missing module alias. Add a
proper one with hard-coded family value 1 for the pseudo-family
NFPROTO_INET.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since RFC:
- Go with hard-coding the value for now like in nf_flow_table_inet.c.
- Adjust subject and commit message a bit.
---
 net/netfilter/nft_chain_nat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_chain_nat.c b/net/netfilter/nft_chain_nat.c
index 2f89bde3c61cb..ff9ac8ae0031f 100644
--- a/net/netfilter/nft_chain_nat.c
+++ b/net/netfilter/nft_chain_nat.c
@@ -142,3 +142,6 @@ MODULE_ALIAS_NFT_CHAIN(AF_INET, "nat");
 #ifdef CONFIG_NF_TABLES_IPV6
 MODULE_ALIAS_NFT_CHAIN(AF_INET6, "nat");
 #endif
+#ifdef CONFIG_NF_TABLES_INET
+MODULE_ALIAS_NFT_CHAIN(1, "nat");	/* NFPROTO_INET */
+#endif
-- 
2.22.0

