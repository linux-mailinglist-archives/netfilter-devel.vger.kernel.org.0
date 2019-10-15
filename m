Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6745ED7549
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfJOLmH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 07:42:07 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:36568 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfJOLmH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:42:07 -0400
Received: from localhost ([::1]:49658 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKLDK-0000wj-21; Tue, 15 Oct 2019 13:42:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v4 6/8] nft: Reduce cache overhead of nft_chain_builtin_init()
Date:   Tue, 15 Oct 2019 13:41:50 +0200
Message-Id: <20191015114152.25254-7-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015114152.25254-1-phil@nwl.cc>
References: <20191015114152.25254-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There is no need for a full chain cache, fetch only the few builtin
chains that might need to be created.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 775582aab7955..7e019d54ee475 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -709,15 +709,16 @@ nft_chain_builtin_find(const struct builtin_table *t, const char *chain)
 static void nft_chain_builtin_init(struct nft_handle *h,
 				   const struct builtin_table *table)
 {
-	struct nftnl_chain_list *list = nft_chain_list_get(h, table->name, NULL);
+	struct nftnl_chain_list *list;
 	struct nftnl_chain *c;
 	int i;
 
-	if (!list)
-		return;
-
 	/* Initialize built-in chains if they don't exist yet */
 	for (i=0; i < NF_INET_NUMHOOKS && table->chains[i].name != NULL; i++) {
+		list = nft_chain_list_get(h, table->name,
+					  table->chains[i].name);
+		if (!list)
+			continue;
 
 		c = nftnl_chain_list_lookup_byname(list, table->chains[i].name);
 		if (c != NULL)
-- 
2.23.0

