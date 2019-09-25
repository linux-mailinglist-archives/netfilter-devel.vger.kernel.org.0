Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25111BE715
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfIYV1F (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:27:05 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45842 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIYV1E (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:27:04 -0400
Received: from localhost ([::1]:58932 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEoR-0005F4-B3; Wed, 25 Sep 2019 23:27:03 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 12/24] nft: Reduce cache overhead of adding a custom chain
Date:   Wed, 25 Sep 2019 23:25:53 +0200
Message-Id: <20190925212605.1005-13-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925212605.1005-1-phil@nwl.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pass the new chain name to nft_chain_list_get() although that doesn't
make sense (it is not supposed to be found). The reason is it avoids
full chain list retrieval from kernel if not present already.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 904068a6404a6..2c05643f7d691 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1937,7 +1937,7 @@ int nft_chain_user_add(struct nft_handle *h, const char *chain, const char *tabl
 
 	ret = batch_chain_add(h, NFT_COMPAT_CHAIN_USER_ADD, c);
 
-	list = nft_chain_list_get(h, table, NULL);
+	list = nft_chain_list_get(h, table, chain);
 	if (list)
 		nftnl_chain_list_add(c, list);
 
@@ -1977,7 +1977,7 @@ int nft_chain_restore(struct nft_handle *h, const char *chain, const char *table
 
 	ret = batch_chain_add(h, NFT_COMPAT_CHAIN_USER_ADD, c);
 
-	list = nft_chain_list_get(h, table, NULL);
+	list = nft_chain_list_get(h, table, chain);
 	if (list)
 		nftnl_chain_list_add(c, list);
 
-- 
2.23.0

