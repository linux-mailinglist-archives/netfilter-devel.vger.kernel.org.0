Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EEA733467
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Jun 2023 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbjFPPMg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Jun 2023 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjFPPMf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:12:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B65FF3581
        for <netfilter-devel@vger.kernel.org>; Fri, 16 Jun 2023 08:12:34 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v4 04/10] netfilter: nft_set_pipapo: .walk does not deal with generations
Date:   Fri, 16 Jun 2023 17:12:20 +0200
Message-Id: <20230616151226.66473-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616151226.66473-1-pablo@netfilter.org>
References: <20230616151226.66473-1-pablo@netfilter.org>
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

The .walk callback iterates over the current active set, but it might be
useful to iterate over the next generation set. Use the generation mask
to determine what set view (either current or next generation) is use
for the walk iteration.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v4: no changes

 net/netfilter/nft_set_pipapo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index c867b5b772e8..0452ee586c1c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1974,12 +1974,16 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_set_iter *iter)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct net *net = read_pnet(&set->net);
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
 	int i, r;
 
 	rcu_read_lock();
-	m = rcu_dereference(priv->match);
+	if (iter->genmask == nft_genmask_cur(net))
+		m = rcu_dereference(priv->match);
+	else
+		m = priv->clone;
 
 	if (unlikely(!m))
 		goto out;
-- 
2.30.2

