Return-Path: <netfilter-devel+bounces-9297-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB5BEE971
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Oct 2025 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ED5B4E5DA1
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Oct 2025 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96392EBB9C;
	Sun, 19 Oct 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="imuHKQ/D"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3326B761;
	Sun, 19 Oct 2025 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889742; cv=none; b=KAbKR07vWHO+5UXV7uVFuXmsTDLAwCHEQ1S6RPhr7RE4cBsQZyshPlO0hjUmh2NFuSyYgde8k8Da+JYVrpkc8ci2Ortl6ywccQ9u0OWMCb/qW1uFAB9wCWmXSrifu1nXCJMWAECiv9A7AzyqOFmWAdGU+O3eoiPRAOuBBllTibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889742; c=relaxed/simple;
	bh=K7l2GTDWosErrYqTqQX7bsTzh2JIYUz/bifgejVsiyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1wgjN4iomwnEq3L5FpV+6/Csop4LIfIsBFgPqZx71r6QVCIxLiK6nBp9ych4Uu2T0lsI3tyIxQPiX0pU0xSnk152ZoWptgn5Jnd9/ffJJwksQdFPf0uCshC4p12a87TJ/DFdUJtigUGRmY5OxOQ+c9TznyGstilcQERv4isnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=imuHKQ/D; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id AFD9421EEC;
	Sun, 19 Oct 2025 19:01:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=/P/MS9p5fPVB+Tkw+7bYuZJaZ/tCVAora0aD1ny47ts=; b=imuHKQ/DjV1h
	PduLOYZFizHr1Y7DA3V/j/cs8SolZAuznIQkOKpD035Jp0AcWYVuVvOgnf1IKF6u
	SuRZir4Od599oLsrZPJdPDndzYSxzR6BwDF6c+U9xynBovFmfnzj0FmfP6T8KQVW
	zYWHl5sBfYz8dwx3GR+lS9yAppJ4VIb1yzkVFWUNKGDsI2xh7xB8A4mnQhNM2Bif
	aLisA5hqxEX1aHPbtTGPc3sD3CTFW7U9UnSYalU91KJrT2s/DaPZrxgDk6TD97Xa
	ofCfXgPfAJrRnQ9nk4hl3VVzgFxf6T9+WS79+5NvplfV9GFEkvuHmz/O0izjB2zk
	Be/c22HZY06d/DGxN1q4IAWs6aXhWbCbMHAl6ANEg4EGlstGQJeibeOIcDrC6Phd
	TDbt0024VJbsNZtSnp46zuXR1N498XpVnQCx4125RTtl6HitRWPpxHLY8B+Y/Vy7
	rT/O4YU4WjSy0GwMbuyJkty6qkQV6J2nI0zRnuD2jYk4vskbluCxRcsnpkXlY51K
	4DevC/FzMmq2akymaeM2tYJ7EOULwtg2sAWIRhSrSRZnD2s4c29nMBd78aKPFshK
	Wd7rRk2vhEpgtQlOXefL0GPAnj5Whh2eLCuVUN92EOTnoW/ag+0gda3WeNA7E9cF
	WqMtKKa7KVTDs2BaXtZB6NZfMsSpImU=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Sun, 19 Oct 2025 19:01:12 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 85B056661A;
	Sun, 19 Oct 2025 19:01:12 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 59JFvfjC067678;
	Sun, 19 Oct 2025 18:57:41 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 59JFvfMc067677;
	Sun, 19 Oct 2025 18:57:41 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: [PATCHv6 net-next 07/14] ipvs: add resizable hash tables
Date: Sun, 19 Oct 2025 18:57:04 +0300
Message-ID: <20251019155711.67609-8-ja@ssi.bg>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019155711.67609-1-ja@ssi.bg>
References: <20251019155711.67609-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add infrastructure for resizable hash tables based on hlist_bl
which we will use in followup patches.

The tables allow RCU lookups during resizing, bucket modifications
are protected with per-bucket bit lock and additional custom locking,
the tables are resized when load reaches thresholds determined based
on load factor parameter.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/net/ip_vs.h             | 197 ++++++++++++++++++++++++++++++++
 net/netfilter/ipvs/ip_vs_conn.c |   5 -
 net/netfilter/ipvs/ip_vs_core.c | 175 ++++++++++++++++++++++++++++
 3 files changed, 372 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index f2291be36409..d12e869c0fc2 100644
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
index 37ebb0cb62b8..3e49b30c6d10 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -80,11 +80,6 @@ static unsigned int ip_vs_conn_rnd __read_mostly;
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
index ac21f02651ff..b203768e23fb 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -118,6 +118,181 @@ void ip_vs_init_hash_table(struct list_head *table, int rows)
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
+ * are calculated based on load factor (shift count), negative value allows
+ * load to be below 100% to reduce collisions by maintaining larger table
+ * while positive value tolerates collisions by using smaller table and load
+ * above 100%: u_thresh(load) = size * (2 ^ lfactor)
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
+/* Get the desired table size for n entries based on current table size and
+ * by using the formula size = n / (2^lfactor)
+ * lfactor: shift value for the load factor:
+ * - >0: u_thresh=size << lfactor, for load factor above 100%
+ * - <0: u_thresh=size >> -lfactor, for load factor below 100%
+ * - 0: for load factor of 100%
+ */
+int ip_vs_rht_desired_size(struct netns_ipvs *ipvs, struct ip_vs_rht *t, int n,
+			   int lfactor, int min_bits, int max_bits)
+{
+	if (!t)
+		return 1 << min_bits;
+	n = roundup_pow_of_two(n);
+	if (lfactor < 0) {
+		int factor = min(-lfactor, max_bits);
+
+		n = min(n, 1 << (max_bits - factor));
+		n <<= factor;
+	} else {
+		n = min(n >> lfactor, 1 << max_bits);
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
+/* Set thresholds based on table size and load factor:
+ * u_thresh = size * (2^lfactor)
+ * l_thresh = u_thresh / 16
+ * u_thresh/l_thresh can be used to check if load triggers a table grow/shrink
+ */
+void ip_vs_rht_set_thresholds(struct ip_vs_rht *t, int size, int lfactor,
+			      int min_bits, int max_bits)
+{
+	if (size >= 1 << max_bits)
+		t->u_thresh = INT_MAX;	/* stop growing */
+	else if (lfactor <= 0)
+		t->u_thresh = size >> min(-lfactor, max_bits);
+	else
+		t->u_thresh = min(size, 1 << (30 - lfactor)) << lfactor;
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
2.51.0



