Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AC783D5E
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Aug 2023 11:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbjHVJxc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Aug 2023 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjHVJxb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:53:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C22361AD
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Aug 2023 02:53:29 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] cache: chain listing implicitly sets on terse option
Date:   Tue, 22 Aug 2023 11:53:24 +0200
Message-Id: <20230822095324.23656-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If user specifies a chain to be listed (which is internally handled via
filtering options), then toggle NFT_CACHE_TERSE to skip fetching set
content from kernel for non-anonymous sets.

With a large IPv6 set with bogons, before this patch:

 # time nft list chain inet raw x
 table inet raw {
        chain x {
                ip6 saddr @bogons6
                ip6 saddr { aaaa::, bbbb:: }
        }
 }

 real    0m2,913s
 user    0m1,345s
 sys     0m1,568s

After this patch:

 # time nft list chain inet raw prerouting
 table inet raw {
        chain x {
                ip6 saddr @bogons6
                ip6 saddr { aaaa::, bbbb:: }
        }
 }

 real    0m0,056s
 user    0m0,018s
 sys     0m0,039s

This speeds up chain listing in the presence of a large set.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/cache.c b/src/cache.c
index b6a7e194771a..db9a9a75074a 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -212,6 +212,10 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 			filter->list.family = cmd->handle.family;
 			filter->list.table = cmd->handle.table.name;
 			filter->list.chain = cmd->handle.chain.name;
+			/* implicit terse listing to fetch content of anonymous
+			 * sets only when chain name is specified.
+			 */
+			flags |= NFT_CACHE_TERSE;
 		}
 		flags |= NFT_CACHE_FULL;
 		break;
-- 
2.30.2

