Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5523C77D7F5
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Aug 2023 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbjHPB6Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Aug 2023 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbjHPB5w (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:57:52 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED747268A;
        Tue, 15 Aug 2023 18:57:35 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 920FF121BC;
        Wed, 16 Aug 2023 04:57:34 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 7A955121BB;
        Wed, 16 Aug 2023 04:57:34 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id 1582D3C07D5;
        Wed, 16 Aug 2023 04:57:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1692151029; bh=EMe/3JWp+HTtpJa5s/HrGkgfX65E6KXvKk9hsuzb+CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KunXh65LF0JSKGSpBIeAp/h1JwU23Ehi7+n5LU4AuFzrx1FMtbSznLFaRZQUfUcdO
         PeFfNlSoo7fYsD1GEdshQ29fEyy8ImTxwM3/OAXHrTB+CUnGtoOXpxrmF8qRaZKfch
         9BWpFQIjYEMaZWU0E1IFvxK3lrxgXW2DDcTQ9XbE=
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37FHWHn6168639;
        Tue, 15 Aug 2023 20:32:17 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 37FHWGUu168637;
        Tue, 15 Aug 2023 20:32:16 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [PATCH RFC net-next 07/14] ipvs: add resizable hash tables
Date:   Tue, 15 Aug 2023 20:30:24 +0300
Message-ID: <20230815173031.168344-8-ja@ssi.bg>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815173031.168344-1-ja@ssi.bg>
References: <20230815173031.168344-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add infrastructure for resizable hash tables based on hlist_bl
which we will use in followup patches.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/net/ip_vs.h             | 197 ++++++++++++++++++++++++++++++++
 net/netfilter/ipvs/ip_vs_conn.c |   5 -
 net/netfilter/ipvs/ip_vs_core.c | 169 +++++++++++++++++++++++++++
 3 files changed, 366 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 6b9b32257e10..51adba5f1bb9 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -11,6 +11,7 @@
 #include <asm/types.h>                  /* for __uXX types */
 
 #include <linux/list.h>                 /* for struct list_head */
+#include <linux/rculist_bl.h>           /* for struct hlist_bl_head */
 #include <linux/spinlock.h>             /* for struct rwlock_t */
 #include <linux/atomic.h>               /* for struct atomic_t */
 #include <linux/refcount.h>             /* for struct refcount_t */
@@ -30,6 +31,7 @@
 #endif
 #include <net/net_namespace.h>		/* Netw namespace */
 #include <linux/sched/isolation.h>
+#include <linux/siphash.h>
 
 #define IP_VS_HDR_INVERSE	1
 #define IP_VS_HDR_ICMP		2
@@ -271,6 +273,10 @@ static inline const char *ip_vs_dbg_addr(int af, char *buf, size_t buf_len,
 			pr_err(msg, ##__VA_ARGS__);			\
 	} while (0)
 
+struct ip_vs_aligned_lock {
+	spinlock_t	l;	/* Protect buckets */
+} ____cacheline_aligned_in_smp;
+
 /* For arrays per family */
 enum {
 	IP_VS_AF_INET,
@@ -484,6 +490,197 @@ struct ip_vs_est_kt_data {
 	int			est_row;	/* estimated row */
 };
 
+/* IPVS resizable hash tables */
+struct ip_vs_rht {
+	struct hlist_bl_head		*buckets;
+	struct ip_vs_rht __rcu		*new_tbl; /* New/Same table	*/
+	seqcount_t			*seqc;	/* Protects moves	*/
+	struct ip_vs_aligned_lock	*lock;	/* Protect seqc		*/
+	int				mask;	/* Buckets mask		*/
+	int				size;	/* Buckets		*/
+	int				seqc_mask; /* seqc mask		*/
+	int				lock_mask; /* lock mask		*/
+	u32				table_id;
+	int				u_thresh; /* upper threshold	*/
+	int				l_thresh; /* lower threshold	*/
+	int				lfactor;  /* Load Factor (shift)*/
+	int				bits;	/* size = 1 << bits	*/
+	siphash_key_t			hash_key;
+	struct rcu_head			rcu_head;
+};
+
+/**
+ * ip_vs_rht_for_each_table() - Walk the hash tables
+ * @table:	struct ip_vs_rht __rcu *table
+ * @t:		current table, used as cursor, struct ip_vs_rht *var
+ * @p:		previous table, temp struct ip_vs_rht *var
+ *
+ * Walk tables assuming others can not change the installed tables
+ */
+#define ip_vs_rht_for_each_table(table, t, p)				\
+	for (p = NULL, t = rcu_dereference_protected(table, 1);		\
+	     t != p;							\
+	     p = t, t = rcu_dereference_protected(t->new_tbl, 1))
+
+/**
+ * ip_vs_rht_for_each_table_rcu() - Walk the hash tables under RCU reader lock
+ * @table:	struct ip_vs_rht __rcu *table
+ * @t:		current table, used as cursor, struct ip_vs_rht *var
+ * @p:		previous table, temp struct ip_vs_rht *var
+ *
+ * We usually search in one table and also in second table on resizing
+ */
+#define ip_vs_rht_for_each_table_rcu(table, t, p)			\
+	for (p = NULL, t = rcu_dereference(table);			\
+	     t != p;							\
+	     p = t, t = rcu_dereference(t->new_tbl))
+
+/**
+ * ip_vs_rht_for_each_bucket() - Walk all table buckets
+ * @t:		current table, used as cursor, struct ip_vs_rht *var
+ * @bucket:	bucket index, used as cursor, u32 var
+ * @head:	bucket address, used as cursor, struct hlist_bl_head *var
+ */
+#define ip_vs_rht_for_each_bucket(t, bucket, head)			\
+	for (bucket = 0, head = (t)->buckets;				\
+	     bucket < t->size; bucket++, head++)
+
+/**
+ * ip_vs_rht_for_bucket_retry() - Retry bucket if entries are moved
+ * @t:		current table, used as cursor, struct ip_vs_rht *var
+ * @bucket:	index of current bucket or hash key
+ * @sc:		temp seqcount_t *var
+ * @retry:	temp int var
+ */
+#define ip_vs_rht_for_bucket_retry(t, bucket, sc, seq, retry)		\
+	for (retry = 1, sc = &(t)->seqc[(bucket) & (t)->seqc_mask];	\
+	     retry && ({ seq = read_seqcount_begin(sc); 1; });		\
+	     retry = read_seqcount_retry(sc, seq))
+
+/**
+ * DECLARE_IP_VS_RHT_WALK_BUCKETS_RCU() - Declare variables
+ *
+ * Variables for ip_vs_rht_walk_buckets_rcu
+ */
+#define DECLARE_IP_VS_RHT_WALK_BUCKETS_RCU()				\
+	struct ip_vs_rht *_t, *_p;					\
+	unsigned int _seq;						\
+	seqcount_t *_sc;						\
+	u32 _bucket;							\
+	int _retry
+/**
+ * ip_vs_rht_walk_buckets_rcu() - Walk all buckets under RCU read lock
+ * @table:	struct ip_vs_rht __rcu *table
+ * @head:	bucket address, used as cursor, struct hlist_bl_head *var
+ *
+ * Can be used while others add/delete/move entries
+ * Not suitable if duplicates are not desired
+ * Possible cases for reader that uses cond_resched_rcu() in the loop:
+ * - new table can not be installed, no need to repeat
+ * - new table can be installed => check and repeat if new table is
+ * installed, needed for !PREEMPT_RCU
+ */
+#define ip_vs_rht_walk_buckets_rcu(table, head)				\
+	ip_vs_rht_for_each_table_rcu(table, _t, _p)			\
+		ip_vs_rht_for_each_bucket(_t, _bucket, head)		\
+			ip_vs_rht_for_bucket_retry(_t, _bucket, _sc,	\
+						   _seq, _retry)
+
+/**
+ * DECLARE_IP_VS_RHT_WALK_BUCKET_RCU() - Declare variables
+ *
+ * Variables for ip_vs_rht_walk_bucket_rcu
+ */
+#define DECLARE_IP_VS_RHT_WALK_BUCKET_RCU()				\
+	unsigned int _seq;						\
+	seqcount_t *_sc;						\
+	int _retry
+/**
+ * ip_vs_rht_walk_bucket_rcu() - Walk bucket under RCU read lock
+ * @t:		current table, struct ip_vs_rht *var
+ * @bucket:	index of current bucket or hash key
+ * @head:	bucket address, used as cursor, struct hlist_bl_head *var
+ *
+ * Can be used while others add/delete/move entries
+ * Not suitable if duplicates are not desired
+ * Possible cases for reader that uses cond_resched_rcu() in the loop:
+ * - new table can not be installed, no need to repeat
+ * - new table can be installed => check and repeat if new table is
+ * installed, needed for !PREEMPT_RCU
+ */
+#define ip_vs_rht_walk_bucket_rcu(t, bucket, head)			\
+	if (({ head = (t)->buckets + ((bucket) & (t)->mask); 0; }))	\
+		{}							\
+	else								\
+		ip_vs_rht_for_bucket_retry(t, (bucket), _sc, _seq, _retry)
+
+/**
+ * DECLARE_IP_VS_RHT_WALK_BUCKETS_SAFE_RCU() - Declare variables
+ *
+ * Variables for ip_vs_rht_walk_buckets_safe_rcu
+ */
+#define DECLARE_IP_VS_RHT_WALK_BUCKETS_SAFE_RCU()			\
+	struct ip_vs_rht *_t, *_p;					\
+	u32 _bucket
+/**
+ * ip_vs_rht_walk_buckets_safe_rcu() - Walk all buckets under RCU read lock
+ * @table:	struct ip_vs_rht __rcu *table
+ * @head:	bucket address, used as cursor, struct hlist_bl_head *var
+ *
+ * Can be used while others add/delete entries but moving is disabled
+ * Using cond_resched_rcu() should be safe if tables do not change
+ */
+#define ip_vs_rht_walk_buckets_safe_rcu(table, head)			\
+	ip_vs_rht_for_each_table_rcu(table, _t, _p)			\
+		ip_vs_rht_for_each_bucket(_t, _bucket, head)
+
+/**
+ * DECLARE_IP_VS_RHT_WALK_BUCKETS() - Declare variables
+ *
+ * Variables for ip_vs_rht_walk_buckets
+ */
+#define DECLARE_IP_VS_RHT_WALK_BUCKETS()				\
+	struct ip_vs_rht *_t, *_p;					\
+	u32 _bucket
+
+/**
+ * ip_vs_rht_walk_buckets() - Walk all buckets
+ * @table:	struct ip_vs_rht __rcu *table
+ * @head:	bucket address, used as cursor, struct hlist_bl_head *var
+ *
+ * Use if others can not add/delete/move entries
+ */
+#define ip_vs_rht_walk_buckets(table, head)				\
+	ip_vs_rht_for_each_table(table, _t, _p)				\
+		ip_vs_rht_for_each_bucket(_t, _bucket, head)
+
+/* Entries can be in one of two tables, so we flip bit when new table is
+ * created and store it as highest bit in hash keys
+ */
+#define IP_VS_RHT_TABLE_ID_MASK	BIT(31)
+
+/* Check if hash key is from this table */
+static inline bool ip_vs_rht_same_table(struct ip_vs_rht *t, u32 hash_key)
+{
+	return !((t->table_id ^ hash_key) & IP_VS_RHT_TABLE_ID_MASK);
+}
+
+/* Build per-table hash key from hash value */
+static inline u32 ip_vs_rht_build_hash_key(struct ip_vs_rht *t, u32 hash)
+{
+	return t->table_id | (hash & ~IP_VS_RHT_TABLE_ID_MASK);
+}
+
+void ip_vs_rht_free(struct ip_vs_rht *t);
+void ip_vs_rht_rcu_free(struct rcu_head *head);
+struct ip_vs_rht *ip_vs_rht_alloc(int buckets, int scounts, int locks);
+int ip_vs_rht_desired_size(struct netns_ipvs *ipvs, struct ip_vs_rht *t, int n,
+			   int lfactor, int min_bits, int max_bits);
+void ip_vs_rht_set_thresholds(struct ip_vs_rht *t, int size, int lfactor,
+			      int min_bits, int max_bits);
+u32 ip_vs_rht_hash_linfo(struct ip_vs_rht *t, int af,
+			 const union nf_inet_addr *addr, u32 v1, u32 v2);
+
 struct dst_entry;
 struct iphdr;
 struct ip_vs_conn;
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 9065da3cdd12..be3f21519cca 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -79,11 +79,6 @@ static unsigned int ip_vs_conn_rnd __read_mostly;
 #define IP_VS_ADDRSTRLEN (8+1)
 #endif
 
-struct ip_vs_aligned_lock
-{
-	spinlock_t	l;
-} __attribute__((__aligned__(SMP_CACHE_BYTES)));
-
 /* lock array for conn table */
 static struct ip_vs_aligned_lock
 __ip_vs_conntbl_lock_array[CT_LOCKARRAY_SIZE] __cacheline_aligned;
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index b56bef234ed4..5956e1d0685e 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -118,6 +118,175 @@ void ip_vs_init_hash_table(struct list_head *table, int rows)
 		INIT_LIST_HEAD(&table[rows]);
 }
 
+/* IPVS Resizable Hash Tables:
+ * - list_bl buckets with bit lock
+ *
+ * Goals:
+ * - RCU lookup for entry can run in parallel with add/del/move operations
+ * - resizing can trigger on load change or depending on key refresh period
+ * - add/del/move operations should be allowed for any context
+ *
+ * Resizing:
+ * - new table is attached to the current table and all entries are moved
+ * with new hash key. Finally, the new table is installed as current one and
+ * the old table is released after RCU grace period.
+ * - RCU read-side critical sections will walk two tables while resizing is
+ * in progress
+ * - new entries are added to the new table
+ * - entries will be deleted from the old or from the new table, the table_id
+ * can be saved into entry as part of the hash key to know where the entry is
+ * hashed
+ * - move operations may delay readers or to cause retry for the modified
+ * bucket. As result, searched entry will be found but walkers that operate
+ * on multiple entries may see same entry twice if bucket walking is retried.
+ * - for fast path the number of entries (load) can be compared to u_thresh
+ * and l_thresh to decide when to trigger table growing/shrinking. They
+ * are calculated based on load factor (shift count), positive value allows
+ * load to be below 100% to reduce collisions by maintaining larger table
+ * while negative value tolerates collisions by using smaller table and load
+ * above 100%.
+ *
+ * Locking:
+ * - lock: protect seqc if other context except resizer can move entries
+ * - seqc: seqcount_t, delay/retry readers while entries are moved to
+ * new table on resizing
+ * - bit lock: serialize bucket modifications
+ * - writers may use other locking mechanisms to serialize operations for
+ * resizing, moving and installing new tables
+ */
+
+void ip_vs_rht_free(struct ip_vs_rht *t)
+{
+	kvfree(t->buckets);
+	kvfree(t->seqc);
+	kvfree(t->lock);
+	kfree(t);
+}
+
+void ip_vs_rht_rcu_free(struct rcu_head *head)
+{
+	struct ip_vs_rht *t;
+
+	t = container_of(head, struct ip_vs_rht, rcu_head);
+	ip_vs_rht_free(t);
+}
+
+struct ip_vs_rht *ip_vs_rht_alloc(int buckets, int scounts, int locks)
+{
+	struct ip_vs_rht *t = kzalloc(sizeof(*t), GFP_KERNEL);
+	int i;
+
+	if (!t)
+		return NULL;
+	if (scounts) {
+		int ml = roundup_pow_of_two(nr_cpu_ids);
+
+		scounts = min(scounts, buckets);
+		scounts = min(scounts, ml);
+		t->seqc = kvmalloc_array(scounts, sizeof(*t->seqc), GFP_KERNEL);
+		if (!t->seqc)
+			goto err;
+		for (i = 0; i < scounts; i++)
+			seqcount_init(&t->seqc[i]);
+
+		if (locks) {
+			locks = min(locks, scounts);
+			t->lock = kvmalloc_array(locks, sizeof(*t->lock),
+						 GFP_KERNEL);
+			if (!t->lock)
+				goto err;
+			for (i = 0; i < locks; i++)
+				spin_lock_init(&t->lock[i].l);
+		}
+	}
+
+	t->buckets = kvmalloc_array(buckets, sizeof(*t->buckets), GFP_KERNEL);
+	if (!t->buckets)
+		goto err;
+	for (i = 0; i < buckets; i++)
+		INIT_HLIST_BL_HEAD(&t->buckets[i]);
+	t->mask = buckets - 1;
+	t->size = buckets;
+	t->seqc_mask = scounts - 1;
+	t->lock_mask = locks - 1;
+	t->u_thresh = buckets;
+	t->l_thresh = buckets >> 4;
+	t->bits = order_base_2(buckets);
+	/* new_tbl points to self if no new table is filled */
+	RCU_INIT_POINTER(t->new_tbl, t);
+	get_random_bytes(&t->hash_key, sizeof(t->hash_key));
+	return t;
+
+err:
+	ip_vs_rht_free(t);
+	return NULL;
+}
+
+/* Get the desired table size for n entries based on current table size
+ * lfactor: negative (u_thresh=size << -lfactor), else u_thresh=size >> lfactor
+ */
+int ip_vs_rht_desired_size(struct netns_ipvs *ipvs, struct ip_vs_rht *t, int n,
+			   int lfactor, int min_bits, int max_bits)
+{
+	if (!t)
+		return 1 << min_bits;
+	n = roundup_pow_of_two(n);
+	if (lfactor >= 0) {
+		int factor = min(lfactor, max_bits);
+
+		n = min(n, 1 << (max_bits - factor));
+		n <<= factor;
+	} else {
+		n = min(n >> -lfactor, 1 << max_bits);
+	}
+	if (lfactor != t->lfactor)
+		return clamp(n, 1 << min_bits, 1 << max_bits);
+	if (n > t->size)
+		return n;
+	if (n > t->size >> 4)
+		return t->size;
+	/* Shrink but keep it n * 2 to prevent frequent resizing */
+	return clamp(n << 1, 1 << min_bits, 1 << max_bits);
+}
+
+/* Set thresholds based on table size and load factor
+ * u_thresh/l_thresh can be used to check if load triggers a table grow/shrink
+ */
+void ip_vs_rht_set_thresholds(struct ip_vs_rht *t, int size, int lfactor,
+			      int min_bits, int max_bits)
+{
+	if (size >= 1 << max_bits)
+		t->u_thresh = INT_MAX;	/* stop growing */
+	else if (lfactor >= 0)
+		t->u_thresh = size >> min(lfactor, max_bits);
+	else
+		t->u_thresh = min(size, 1 << (30 + lfactor)) << -lfactor;
+
+	/* l_thresh: shrink when load is 16 times lower, can be 0 */
+	if (size >= 1 << max_bits)
+		t->l_thresh = (1 << max_bits) >> 4;
+	else if (size > 1 << min_bits)
+		t->l_thresh = t->u_thresh >> 4;
+	else
+		t->l_thresh = 0;	/* stop shrinking */
+}
+
+/* Return hash value for local info (fast, insecure) */
+u32 ip_vs_rht_hash_linfo(struct ip_vs_rht *t, int af,
+			 const union nf_inet_addr *addr, u32 v1, u32 v2)
+{
+	u32 v3;
+
+#ifdef CONFIG_IP_VS_IPV6
+	if (af == AF_INET6)
+		v3 = ipv6_addr_hash(&addr->in6);
+	else
+#endif
+		v3 = addr->all[0];
+
+	return jhash_3words(v1, v2, v3, (u32)t->hash_key.key[0]);
+}
+
 static inline void
 ip_vs_in_stats(struct ip_vs_conn *cp, struct sk_buff *skb)
 {
-- 
2.41.0


