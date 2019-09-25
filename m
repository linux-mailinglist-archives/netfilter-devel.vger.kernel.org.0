Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F905BE717
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfIYV1Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:27:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45854 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIYV1P (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:27:15 -0400
Received: from localhost ([::1]:58944 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEoc-0005Fk-BK; Wed, 25 Sep 2019 23:27:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 07/24] nft: Support fetch_rule_cache() per chain
Date:   Wed, 25 Sep 2019 23:25:48 +0200
Message-Id: <20190925212605.1005-8-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925212605.1005-1-phil@nwl.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Support passing an nftnl_chain to fetch its rules from kernel.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 02da53e60bc83..7c974af8b4141 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1575,10 +1575,13 @@ static int nft_rule_list_update(struct nftnl_chain *c, void *data)
 	return 0;
 }
 
-static int fetch_rule_cache(struct nft_handle *h)
+static int fetch_rule_cache(struct nft_handle *h, struct nftnl_chain *c)
 {
 	int i;
 
+	if (c)
+		return nft_rule_list_update(c, h);
+
 	for (i = 0; i < NFT_TABLE_MAX; i++) {
 		enum nft_table_type type = h->tables[i].type;
 
@@ -1599,7 +1602,7 @@ static void __nft_build_cache(struct nft_handle *h)
 retry:
 	mnl_genid_get(h, &genid_start);
 	fetch_chain_cache(h);
-	fetch_rule_cache(h);
+	fetch_rule_cache(h, NULL);
 	h->have_cache = true;
 	mnl_genid_get(h, &genid_stop);
 
-- 
2.23.0

