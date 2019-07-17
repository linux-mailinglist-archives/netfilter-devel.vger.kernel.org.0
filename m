Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940066C040
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfGQRRy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 13:17:54 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:53504 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfGQRRy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:17:54 -0400
Received: from localhost ([::1]:38362 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hnnYu-00037B-1j; Wed, 17 Jul 2019 19:17:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [nf PATCH RFC] net: nf_tables: Support auto-loading inet family nat chain
Date:   Wed, 17 Jul 2019 19:17:43 +0200
Message-Id: <20190717171743.14754-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Trying to create an inet family nat chain would not cause
nft_chain_nat.ko module auto-load due to missing module alias.

The family is actually NFPROTO_INET which happens to be the same
numerical value as AF_UNIX.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
This is obviously a hack to illustrate the problem and show a working
solution. I'm not sure what a real fix would look like - maybe nf_tables
should internally use NFPROTO_* defines instead of AF_* ones? Maybe it
should translate NFPROTO_INET into AF_UNSPEC?
---
 net/netfilter/nft_chain_nat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_chain_nat.c b/net/netfilter/nft_chain_nat.c
index 2f89bde3c61cb..d3bf4a297c655 100644
--- a/net/netfilter/nft_chain_nat.c
+++ b/net/netfilter/nft_chain_nat.c
@@ -142,3 +142,6 @@ MODULE_ALIAS_NFT_CHAIN(AF_INET, "nat");
 #ifdef CONFIG_NF_TABLES_IPV6
 MODULE_ALIAS_NFT_CHAIN(AF_INET6, "nat");
 #endif
+#ifdef CONFIG_NF_TABLES_INET
+MODULE_ALIAS_NFT_CHAIN(AF_UNIX, "nat");
+#endif
-- 
2.22.0

