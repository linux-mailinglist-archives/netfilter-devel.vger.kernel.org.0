Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE076DDDF4
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Apr 2023 16:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDKOa4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Apr 2023 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKOaf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:30:35 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07CB61A3
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Apr 2023 07:30:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pmF0N-0002Lx-TJ; Tue, 11 Apr 2023 16:29:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 1/3] netfilter: nf_tables: merge nft_rules_old structure and end of ruleblob marker
Date:   Tue, 11 Apr 2023 16:29:45 +0200
Message-Id: <20230411142947.9038-2-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411142947.9038-1-fw@strlen.de>
References: <20230411142947.9038-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In order to free the rules in a chain via call_rcu, the rule array used
to stash a rcu_head and space for a pointer at the end of the rule array.

When the current nft_rule_dp blob format got added in
2c865a8a28a1 ("netfilter: nf_tables: add rule blob layout"), this results
in a double-trailer:

  size (unsigned long)
  struct nft_rule_dp
    struct nft_expr
         ...
    struct nft_rule_dp
     struct nft_expr
         ...
    struct nft_rule_dp (is_last=1) // Trailer

The trailer, struct nft_rule_dp (is_last=1), is not accounted for in size,
so it can be located via start_addr + size.

Because the rcu_head is stored after 'start+size' as well this means the
is_last trailer is *aliased* to the rcu_head (struct nft_rules_old).

This is harmless, because at this time the nft_do_chain function never
evaluates/accesses the trailer, it only checks the address boundary:

        for (; rule < last_rule; rule = nft_rule_next(rule)) {
...

But this way the last_rule address has to be stashed in the jump
structure to restore it after returning from a chain.

nft_do_chain stack usage has become way too big, so put it on a diet.

Without this patch is impossible to use
        for (; !rule->is_last; rule = nft_rule_next(rule)) {

... because on free, the needed update of the rcu_head will clobber the
nft_rule_dp is_last bit.

Furthermore, also stash the chain pointer in the trailer, this allows
to recover the original chain structure from nf_tables_trace infra
without a need to place them in the jump struct.

After this patch it is trivial to diet the jump stack structure,
done in the next two patches.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 55 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6004d4b24451..f89fa158ead9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2110,38 +2110,41 @@ static void nft_chain_release_hook(struct nft_chain_hook *hook)
 	module_put(hook->type->owner);
 }
 
-struct nft_rules_old {
+struct nft_rule_dp_last {
+	struct nft_rule_dp end;	/* end of nft_rule_blob marker */
 	struct rcu_head h;
 	struct nft_rule_blob *blob;
+	const struct nft_chain *chain;	/* for tracing */
 };
 
-static void nft_last_rule(struct nft_rule_blob *blob, const void *ptr)
+static void nft_last_rule(const struct nft_chain *chain, const void *ptr)
 {
-	struct nft_rule_dp *prule;
+	struct nft_rule_dp_last *lrule;
+
+	BUILD_BUG_ON(offsetof(struct nft_rule_dp_last, end) != 0);
 
-	prule = (struct nft_rule_dp *)ptr;
-	prule->is_last = 1;
+	lrule = (struct nft_rule_dp_last *)ptr;
+	lrule->end.is_last = 1;
+	lrule->chain = chain;
 	/* blob size does not include the trailer rule */
 }
 
-static struct nft_rule_blob *nf_tables_chain_alloc_rules(unsigned int size)
+static struct nft_rule_blob *nf_tables_chain_alloc_rules(const struct nft_chain *chain,
+							 unsigned int size)
 {
 	struct nft_rule_blob *blob;
 
-	/* size must include room for the last rule */
-	if (size < offsetof(struct nft_rule_dp, data))
-		return NULL;
-
-	size += sizeof(struct nft_rule_blob) + sizeof(struct nft_rules_old);
 	if (size > INT_MAX)
 		return NULL;
 
+	size += sizeof(struct nft_rule_blob) + sizeof(struct nft_rule_dp_last);
+
 	blob = kvmalloc(size, GFP_KERNEL_ACCOUNT);
 	if (!blob)
 		return NULL;
 
 	blob->size = 0;
-	nft_last_rule(blob, blob->data);
+	nft_last_rule(chain, blob->data);
 
 	return blob;
 }
@@ -2220,7 +2223,6 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	struct nft_rule_blob *blob;
 	struct nft_trans *trans;
 	struct nft_chain *chain;
-	unsigned int data_size;
 	int err;
 
 	if (table->use == UINT_MAX)
@@ -2308,8 +2310,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		chain->udlen = nla_len(nla[NFTA_CHAIN_USERDATA]);
 	}
 
-	data_size = offsetof(struct nft_rule_dp, data);	/* last rule */
-	blob = nf_tables_chain_alloc_rules(data_size);
+	blob = nf_tables_chain_alloc_rules(chain, 0);
 	if (!blob) {
 		err = -ENOMEM;
 		goto err_destroy_chain;
@@ -8764,9 +8765,8 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 				return -ENOMEM;
 		}
 	}
-	data_size += offsetof(struct nft_rule_dp, data);	/* last rule */
 
-	chain->blob_next = nf_tables_chain_alloc_rules(data_size);
+	chain->blob_next = nf_tables_chain_alloc_rules(chain, data_size);
 	if (!chain->blob_next)
 		return -ENOMEM;
 
@@ -8811,12 +8811,11 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 		chain->blob_next->size += (unsigned long)(data - (void *)prule);
 	}
 
-	prule = (struct nft_rule_dp *)data;
-	data += offsetof(struct nft_rule_dp, data);
 	if (WARN_ON_ONCE(data > data_boundary))
 		return -ENOMEM;
 
-	nft_last_rule(chain->blob_next, prule);
+	prule = (struct nft_rule_dp *)data;
+	nft_last_rule(chain, prule);
 
 	return 0;
 }
@@ -8837,22 +8836,22 @@ static void nf_tables_commit_chain_prepare_cancel(struct net *net)
 	}
 }
 
-static void __nf_tables_commit_chain_free_rules_old(struct rcu_head *h)
+static void __nf_tables_commit_chain_free_rules(struct rcu_head *h)
 {
-	struct nft_rules_old *o = container_of(h, struct nft_rules_old, h);
+	struct nft_rule_dp_last *l = container_of(h, struct nft_rule_dp_last, h);
 
-	kvfree(o->blob);
+	kvfree(l->blob);
 }
 
 static void nf_tables_commit_chain_free_rules_old(struct nft_rule_blob *blob)
 {
-	struct nft_rules_old *old;
+	struct nft_rule_dp_last *last;
 
-	/* rcu_head is after end marker */
-	old = (void *)blob + sizeof(*blob) + blob->size;
-	old->blob = blob;
+	/* last rule trailer is after end marker */
+	last = (void *)blob + sizeof(*blob) + blob->size;
+	last->blob = blob;
 
-	call_rcu(&old->h, __nf_tables_commit_chain_free_rules_old);
+	call_rcu(&last->h, __nf_tables_commit_chain_free_rules);
 }
 
 static void nf_tables_commit_chain(struct net *net, struct nft_chain *chain)
-- 
2.39.2

