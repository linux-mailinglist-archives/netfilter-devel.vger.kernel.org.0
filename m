Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5F241F5C
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Aug 2020 19:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHKRj2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Aug 2020 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgHKRjZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:39:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D28CC06174A
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Aug 2020 10:39:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1k5YF4-0001yQ-E5; Tue, 11 Aug 2020 19:39:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     syzkaller-bugs@googlegroups.com, Florian Westphal <fw@strlen.de>,
        syzbot+c99868fde67014f7e9f5@syzkaller.appspotmail.com
Subject: [PATCH nf] netfilter: free chain context when BINDING flag is missing
Date:   Tue, 11 Aug 2020 19:39:09 +0200
Message-Id: <20200811173909.11246-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot found a memory leak in nf_tables_addchain() because the chain
object is not free'd correctly on error.

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Reported-by: syzbot+c99868fde67014f7e9f5@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d878e34e3354..fd814e514f94 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2018,8 +2018,10 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (nla[NFTA_CHAIN_NAME]) {
 		chain->name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL);
 	} else {
-		if (!(flags & NFT_CHAIN_BINDING))
-			return -EINVAL;
+		if (!(flags & NFT_CHAIN_BINDING)) {
+			err = -EINVAL;
+			goto err1;
+		}
 
 		snprintf(name, sizeof(name), "__chain%llu", ++chain_id);
 		chain->name = kstrdup(name, GFP_KERNEL);
-- 
2.26.2

