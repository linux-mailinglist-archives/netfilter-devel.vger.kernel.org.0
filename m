Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DA4228C1
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Oct 2021 15:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhJENyH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Oct 2021 09:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235524AbhJENwt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:52:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3834761526;
        Tue,  5 Oct 2021 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633441859;
        bh=jrcEUgW68Qkqt5B8DOxIH62D8gSCwxGLreQ0NMB8Lc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qa8gCMtlXzr3YQgjGkUu3r6y/F86WrUi+8RY6x+uMAsQtmGrEhVt3A0K/y1OGb7SI
         jT7Kt7A9Wg24FVRaV4+EgEGxY/hnWoBqw6/HO+oeDeBInZYMow24FGwGTvwxf2xPa7
         VUoBowqfVkKcYPcrZSPFLp9MBu4xYuuMgmZXeUDNyFYtIy6nGCFQLB2qnhUbtcinF6
         FhNYM59r7iZ0zfziDMxQcQcuhNig3W5xbN+UkxKGQeOf2L2/GjhY6Gedf8z2lAGYC8
         JUHuxgNiUGkOrxA8AMcsH4k3uWISqRR/tCQ2izygmtIp6YHQM2C27yerKkjKXs04ot
         s1LtsGxMrg58g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, kadlec@netfilter.org,
        davem@davemloft.net, kuba@kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 18/40] netfilter: nf_nat_masquerade: make async masq_inet6_event handling generic
Date:   Tue,  5 Oct 2021 09:49:57 -0400
Message-Id: <20211005135020.214291-18-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005135020.214291-1-sashal@kernel.org>
References: <20211005135020.214291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 30db406923b9285a9bac06a6af5e74bd6d0f1d06 ]

masq_inet6_event is called asynchronously from system work queue,
because the inet6 notifier is atomic and nf_iterate_cleanup can sleep.

The ipv4 and device notifiers call nf_iterate_cleanup directly.

This is legal, but these notifiers are called with RTNL mutex held.
A large conntrack table with many devices coming and going will have severe
impact on the system usability, with 'ip a' blocking for several seconds.

This change places the defer code into a helper and makes it more
generic so ipv4 and ifdown notifiers can be converted to defer the
cleanup walk as well in a follow patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_nat_masquerade.c | 122 ++++++++++++++++++------------
 1 file changed, 75 insertions(+), 47 deletions(-)

diff --git a/net/netfilter/nf_nat_masquerade.c b/net/netfilter/nf_nat_masquerade.c
index 8e8a65d46345..415919a6ac1a 100644
--- a/net/netfilter/nf_nat_masquerade.c
+++ b/net/netfilter/nf_nat_masquerade.c
@@ -9,8 +9,19 @@
 
 #include <net/netfilter/nf_nat_masquerade.h>
 
+struct masq_dev_work {
+	struct work_struct work;
+	struct net *net;
+	union nf_inet_addr addr;
+	int ifindex;
+	int (*iter)(struct nf_conn *i, void *data);
+};
+
+#define MAX_MASQ_WORKER_COUNT	16
+
 static DEFINE_MUTEX(masq_mutex);
 static unsigned int masq_refcnt __read_mostly;
+static atomic_t masq_worker_count __read_mostly;
 
 unsigned int
 nf_nat_masquerade_ipv4(struct sk_buff *skb, unsigned int hooknum,
@@ -63,6 +74,63 @@ nf_nat_masquerade_ipv4(struct sk_buff *skb, unsigned int hooknum,
 }
 EXPORT_SYMBOL_GPL(nf_nat_masquerade_ipv4);
 
+static void iterate_cleanup_work(struct work_struct *work)
+{
+	struct masq_dev_work *w;
+
+	w = container_of(work, struct masq_dev_work, work);
+
+	nf_ct_iterate_cleanup_net(w->net, w->iter, (void *)w, 0, 0);
+
+	put_net(w->net);
+	kfree(w);
+	atomic_dec(&masq_worker_count);
+	module_put(THIS_MODULE);
+}
+
+/* Iterate conntrack table in the background and remove conntrack entries
+ * that use the device/address being removed.
+ *
+ * In case too many work items have been queued already or memory allocation
+ * fails iteration is skipped, conntrack entries will time out eventually.
+ */
+static void nf_nat_masq_schedule(struct net *net, union nf_inet_addr *addr,
+				 int ifindex,
+				 int (*iter)(struct nf_conn *i, void *data),
+				 gfp_t gfp_flags)
+{
+	struct masq_dev_work *w;
+
+	if (atomic_read(&masq_worker_count) > MAX_MASQ_WORKER_COUNT)
+		return;
+
+	net = maybe_get_net(net);
+	if (!net)
+		return;
+
+	if (!try_module_get(THIS_MODULE))
+		goto err_module;
+
+	w = kzalloc(sizeof(*w), gfp_flags);
+	if (w) {
+		/* We can overshoot MAX_MASQ_WORKER_COUNT, no big deal */
+		atomic_inc(&masq_worker_count);
+
+		INIT_WORK(&w->work, iterate_cleanup_work);
+		w->ifindex = ifindex;
+		w->net = net;
+		w->iter = iter;
+		if (addr)
+			w->addr = *addr;
+		schedule_work(&w->work);
+		return;
+	}
+
+	module_put(THIS_MODULE);
+ err_module:
+	put_net(net);
+}
+
 static int device_cmp(struct nf_conn *i, void *ifindex)
 {
 	const struct nf_conn_nat *nat = nfct_nat(i);
@@ -136,8 +204,6 @@ static struct notifier_block masq_inet_notifier = {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
-static atomic_t v6_worker_count __read_mostly;
-
 static int
 nat_ipv6_dev_get_saddr(struct net *net, const struct net_device *dev,
 		       const struct in6_addr *daddr, unsigned int srcprefs,
@@ -187,13 +253,6 @@ nf_nat_masquerade_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 }
 EXPORT_SYMBOL_GPL(nf_nat_masquerade_ipv6);
 
-struct masq_dev_work {
-	struct work_struct work;
-	struct net *net;
-	struct in6_addr addr;
-	int ifindex;
-};
-
 static int inet6_cmp(struct nf_conn *ct, void *work)
 {
 	struct masq_dev_work *w = (struct masq_dev_work *)work;
@@ -204,21 +263,7 @@ static int inet6_cmp(struct nf_conn *ct, void *work)
 
 	tuple = &ct->tuplehash[IP_CT_DIR_REPLY].tuple;
 
-	return ipv6_addr_equal(&w->addr, &tuple->dst.u3.in6);
-}
-
-static void iterate_cleanup_work(struct work_struct *work)
-{
-	struct masq_dev_work *w;
-
-	w = container_of(work, struct masq_dev_work, work);
-
-	nf_ct_iterate_cleanup_net(w->net, inet6_cmp, (void *)w, 0, 0);
-
-	put_net(w->net);
-	kfree(w);
-	atomic_dec(&v6_worker_count);
-	module_put(THIS_MODULE);
+	return nf_inet_addr_cmp(&w->addr, &tuple->dst.u3);
 }
 
 /* atomic notifier; can't call nf_ct_iterate_cleanup_net (it can sleep).
@@ -233,36 +278,19 @@ static int masq_inet6_event(struct notifier_block *this,
 {
 	struct inet6_ifaddr *ifa = ptr;
 	const struct net_device *dev;
-	struct masq_dev_work *w;
-	struct net *net;
+	union nf_inet_addr addr;
 
-	if (event != NETDEV_DOWN || atomic_read(&v6_worker_count) >= 16)
+	if (event != NETDEV_DOWN)
 		return NOTIFY_DONE;
 
 	dev = ifa->idev->dev;
-	net = maybe_get_net(dev_net(dev));
-	if (!net)
-		return NOTIFY_DONE;
 
-	if (!try_module_get(THIS_MODULE))
-		goto err_module;
+	memset(&addr, 0, sizeof(addr));
 
-	w = kmalloc(sizeof(*w), GFP_ATOMIC);
-	if (w) {
-		atomic_inc(&v6_worker_count);
+	addr.in6 = ifa->addr;
 
-		INIT_WORK(&w->work, iterate_cleanup_work);
-		w->ifindex = dev->ifindex;
-		w->net = net;
-		w->addr = ifa->addr;
-		schedule_work(&w->work);
-
-		return NOTIFY_DONE;
-	}
-
-	module_put(THIS_MODULE);
- err_module:
-	put_net(net);
+	nf_nat_masq_schedule(dev_net(dev), &addr, dev->ifindex, inet6_cmp,
+			     GFP_ATOMIC);
 	return NOTIFY_DONE;
 }
 
-- 
2.33.0

