Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C421761A3
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 18:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCBRy3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 12:54:29 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:53342 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBRy3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:54:29 -0500
Received: from localhost ([::1]:38200 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1j8pGu-0007Jw-EY; Mon, 02 Mar 2020 18:54:28 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 4/4] nft: cache: Review flush_cache()
Date:   Mon,  2 Mar 2020 18:53:58 +0100
Message-Id: <20200302175358.27796-5-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302175358.27796-1-phil@nwl.cc>
References: <20200302175358.27796-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

While fixing for iptables-nft-restore under stress, I managed to hit
NULL-pointer deref in flush_cache(). Given that nftnl_*_list_free()
functions are not NULL-pointer tolerant, better make sure such are not
passed by accident.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 0429fb32f2ed0..0dd131e1f70f5 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -603,17 +603,19 @@ static int flush_cache(struct nft_handle *h, struct nft_cache *c,
 		if (h->tables[i].name == NULL)
 			continue;
 
-		if (!c->table[i].chains)
-			continue;
-
-		nftnl_chain_list_free(c->table[i].chains);
-		c->table[i].chains = NULL;
-		if (c->table[i].sets)
+		if (c->table[i].chains) {
+			nftnl_chain_list_free(c->table[i].chains);
+			c->table[i].chains = NULL;
+		}
+		if (c->table[i].sets) {
 			nftnl_set_list_free(c->table[i].sets);
-		c->table[i].sets = NULL;
+			c->table[i].sets = NULL;
+		}
+	}
+	if (c->tables) {
+		nftnl_table_list_free(c->tables);
+		c->tables = NULL;
 	}
-	nftnl_table_list_free(c->tables);
-	c->tables = NULL;
 
 	return 1;
 }
-- 
2.25.1

