Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD546184D53
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2020 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMRMa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Mar 2020 13:12:30 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:52440 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRM3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:12:29 -0400
Received: from localhost ([::1]:37298 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jCnrH-0006dn-U7; Fri, 13 Mar 2020 18:12:27 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] nft: cache: Fix for unused variable warnings
Date:   Fri, 13 Mar 2020 18:12:19 +0100
Message-Id: <20200313171219.26857-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Loop index variable was left in place after removing the loops.

Fixes: 39ec645093baa ("nft: cache: Simplify chain list allocation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 0dd131e1f70f5..e3c9655739187 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -331,7 +331,7 @@ static int fetch_chain_cache(struct nft_handle *h,
 	};
 	char buf[16536];
 	struct nlmsghdr *nlh;
-	int i, ret;
+	int ret;
 
 	if (t && chain) {
 		struct nftnl_chain *c = nftnl_chain_alloc();
@@ -516,8 +516,6 @@ void nft_build_cache(struct nft_handle *h, struct nftnl_chain *c)
 
 void nft_fake_cache(struct nft_handle *h)
 {
-	int i;
-
 	fetch_table_cache(h);
 	init_chain_cache(h);
 
-- 
2.25.1

