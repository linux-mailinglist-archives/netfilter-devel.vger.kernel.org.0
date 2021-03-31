Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B8D3507E7
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhCaUK5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 16:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbhCaUKu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:10:50 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF5C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Mar 2021 13:10:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lRhAv-0005AW-57; Wed, 31 Mar 2021 22:10:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 06/11] netfilter: ebtables: use net_generic infra
Date:   Wed, 31 Mar 2021 22:10:09 +0200
Message-Id: <20210331201014.23293-7-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210331201014.23293-1-fw@strlen.de>
References: <20210331201014.23293-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ebtables currently uses net->xt.tables[BRIDGE], but upcoming
patch will move net->xt.tables away from struct net.

To avoid exposing x_tables internals to ebtables, use a private list
instead.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebtables.c | 39 ++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index ebe33b60efd6..11625d05bbbc 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -24,6 +24,7 @@
 #include <linux/cpumask.h>
 #include <linux/audit.h>
 #include <net/sock.h>
+#include <net/netns/generic.h>
 /* needed for logical [in,out]-dev filtering */
 #include "../br_private.h"
 
@@ -39,8 +40,11 @@
 #define COUNTER_BASE(c, n, cpu) ((struct ebt_counter *)(((char *)c) + \
 				 COUNTER_OFFSET(n) * cpu))
 
+struct ebt_pernet {
+	struct list_head tables;
+};
 
-
+static unsigned int ebt_pernet_id __read_mostly;
 static DEFINE_MUTEX(ebt_mutex);
 
 #ifdef CONFIG_COMPAT
@@ -336,7 +340,9 @@ static inline struct ebt_table *
 find_table_lock(struct net *net, const char *name, int *error,
 		struct mutex *mutex)
 {
-	return find_inlist_lock(&net->xt.tables[NFPROTO_BRIDGE], name,
+	struct ebt_pernet *ebt_net = net_generic(net, ebt_pernet_id);
+
+	return find_inlist_lock(&ebt_net->tables, name,
 				"ebtable_", error, mutex);
 }
 
@@ -1136,6 +1142,7 @@ static void __ebt_unregister_table(struct net *net, struct ebt_table *table)
 int ebt_register_table(struct net *net, const struct ebt_table *input_table,
 		       const struct nf_hook_ops *ops, struct ebt_table **res)
 {
+	struct ebt_pernet *ebt_net = net_generic(net, ebt_pernet_id);
 	struct ebt_table_info *newinfo;
 	struct ebt_table *t, *table;
 	struct ebt_replace_kernel *repl;
@@ -1194,7 +1201,7 @@ int ebt_register_table(struct net *net, const struct ebt_table *input_table,
 	table->private = newinfo;
 	rwlock_init(&table->lock);
 	mutex_lock(&ebt_mutex);
-	list_for_each_entry(t, &net->xt.tables[NFPROTO_BRIDGE], list) {
+	list_for_each_entry(t, &ebt_net->tables, list) {
 		if (strcmp(t->name, table->name) == 0) {
 			ret = -EEXIST;
 			goto free_unlock;
@@ -1206,7 +1213,7 @@ int ebt_register_table(struct net *net, const struct ebt_table *input_table,
 		ret = -ENOENT;
 		goto free_unlock;
 	}
-	list_add(&table->list, &net->xt.tables[NFPROTO_BRIDGE]);
+	list_add(&table->list, &ebt_net->tables);
 	mutex_unlock(&ebt_mutex);
 
 	WRITE_ONCE(*res, table);
@@ -2412,6 +2419,20 @@ static struct nf_sockopt_ops ebt_sockopts = {
 	.owner		= THIS_MODULE,
 };
 
+static int __net_init ebt_pernet_init(struct net *net)
+{
+	struct ebt_pernet *ebt_net = net_generic(net, ebt_pernet_id);
+
+	INIT_LIST_HEAD(&ebt_net->tables);
+	return 0;
+}
+
+static struct pernet_operations ebt_net_ops = {
+	.init = ebt_pernet_init,
+	.id   = &ebt_pernet_id,
+	.size = sizeof(struct ebt_pernet),
+};
+
 static int __init ebtables_init(void)
 {
 	int ret;
@@ -2425,13 +2446,21 @@ static int __init ebtables_init(void)
 		return ret;
 	}
 
+	ret = register_pernet_subsys(&ebt_net_ops);
+	if (ret < 0) {
+		nf_unregister_sockopt(&ebt_sockopts);
+		xt_unregister_target(&ebt_standard_target);
+		return ret;
+	}
+
 	return 0;
 }
 
-static void __exit ebtables_fini(void)
+static void ebtables_fini(void)
 {
 	nf_unregister_sockopt(&ebt_sockopts);
 	xt_unregister_target(&ebt_standard_target);
+	unregister_pernet_subsys(&ebt_net_ops);
 }
 
 EXPORT_SYMBOL(ebt_register_table);
-- 
2.26.3

