Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB07AB6CF
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Sep 2023 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjIVRBr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 22 Sep 2023 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjIVRBh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:01:37 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F2E919D;
        Fri, 22 Sep 2023 10:01:31 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.10 13/17] netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
Date:   Fri, 22 Sep 2023 19:01:14 +0200
Message-Id: <20230922170118.152420-14-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922170118.152420-1-pablo@netfilter.org>
References: <20230922170118.152420-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

commit 2ee52ae94baabf7ee09cf2a8d854b990dac5d0e4 upstream.

New elements in this transaction might expired before such transaction
ends. Skip sync GC for such elements otherwise commit path might walk
over an already released object. Once transaction is finished, async GC
will collect such expired element.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_rbtree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 9b0bdd421615..535076b4de53 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -314,6 +314,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
+	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
 	int d, err;
 
@@ -359,8 +360,11 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		if (!nft_set_elem_active(&rbe->ext, genmask))
 			continue;
 
-		/* perform garbage collection to avoid bogus overlap reports. */
-		if (nft_set_elem_expired(&rbe->ext)) {
+		/* perform garbage collection to avoid bogus overlap reports
+		 * but skip new elements in this transaction.
+		 */
+		if (nft_set_elem_expired(&rbe->ext) &&
+		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
-- 
2.30.2

