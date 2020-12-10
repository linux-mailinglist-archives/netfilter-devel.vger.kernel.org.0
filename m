Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08302D5B42
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Dec 2020 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgLJNHv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Dec 2020 08:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388780AbgLJNHv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:07:51 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE60FC0613D6
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 05:07:07 -0800 (PST)
Received: from localhost ([::1]:41008 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1knLf0-0000gx-G8; Thu, 10 Dec 2020 14:07:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 1/9] nft: Fix selective chain compatibility checks
Date:   Thu, 10 Dec 2020 14:06:28 +0100
Message-Id: <20201210130636.26379-2-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210130636.26379-1-phil@nwl.cc>
References: <20201210130636.26379-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since commit 80251bc2a56ed ("nft: remove cache build calls"), 'chain'
parameter passed to nft_chain_list_get() is no longer effective.
Before, it was used to fetch only that single chain from kernel when
populating the cache. So the returned list of chains for which
compatibility checks are done would contain only that single chain.

Re-establish the single chain compat checking by introducing a dedicated
code path to nft_is_chain_compatible() doing so.

Fixes: 80251bc2a56ed ("nft: remove cache build calls")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/iptables/nft.c b/iptables/nft.c
index 411e2597205c9..24e49db4ab919 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -3456,6 +3456,12 @@ bool nft_is_table_compatible(struct nft_handle *h,
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

