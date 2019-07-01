Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDD7392F5
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfFGRVc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:21:32 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35922 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfFGRVc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:21:32 -0400
Received: from localhost ([::1]:49012 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIYT-0006t7-M9; Fri, 07 Jun 2019 19:21:29 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH v6 4/5] src: Make cache_is_complete() public
Date:   Fri,  7 Jun 2019 19:21:20 +0200
Message-Id: <20190607172121.21752-5-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607172121.21752-1-phil@nwl.cc>
References: <20190607172121.21752-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/rule.h | 1 +
 src/rule.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/rule.h b/include/rule.h
index 87b440b63ba5c..8ccdc2e1c143f 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -639,6 +639,7 @@ extern int cache_update(struct nft_ctx *ctx, enum cmd_ops cmd,
 extern void cache_flush(struct nft_ctx *ctx, enum cmd_ops cmd,
 			struct list_head *msgs);
 extern void cache_release(struct nft_cache *cache);
+extern bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd);
 
 struct timeout_protocol {
 	uint32_t array_size;
diff --git a/src/rule.c b/src/rule.c
index 20fe6f3758cbc..ad549b1eee8ac 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -232,7 +232,7 @@ static int cache_completeness(enum cmd_ops cmd)
 	return 1;
 }
 
-static bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd)
+bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd)
 {
 	return cache_completeness(cache->cmd) >= cache_completeness(cmd);
 }
-- 
2.21.0

