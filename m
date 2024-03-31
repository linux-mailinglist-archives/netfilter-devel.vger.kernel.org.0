Return-Path: <netfilter-devel+bounces-1565-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F109F8931EE
	for <lists+netfilter-devel@lfdr.de>; Sun, 31 Mar 2024 16:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1110B1C20AA3
	for <lists+netfilter-devel@lfdr.de>; Sun, 31 Mar 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E575813;
	Sun, 31 Mar 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="q4DiqW8G"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB5144D27;
	Sun, 31 Mar 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711894069; cv=none; b=jJyTvzNPGTDmRk0rp7AkVYXMWT7OjZHfSF4Kwmuc9MHWudHhmli3v28x46DcP/YPMcE4UPCWJ3T44P4sQXF/ouvJt1/baFJfLUZNsHAbmEL/QWIgerosA2Ba0t8EyM4DaHUVvPEkIoNIdmob9M0DRlRbp0x8H3lRWye7Zduloj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711894069; c=relaxed/simple;
	bh=9it6aGQPavGenZ45jHgl5wzKYLlzTh8PDTwQ3AOtrtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8q8P6Z/CVaSminE2oNpk3HWqBAxzrzrHIJ5FJd9TNyl7/njaraQBreWgN0pSOaTKrgg+RcdtsUfH6zFPgYPwvqrKrYk/YxguPlu4Jv/FWMqqPChqtnR3fqwWjxQnsorUgKEUvE1qIvND3GgWd9AmBMX7mh29wkolrIciUW2Hl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (1024-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=q4DiqW8G; arc=none smtp.client-ip=193.238.174.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mg.ssi.bg (localhost [127.0.0.1])
	by mg.ssi.bg (Proxmox) with ESMTP id 4B83231EB7;
	Sun, 31 Mar 2024 17:07:44 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.ssi.bg (Proxmox) with ESMTPS id 4ECFA31DEF;
	Sun, 31 Mar 2024 17:07:40 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id D4B139036B3;
	Sun, 31 Mar 2024 17:07:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1711894024; bh=9it6aGQPavGenZ45jHgl5wzKYLlzTh8PDTwQ3AOtrtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q4DiqW8GCz7mOGx6NgzXhz0mdLnDWoCe/07XxlJEkltnW39O3cc9fhT22Tpi6O5Dc
	 wr6fUGuV69cQter9lqpCh/gK2x3Eh2ufA7837OLkKWjVa/0tW+eav6CGT7ysMgOuBW
	 mFIpZ4UOsjWMAVMyLkJmANZn8CV9peWIqh0je8TY=
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 42VE4538077726;
	Sun, 31 Mar 2024 17:04:05 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 42VE454n077725;
	Sun, 31 Mar 2024 17:04:05 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: [PATCHv3 net-next 09/14] ipvs: switch to per-net connection table
Date: Sun, 31 Mar 2024 17:03:56 +0300
Message-ID: <20240331140401.77657-10-ja@ssi.bg>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331140401.77657-1-ja@ssi.bg>
References: <20240331140401.77657-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use per-net resizable hash table for connections. The global table
is slow to walk when using many namespaces.

The table can be resized in the range of [256 - ip_vs_conn_tab_size].
Table is attached only while services are present. Resizing is done
by delayed work based on load (the number of connections).

Add a hash_key field into the connection to store the table ID in
the highest bit and the entry's hash value in the lowest bits. The
lowest part of the hash value is used as bucket ID, the remaining
part is used to filter the entries in the bucket before matching
the keys and as result, helps the lookup operation to access only
one cache line. By knowing the table ID and bucket ID for entry,
we can unlink it without calculating the hash value and doing
lookup by keys. We need only to validate the saved hash_key under
lock.

For better security switch from jhash to siphash for the default
connection hashing but the persistence engines may use their own
function. Keeping the hash table loaded with entries below the
size (12%) allows to avoid collision for 96+% of the conns.

ip_vs_conn_fill_cport() now will rehash the connection with proper
locking because unhash+hash is not safe for RCU readers.

To invalidate the templates setting just dport to 0xffff is enough,
no need to rehash them. As result, ip_vs_conn_unhash() is now
unused and removed.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/net/ip_vs.h               |  34 +-
 net/netfilter/ipvs/ip_vs_conn.c   | 868 +++++++++++++++++++++---------
 net/netfilter/ipvs/ip_vs_ctl.c    |  18 +
 net/netfilter/ipvs/ip_vs_pe_sip.c |   4 +-
 net/netfilter/ipvs/ip_vs_sync.c   |  23 +
 5 files changed, 679 insertions(+), 268 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 0b1e1f870c46..074f45f89c80 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -36,6 +36,14 @@
 #define IP_VS_HDR_INVERSE	1
 #define IP_VS_HDR_ICMP		2
 
+/* conn_tab limits (as per Kconfig) */
+#define IP_VS_CONN_TAB_MIN_BITS	8
+#if BITS_PER_LONG > 32
+#define IP_VS_CONN_TAB_MAX_BITS	27
+#else
+#define IP_VS_CONN_TAB_MAX_BITS	20
+#endif
+
 /* svc_table limits */
 #define IP_VS_SVC_TAB_MIN_BITS	4
 #define IP_VS_SVC_TAB_MAX_BITS	20
@@ -289,6 +297,7 @@ static inline int ip_vs_af_index(int af)
 enum {
 	IP_VS_WORK_SVC_RESIZE,		/* Schedule svc_resize_work */
 	IP_VS_WORK_SVC_NORESIZE,	/* Stopping svc_resize_work */
+	IP_VS_WORK_CONN_RESIZE,		/* Schedule conn_resize_work */
 };
 
 /* The port number of FTP service (in network order). */
@@ -778,18 +787,19 @@ struct ip_vs_conn_param {
 
 /* IP_VS structure allocated for each dynamically scheduled connection */
 struct ip_vs_conn {
-	struct hlist_node	c_list;         /* hashed list heads */
+	struct hlist_bl_node	c_list;         /* node in conn_tab */
+	__u32			hash_key;	/* Key for the hash table */
 	/* Protocol, addresses and port numbers */
 	__be16                  cport;
 	__be16                  dport;
 	__be16                  vport;
 	u16			af;		/* address family */
+	__u16                   protocol;       /* Which protocol (TCP/UDP) */
+	__u16			daf;		/* Address family of the dest */
 	union nf_inet_addr      caddr;          /* client address */
 	union nf_inet_addr      vaddr;          /* virtual address */
 	union nf_inet_addr      daddr;          /* destination address */
 	volatile __u32          flags;          /* status flags */
-	__u16                   protocol;       /* Which protocol (TCP/UDP) */
-	__u16			daf;		/* Address family of the dest */
 	struct netns_ipvs	*ipvs;
 
 	/* counter and timer */
@@ -1008,8 +1018,8 @@ struct ip_vs_pe {
 	int (*fill_param)(struct ip_vs_conn_param *p, struct sk_buff *skb);
 	bool (*ct_match)(const struct ip_vs_conn_param *p,
 			 struct ip_vs_conn *ct);
-	u32 (*hashkey_raw)(const struct ip_vs_conn_param *p, u32 initval,
-			   bool inverse);
+	u32 (*hashkey_raw)(const struct ip_vs_conn_param *p,
+			   struct ip_vs_rht *t, bool inverse);
 	int (*show_pe_data)(const struct ip_vs_conn *cp, char *buf);
 	/* create connections for real-server outgoing packets */
 	struct ip_vs_conn* (*conn_out)(struct ip_vs_service *svc,
@@ -1148,6 +1158,7 @@ struct netns_ipvs {
 #endif
 	/* ip_vs_conn */
 	atomic_t		conn_count;      /* connection counter */
+	struct delayed_work	conn_resize_work;/* resize conn_tab */
 
 	/* ip_vs_ctl */
 	struct ip_vs_stats_rcu	*tot_stats;      /* Statistics & est. */
@@ -1223,6 +1234,7 @@ struct netns_ipvs {
 	int			sysctl_est_nice;	/* kthread nice */
 	int			est_stopped;		/* stop tasks */
 #endif
+	int			sysctl_conn_lfactor;
 	int			sysctl_svc_lfactor;
 
 	/* ip_vs_lblc */
@@ -1266,6 +1278,8 @@ struct netns_ipvs {
 	unsigned int		hooks_afmask;	/* &1=AF_INET, &2=AF_INET6 */
 
 	struct ip_vs_rht __rcu	*svc_table;	/* Services */
+	struct ip_vs_rht __rcu	*conn_tab;	/* Connections */
+	atomic_t		conn_tab_changes;/* ++ on new table */
 };
 
 #define DEFAULT_SYNC_THRESHOLD	3
@@ -1502,6 +1516,12 @@ static inline int sysctl_est_nice(struct netns_ipvs *ipvs)
 
 #endif
 
+/* Get load factor to map conn_count/u_thresh to t->size */
+static inline int sysctl_conn_lfactor(struct netns_ipvs *ipvs)
+{
+	return READ_ONCE(ipvs->sysctl_conn_lfactor);
+}
+
 /* Get load factor to map num_services/u_thresh to t->size
  * Smaller value decreases u_thresh to reduce collisions but increases
  * the table size
@@ -1587,6 +1607,10 @@ static inline void __ip_vs_conn_put(struct ip_vs_conn *cp)
 }
 void ip_vs_conn_put(struct ip_vs_conn *cp);
 void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport);
+int ip_vs_conn_desired_size(struct netns_ipvs *ipvs, struct ip_vs_rht *t,
+			    int lfactor);
+struct ip_vs_rht *ip_vs_conn_tab_alloc(struct netns_ipvs *ipvs, int buckets,
+				       int lfactor);
 
 struct ip_vs_conn *ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 				  const union nf_inet_addr *daddr,
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index a24af0ea59eb..68d25dbb38a5 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -48,14 +48,8 @@ static int ip_vs_conn_tab_bits = CONFIG_IP_VS_TAB_BITS;
 module_param_named(conn_tab_bits, ip_vs_conn_tab_bits, int, 0444);
 MODULE_PARM_DESC(conn_tab_bits, "Set connections' hash size");
 
-/* size and mask values */
+/* Max table size */
 int ip_vs_conn_tab_size __read_mostly;
-static int ip_vs_conn_tab_mask __read_mostly;
-
-/*
- *  Connection hash table: for input and output packets lookups of IPVS
- */
-static struct hlist_head *ip_vs_conn_tab __read_mostly;
 
 /*  SLAB cache for IPVS connections */
 static struct kmem_cache *ip_vs_conn_cachep __read_mostly;
@@ -63,16 +57,6 @@ static struct kmem_cache *ip_vs_conn_cachep __read_mostly;
 /*  counter for no client port connections */
 static atomic_t ip_vs_conn_no_cport_cnt = ATOMIC_INIT(0);
 
-/* random value for IPVS connection hash */
-static unsigned int ip_vs_conn_rnd __read_mostly;
-
-/*
- *  Fine locking granularity for big connection hash table
- */
-#define CT_LOCKARRAY_BITS  5
-#define CT_LOCKARRAY_SIZE  (1<<CT_LOCKARRAY_BITS)
-#define CT_LOCKARRAY_MASK  (CT_LOCKARRAY_SIZE-1)
-
 /* We need an addrstrlen that works with or without v6 */
 #ifdef CONFIG_IP_VS_IPV6
 #define IP_VS_ADDRSTRLEN INET6_ADDRSTRLEN
@@ -80,18 +64,61 @@ static unsigned int ip_vs_conn_rnd __read_mostly;
 #define IP_VS_ADDRSTRLEN (8+1)
 #endif
 
-/* lock array for conn table */
-static struct ip_vs_aligned_lock
-__ip_vs_conntbl_lock_array[CT_LOCKARRAY_SIZE] __cacheline_aligned;
+/* Connection hashing:
+ * - hash (add conn) and unhash (del conn) are safe for RCU readers walking
+ * the bucket, they will not jump to another bucket or hash table and to miss
+ * conns
+ * - rehash (fill cport) hashes the conn to new bucket or even new table,
+ * so we use seqcount to retry lookups on buckets where we delete
+ * conns (unhash) because after hashing their next ptr can point to another
+ * bucket or hash table
+ * - hash table resize works like rehash but always rehashes into new table
+ * - bit lock on bucket serializes all operations that modify the chain
+ * - cp->lock protects conn fields like cp->flags, cp->dest
+ */
 
-static inline void ct_write_lock_bh(unsigned int key)
+/* Lock conn_tab bucket for conn hash/unhash, not for rehash */
+static __always_inline void
+conn_tab_lock(struct ip_vs_rht *t, struct ip_vs_conn *cp, u32 hash_key,
+	      bool new_hash, struct hlist_bl_head **head_ret)
 {
-	spin_lock_bh(&__ip_vs_conntbl_lock_array[key&CT_LOCKARRAY_MASK].l);
+	struct hlist_bl_head *head;
+	u32 hash_key_new;
+
+	if (!new_hash) {
+		/* We need to lock the bucket in the right table */
+
+retry:
+		if (!ip_vs_rht_same_table(t, hash_key)) {
+			/* It is already moved to new table */
+			t = rcu_dereference(t->new_tbl);
+		}
+	}
+
+	head = t->buckets + (hash_key & t->mask);
+
+	local_bh_disable();
+	/* Do not touch seqcount, this is a safe operation */
+
+	hlist_bl_lock(head);
+	if (!new_hash) {
+		/* Ensure hash_key is read under lock */
+		hash_key_new = READ_ONCE(cp->hash_key);
+		/* Hash changed ? */
+		if (hash_key != hash_key_new) {
+			hlist_bl_unlock(head);
+			local_bh_enable();
+			hash_key = hash_key_new;
+			goto retry;
+		}
+	}
+	*head_ret = head;
 }
 
-static inline void ct_write_unlock_bh(unsigned int key)
+static inline void conn_tab_unlock(struct hlist_bl_head *head)
 {
-	spin_unlock_bh(&__ip_vs_conntbl_lock_array[key&CT_LOCKARRAY_MASK].l);
+	hlist_bl_unlock(head);
+	local_bh_enable();
 }
 
 static void ip_vs_conn_expire(struct timer_list *t);
@@ -99,30 +126,31 @@ static void ip_vs_conn_expire(struct timer_list *t);
 /*
  *	Returns hash value for IPVS connection entry
  */
-static unsigned int ip_vs_conn_hashkey(struct netns_ipvs *ipvs, int af, unsigned int proto,
-				       const union nf_inet_addr *addr,
-				       __be16 port)
+static u32 ip_vs_conn_hashkey(struct ip_vs_rht *t, int af, unsigned int proto,
+			      const union nf_inet_addr *addr, __be16 port)
 {
+	u64 a = (u32)proto << 16 | (__force u32)port;
+
 #ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		return (jhash_3words(jhash(addr, 16, ip_vs_conn_rnd),
-				    (__force u32)port, proto, ip_vs_conn_rnd) ^
-			((size_t)ipvs>>8)) & ip_vs_conn_tab_mask;
+	if (af == AF_INET6) {
+		u64 b = (u64)addr->all[0] << 32 | addr->all[1];
+		u64 c = (u64)addr->all[2] << 32 | addr->all[3];
+
+		return (u32)siphash_3u64(a, b, c, &t->hash_key);
+	}
 #endif
-	return (jhash_3words((__force u32)addr->ip, (__force u32)port, proto,
-			    ip_vs_conn_rnd) ^
-		((size_t)ipvs>>8)) & ip_vs_conn_tab_mask;
+	a |= (u64)addr->all[0] << 32;
+	return (u32)siphash_1u64(a, &t->hash_key);
 }
 
 static unsigned int ip_vs_conn_hashkey_param(const struct ip_vs_conn_param *p,
-					     bool inverse)
+					     struct ip_vs_rht *t, bool inverse)
 {
 	const union nf_inet_addr *addr;
 	__be16 port;
 
 	if (p->pe_data && p->pe->hashkey_raw)
-		return p->pe->hashkey_raw(p, ip_vs_conn_rnd, inverse) &
-			ip_vs_conn_tab_mask;
+		return p->pe->hashkey_raw(p, t, inverse);
 
 	if (likely(!inverse)) {
 		addr = p->caddr;
@@ -132,10 +160,11 @@ static unsigned int ip_vs_conn_hashkey_param(const struct ip_vs_conn_param *p,
 		port = p->vport;
 	}
 
-	return ip_vs_conn_hashkey(p->ipvs, p->af, p->protocol, addr, port);
+	return ip_vs_conn_hashkey(t, p->af, p->protocol, addr, port);
 }
 
-static unsigned int ip_vs_conn_hashkey_conn(const struct ip_vs_conn *cp)
+static unsigned int ip_vs_conn_hashkey_conn(struct ip_vs_rht *t,
+					    const struct ip_vs_conn *cp)
 {
 	struct ip_vs_conn_param p;
 
@@ -148,31 +177,36 @@ static unsigned int ip_vs_conn_hashkey_conn(const struct ip_vs_conn *cp)
 		p.pe_data_len = cp->pe_data_len;
 	}
 
-	return ip_vs_conn_hashkey_param(&p, false);
+	return ip_vs_conn_hashkey_param(&p, t, false);
 }
 
-/*
- *	Hashes ip_vs_conn in ip_vs_conn_tab by netns,proto,addr,port.
+/*	Hashes ip_vs_conn in conn_tab
  *	returns bool success.
  */
 static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 {
-	unsigned int hash;
+	struct netns_ipvs *ipvs = cp->ipvs;
+	struct hlist_bl_head *head;
+	struct ip_vs_rht *t;
+	u32 hash_key;
 	int ret;
 
 	if (cp->flags & IP_VS_CONN_F_ONE_PACKET)
 		return 0;
 
-	/* Hash by protocol, client address and port */
-	hash = ip_vs_conn_hashkey_conn(cp);
+	/* New entries go into recent table */
+	t = rcu_dereference(ipvs->conn_tab);
+	t = rcu_dereference(t->new_tbl);
 
-	ct_write_lock_bh(hash);
+	hash_key = ip_vs_rht_build_hash_key(t, ip_vs_conn_hashkey_conn(t, cp));
+	conn_tab_lock(t, cp, hash_key, true /* new_hash */, &head);
 	spin_lock(&cp->lock);
 
 	if (!(cp->flags & IP_VS_CONN_F_HASHED)) {
 		cp->flags |= IP_VS_CONN_F_HASHED;
+		WRITE_ONCE(cp->hash_key, hash_key);
 		refcount_inc(&cp->refcnt);
-		hlist_add_head_rcu(&cp->c_list, &ip_vs_conn_tab[hash]);
+		hlist_bl_add_head_rcu(&cp->c_list, head);
 		ret = 1;
 	} else {
 		pr_err("%s(): request for already hashed, called from %pS\n",
@@ -181,75 +215,58 @@ static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 	}
 
 	spin_unlock(&cp->lock);
-	ct_write_unlock_bh(hash);
-
-	return ret;
-}
-
+	conn_tab_unlock(head);
 
-/*
- *	UNhashes ip_vs_conn from ip_vs_conn_tab.
- *	returns bool success. Caller should hold conn reference.
- */
-static inline int ip_vs_conn_unhash(struct ip_vs_conn *cp)
-{
-	unsigned int hash;
-	int ret;
-
-	/* unhash it and decrease its reference counter */
-	hash = ip_vs_conn_hashkey_conn(cp);
-
-	ct_write_lock_bh(hash);
-	spin_lock(&cp->lock);
-
-	if (cp->flags & IP_VS_CONN_F_HASHED) {
-		hlist_del_rcu(&cp->c_list);
-		cp->flags &= ~IP_VS_CONN_F_HASHED;
-		refcount_dec(&cp->refcnt);
-		ret = 1;
-	} else
-		ret = 0;
-
-	spin_unlock(&cp->lock);
-	ct_write_unlock_bh(hash);
+	/* Schedule resizing if load increases */
+	if (atomic_read(&ipvs->conn_count) > t->u_thresh &&
+	    !test_and_set_bit(IP_VS_WORK_CONN_RESIZE, &ipvs->work_flags))
+		mod_delayed_work(system_unbound_wq, &ipvs->conn_resize_work, 0);
 
 	return ret;
 }
 
-/* Try to unlink ip_vs_conn from ip_vs_conn_tab.
+/* Try to unlink ip_vs_conn from conn_tab.
  * returns bool success.
  */
 static inline bool ip_vs_conn_unlink(struct ip_vs_conn *cp)
 {
-	unsigned int hash;
+	struct netns_ipvs *ipvs = cp->ipvs;
+	struct hlist_bl_head *head;
+	struct ip_vs_rht *t;
 	bool ret = false;
+	u32 hash_key;
 
 	if (cp->flags & IP_VS_CONN_F_ONE_PACKET)
 		return refcount_dec_if_one(&cp->refcnt);
 
-	hash = ip_vs_conn_hashkey_conn(cp);
+	rcu_read_lock();
+
+	t = rcu_dereference(ipvs->conn_tab);
+	hash_key = READ_ONCE(cp->hash_key);
 
-	ct_write_lock_bh(hash);
+	conn_tab_lock(t, cp, hash_key, false /* new_hash */, &head);
 	spin_lock(&cp->lock);
 
 	if (cp->flags & IP_VS_CONN_F_HASHED) {
 		/* Decrease refcnt and unlink conn only if we are last user */
 		if (refcount_dec_if_one(&cp->refcnt)) {
-			hlist_del_rcu(&cp->c_list);
+			hlist_bl_del_rcu(&cp->c_list);
 			cp->flags &= ~IP_VS_CONN_F_HASHED;
 			ret = true;
 		}
 	}
 
 	spin_unlock(&cp->lock);
-	ct_write_unlock_bh(hash);
+	conn_tab_unlock(head);
+
+	rcu_read_unlock();
 
 	return ret;
 }
 
 
 /*
- *  Gets ip_vs_conn associated with supplied parameters in the ip_vs_conn_tab.
+ *  Gets ip_vs_conn associated with supplied parameters in the conn_tab.
  *  Called for pkts coming from OUTside-to-INside.
  *	p->caddr, p->cport: pkt source address (foreign host)
  *	p->vaddr, p->vport: pkt dest address (load balancer)
@@ -257,26 +274,38 @@ static inline bool ip_vs_conn_unlink(struct ip_vs_conn *cp)
 static inline struct ip_vs_conn *
 __ip_vs_conn_in_get(const struct ip_vs_conn_param *p)
 {
-	unsigned int hash;
+	DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
+	struct netns_ipvs *ipvs = p->ipvs;
+	struct hlist_bl_head *head;
+	struct ip_vs_rht *t, *pt;
+	struct hlist_bl_node *e;
 	struct ip_vs_conn *cp;
-
-	hash = ip_vs_conn_hashkey_param(p, false);
+	u32 hash, hash_key;
 
 	rcu_read_lock();
 
-	hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[hash], c_list) {
-		if (p->cport == cp->cport && p->vport == cp->vport &&
-		    cp->af == p->af &&
-		    ip_vs_addr_equal(p->af, p->caddr, &cp->caddr) &&
-		    ip_vs_addr_equal(p->af, p->vaddr, &cp->vaddr) &&
-		    ((!p->cport) ^ (!(cp->flags & IP_VS_CONN_F_NO_CPORT))) &&
-		    p->protocol == cp->protocol &&
-		    cp->ipvs == p->ipvs) {
-			if (!__ip_vs_conn_get(cp))
-				continue;
-			/* HIT */
-			rcu_read_unlock();
-			return cp;
+	ip_vs_rht_for_each_table_rcu(ipvs->conn_tab, t, pt) {
+		hash = ip_vs_conn_hashkey_param(p, t, false);
+		hash_key = ip_vs_rht_build_hash_key(t, hash);
+		ip_vs_rht_walk_bucket_rcu(t, hash_key, head) {
+			hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
+				if (READ_ONCE(cp->hash_key) == hash_key &&
+				    p->cport == cp->cport &&
+				    p->vport == cp->vport && cp->af == p->af &&
+				    ip_vs_addr_equal(p->af, p->caddr,
+						     &cp->caddr) &&
+				    ip_vs_addr_equal(p->af, p->vaddr,
+						     &cp->vaddr) &&
+				    (!p->cport ^
+				     (!(cp->flags & IP_VS_CONN_F_NO_CPORT))) &&
+				    p->protocol == cp->protocol) {
+					if (__ip_vs_conn_get(cp)) {
+						/* HIT */
+						rcu_read_unlock();
+						return cp;
+					}
+				}
+			}
 		}
 	}
 
@@ -343,37 +372,50 @@ EXPORT_SYMBOL_GPL(ip_vs_conn_in_get_proto);
 /* Get reference to connection template */
 struct ip_vs_conn *ip_vs_ct_in_get(const struct ip_vs_conn_param *p)
 {
-	unsigned int hash;
+	DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
+	struct netns_ipvs *ipvs = p->ipvs;
+	struct hlist_bl_head *head;
+	struct ip_vs_rht *t, *pt;
+	struct hlist_bl_node *e;
 	struct ip_vs_conn *cp;
-
-	hash = ip_vs_conn_hashkey_param(p, false);
+	u32 hash, hash_key;
 
 	rcu_read_lock();
 
-	hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[hash], c_list) {
-		if (unlikely(p->pe_data && p->pe->ct_match)) {
-			if (cp->ipvs != p->ipvs)
-				continue;
-			if (p->pe == cp->pe && p->pe->ct_match(p, cp)) {
-				if (__ip_vs_conn_get(cp))
-					goto out;
+	ip_vs_rht_for_each_table_rcu(ipvs->conn_tab, t, pt) {
+		hash = ip_vs_conn_hashkey_param(p, t, false);
+		hash_key = ip_vs_rht_build_hash_key(t, hash);
+		ip_vs_rht_walk_bucket_rcu(t, hash_key, head) {
+			hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
+				if (READ_ONCE(cp->hash_key) != hash_key)
+					continue;
+				if (unlikely(p->pe_data && p->pe->ct_match)) {
+					if (p->pe == cp->pe &&
+					    p->pe->ct_match(p, cp) &&
+					    __ip_vs_conn_get(cp))
+						goto out;
+					continue;
+				}
+				if (cp->af == p->af &&
+				    ip_vs_addr_equal(p->af, p->caddr,
+						     &cp->caddr) &&
+				    /* protocol should only be IPPROTO_IP if
+				     * p->vaddr is a fwmark
+				     */
+				    ip_vs_addr_equal(p->protocol == IPPROTO_IP ?
+						     AF_UNSPEC : p->af,
+						     p->vaddr, &cp->vaddr) &&
+				    p->vport == cp->vport &&
+				    p->cport == cp->cport &&
+				    cp->flags & IP_VS_CONN_F_TEMPLATE &&
+				    p->protocol == cp->protocol &&
+				    cp->dport != htons(0xffff)) {
+					if (__ip_vs_conn_get(cp))
+						goto out;
+				}
 			}
-			continue;
 		}
 
-		if (cp->af == p->af &&
-		    ip_vs_addr_equal(p->af, p->caddr, &cp->caddr) &&
-		    /* protocol should only be IPPROTO_IP if
-		     * p->vaddr is a fwmark */
-		    ip_vs_addr_equal(p->protocol == IPPROTO_IP ? AF_UNSPEC :
-				     p->af, p->vaddr, &cp->vaddr) &&
-		    p->vport == cp->vport && p->cport == cp->cport &&
-		    cp->flags & IP_VS_CONN_F_TEMPLATE &&
-		    p->protocol == cp->protocol &&
-		    cp->ipvs == p->ipvs) {
-			if (__ip_vs_conn_get(cp))
-				goto out;
-		}
 	}
 	cp = NULL;
 
@@ -389,58 +431,64 @@ struct ip_vs_conn *ip_vs_ct_in_get(const struct ip_vs_conn_param *p)
 	return cp;
 }
 
-/* Gets ip_vs_conn associated with supplied parameters in the ip_vs_conn_tab.
+/* Gets ip_vs_conn associated with supplied parameters in the conn_tab.
  * Called for pkts coming from inside-to-OUTside.
  *	p->caddr, p->cport: pkt source address (inside host)
  *	p->vaddr, p->vport: pkt dest address (foreign host) */
 struct ip_vs_conn *ip_vs_conn_out_get(const struct ip_vs_conn_param *p)
 {
-	unsigned int hash;
-	struct ip_vs_conn *cp, *ret=NULL;
+	DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
+	struct netns_ipvs *ipvs = p->ipvs;
 	const union nf_inet_addr *saddr;
+	struct hlist_bl_head *head;
+	struct ip_vs_rht *t, *pt;
+	struct hlist_bl_node *e;
+	struct ip_vs_conn *cp;
+	u32 hash, hash_key;
 	__be16 sport;
 
-	/*
-	 *	Check for "full" addressed entries
-	 */
-	hash = ip_vs_conn_hashkey_param(p, true);
-
 	rcu_read_lock();
 
-	hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[hash], c_list) {
-		if (p->vport != cp->cport)
-			continue;
+	ip_vs_rht_for_each_table_rcu(ipvs->conn_tab, t, pt) {
+		hash = ip_vs_conn_hashkey_param(p, t, true);
+		hash_key = ip_vs_rht_build_hash_key(t, hash);
+		ip_vs_rht_walk_bucket_rcu(t, hash_key, head) {
+			hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
+				if (READ_ONCE(cp->hash_key) != hash_key ||
+				    p->vport != cp->cport)
+					continue;
 
-		if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ) {
-			sport = cp->vport;
-			saddr = &cp->vaddr;
-		} else {
-			sport = cp->dport;
-			saddr = &cp->daddr;
-		}
+				if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ) {
+					sport = cp->vport;
+					saddr = &cp->vaddr;
+				} else {
+					sport = cp->dport;
+					saddr = &cp->daddr;
+				}
 
-		if (p->cport == sport && cp->af == p->af &&
-		    ip_vs_addr_equal(p->af, p->vaddr, &cp->caddr) &&
-		    ip_vs_addr_equal(p->af, p->caddr, saddr) &&
-		    p->protocol == cp->protocol &&
-		    cp->ipvs == p->ipvs) {
-			if (!__ip_vs_conn_get(cp))
-				continue;
-			/* HIT */
-			ret = cp;
-			break;
+				if (p->cport == sport && cp->af == p->af &&
+				    ip_vs_addr_equal(p->af, p->vaddr,
+						     &cp->caddr) &&
+				    ip_vs_addr_equal(p->af, p->caddr, saddr) &&
+				    p->protocol == cp->protocol) {
+					if (__ip_vs_conn_get(cp))
+						goto out;
+				}
+			}
 		}
 	}
+	cp = NULL;
 
+out:
 	rcu_read_unlock();
 
 	IP_VS_DBG_BUF(9, "lookup/out %s %s:%d->%s:%d %s\n",
 		      ip_vs_proto_name(p->protocol),
 		      IP_VS_DBG_ADDR(p->af, p->caddr), ntohs(p->cport),
 		      IP_VS_DBG_ADDR(p->af, p->vaddr), ntohs(p->vport),
-		      ret ? "hit" : "not hit");
+		      cp ? "hit" : "not hit");
 
-	return ret;
+	return cp;
 }
 
 struct ip_vs_conn *
@@ -485,20 +533,260 @@ void ip_vs_conn_put(struct ip_vs_conn *cp)
  */
 void ip_vs_conn_fill_cport(struct ip_vs_conn *cp, __be16 cport)
 {
-	if (ip_vs_conn_unhash(cp)) {
-		spin_lock_bh(&cp->lock);
-		if (cp->flags & IP_VS_CONN_F_NO_CPORT) {
-			atomic_dec(&ip_vs_conn_no_cport_cnt);
-			cp->flags &= ~IP_VS_CONN_F_NO_CPORT;
-			cp->cport = cport;
-		}
-		spin_unlock_bh(&cp->lock);
+	struct hlist_bl_head *head, *head2, *head_new;
+	struct netns_ipvs *ipvs = cp->ipvs;
+	u32 hash_r = 0, hash_key_r = 0;
+	struct ip_vs_rht *t, *tp, *t2;
+	u32 hash_key, hash_key_new;
+	struct ip_vs_conn_param p;
+	int ntbl;
+
+	ip_vs_conn_fill_param(ipvs, cp->af, cp->protocol, &cp->caddr,
+			      cport, &cp->vaddr, cp->vport, &p);
+	ntbl = 0;
+
+	/* Attempt to rehash cp safely, by informing seqcount readers */
+	t = rcu_dereference(ipvs->conn_tab);
+	hash_key = READ_ONCE(cp->hash_key);
+	tp = NULL;
+
+retry:
+	/* Moved to new table ? */
+	if (!ip_vs_rht_same_table(t, hash_key)) {
+		t = rcu_dereference(t->new_tbl);
+		ntbl++;
+		/* We are lost? */
+		if (ntbl >= 2)
+			return;
+	}
+
+	/* Rehashing during resize? Use the recent table for adds */
+	t2 = rcu_dereference(t->new_tbl);
+	/* Calc new hash once per table */
+	if (tp != t2) {
+		hash_r = ip_vs_conn_hashkey_param(&p, t2, false);
+		hash_key_r = ip_vs_rht_build_hash_key(t2, hash_r);
+		tp = t2;
+	}
+	head = t->buckets + (hash_key & t->mask);
+	head2 = t2->buckets + (hash_key_r & t2->mask);
+	head_new = head2;
 
-		/* hash on new dport */
-		ip_vs_conn_hash(cp);
+	if (head > head2 && t == t2)
+		swap(head, head2);
+
+	/* Lock seqcount only for the old bucket, even if we are on new table
+	 * because it affacts the del operation, not the adding.
+	 */
+	spin_lock_bh(&t->lock[hash_key & t->lock_mask].l);
+	preempt_disable_nested();
+	write_seqcount_begin(&t->seqc[hash_key & t->seqc_mask]);
+
+	/* Lock buckets in same (increasing) order */
+	hlist_bl_lock(head);
+	if (head != head2)
+		hlist_bl_lock(head2);
+
+	/* Ensure hash_key is read under lock */
+	hash_key_new = READ_ONCE(cp->hash_key);
+	/* Racing with another rehashing ? */
+	if (unlikely(hash_key != hash_key_new)) {
+		if (head != head2)
+			hlist_bl_unlock(head2);
+		hlist_bl_unlock(head);
+		write_seqcount_end(&t->seqc[hash_key & t->seqc_mask]);
+		preempt_enable_nested();
+		spin_unlock_bh(&t->lock[hash_key & t->lock_mask].l);
+		hash_key = hash_key_new;
+		goto retry;
 	}
+
+	spin_lock(&cp->lock);
+	if ((cp->flags & IP_VS_CONN_F_NO_CPORT) &&
+	    (cp->flags & IP_VS_CONN_F_HASHED)) {
+		/* We do not recalc hash_key_r under lock, we assume the
+		 * parameters in cp do not change, i.e. cport is
+		 * the only possible change.
+		 */
+		WRITE_ONCE(cp->hash_key, hash_key_r);
+		if (head != head2) {
+			hlist_bl_del_rcu(&cp->c_list);
+			hlist_bl_add_head_rcu(&cp->c_list, head_new);
+		}
+		atomic_dec(&ip_vs_conn_no_cport_cnt);
+		cp->flags &= ~IP_VS_CONN_F_NO_CPORT;
+		cp->cport = cport;
+	}
+	spin_unlock(&cp->lock);
+
+	if (head != head2)
+		hlist_bl_unlock(head2);
+	hlist_bl_unlock(head);
+	write_seqcount_end(&t->seqc[hash_key & t->seqc_mask]);
+	preempt_enable_nested();
+	spin_unlock_bh(&t->lock[hash_key & t->lock_mask].l);
+}
+
+/* Get default load factor to map conn_count/u_thresh to t->size */
+static int ip_vs_conn_default_load_factor(struct netns_ipvs *ipvs)
+{
+	int factor;
+
+	if (net_eq(ipvs->net, &init_net))
+		factor = -3;
+	else
+		factor = -1;
+	return factor;
+}
+
+/* Get the desired conn_tab size */
+int ip_vs_conn_desired_size(struct netns_ipvs *ipvs, struct ip_vs_rht *t,
+			    int lfactor)
+{
+	return ip_vs_rht_desired_size(ipvs, t, atomic_read(&ipvs->conn_count),
+				      lfactor, IP_VS_CONN_TAB_MIN_BITS,
+				      ip_vs_conn_tab_bits);
+}
+
+/* Allocate conn_tab */
+struct ip_vs_rht *ip_vs_conn_tab_alloc(struct netns_ipvs *ipvs, int buckets,
+				       int lfactor)
+{
+	struct ip_vs_rht *t;
+	int scounts, locks;
+
+	/* scounts: affects readers during resize */
+	scounts = clamp(buckets >> 6, 1, 256);
+	/* locks: based on parallel IP_VS_CONN_F_NO_CPORT operations + resize */
+	locks = clamp(8, 1, scounts);
+
+	t = ip_vs_rht_alloc(buckets, scounts, locks);
+	if (!t)
+		return NULL;
+	t->lfactor = lfactor;
+	ip_vs_rht_set_thresholds(t, t->size, lfactor, IP_VS_CONN_TAB_MIN_BITS,
+				 ip_vs_conn_tab_bits);
+	return t;
 }
 
+/* conn_tab resizer work */
+static void conn_resize_work_handler(struct work_struct *work)
+{
+	struct hlist_bl_head *head, *head2;
+	unsigned int resched_score = 0;
+	struct hlist_bl_node *cn, *nn;
+	struct ip_vs_rht *t, *t_new;
+	struct netns_ipvs *ipvs;
+	struct ip_vs_conn *cp;
+	bool more_work = false;
+	u32 hash, hash_key;
+	int limit = 0;
+	int new_size;
+	int lfactor;
+	u32 bucket;
+
+	ipvs = container_of(work, struct netns_ipvs, conn_resize_work.work);
+
+	/* Allow work to be queued again */
+	clear_bit(IP_VS_WORK_CONN_RESIZE, &ipvs->work_flags);
+	t = rcu_dereference_protected(ipvs->conn_tab, 1);
+	/* Do nothing if table is removed */
+	if (!t)
+		goto out;
+	/* New table needs to be registered? BUG! */
+	if (t != rcu_dereference_protected(t->new_tbl, 1))
+		goto out;
+
+	lfactor = sysctl_conn_lfactor(ipvs);
+	/* Should we resize ? */
+	new_size = ip_vs_conn_desired_size(ipvs, t, lfactor);
+	if (new_size == t->size && lfactor == t->lfactor)
+		goto out;
+
+	t_new = ip_vs_conn_tab_alloc(ipvs, new_size, lfactor);
+	if (!t_new) {
+		more_work = true;
+		goto out;
+	}
+	/* Flip the table_id */
+	t_new->table_id = t->table_id ^ IP_VS_RHT_TABLE_ID_MASK;
+
+	rcu_assign_pointer(t->new_tbl, t_new);
+
+	/* Wait RCU readers to see the new table, we do not want new
+	 * conns to go into old table and to be left there.
+	 */
+	synchronize_rcu();
+
+	ip_vs_rht_for_each_bucket(t, bucket, head) {
+same_bucket:
+		if (++limit >= 16) {
+			if (resched_score >= 100) {
+				resched_score = 0;
+				cond_resched();
+			}
+			limit = 0;
+		}
+		if (hlist_bl_empty(head)) {
+			resched_score++;
+			continue;
+		}
+		/* Preemption calls ahead... */
+		resched_score = 0;
+
+		/* seqcount_t usage considering PREEMPT_RT rules:
+		 * - other writers (SoftIRQ) => serialize with spin_lock_bh
+		 * - readers (SoftIRQ) => disable BHs
+		 * - readers (processes) => preemption should be disabled
+		 */
+		spin_lock_bh(&t->lock[bucket & t->lock_mask].l);
+		preempt_disable_nested();
+		write_seqcount_begin(&t->seqc[bucket & t->seqc_mask]);
+		hlist_bl_lock(head);
+
+		hlist_bl_for_each_entry_safe(cp, cn, nn, head, c_list) {
+			hash = ip_vs_conn_hashkey_conn(t_new, cp);
+			hash_key = ip_vs_rht_build_hash_key(t_new, hash);
+
+			head2 = t_new->buckets + (hash & t_new->mask);
+			hlist_bl_lock(head2);
+			/* t_new->seqc are not used at this stage, we race
+			 * only with add/del, so only lock the bucket.
+			 */
+			hlist_bl_del_rcu(&cp->c_list);
+			WRITE_ONCE(cp->hash_key, hash_key);
+			hlist_bl_add_head_rcu(&cp->c_list, head2);
+			hlist_bl_unlock(head2);
+			/* Too long chain? Do it in steps */
+			if (++limit >= 64)
+				break;
+		}
+
+		hlist_bl_unlock(head);
+		write_seqcount_end(&t->seqc[bucket & t->seqc_mask]);
+		preempt_enable_nested();
+		spin_unlock_bh(&t->lock[bucket & t->lock_mask].l);
+		if (limit >= 64)
+			goto same_bucket;
+	}
+
+	rcu_assign_pointer(ipvs->conn_tab, t_new);
+	/* Inform readers that new table is installed */
+	smp_mb__before_atomic();
+	atomic_inc(&ipvs->conn_tab_changes);
+
+	/* RCU readers should not see more than two tables in chain.
+	 * To prevent new table to be attached wait here instead of
+	 * freeing the old table in RCU callback.
+	 */
+	synchronize_rcu();
+	ip_vs_rht_free(t);
+
+out:
+	/* Monitor if we need to shrink table */
+	queue_delayed_work(system_unbound_wq, &ipvs->conn_resize_work,
+			   more_work ? 1 : 2 * HZ);
+}
 
 /*
  *	Bind a connection entry with the corresponding packet_xmit.
@@ -782,17 +1070,11 @@ int ip_vs_check_template(struct ip_vs_conn *ct, struct ip_vs_dest *cdest)
 			      IP_VS_DBG_ADDR(ct->daf, &ct->daddr),
 			      ntohs(ct->dport));
 
-		/*
-		 * Invalidate the connection template
+		/* Invalidate the connection template. Prefer to avoid
+		 * rehashing, it will move it as first in chain, so use
+		 * only dport as indication, it is not a hash key.
 		 */
-		if (ct->vport != htons(0xffff)) {
-			if (ip_vs_conn_unhash(ct)) {
-				ct->dport = htons(0xffff);
-				ct->vport = htons(0xffff);
-				ct->cport = 0;
-				ip_vs_conn_hash(ct);
-			}
-		}
+		ct->dport = htons(0xffff);
 
 		/*
 		 * Simply decrease the refcnt of the template,
@@ -930,7 +1212,7 @@ void ip_vs_conn_expire_now(struct ip_vs_conn *cp)
 
 
 /*
- *	Create a new connection entry and hash it into the ip_vs_conn_tab
+ *	Create a new connection entry and hash it into the conn_tab
  */
 struct ip_vs_conn *
 ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
@@ -948,7 +1230,7 @@ ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 		return NULL;
 	}
 
-	INIT_HLIST_NODE(&cp->c_list);
+	INIT_HLIST_BL_NODE(&cp->c_list);
 	timer_setup(&cp->timer, ip_vs_conn_expire, 0);
 	cp->ipvs	   = ipvs;
 	cp->af		   = p->af;
@@ -1029,7 +1311,7 @@ ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 	if (ip_vs_conntrack_enabled(ipvs))
 		cp->flags |= IP_VS_CONN_F_NFCT;
 
-	/* Hash it in the ip_vs_conn_tab finally */
+	/* Hash it in the conn_tab finally */
 	ip_vs_conn_hash(cp);
 
 	return cp;
@@ -1041,26 +1323,41 @@ ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 #ifdef CONFIG_PROC_FS
 struct ip_vs_iter_state {
 	struct seq_net_private	p;
-	struct hlist_head	*l;
+	struct ip_vs_rht *t;
+	u32 bucket;
+	int gen;
 };
 
 static void *ip_vs_conn_array(struct seq_file *seq, loff_t pos)
 {
-	int idx;
-	struct ip_vs_conn *cp;
 	struct ip_vs_iter_state *iter = seq->private;
+	struct net *net = seq_file_net(seq);
+	struct netns_ipvs *ipvs = net_ipvs(net);
+	struct ip_vs_rht *t = iter->t;
+	struct hlist_bl_node *e;
+	struct ip_vs_conn *cp;
+	int idx;
 
-	for (idx = 0; idx < ip_vs_conn_tab_size; idx++) {
-		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
+	if (!t)
+		return NULL;
+	for (idx = 0; idx < t->size; idx++) {
+		hlist_bl_for_each_entry_rcu(cp, e, &t->buckets[idx], c_list) {
 			/* __ip_vs_conn_get() is not needed by
 			 * ip_vs_conn_seq_show and ip_vs_conn_sync_seq_show
 			 */
+			if (!ip_vs_rht_same_table(t, READ_ONCE(cp->hash_key)))
+				break;
 			if (pos-- == 0) {
-				iter->l = &ip_vs_conn_tab[idx];
+				iter->bucket = idx;
 				return cp;
 			}
 		}
-		cond_resched_rcu();
+		if (!(idx & 31)) {
+			cond_resched_rcu();
+			/* New table installed ? */
+			if (iter->gen != atomic_read(&ipvs->conn_tab_changes))
+				break;
+		}
 	}
 
 	return NULL;
@@ -1070,38 +1367,55 @@ static void *ip_vs_conn_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
 	struct ip_vs_iter_state *iter = seq->private;
+	struct net *net = seq_file_net(seq);
+	struct netns_ipvs *ipvs = net_ipvs(net);
 
-	iter->l = NULL;
 	rcu_read_lock();
+	iter->gen = atomic_read(&ipvs->conn_tab_changes);
+	smp_rmb(); /* ipvs->conn_tab and conn_tab_changes */
+	iter->t = rcu_dereference(ipvs->conn_tab);
 	return *pos ? ip_vs_conn_array(seq, *pos - 1) :SEQ_START_TOKEN;
 }
 
 static void *ip_vs_conn_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct ip_vs_conn *cp = v;
 	struct ip_vs_iter_state *iter = seq->private;
-	struct hlist_node *e;
-	struct hlist_head *l = iter->l;
-	int idx;
+	struct net *net = seq_file_net(seq);
+	struct netns_ipvs *ipvs = net_ipvs(net);
+	struct ip_vs_conn *cp = v;
+	struct hlist_bl_node *e;
+	struct ip_vs_rht *t;
 
 	++*pos;
 	if (v == SEQ_START_TOKEN)
 		return ip_vs_conn_array(seq, 0);
 
+	t = iter->t;
+	if (!t)
+		return NULL;
+
 	/* more on same hash chain? */
-	e = rcu_dereference(hlist_next_rcu(&cp->c_list));
-	if (e)
-		return hlist_entry(e, struct ip_vs_conn, c_list);
-
-	idx = l - ip_vs_conn_tab;
-	while (++idx < ip_vs_conn_tab_size) {
-		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
-			iter->l = &ip_vs_conn_tab[idx];
+	hlist_bl_for_each_entry_continue_rcu(cp, e, c_list) {
+		/* Our cursor was moved to new table ? */
+		if (!ip_vs_rht_same_table(t, READ_ONCE(cp->hash_key)))
+			break;
+		return cp;
+	}
+
+	while (++iter->bucket < t->size) {
+		hlist_bl_for_each_entry_rcu(cp, e, &t->buckets[iter->bucket],
+					    c_list) {
+			if (!ip_vs_rht_same_table(t, READ_ONCE(cp->hash_key)))
+				break;
 			return cp;
 		}
-		cond_resched_rcu();
+		if (!(iter->bucket & 31)) {
+			cond_resched_rcu();
+			/* New table installed ? */
+			if (iter->gen != atomic_read(&ipvs->conn_tab_changes))
+				break;
+		}
 	}
-	iter->l = NULL;
 	return NULL;
 }
 
@@ -1119,13 +1433,10 @@ static int ip_vs_conn_seq_show(struct seq_file *seq, void *v)
    "Pro FromIP   FPrt ToIP     TPrt DestIP   DPrt State       Expires PEName PEData\n");
 	else {
 		const struct ip_vs_conn *cp = v;
-		struct net *net = seq_file_net(seq);
 		char pe_data[IP_VS_PENAME_MAXLEN + IP_VS_PEDATA_MAXLEN + 3];
 		size_t len = 0;
 		char dbuf[IP_VS_ADDRSTRLEN];
 
-		if (!net_eq(cp->ipvs->net, net))
-			return 0;
 		if (cp->pe_data) {
 			pe_data[0] = ' ';
 			len = strlen(cp->pe->name);
@@ -1197,10 +1508,6 @@ static int ip_vs_conn_sync_seq_show(struct seq_file *seq, void *v)
    "Pro FromIP   FPrt ToIP     TPrt DestIP   DPrt State       Origin Expires\n");
 	else {
 		const struct ip_vs_conn *cp = v;
-		struct net *net = seq_file_net(seq);
-
-		if (!net_eq(cp->ipvs->net, net))
-			return 0;
 
 #ifdef CONFIG_IP_VS_IPV6
 		if (cp->daf == AF_INET6)
@@ -1292,22 +1599,29 @@ static inline bool ip_vs_conn_ops_mode(struct ip_vs_conn *cp)
 	return svc && (svc->flags & IP_VS_SVC_F_ONEPACKET);
 }
 
-/* Called from keventd and must protect itself from softirqs */
 void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
 {
-	int idx;
+	struct hlist_bl_node *e;
 	struct ip_vs_conn *cp;
+	struct ip_vs_rht *t;
+	unsigned int r;
+	int idx;
 
+	r = get_random_u32();
 	rcu_read_lock();
+	t = rcu_dereference(ipvs->conn_tab);
+	if (!t)
+		goto out;
 	/*
 	 * Randomly scan 1/32 of the whole table every second
 	 */
-	for (idx = 0; idx < (ip_vs_conn_tab_size>>5); idx++) {
-		unsigned int hash = get_random_u32() & ip_vs_conn_tab_mask;
+	for (idx = 0; idx < (t->size >> 5); idx++) {
+		unsigned int hash = (r + idx) & t->mask;
 
-		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[hash], c_list) {
-			if (cp->ipvs != ipvs)
-				continue;
+		/* Don't care if due to moved entry we jump to another bucket
+		 * and even to new table
+		 */
+		hlist_bl_for_each_entry_rcu(cp, e, &t->buckets[hash], c_list) {
 			if (atomic_read(&cp->n_control))
 				continue;
 			if (cp->flags & IP_VS_CONN_F_TEMPLATE) {
@@ -1354,27 +1668,39 @@ void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
 			IP_VS_DBG(4, "drop connection\n");
 			ip_vs_conn_del(cp);
 		}
-		cond_resched_rcu();
+		if (!(idx & 31)) {
+			cond_resched_rcu();
+			t = rcu_dereference(ipvs->conn_tab);
+			if (!t)
+				goto out;
+		}
 	}
+
+out:
 	rcu_read_unlock();
 }
 
 
-/*
- *      Flush all the connection entries in the ip_vs_conn_tab
- */
+/* Flush all the connection entries in the conn_tab */
 static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
 {
-	int idx;
+	DECLARE_IP_VS_RHT_WALK_BUCKETS_SAFE_RCU();
 	struct ip_vs_conn *cp, *cp_c;
+	struct hlist_bl_head *head;
+	struct ip_vs_rht *t, *p;
+	struct hlist_bl_node *e;
+
+	if (!rcu_dereference_protected(ipvs->conn_tab, 1))
+		return;
+	cancel_delayed_work_sync(&ipvs->conn_resize_work);
+	if (!atomic_read(&ipvs->conn_count))
+		goto unreg;
 
 flush_again:
+	/* Rely on RCU grace period while accessing cp after ip_vs_conn_del */
 	rcu_read_lock();
-	for (idx = 0; idx < ip_vs_conn_tab_size; idx++) {
-
-		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
-			if (cp->ipvs != ipvs)
-				continue;
+	ip_vs_rht_walk_buckets_safe_rcu(ipvs->conn_tab, head) {
+		hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
 			if (atomic_read(&cp->n_control))
 				continue;
 			cp_c = cp->control;
@@ -1395,21 +1721,47 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
 		schedule();
 		goto flush_again;
 	}
+
+unreg:
+	/* Unregister the hash table and release it after RCU grace period.
+	 * This is needed because other works may not be stopped yet and
+	 * they may walk the tables.
+	 */
+	t = rcu_dereference_protected(ipvs->conn_tab, 1);
+	rcu_assign_pointer(ipvs->conn_tab, NULL);
+	/* Inform readers that conn_tab is changed */
+	smp_mb__before_atomic();
+	atomic_inc(&ipvs->conn_tab_changes);
+	while (1) {
+		p = rcu_dereference_protected(t->new_tbl, 1);
+		call_rcu(&t->rcu_head, ip_vs_rht_rcu_free);
+		if (p == t)
+			break;
+		t = p;
+	}
 }
 
 #ifdef CONFIG_SYSCTL
 void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 {
-	int idx;
+	DECLARE_IP_VS_RHT_WALK_BUCKETS_RCU();
+	unsigned int resched_score = 0;
 	struct ip_vs_conn *cp, *cp_c;
+	struct hlist_bl_head *head;
 	struct ip_vs_dest *dest;
+	struct hlist_bl_node *e;
+	int old_gen, new_gen;
 
+	if (!atomic_read(&ipvs->conn_count))
+		return;
+	old_gen = atomic_read(&ipvs->conn_tab_changes);
 	rcu_read_lock();
-	for (idx = 0; idx < ip_vs_conn_tab_size; idx++) {
-		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
-			if (cp->ipvs != ipvs)
-				continue;
 
+repeat:
+	smp_rmb(); /* ipvs->conn_tab and conn_tab_changes */
+	ip_vs_rht_walk_buckets_rcu(ipvs->conn_tab, head) {
+		hlist_bl_for_each_entry_rcu(cp, e, head, c_list) {
+			resched_score++;
 			dest = cp->dest;
 			if (!dest || (dest->flags & IP_VS_DEST_F_AVAILABLE))
 				continue;
@@ -1424,13 +1776,25 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 				IP_VS_DBG(4, "del controlling connection\n");
 				ip_vs_conn_del(cp_c);
 			}
+			resched_score += 10;
+		}
+		resched_score++;
+		if (resched_score >= 100) {
+			resched_score = 0;
+			cond_resched_rcu();
+			/* netns clean up started, abort delayed work */
+			if (!ipvs->enable)
+				goto out;
+			new_gen = atomic_read(&ipvs->conn_tab_changes);
+			/* New table installed ? */
+			if (old_gen != new_gen) {
+				old_gen = new_gen;
+				goto repeat;
+			}
 		}
-		cond_resched_rcu();
-
-		/* netns clean up started, abort delayed work */
-		if (!ipvs->enable)
-			break;
 	}
+
+out:
 	rcu_read_unlock();
 }
 #endif
@@ -1441,6 +1805,10 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 int __net_init ip_vs_conn_net_init(struct netns_ipvs *ipvs)
 {
 	atomic_set(&ipvs->conn_count, 0);
+	INIT_DELAYED_WORK(&ipvs->conn_resize_work, conn_resize_work_handler);
+	RCU_INIT_POINTER(ipvs->conn_tab, NULL);
+	atomic_set(&ipvs->conn_tab_changes, 0);
+	ipvs->sysctl_conn_lfactor = ip_vs_conn_default_load_factor(ipvs);
 
 #ifdef CONFIG_PROC_FS
 	if (!proc_create_net("ip_vs_conn", 0, ipvs->net->proc_net,
@@ -1476,57 +1844,36 @@ void __net_exit ip_vs_conn_net_cleanup(struct netns_ipvs *ipvs)
 
 int __init ip_vs_conn_init(void)
 {
+	int min = IP_VS_CONN_TAB_MIN_BITS;
+	int max = IP_VS_CONN_TAB_MAX_BITS;
 	size_t tab_array_size;
 	int max_avail;
-#if BITS_PER_LONG > 32
-	int max = 27;
-#else
-	int max = 20;
-#endif
-	int min = 8;
-	int idx;
 
 	max_avail = order_base_2(totalram_pages()) + PAGE_SHIFT;
-	max_avail -= 2;		/* ~4 in hash row */
+	/* 64-bit: 27 bits at 64GB, 32-bit: 20 bits at 512MB */
+	max_avail += 1;		/* hash table loaded at 50% */
 	max_avail -= 1;		/* IPVS up to 1/2 of mem */
 	max_avail -= order_base_2(sizeof(struct ip_vs_conn));
 	max = clamp(max, min, max_avail);
 	ip_vs_conn_tab_bits = clamp_val(ip_vs_conn_tab_bits, min, max);
 	ip_vs_conn_tab_size = 1 << ip_vs_conn_tab_bits;
-	ip_vs_conn_tab_mask = ip_vs_conn_tab_size - 1;
 
 	/*
 	 * Allocate the connection hash table and initialize its list heads
 	 */
 	tab_array_size = array_size(ip_vs_conn_tab_size,
-				    sizeof(*ip_vs_conn_tab));
-	ip_vs_conn_tab = kvmalloc_array(ip_vs_conn_tab_size,
-					sizeof(*ip_vs_conn_tab), GFP_KERNEL);
-	if (!ip_vs_conn_tab)
-		return -ENOMEM;
+				    sizeof(struct hlist_bl_head));
 
 	/* Allocate ip_vs_conn slab cache */
 	ip_vs_conn_cachep = KMEM_CACHE(ip_vs_conn, SLAB_HWCACHE_ALIGN);
-	if (!ip_vs_conn_cachep) {
-		kvfree(ip_vs_conn_tab);
+	if (!ip_vs_conn_cachep)
 		return -ENOMEM;
-	}
 
 	pr_info("Connection hash table configured (size=%d, memory=%zdKbytes)\n",
 		ip_vs_conn_tab_size, tab_array_size / 1024);
 	IP_VS_DBG(0, "Each connection entry needs %zd bytes at least\n",
 		  sizeof(struct ip_vs_conn));
 
-	for (idx = 0; idx < ip_vs_conn_tab_size; idx++)
-		INIT_HLIST_HEAD(&ip_vs_conn_tab[idx]);
-
-	for (idx = 0; idx < CT_LOCKARRAY_SIZE; idx++)  {
-		spin_lock_init(&__ip_vs_conntbl_lock_array[idx].l);
-	}
-
-	/* calculate the random value for connection hash */
-	get_random_bytes(&ip_vs_conn_rnd, sizeof(ip_vs_conn_rnd));
-
 	return 0;
 }
 
@@ -1536,5 +1883,4 @@ void ip_vs_conn_cleanup(void)
 	rcu_barrier();
 	/* Release the empty cache */
 	kmem_cache_destroy(ip_vs_conn_cachep);
-	kvfree(ip_vs_conn_tab);
 }
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index aac0e1751fe5..a5a7d7027237 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1643,6 +1643,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		  struct ip_vs_service **svc_p)
 {
 	struct ip_vs_scheduler *sched = NULL;
+	struct ip_vs_rht *tc_new = NULL;
 	struct ip_vs_rht *t, *t_new = NULL;
 	int af_id = ip_vs_af_index(u->af);
 	struct ip_vs_service *svc = NULL;
@@ -1702,6 +1703,17 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		}
 	}
 
+	if (!rcu_dereference_protected(ipvs->conn_tab, 1)) {
+		int lfactor = sysctl_conn_lfactor(ipvs);
+		int new_size = ip_vs_conn_desired_size(ipvs, NULL, lfactor);
+
+		tc_new = ip_vs_conn_tab_alloc(ipvs, new_size, lfactor);
+		if (!tc_new) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
+	}
+
 	if (!atomic_read(&ipvs->num_services[af_id])) {
 		ret = ip_vs_register_hooks(ipvs, u->af);
 		if (ret < 0)
@@ -1756,6 +1768,10 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		rcu_assign_pointer(ipvs->svc_table, t_new);
 		t_new = NULL;
 	}
+	if (tc_new) {
+		rcu_assign_pointer(ipvs->conn_tab, tc_new);
+		tc_new = NULL;
+	}
 
 	/* Hash the service into the service table */
 	ip_vs_svc_hash(svc);
@@ -1794,6 +1810,8 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 
 
  out_err:
+	if (tc_new)
+		ip_vs_rht_free(tc_new);
 	if (t_new)
 		ip_vs_rht_free(t_new);
 	if (ret_hooks >= 0)
diff --git a/net/netfilter/ipvs/ip_vs_pe_sip.c b/net/netfilter/ipvs/ip_vs_pe_sip.c
index e4ce1d9a63f9..fc419aa1dc3f 100644
--- a/net/netfilter/ipvs/ip_vs_pe_sip.c
+++ b/net/netfilter/ipvs/ip_vs_pe_sip.c
@@ -133,9 +133,9 @@ static bool ip_vs_sip_ct_match(const struct ip_vs_conn_param *p,
 }
 
 static u32 ip_vs_sip_hashkey_raw(const struct ip_vs_conn_param *p,
-				 u32 initval, bool inverse)
+				 struct ip_vs_rht *t, bool inverse)
 {
-	return jhash(p->pe_data, p->pe_data_len, initval);
+	return jhash(p->pe_data, p->pe_data_len, (u32)t->hash_key.key[0]);
 }
 
 static int ip_vs_sip_show_pe_data(const struct ip_vs_conn *cp, char *buf)
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index be74c0906dda..6e0d2904e24a 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1756,6 +1756,28 @@ int start_sync_thread(struct netns_ipvs *ipvs, struct ipvs_sync_daemon_cfg *c,
 	if (!ip_vs_use_count_inc())
 		return -ENOPROTOOPT;
 
+	/* Backup server can be started without services just to sync conns,
+	 * make sure conn_tab is created even if ipvs->enable is 0.
+	 */
+	if (state == IP_VS_STATE_BACKUP) {
+		mutex_lock(&ipvs->service_mutex);
+		if (!rcu_dereference_protected(ipvs->conn_tab, 1)) {
+			int lfactor = sysctl_conn_lfactor(ipvs);
+			int new_size = ip_vs_conn_desired_size(ipvs, NULL,
+							       lfactor);
+			struct ip_vs_rht *tc_new;
+
+			tc_new = ip_vs_conn_tab_alloc(ipvs, new_size, lfactor);
+			if (!tc_new) {
+				mutex_unlock(&ipvs->service_mutex);
+				result = -ENOMEM;
+				goto out_module;
+			}
+			rcu_assign_pointer(ipvs->conn_tab, tc_new);
+		}
+		mutex_unlock(&ipvs->service_mutex);
+	}
+
 	/* Do not hold one mutex and then to block on another */
 	for (;;) {
 		rtnl_lock();
@@ -1924,6 +1946,7 @@ int start_sync_thread(struct netns_ipvs *ipvs, struct ipvs_sync_daemon_cfg *c,
 	mutex_unlock(&ipvs->sync_mutex);
 	rtnl_unlock();
 
+out_module:
 	/* decrease the module use count */
 	ip_vs_use_count_dec();
 	return result;
-- 
2.44.0



