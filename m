Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31D5BE713
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfIYV0x (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:26:53 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45830 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIYV0x (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:26:53 -0400
Received: from localhost ([::1]:58920 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEoG-0005E7-LA; Wed, 25 Sep 2019 23:26:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 05/24] nft: Make nftnl_table_list_get() fetch only tables
Date:   Wed, 25 Sep 2019 23:25:46 +0200
Message-Id: <20190925212605.1005-6-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925212605.1005-1-phil@nwl.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

No need for a full cache to serve the list of tables.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 255e51b4d2275..695758831047a 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2046,7 +2046,8 @@ int nft_chain_user_rename(struct nft_handle *h,const char *chain,
 
 static struct nftnl_table_list *nftnl_table_list_get(struct nft_handle *h)
 {
-	nft_build_cache(h);
+	if (!h->cache->tables)
+		fetch_table_cache(h);
 
 	return h->cache->tables;
 }
-- 
2.23.0

