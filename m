Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDFA405949
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Sep 2021 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhIIOlk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Sep 2021 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbhIIOld (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:41:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18784C066425;
        Thu,  9 Sep 2021 07:03:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mOKei-0003y3-FO; Thu, 09 Sep 2021 16:03:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     stable@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        syzbot+ce96ca2b1d0b37c6422d@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 5.10.y 2/3] netfilter: nf_tables: initialize set before expression setup
Date:   Thu,  9 Sep 2021 16:03:36 +0200
Message-Id: <20210909140337.29707-3-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909140337.29707-1-fw@strlen.de>
References: <20210909140337.29707-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit ad9f151e560b016b6ad3280b48e42fa11e1a5440 upstream.

nft_set_elem_expr_alloc() needs an initialized set if expression sets on
the NFT_EXPR_GC flag. Move set fields initialization before expression
setup.

[4512935.019450] ==================================================================
[4512935.019456] BUG: KASAN: null-ptr-deref in nft_set_elem_expr_alloc+0x84/0xd0 [nf_tables]
[4512935.019487] Read of size 8 at addr 0000000000000070 by task nft/23532
[4512935.019494] CPU: 1 PID: 23532 Comm: nft Not tainted 5.12.0-rc4+ #48
[...]
[4512935.019502] Call Trace:
[4512935.019505]  dump_stack+0x89/0xb4
[4512935.019512]  ? nft_set_elem_expr_alloc+0x84/0xd0 [nf_tables]
[4512935.019536]  ? nft_set_elem_expr_alloc+0x84/0xd0 [nf_tables]
[4512935.019560]  kasan_report.cold.12+0x5f/0xd8
[4512935.019566]  ? nft_set_elem_expr_alloc+0x84/0xd0 [nf_tables]
[4512935.019590]  nft_set_elem_expr_alloc+0x84/0xd0 [nf_tables]
[4512935.019615]  nf_tables_newset+0xc7f/0x1460 [nf_tables]

Reported-by: syzbot+ce96ca2b1d0b37c6422d@syzkaller.appspotmail.com
Fixes: 65038428b2c6 ("netfilter: nf_tables: allow to specify stateful expression in set definition")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 46 ++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 947d52cff582..3942a29413a4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4280,15 +4280,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	err = nf_tables_set_alloc_name(&ctx, set, name);
 	kfree(name);
 	if (err < 0)
-		goto err_set_alloc_name;
-
-	if (nla[NFTA_SET_EXPR]) {
-		expr = nft_set_elem_expr_alloc(&ctx, set, nla[NFTA_SET_EXPR]);
-		if (IS_ERR(expr)) {
-			err = PTR_ERR(expr);
-			goto err_set_alloc_name;
-		}
-	}
+		goto err_set_name;
 
 	udata = NULL;
 	if (udlen) {
@@ -4299,21 +4291,19 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	INIT_LIST_HEAD(&set->bindings);
 	set->table = table;
 	write_pnet(&set->net, net);
-	set->ops   = ops;
+	set->ops = ops;
 	set->ktype = ktype;
-	set->klen  = desc.klen;
+	set->klen = desc.klen;
 	set->dtype = dtype;
 	set->objtype = objtype;
-	set->dlen  = desc.dlen;
-	set->expr = expr;
+	set->dlen = desc.dlen;
 	set->flags = flags;
-	set->size  = desc.size;
+	set->size = desc.size;
 	set->policy = policy;
-	set->udlen  = udlen;
-	set->udata  = udata;
+	set->udlen = udlen;
+	set->udata = udata;
 	set->timeout = timeout;
 	set->gc_int = gc_int;
-	set->handle = nf_tables_alloc_handle(table);
 
 	set->field_count = desc.field_count;
 	for (i = 0; i < desc.field_count; i++)
@@ -4323,20 +4313,32 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	if (err < 0)
 		goto err_set_init;
 
+	if (nla[NFTA_SET_EXPR]) {
+		expr = nft_set_elem_expr_alloc(&ctx, set, nla[NFTA_SET_EXPR]);
+		if (IS_ERR(expr)) {
+			err = PTR_ERR(expr);
+			goto err_set_expr_alloc;
+		}
+
+		set->expr = expr;
+	}
+
+	set->handle = nf_tables_alloc_handle(table);
+
 	err = nft_trans_set_add(&ctx, NFT_MSG_NEWSET, set);
 	if (err < 0)
-		goto err_set_trans;
+		goto err_set_expr_alloc;
 
 	list_add_tail_rcu(&set->list, &table->sets);
 	table->use++;
 	return 0;
 
-err_set_trans:
+err_set_expr_alloc:
+	if (set->expr)
+		nft_expr_destroy(&ctx, set->expr);
+
 	ops->destroy(set);
 err_set_init:
-	if (expr)
-		nft_expr_destroy(&ctx, expr);
-err_set_alloc_name:
 	kfree(set->name);
 err_set_name:
 	kvfree(set);
-- 
2.32.0

