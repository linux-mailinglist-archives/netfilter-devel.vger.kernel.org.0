Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC87AB658
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Sep 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjIVQnq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 22 Sep 2023 12:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjIVQni (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:43:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3103DCE9;
        Fri, 22 Sep 2023 09:43:24 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.15 16/17] netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
Date:   Fri, 22 Sep 2023 18:43:12 +0200
Message-Id: <20230922164313.151564-17-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922164313.151564-1-pablo@netfilter.org>
References: <20230922164313.151564-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

commit b079155faae94e9b3ab9337e82100a914ebb4e8d upstream.

Skip GC run if iterator rewinds to the beginning with EAGAIN, otherwise GC
might collect the same element more than once.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_hash.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index eca20dc60138..2013de934cef 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -338,12 +338,9 @@ static void nft_rhash_gc(struct work_struct *work)
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN) {
-				nft_trans_gc_destroy(gc);
-				gc = NULL;
-				goto try_later;
-			}
-			continue;
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
 		}
 
 		/* Ruleset has been updated, try later. */
-- 
2.30.2

