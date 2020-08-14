Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F10244A24
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Aug 2020 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHNNHu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Aug 2020 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHNNHt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:07:49 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6FC061384
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Aug 2020 06:07:49 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1k6ZQx-0008FY-St; Fri, 14 Aug 2020 15:07:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nftables: permit any priority for nat hooks
Date:   Fri, 14 Aug 2020 15:07:43 +0200
Message-Id: <20200814130743.29024-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts
commit 84ba7dd71add ("netfilter: nf_tables: reject nat hook registration if prio is before conntrack")

As of commit 9971a514ed2697e ("netfilter: nf_nat: add nat type hooks to nat core")
NAT hooks are always called from a fixed chain priority. The priority is
only used to order a nat chain wrt. other nat base chains, not arbitrary
hook functions. Even INT_MIN will not call the nat hook before conntrack
anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fd814e514f94..6e2a75223882 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1831,10 +1831,6 @@ static int nft_chain_parse_hook(struct net *net,
 	if (hook->num > NF_MAX_HOOKS || !(type->hook_mask & (1 << hook->num)))
 		return -EOPNOTSUPP;
 
-	if (type->type == NFT_CHAIN_T_NAT &&
-	    hook->priority <= NF_IP_PRI_CONNTRACK)
-		return -EOPNOTSUPP;
-
 	if (!try_module_get(type->owner))
 		return -ENOENT;
 
-- 
2.26.2

