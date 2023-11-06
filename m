Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568F7E1DD2
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Nov 2023 11:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjKFKDc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Nov 2023 05:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKDc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:03:32 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94FD6B6
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Nov 2023 02:03:28 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: remove catchall element in GC sync path
Date:   Mon,  6 Nov 2023 11:03:23 +0100
Message-Id: <20231106100323.320284-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The expired catchall element is not removed from GC sync path. This path
holds mutex so just call nft_setelem_catchall_remove() before queueing
the GC work.

Fixes: 4a9e12ea7e70 ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3c1fd8283bf4..024a88b009a3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9692,10 +9692,12 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 
 		nft_set_elem_dead(ext);
 dead_elem:
-		if (sync)
+		if (sync) {
+			nft_setelem_catchall_remove(gc->net, gc->set, catchall->elem);
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
-		else
+		} else {
 			gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		}
 
 		if (!gc)
 			return NULL;
-- 
2.30.2

