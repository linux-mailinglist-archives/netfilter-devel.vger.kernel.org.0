Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78E47081F5
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjERM6Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjERM6P (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 08:58:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D40CA1712
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 05:58:11 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft] evaluate: set NFT_SET_EVAL flag if dynamic set already exists
Date:   Thu, 18 May 2023 14:58:06 +0200
Message-Id: <20230518125806.11100-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 # cat test.nft
 table ip test {
        set dlist {
                type ipv4_addr
                size 65535
        }

        chain output {
                type filter hook output priority filter; policy accept;
                udp dport 1234 update @dlist { ip daddr } counter packets 0 bytes 0
        }
 }
 # nft -f test.nft
 # nft -f test.nft
 test.nft:2:6-10: Error: Could not process rule: File exists
         set dlist {
             ^^^^^

Phil Sutter says:

In the first call, the set lacking 'dynamic' flag does not exist
and is therefore added to the cache. Consequently, both the 'add set'
command and the set statement point at the same set object. In the
second call, a set with same name exists already, so the object created
for 'add set' command is not added to cache and consequently not updated
with the missing flag. The kernel thus rejects the NEWSET request as the
existing set differs from the new one.

Set on the NFT_SET_EVAL flag if the existing set sets it on.

Fixes: 8d443adfcc8c1 ("evaluate: attempt to set_eval flag if dynamic updates requested")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Hi Phil,

Maybe this fix so there is no need for revert?

 src/evaluate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 63e3e4147a40..09ad4ea19409 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4516,6 +4516,14 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 		existing_set = set_cache_find(table, set->handle.set.name);
 		if (!existing_set)
 			set_cache_add(set_get(set), table);
+
+		if (existing_set && existing_set->flags & NFT_SET_EVAL) {
+			uint32_t existing_flags = existing_set->flags & ~NFT_SET_EVAL;
+			uint32_t new_flags = set->flags & ~NFT_SET_EVAL;
+
+			if (existing_flags == new_flags)
+				set->flags |= NFT_SET_EVAL;
+		}
 	}
 
 	if (!(set->flags & NFT_SET_INTERVAL) && set->automerge)
-- 
2.30.2

