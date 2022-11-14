Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCA627AED
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Nov 2022 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiKNKsw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Nov 2022 05:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiKNKsw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:48:52 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C09721B2
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Nov 2022 02:48:51 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ouX1B-0006Lx-SP; Mon, 14 Nov 2022 11:48:45 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, kernel test robot <lkp@intel.com>
Subject: [PATCH nf-next] netfilter: conntrack: add __force annotation to silence harmless warning
Date:   Mon, 14 Nov 2022 11:48:41 +0100
Message-Id: <20221114104841.29891-1-fw@strlen.de>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_conntrack_core.c:222:14: sparse: cast from restricted __be16
nf_conntrack_core.c:222:55: sparse: restricted __be16 degrades to integer

no need to convert anything, just add __force to silence the warning.

Fixes: 21a92d58de4e ("netfilter: conntrack: use siphash_4u64")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d633ef028a3d..057ebdcc25d7 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -219,7 +219,9 @@ static u32 hash_conntrack_raw(const struct nf_conntrack_tuple *tuple,
 	a = (u64)tuple->src.u3.all[0] << 32 | tuple->src.u3.all[3];
 	b = (u64)tuple->dst.u3.all[0] << 32 | tuple->dst.u3.all[3];
 
-	c = (u64)tuple->src.u.all << 32 | tuple->dst.u.all << 16 | tuple->dst.protonum;
+	c = (__force u64)tuple->src.u.all << 32 | (__force u64)tuple->dst.u.all << 16;
+	c |= tuple->dst.protonum;
+
 	d = (u64)zoneid << 32 | net_hash_mix(net);
 
 	/* IPv4: u3.all[1,2,3] == 0 */
-- 
2.37.4

