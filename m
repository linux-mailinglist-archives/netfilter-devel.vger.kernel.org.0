Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA2AAFDB
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2019 02:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391513AbfIFAdF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 20:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390838AbfIFAdF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:33:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A665910C6980;
        Fri,  6 Sep 2019 00:33:04 +0000 (UTC)
Received: from egarver.remote.csb (ovpn-122-8.rdu2.redhat.com [10.10.122.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01F5419C77;
        Fri,  6 Sep 2019 00:33:03 +0000 (UTC)
From:   Eric Garver <eric@garver.life>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 1/2] cache: fix --echo with index/position
Date:   Thu,  5 Sep 2019 20:33:01 -0400
Message-Id: <20190906003302.25953-1-eric@garver.life>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 06 Sep 2019 00:33:04 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Always call evaluate_cache_add() so it can set special flags - in this
case NFT_CACHE_UPDATE.

Fixes: 01e5c6f0ed03 ("src: add cache level flags")
Signed-off-by: Eric Garver <eric@garver.life>
---
 src/cache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index cffcbb623ced..a778650ac133 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -104,11 +104,9 @@ unsigned int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
 		case CMD_ADD:
 		case CMD_INSERT:
 		case CMD_CREATE:
-			if (nft_output_echo(&nft->output)) {
-				flags = NFT_CACHE_FULL;
-				break;
-			}
 			flags = evaluate_cache_add(cmd, flags);
+			if (nft_output_echo(&nft->output))
+				flags |= NFT_CACHE_FULL;
 			break;
 		case CMD_REPLACE:
 			flags = NFT_CACHE_FULL;
-- 
2.20.1

