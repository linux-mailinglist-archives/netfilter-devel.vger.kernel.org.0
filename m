Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC715BD9
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 May 2019 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfEGFh2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 May 2019 01:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbfEGFh1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 May 2019 01:37:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BF320675;
        Tue,  7 May 2019 05:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207446;
        bh=XUpeAAX8vOQrbK/u6ko9Ts+71HRnrd26OkGJA8E5MEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCvqNPskS+LEVpQpc8/SfKzVkXgVS6vtC3yY9/Jco4u/miFbZCmv1ITVD+MankC5n
         g0ULmgVLT54q8G3/jOKfgpkxihCCXismxJ556J4PKgn9DjU0SZf4iczNKWMqvT6fBZ
         x4+yIoKM8nSa0f4sWNKCTrm8QXJw/TrHbpy9P+EQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/81] netfilter: ctnetlink: don't use conntrack/expect object addresses as id
Date:   Tue,  7 May 2019 01:35:16 -0400
Message-Id: <20190507053554.30848-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 3c79107631db1f7fd32cf3f7368e4672004a3010 ]

else, we leak the addresses to userspace via ctnetlink events
and dumps.

Compute an ID on demand based on the immutable parts of nf_conn struct.

Another advantage compared to using an address is that there is no
immediate re-use of the same ID in case the conntrack entry is freed and
reallocated again immediately.

Fixes: 3583240249ef ("[NETFILTER]: nf_conntrack_expect: kill unique ID")
Fixes: 7f85f914721f ("[NETFILTER]: nf_conntrack: kill unique ID")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack.h |  2 ++
 net/netfilter/nf_conntrack_core.c    | 35 ++++++++++++++++++++++++++++
 net/netfilter/nf_conntrack_netlink.c | 34 +++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 7e012312cd61..f45141bdbb83 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -313,6 +313,8 @@ struct nf_conn *nf_ct_tmpl_alloc(struct net *net,
 				 gfp_t flags);
 void nf_ct_tmpl_free(struct nf_conn *tmpl);
 
+u32 nf_ct_get_id(const struct nf_conn *ct);
+
 static inline void
 nf_ct_set(struct sk_buff *skb, struct nf_conn *ct, enum ip_conntrack_info info)
 {
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 9a249478abf2..27eff89fad01 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 #include <linux/jhash.h>
+#include <linux/siphash.h>
 #include <linux/err.h>
 #include <linux/percpu.h>
 #include <linux/moduleparam.h>
@@ -424,6 +425,40 @@ nf_ct_invert_tuple(struct nf_conntrack_tuple *inverse,
 }
 EXPORT_SYMBOL_GPL(nf_ct_invert_tuple);
 
+/* Generate a almost-unique pseudo-id for a given conntrack.
+ *
+ * intentionally doesn't re-use any of the seeds used for hash
+ * table location, we assume id gets exposed to userspace.
+ *
+ * Following nf_conn items do not change throughout lifetime
+ * of the nf_conn after it has been committed to main hash table:
+ *
+ * 1. nf_conn address
+ * 2. nf_conn->ext address
+ * 3. nf_conn->master address (normally NULL)
+ * 4. tuple
+ * 5. the associated net namespace
+ */
+u32 nf_ct_get_id(const struct nf_conn *ct)
+{
+	static __read_mostly siphash_key_t ct_id_seed;
+	unsigned long a, b, c, d;
+
+	net_get_random_once(&ct_id_seed, sizeof(ct_id_seed));
+
+	a = (unsigned long)ct;
+	b = (unsigned long)ct->master ^ net_hash_mix(nf_ct_net(ct));
+	c = (unsigned long)ct->ext;
+	d = (unsigned long)siphash(&ct->tuplehash, sizeof(ct->tuplehash),
+				   &ct_id_seed);
+#ifdef CONFIG_64BIT
+	return siphash_4u64((u64)a, (u64)b, (u64)c, (u64)d, &ct_id_seed);
+#else
+	return siphash_4u32((u32)a, (u32)b, (u32)c, (u32)d, &ct_id_seed);
+#endif
+}
+EXPORT_SYMBOL_GPL(nf_ct_get_id);
+
 static void
 clean_from_lists(struct nf_conn *ct)
 {
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 036207ecaf16..47e5a076522d 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/siphash.h>
 
 #include <linux/netfilter.h>
 #include <net/netlink.h>
@@ -487,7 +488,9 @@ static int ctnetlink_dump_ct_synproxy(struct sk_buff *skb, struct nf_conn *ct)
 
 static int ctnetlink_dump_id(struct sk_buff *skb, const struct nf_conn *ct)
 {
-	if (nla_put_be32(skb, CTA_ID, htonl((unsigned long)ct)))
+	__be32 id = (__force __be32)nf_ct_get_id(ct);
+
+	if (nla_put_be32(skb, CTA_ID, id))
 		goto nla_put_failure;
 	return 0;
 
@@ -1275,8 +1278,9 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
 	}
 
 	if (cda[CTA_ID]) {
-		u_int32_t id = ntohl(nla_get_be32(cda[CTA_ID]));
-		if (id != (u32)(unsigned long)ct) {
+		__be32 id = nla_get_be32(cda[CTA_ID]);
+
+		if (id != (__force __be32)nf_ct_get_id(ct)) {
 			nf_ct_put(ct);
 			return -ENOENT;
 		}
@@ -2675,6 +2679,25 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 
 static const union nf_inet_addr any_addr;
 
+static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
+{
+	static __read_mostly siphash_key_t exp_id_seed;
+	unsigned long a, b, c, d;
+
+	net_get_random_once(&exp_id_seed, sizeof(exp_id_seed));
+
+	a = (unsigned long)exp;
+	b = (unsigned long)exp->helper;
+	c = (unsigned long)exp->master;
+	d = (unsigned long)siphash(&exp->tuple, sizeof(exp->tuple), &exp_id_seed);
+
+#ifdef CONFIG_64BIT
+	return (__force __be32)siphash_4u64((u64)a, (u64)b, (u64)c, (u64)d, &exp_id_seed);
+#else
+	return (__force __be32)siphash_4u32((u32)a, (u32)b, (u32)c, (u32)d, &exp_id_seed);
+#endif
+}
+
 static int
 ctnetlink_exp_dump_expect(struct sk_buff *skb,
 			  const struct nf_conntrack_expect *exp)
@@ -2722,7 +2745,7 @@ ctnetlink_exp_dump_expect(struct sk_buff *skb,
 	}
 #endif
 	if (nla_put_be32(skb, CTA_EXPECT_TIMEOUT, htonl(timeout)) ||
-	    nla_put_be32(skb, CTA_EXPECT_ID, htonl((unsigned long)exp)) ||
+	    nla_put_be32(skb, CTA_EXPECT_ID, nf_expect_get_id(exp)) ||
 	    nla_put_be32(skb, CTA_EXPECT_FLAGS, htonl(exp->flags)) ||
 	    nla_put_be32(skb, CTA_EXPECT_CLASS, htonl(exp->class)))
 		goto nla_put_failure;
@@ -3027,7 +3050,8 @@ static int ctnetlink_get_expect(struct net *net, struct sock *ctnl,
 
 	if (cda[CTA_EXPECT_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
-		if (ntohl(id) != (u32)(unsigned long)exp) {
+
+		if (id != nf_expect_get_id(exp)) {
 			nf_ct_expect_put(exp);
 			return -ENOENT;
 		}
-- 
2.20.1

