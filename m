Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05B041FACE
	for <lists+netfilter-devel@lfdr.de>; Sat,  2 Oct 2021 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhJBKK0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 2 Oct 2021 06:10:26 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45078 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhJBKKZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 2 Oct 2021 06:10:25 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 32FC763EE3;
        Sat,  2 Oct 2021 12:07:11 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 1/4] netfilter: conntrack: fix boot failure with nf_conntrack.enable_hooks=1
Date:   Sat,  2 Oct 2021 12:08:30 +0200
Message-Id: <20211002100833.21411-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211002100833.21411-1-pablo@netfilter.org>
References: <20211002100833.21411-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

This is a revert of
7b1957b049 ("netfilter: nf_defrag_ipv4: use net_generic infra")
and a partial revert of
8b0adbe3e3 ("netfilter: nf_defrag_ipv6: use net_generic infra").

If conntrack is builtin and kernel is booted with:
nf_conntrack.enable_hooks=1

.... kernel will fail to boot due to a NULL deref in
nf_defrag_ipv4_enable(): Its called before the ipv4 defrag initcall is
made, so net_generic() returns NULL.

To resolve this, move the user refcount back to struct net so calls
to those functions are possible even before their initcalls have run.

Fixes: 7b1957b04956 ("netfilter: nf_defrag_ipv4: use net_generic infra")
Fixes: 8b0adbe3e38d ("netfilter: nf_defrag_ipv6: use net_generic infra").
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/ipv6/nf_defrag_ipv6.h |  1 -
 include/net/netns/netfilter.h               |  6 +++++
 net/ipv4/netfilter/nf_defrag_ipv4.c         | 30 +++++++--------------
 net/ipv6/netfilter/nf_conntrack_reasm.c     |  2 +-
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c   | 25 +++++++----------
 5 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/include/net/netfilter/ipv6/nf_defrag_ipv6.h b/include/net/netfilter/ipv6/nf_defrag_ipv6.h
index 0fd8a4159662..ceadf8ba25a4 100644
--- a/include/net/netfilter/ipv6/nf_defrag_ipv6.h
+++ b/include/net/netfilter/ipv6/nf_defrag_ipv6.h
@@ -17,7 +17,6 @@ struct inet_frags_ctl;
 struct nft_ct_frag6_pernet {
 	struct ctl_table_header *nf_frag_frags_hdr;
 	struct fqdir	*fqdir;
-	unsigned int users;
 };
 
 #endif /* _NF_DEFRAG_IPV6_H */
diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
index 986a2a9cfdfa..b593f95e9991 100644
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -27,5 +27,11 @@ struct netns_nf {
 #if IS_ENABLED(CONFIG_DECNET)
 	struct nf_hook_entries __rcu *hooks_decnet[NF_DN_NUMHOOKS];
 #endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
+	unsigned int defrag_ipv4_users;
+#endif
+#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
+	unsigned int defrag_ipv6_users;
+#endif
 };
 #endif
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index 613432a36f0a..e61ea428ea18 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -20,13 +20,8 @@
 #endif
 #include <net/netfilter/nf_conntrack_zones.h>
 
-static unsigned int defrag4_pernet_id __read_mostly;
 static DEFINE_MUTEX(defrag4_mutex);
 
-struct defrag4_pernet {
-	unsigned int users;
-};
-
 static int nf_ct_ipv4_gather_frags(struct net *net, struct sk_buff *skb,
 				   u_int32_t user)
 {
@@ -111,19 +106,15 @@ static const struct nf_hook_ops ipv4_defrag_ops[] = {
 
 static void __net_exit defrag4_net_exit(struct net *net)
 {
-	struct defrag4_pernet *nf_defrag = net_generic(net, defrag4_pernet_id);
-
-	if (nf_defrag->users) {
+	if (net->nf.defrag_ipv4_users) {
 		nf_unregister_net_hooks(net, ipv4_defrag_ops,
 					ARRAY_SIZE(ipv4_defrag_ops));
-		nf_defrag->users = 0;
+		net->nf.defrag_ipv4_users = 0;
 	}
 }
 
 static struct pernet_operations defrag4_net_ops = {
 	.exit = defrag4_net_exit,
-	.id   = &defrag4_pernet_id,
-	.size = sizeof(struct defrag4_pernet),
 };
 
 static int __init nf_defrag_init(void)
@@ -138,24 +129,23 @@ static void __exit nf_defrag_fini(void)
 
 int nf_defrag_ipv4_enable(struct net *net)
 {
-	struct defrag4_pernet *nf_defrag = net_generic(net, defrag4_pernet_id);
 	int err = 0;
 
 	mutex_lock(&defrag4_mutex);
-	if (nf_defrag->users == UINT_MAX) {
+	if (net->nf.defrag_ipv4_users == UINT_MAX) {
 		err = -EOVERFLOW;
 		goto out_unlock;
 	}
 
-	if (nf_defrag->users) {
-		nf_defrag->users++;
+	if (net->nf.defrag_ipv4_users) {
+		net->nf.defrag_ipv4_users++;
 		goto out_unlock;
 	}
 
 	err = nf_register_net_hooks(net, ipv4_defrag_ops,
 				    ARRAY_SIZE(ipv4_defrag_ops));
 	if (err == 0)
-		nf_defrag->users = 1;
+		net->nf.defrag_ipv4_users = 1;
 
  out_unlock:
 	mutex_unlock(&defrag4_mutex);
@@ -165,12 +155,10 @@ EXPORT_SYMBOL_GPL(nf_defrag_ipv4_enable);
 
 void nf_defrag_ipv4_disable(struct net *net)
 {
-	struct defrag4_pernet *nf_defrag = net_generic(net, defrag4_pernet_id);
-
 	mutex_lock(&defrag4_mutex);
-	if (nf_defrag->users) {
-		nf_defrag->users--;
-		if (nf_defrag->users == 0)
+	if (net->nf.defrag_ipv4_users) {
+		net->nf.defrag_ipv4_users--;
+		if (net->nf.defrag_ipv4_users == 0)
 			nf_unregister_net_hooks(net, ipv4_defrag_ops,
 						ARRAY_SIZE(ipv4_defrag_ops));
 	}
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index a0108415275f..5c47be29b9ee 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -33,7 +33,7 @@
 
 static const char nf_frags_cache_name[] = "nf-frags";
 
-unsigned int nf_frag_pernet_id __read_mostly;
+static unsigned int nf_frag_pernet_id __read_mostly;
 static struct inet_frags nf_frags;
 
 static struct nft_ct_frag6_pernet *nf_frag_pernet(struct net *net)
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index e8a59d8bf2ad..cb4eb1d2c620 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -25,8 +25,6 @@
 #include <net/netfilter/nf_conntrack_zones.h>
 #include <net/netfilter/ipv6/nf_defrag_ipv6.h>
 
-extern unsigned int nf_frag_pernet_id;
-
 static DEFINE_MUTEX(defrag6_mutex);
 
 static enum ip6_defrag_users nf_ct6_defrag_user(unsigned int hooknum,
@@ -91,12 +89,10 @@ static const struct nf_hook_ops ipv6_defrag_ops[] = {
 
 static void __net_exit defrag6_net_exit(struct net *net)
 {
-	struct nft_ct_frag6_pernet *nf_frag = net_generic(net, nf_frag_pernet_id);
-
-	if (nf_frag->users) {
+	if (net->nf.defrag_ipv6_users) {
 		nf_unregister_net_hooks(net, ipv6_defrag_ops,
 					ARRAY_SIZE(ipv6_defrag_ops));
-		nf_frag->users = 0;
+		net->nf.defrag_ipv6_users = 0;
 	}
 }
 
@@ -134,24 +130,23 @@ static void __exit nf_defrag_fini(void)
 
 int nf_defrag_ipv6_enable(struct net *net)
 {
-	struct nft_ct_frag6_pernet *nf_frag = net_generic(net, nf_frag_pernet_id);
 	int err = 0;
 
 	mutex_lock(&defrag6_mutex);
-	if (nf_frag->users == UINT_MAX) {
+	if (net->nf.defrag_ipv6_users == UINT_MAX) {
 		err = -EOVERFLOW;
 		goto out_unlock;
 	}
 
-	if (nf_frag->users) {
-		nf_frag->users++;
+	if (net->nf.defrag_ipv6_users) {
+		net->nf.defrag_ipv6_users++;
 		goto out_unlock;
 	}
 
 	err = nf_register_net_hooks(net, ipv6_defrag_ops,
 				    ARRAY_SIZE(ipv6_defrag_ops));
 	if (err == 0)
-		nf_frag->users = 1;
+		net->nf.defrag_ipv6_users = 1;
 
  out_unlock:
 	mutex_unlock(&defrag6_mutex);
@@ -161,12 +156,10 @@ EXPORT_SYMBOL_GPL(nf_defrag_ipv6_enable);
 
 void nf_defrag_ipv6_disable(struct net *net)
 {
-	struct nft_ct_frag6_pernet *nf_frag = net_generic(net, nf_frag_pernet_id);
-
 	mutex_lock(&defrag6_mutex);
-	if (nf_frag->users) {
-		nf_frag->users--;
-		if (nf_frag->users == 0)
+	if (net->nf.defrag_ipv6_users) {
+		net->nf.defrag_ipv6_users--;
+		if (net->nf.defrag_ipv6_users == 0)
 			nf_unregister_net_hooks(net, ipv6_defrag_ops,
 						ARRAY_SIZE(ipv6_defrag_ops));
 	}
-- 
2.30.2

