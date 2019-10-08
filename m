Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6548CFEAA
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfJHQO6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 12:14:58 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48464 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJHQO6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:14:58 -0400
Received: from localhost ([::1]:33322 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iHs8W-0004TS-DA; Tue, 08 Oct 2019 18:14:56 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 02/11] nft: Avoid nested cache fetching
Date:   Tue,  8 Oct 2019 18:14:38 +0200
Message-Id: <20191008161447.6595-3-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008161447.6595-1-phil@nwl.cc>
References: <20191008161447.6595-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Don't call fetch_table_cache() from within fetch_chain_cache() but
instead from __nft_build_cache(). Since that is the only caller of
fetch_chain_cache(), this change should not have any effect in practice.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index bdc9fbc37f110..3228842cd3c8b 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1414,8 +1414,6 @@ static int fetch_chain_cache(struct nft_handle *h)
 	struct nlmsghdr *nlh;
 	int i, ret;
 
-	fetch_table_cache(h);
-
 	for (i = 0; i < NFT_TABLE_MAX; i++) {
 		enum nft_table_type type = h->tables[i].type;
 
@@ -1592,6 +1590,7 @@ static void __nft_build_cache(struct nft_handle *h)
 
 retry:
 	mnl_genid_get(h, &genid_start);
+	fetch_table_cache(h);
 	fetch_chain_cache(h);
 	fetch_rule_cache(h);
 	h->have_cache = true;
-- 
2.23.0

