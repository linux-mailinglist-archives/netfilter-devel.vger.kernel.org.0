Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE88734EDD
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Jun 2019 19:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDRcW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Jun 2019 13:32:22 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:56464 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFDRcW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:32:22 -0400
Received: from localhost ([::1]:41320 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hYDIL-0000lx-0D; Tue, 04 Jun 2019 19:32:21 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: [nft PATCH v5 08/10] src: Make cache_is_complete() public
Date:   Tue,  4 Jun 2019 19:31:56 +0200
Message-Id: <20190604173158.1184-9-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604173158.1184-1-phil@nwl.cc>
References: <20190604173158.1184-1-phil@nwl.cc>
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
index a7dd042d60e3f..aa8881d375b96 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -638,6 +638,7 @@ extern int cache_update(struct nft_ctx *ctx, enum cmd_ops cmd,
 extern void cache_flush(struct nft_ctx *ctx, enum cmd_ops cmd,
 			struct list_head *msgs);
 extern void cache_release(struct nft_cache *cache);
+extern bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd);
 
 struct timeout_protocol {
 	uint32_t array_size;
diff --git a/src/rule.c b/src/rule.c
index 4270fc7a9cd92..8343614a9d9c5 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -234,7 +234,7 @@ static int cache_completeness(enum cmd_ops cmd)
 	return 1;
 }
 
-static bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd)
+bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd)
 {
 	return cache_completeness(cache->cmd) >= cache_completeness(cmd);
 }
-- 
2.21.0

