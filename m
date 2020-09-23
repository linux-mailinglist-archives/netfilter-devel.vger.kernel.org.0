Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891DB275EC9
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Sep 2020 19:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIWRho (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Sep 2020 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIWRho (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:37:44 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11ECC0613CE
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 10:37:44 -0700 (PDT)
Received: from localhost ([::1]:54154 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kL8i7-0003rP-7B; Wed, 23 Sep 2020 19:37:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 01/10] nft: Fix selective chain compatibility checks
Date:   Wed, 23 Sep 2020 19:48:40 +0200
Message-Id: <20200923174849.5773-2-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923174849.5773-1-phil@nwl.cc>
References: <20200923174849.5773-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since commit 80251bc2a56ed ("nft: remove cache build calls"), 'chain'
parameter passed to nft_chain_list_get() is no longer effective. To
still support running nft_is_chain_compatible() on specific chains only,
add a short path to nft_is_table_compatible().

Follow-up patches will kill nft_chain_list_get(), so don't bother
dropping the unused parameter from its signature.

Fixes: 80251bc2a56ed ("nft: remove cache build calls")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/iptables/nft.c b/iptables/nft.c
index 27bb98d184c7c..669e29d4cf88f 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -3453,6 +3453,12 @@ bool nft_is_table_compatible(struct nft_handle *h,
 {
 	struct nftnl_chain_list *clist;
 
+	if (chain) {
+		struct nftnl_chain *c = nft_chain_find(h, table, chain);
+
+		return c && !nft_is_chain_compatible(c, h);
+	}
+
 	clist = nft_chain_list_get(h, table, chain);
 	if (clist == NULL)
 		return false;
-- 
2.28.0

