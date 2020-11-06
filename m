Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81D2A9FB5
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Nov 2020 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgKFWDm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Nov 2020 17:03:42 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43647 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728154AbgKFWDm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:03:42 -0500
Received: from localhost.localdomain (ip5f5af1f7.dynamic.kabel-deutschland.de [95.90.241.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BE5DC20646211;
        Fri,  6 Nov 2020 23:03:34 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, Xin Liu <xinxliu@microsoft.com>,
        Guohan Lu <lguohan@gmail.com>,
        Kiran Kella <kiran.kella@broadcom.com>,
        Akhilesh Samineni <akhilesh.samineni@broadcom.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] netfilter: nf_nat: Support fullcone NAT
Date:   Fri,  6 Nov 2020 23:01:07 +0100
Message-Id: <20201106220106.80432-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Kiran Kella <kiran.kella@broadcom.com>

Changes done in the kernel to ensure 3-tuple uniqueness of the conntrack
entries for the fullcone nat functionality.

*   Hashlist is maintained for the 3-tuple unique keys (Protocol/Source
    IP/Port) for all the conntrack entries.

*   When NAT table rules are created with the fullcone option, the
    SNAT/POSTROUTING stage ensures the ports from the pool are picked up in
    such a way that the 3-tuple is uniquely assigned.

*   In the DNAT/POSTROUTING stage, the fullcone behavior is ensured by checking
    and reusing the 3-tuple for the Source IP/Port in the original direction.

*   When the pool is exhausted of the 3-tuple assignments, the packets are
    dropped, else, they will be going out of the router they being 5-tuple
    unique (which is not intended).

*   Passing fullcone option using iptables is part of another PR (in
    sonic-buildimage repo).

The kernel changes mentioned above are done to counter the challenges
explained in the section *3.4.2.1 Handling NAT model mismatch between
the ASIC and the Kernel* in the NAT HLD [1].

[1]: https://github.com/kirankella/SONiC/blob/nat_doc_changes/doc/nat/nat_design_spec.md

[Add to SONiC in https://github.com/Azure/sonic-linux-kernel/pull/100]
Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
[forward port to Linux v4.19, https://github.com/Azure/sonic-linux-kernel/pull/147]
Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
Dear Linux folks,


This is taken from switch network operating system (NOS) SONiC’s Linux
repository, where the support was added in September 2019 [1], and
forwarded ported to Linux 4.19 by Akhilesh in June 2020 [2].

I am sending it upstream as a request for comments, before effort is put
into forward porting it to Linux master.


Kind regards,

Paul 


[1]: https://github.com/Azure/sonic-linux-kernel/pull/100
[2]: https://github.com/Azure/sonic-linux-kernel/pull/147

 include/net/netfilter/nf_conntrack.h     |   3 +
 include/net/netfilter/nf_nat.h           |   6 +
 include/net/netfilter/nf_nat_l4proto.h   |  12 +-
 include/uapi/linux/netfilter/nf_nat.h    |   1 +
 net/ipv4/netfilter/nf_nat_proto_gre.c    |   8 +-
 net/ipv4/netfilter/nf_nat_proto_icmp.c   |   6 +-
 net/ipv6/netfilter/nf_nat_proto_icmpv6.c |   5 +-
 net/netfilter/nf_nat_core.c              | 173 ++++++++++++++++++++---
 net/netfilter/nf_nat_proto_common.c      |  32 +++--
 net/netfilter/nf_nat_proto_dccp.c        |   6 +-
 net/netfilter/nf_nat_proto_sctp.c        |   6 +-
 net/netfilter/nf_nat_proto_tcp.c         |   6 +-
 net/netfilter/nf_nat_proto_udp.c         |  12 +-
 net/netfilter/nf_nat_proto_unknown.c     |   4 +-
 14 files changed, 220 insertions(+), 60 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index f45141bdbb83..64b9293a31f6 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -84,6 +84,9 @@ struct nf_conn {
 #if IS_ENABLED(CONFIG_NF_NAT)
 	struct hlist_node	nat_bysource;
 #endif
+        /* To optionally ensure 3-tuple uniqueness on the translated source */
+        struct hlist_node       nat_by_manip_src;
+
 	/* all members below initialized via memset */
 	u8 __nfct_init_offset[0];
 
diff --git a/include/net/netfilter/nf_nat.h b/include/net/netfilter/nf_nat.h
index a17eb2f8d40e..7c3cc3c7b35f 100644
--- a/include/net/netfilter/nf_nat.h
+++ b/include/net/netfilter/nf_nat.h
@@ -51,6 +51,12 @@ struct nf_conn_nat *nf_ct_nat_ext_add(struct nf_conn *ct);
 int nf_nat_used_tuple(const struct nf_conntrack_tuple *tuple,
 		      const struct nf_conn *ignored_conntrack);
 
+/* Is this 3-tuple already taken? (not by us)*/
+int
+nf_nat_used_3_tuple(const struct nf_conntrack_tuple *tuple,
+		    const struct nf_conn *ignored_conntrack,
+		    enum nf_nat_manip_type maniptype);
+
 static inline struct nf_conn_nat *nfct_nat(const struct nf_conn *ct)
 {
 #if defined(CONFIG_NF_NAT) || defined(CONFIG_NF_NAT_MODULE)
diff --git a/include/net/netfilter/nf_nat_l4proto.h b/include/net/netfilter/nf_nat_l4proto.h
index b4d6b29bca62..fbcbb9ad9e4b 100644
--- a/include/net/netfilter/nf_nat_l4proto.h
+++ b/include/net/netfilter/nf_nat_l4proto.h
@@ -32,7 +32,7 @@ struct nf_nat_l4proto {
 	 * possible.  Per-protocol part of tuple is initialized to the
 	 * incoming packet.
 	 */
-	void (*unique_tuple)(const struct nf_nat_l3proto *l3proto,
+	int  (*unique_tuple)(const struct nf_nat_l3proto *l3proto,
 			     struct nf_conntrack_tuple *tuple,
 			     const struct nf_nat_range2 *range,
 			     enum nf_nat_manip_type maniptype,
@@ -70,11 +70,11 @@ bool nf_nat_l4proto_in_range(const struct nf_conntrack_tuple *tuple,
 			     const union nf_conntrack_man_proto *min,
 			     const union nf_conntrack_man_proto *max);
 
-void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
-				 struct nf_conntrack_tuple *tuple,
-				 const struct nf_nat_range2 *range,
-				 enum nf_nat_manip_type maniptype,
-				 const struct nf_conn *ct, u16 *rover);
+int nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
+				struct nf_conntrack_tuple *tuple,
+				const struct nf_nat_range2 *range,
+				enum nf_nat_manip_type maniptype,
+				const struct nf_conn *ct, u16 *rover);
 
 int nf_nat_l4proto_nlattr_to_range(struct nlattr *tb[],
 				   struct nf_nat_range2 *range);
diff --git a/include/uapi/linux/netfilter/nf_nat.h b/include/uapi/linux/netfilter/nf_nat.h
index 4a95c0db14d4..1cda390e17c6 100644
--- a/include/uapi/linux/netfilter/nf_nat.h
+++ b/include/uapi/linux/netfilter/nf_nat.h
@@ -11,6 +11,7 @@
 #define NF_NAT_RANGE_PERSISTENT			(1 << 3)
 #define NF_NAT_RANGE_PROTO_RANDOM_FULLY		(1 << 4)
 #define NF_NAT_RANGE_PROTO_OFFSET		(1 << 5)
+#define NF_NAT_RANGE_FULLCONE		        (1 << 6)
 
 #define NF_NAT_RANGE_PROTO_RANDOM_ALL		\
 	(NF_NAT_RANGE_PROTO_RANDOM | NF_NAT_RANGE_PROTO_RANDOM_FULLY)
diff --git a/net/ipv4/netfilter/nf_nat_proto_gre.c b/net/ipv4/netfilter/nf_nat_proto_gre.c
index 00fda6331ce5..d2ca4f6003ba 100644
--- a/net/ipv4/netfilter/nf_nat_proto_gre.c
+++ b/net/ipv4/netfilter/nf_nat_proto_gre.c
@@ -38,7 +38,7 @@ MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
 MODULE_DESCRIPTION("Netfilter NAT protocol helper module for GRE");
 
 /* generate unique tuple ... */
-static void
+static int
 gre_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 struct nf_conntrack_tuple *tuple,
 		 const struct nf_nat_range2 *range,
@@ -52,7 +52,7 @@ gre_unique_tuple(const struct nf_nat_l3proto *l3proto,
 	/* If there is no master conntrack we are not PPTP,
 	   do not change tuples */
 	if (!ct->master)
-		return;
+		return 0;
 
 	if (maniptype == NF_NAT_MANIP_SRC)
 		keyptr = &tuple->src.u.gre.key;
@@ -73,11 +73,11 @@ gre_unique_tuple(const struct nf_nat_l3proto *l3proto,
 	for (i = 0; ; ++key) {
 		*keyptr = htons(min + key % range_size);
 		if (++i == range_size || !nf_nat_used_tuple(tuple, ct))
-			return;
+			return 1;
 	}
 
 	pr_debug("%p: no NAT mapping\n", ct);
-	return;
+	return 0;
 }
 
 /* manipulate a GRE packet according to maniptype */
diff --git a/net/ipv4/netfilter/nf_nat_proto_icmp.c b/net/ipv4/netfilter/nf_nat_proto_icmp.c
index 6d7cf1d79baf..403783cda503 100644
--- a/net/ipv4/netfilter/nf_nat_proto_icmp.c
+++ b/net/ipv4/netfilter/nf_nat_proto_icmp.c
@@ -27,7 +27,7 @@ icmp_in_range(const struct nf_conntrack_tuple *tuple,
 	       ntohs(tuple->src.u.icmp.id) <= ntohs(max->icmp.id);
 }
 
-static void
+static int
 icmp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  struct nf_conntrack_tuple *tuple,
 		  const struct nf_nat_range2 *range,
@@ -48,9 +48,9 @@ icmp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		tuple->src.u.icmp.id = htons(ntohs(range->min_proto.icmp.id) +
 					     (id % range_size));
 		if (++i == range_size || !nf_nat_used_tuple(tuple, ct))
-			return;
+			return 1;
 	}
-	return;
+	return 0;
 }
 
 static bool
diff --git a/net/ipv6/netfilter/nf_nat_proto_icmpv6.c b/net/ipv6/netfilter/nf_nat_proto_icmpv6.c
index d9bf42ba44fa..7ff30a023f04 100644
--- a/net/ipv6/netfilter/nf_nat_proto_icmpv6.c
+++ b/net/ipv6/netfilter/nf_nat_proto_icmpv6.c
@@ -29,7 +29,7 @@ icmpv6_in_range(const struct nf_conntrack_tuple *tuple,
 	       ntohs(tuple->src.u.icmp.id) <= ntohs(max->icmp.id);
 }
 
-static void
+static int
 icmpv6_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		    struct nf_conntrack_tuple *tuple,
 		    const struct nf_nat_range2 *range,
@@ -50,8 +50,9 @@ icmpv6_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		tuple->src.u.icmp.id = htons(ntohs(range->min_proto.icmp.id) +
 					     (id % range_size));
 		if (++i == range_size || !nf_nat_used_tuple(tuple, ct))
-			return;
+			return 1;
 	}
+	return 0;
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 2268b10a9dcf..1b83427a7a68 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -43,6 +43,7 @@ static const struct nf_nat_l4proto __rcu **nf_nat_l4protos[NFPROTO_NUMPROTO]
 static unsigned int nat_net_id __read_mostly;
 
 static struct hlist_head *nf_nat_bysource __read_mostly;
+static struct hlist_head *nf_nat_by_manip_src __read_mostly;
 static unsigned int nf_nat_htable_size __read_mostly;
 static unsigned int nf_nat_hash_rnd __read_mostly;
 
@@ -155,6 +156,31 @@ hash_by_src(const struct net *n, const struct nf_conntrack_tuple *tuple)
 	return reciprocal_scale(hash, nf_nat_htable_size);
 }
 
+static inline unsigned int
+hash_by_dst(const struct net *n, const struct nf_conntrack_tuple *tuple)
+{
+	unsigned int hash;
+
+	get_random_once(&nf_nat_hash_rnd, sizeof(nf_nat_hash_rnd));
+
+	hash = jhash2((u32 *)&tuple->dst, sizeof(tuple->dst) / sizeof(u32),
+	      tuple->dst.protonum ^ nf_nat_hash_rnd ^ net_hash_mix(n));
+
+	return reciprocal_scale(hash, nf_nat_htable_size);
+}
+
+static inline int
+same_reply_dst(const struct nf_conn *ct,
+	       const struct nf_conntrack_tuple *tuple)
+{
+	const struct nf_conntrack_tuple *t;
+
+	t = &ct->tuplehash[IP_CT_DIR_REPLY].tuple;
+	return (t->dst.protonum == tuple->dst.protonum &&
+		nf_inet_addr_cmp(&t->dst.u3, &tuple->dst.u3) &&
+		t->dst.u.all == tuple->dst.u.all);
+}
+
 /* Is this tuple already taken? (not by us) */
 int
 nf_nat_used_tuple(const struct nf_conntrack_tuple *tuple,
@@ -171,7 +197,40 @@ nf_nat_used_tuple(const struct nf_conntrack_tuple *tuple,
 	nf_ct_invert_tuplepr(&reply, tuple);
 	return nf_conntrack_tuple_taken(&reply, ignored_conntrack);
 }
+
+/* Is this 3-tuple already taken? (not by us) */
+int
+nf_nat_used_3_tuple(const struct nf_conntrack_tuple *tuple,
+		    const struct nf_conn *ignored_conntrack,
+		    enum nf_nat_manip_type maniptype)
+{
+	const struct nf_conn *ct;
+	const struct nf_conntrack_zone *zone;
+	unsigned int h;
+	struct net *net = nf_ct_net(ignored_conntrack);
+
+	/* 3-tuple uniqueness is required for translated source only */
+	if (maniptype != NF_NAT_MANIP_SRC) {
+		return 0;
+	}
+	zone = nf_ct_zone(ignored_conntrack);
+
+	/* The tuple passed here is the inverted reply (with translated source) */
+	h = hash_by_src(net, tuple);
+	hlist_for_each_entry_rcu(ct, &nf_nat_by_manip_src[h], nat_by_manip_src) {
+		struct nf_conntrack_tuple reply;
+		nf_ct_invert_tuplepr(&reply, tuple);
+		/* Compare against the destination in the reply */
+		if (same_reply_dst(ct, &reply) &&
+		    net_eq(net, nf_ct_net(ct)) &&
+		    nf_ct_zone_equal(ct, zone, IP_CT_DIR_ORIGINAL)) {
+			return 1;
+		}
+	}
+	return 0;
+}
 EXPORT_SYMBOL(nf_nat_used_tuple);
+EXPORT_SYMBOL(nf_nat_used_3_tuple);
 
 /* If we source map this tuple so reply looks like reply_tuple, will
  * that meet the constraints of range.
@@ -237,6 +296,36 @@ find_appropriate_src(struct net *net,
 	return 0;
 }
 
+/* Only called for DST manip */
+static int
+find_appropriate_dst(struct net *net,
+		     const struct nf_conntrack_zone *zone,
+		     const struct nf_nat_l3proto *l3proto,
+		     const struct nf_nat_l4proto *l4proto,
+		     const struct nf_conntrack_tuple *tuple,
+		     struct nf_conntrack_tuple *result)
+{
+	struct nf_conntrack_tuple reply;
+	unsigned int h;
+	const struct nf_conn *ct;
+
+	nf_ct_invert_tuplepr(&reply, tuple);
+	h = hash_by_src(net, &reply);
+
+	hlist_for_each_entry_rcu(ct, &nf_nat_by_manip_src[h], nat_by_manip_src) {
+		if (same_reply_dst(ct, tuple) &&
+		    net_eq(net, nf_ct_net(ct)) &&
+		    nf_ct_zone_equal(ct, zone, IP_CT_DIR_REPLY)) {
+			/* Copy destination part from original tuple. */
+			nf_ct_invert_tuplepr(result,
+				       &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple);
+			result->src = tuple->src;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /* For [FUTURE] fragmentation handling, we want the least-used
  * src-ip/dst-ip/proto triple.  Fairness doesn't come into it.  Thus
  * if the range specifies 1.2.3.4 ports 10000-10005 and 1.2.3.5 ports
@@ -314,10 +403,15 @@ find_best_ips_proto(const struct nf_conntrack_zone *zone,
 /* Manipulate the tuple into the range given. For NF_INET_POST_ROUTING,
  * we change the source to map into the range. For NF_INET_PRE_ROUTING
  * and NF_INET_LOCAL_OUT, we change the destination to map into the
- * range. It might not be possible to get a unique tuple, but we try.
+ * range. It might not be possible to get a unique 5-tuple, but we try.
  * At worst (or if we race), we will end up with a final duplicate in
- * __ip_conntrack_confirm and drop the packet. */
-static void
+ * __ip_conntrack_confirm and drop the packet.
+ * If the range is of type fullcone, if we end up with a 3-tuple
+ * duplicate, we do not wait till the packet reaches the
+ * nf_conntrack_confirm to drop the packet. Instead return the packet
+ * to be dropped at this stage.
+ */
+static int
 get_unique_tuple(struct nf_conntrack_tuple *tuple,
 		 const struct nf_conntrack_tuple *orig_tuple,
 		 const struct nf_nat_range2 *range,
@@ -327,8 +421,11 @@ get_unique_tuple(struct nf_conntrack_tuple *tuple,
 	const struct nf_conntrack_zone *zone;
 	const struct nf_nat_l3proto *l3proto;
 	const struct nf_nat_l4proto *l4proto;
+	struct nf_nat_range2 nat_range;
 	struct net *net = nf_ct_net(ct);
 
+        memcpy(&nat_range, range, sizeof(struct nf_nat_range2));
+
 	zone = nf_ct_zone(ct);
 
 	rcu_read_lock();
@@ -345,48 +442,77 @@ get_unique_tuple(struct nf_conntrack_tuple *tuple,
 	 * manips not an issue.
 	 */
 	if (maniptype == NF_NAT_MANIP_SRC &&
-	    !(range->flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
+	    !(nat_range.flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
 		/* try the original tuple first */
-		if (in_range(l3proto, l4proto, orig_tuple, range)) {
+		if (in_range(l3proto, l4proto, orig_tuple, &nat_range)) {
 			if (!nf_nat_used_tuple(orig_tuple, ct)) {
 				*tuple = *orig_tuple;
 				goto out;
 			}
 		} else if (find_appropriate_src(net, zone, l3proto, l4proto,
-						orig_tuple, tuple, range)) {
+						orig_tuple, tuple, &nat_range)) {
 			pr_debug("get_unique_tuple: Found current src map\n");
 			if (!nf_nat_used_tuple(tuple, ct))
 				goto out;
 		}
 	}
 
+	if (maniptype == NF_NAT_MANIP_DST) {
+		if (nat_range.flags & NF_NAT_RANGE_FULLCONE) {
+			/* Destination IP range does not apply when fullcone flag is set. */
+			nat_range.min_addr.ip = nat_range.max_addr.ip = orig_tuple->dst.u3.ip;
+			nat_range.min_proto.all = nat_range.max_proto.all = 0;
+
+			/* If this dstip/proto/dst-proto-part is mapped currently
+			 * as a translated source for a given tuple, use that
+			 */
+			if (find_appropriate_dst(net, zone, l3proto, l4proto,
+						orig_tuple, tuple)) {
+				if (!nf_nat_used_tuple(tuple, ct)) {
+					goto out;
+				}
+			} else {
+				/* If not mapped, proceed with the original tuple */
+				*tuple = *orig_tuple;
+				goto out;
+			}
+		}
+	}
+
 	/* 2) Select the least-used IP/proto combination in the given range */
 	*tuple = *orig_tuple;
-	find_best_ips_proto(zone, tuple, range, ct, maniptype);
+	find_best_ips_proto(zone, tuple, &nat_range, ct, maniptype);
 
 	/* 3) The per-protocol part of the manip is made to map into
 	 * the range to make a unique tuple.
 	 */
 
 	/* Only bother mapping if it's not already in range and unique */
-	if (!(range->flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
-		if (range->flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
-			if (!(range->flags & NF_NAT_RANGE_PROTO_OFFSET) &&
+	if (!(nat_range.flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
+		if (nat_range.flags & NF_NAT_RANGE_PROTO_SPECIFIED) {
+			if (!(nat_range.flags & NF_NAT_RANGE_PROTO_OFFSET) &&
 			    l4proto->in_range(tuple, maniptype,
-			          &range->min_proto,
-			          &range->max_proto) &&
-			    (range->min_proto.all == range->max_proto.all ||
-			     !nf_nat_used_tuple(tuple, ct)))
-				goto out;
+			          &(nat_range.min_proto),
+			          &(nat_range.max_proto))) {
+				if (nat_range.flags & NF_NAT_RANGE_FULLCONE) {
+					if (!nf_nat_used_3_tuple(tuple, ct, maniptype))
+						goto out;
+				} else {
+					if ((nat_range.min_proto.all == nat_range.max_proto.all) ||
+					    !nf_nat_used_tuple(tuple, ct))
+						goto out;
+				}
+			}
 		} else if (!nf_nat_used_tuple(tuple, ct)) {
 			goto out;
 		}
 	}
 
 	/* Last chance: get protocol to try to obtain unique tuple. */
-	l4proto->unique_tuple(l3proto, tuple, range, maniptype, ct);
+	return l4proto->unique_tuple(l3proto, tuple, &nat_range, maniptype, ct);
 out:
 	rcu_read_unlock();
+	return 1;
 }
 
 struct nf_conn_nat *nf_ct_nat_ext_add(struct nf_conn *ct)
@@ -428,7 +554,9 @@ nf_nat_setup_info(struct nf_conn *ct,
 	nf_ct_invert_tuplepr(&curr_tuple,
 			     &ct->tuplehash[IP_CT_DIR_REPLY].tuple);
 
-	get_unique_tuple(&new_tuple, &curr_tuple, range, ct, maniptype);
+	if (! get_unique_tuple(&new_tuple, &curr_tuple, range, ct, maniptype)) {
+		return NF_DROP;
+	}
 
 	if (!nf_ct_tuple_equal(&new_tuple, &curr_tuple)) {
 		struct nf_conntrack_tuple reply;
@@ -450,12 +578,16 @@ nf_nat_setup_info(struct nf_conn *ct,
 
 	if (maniptype == NF_NAT_MANIP_SRC) {
 		unsigned int srchash;
+		unsigned int manip_src_hash;
 		spinlock_t *lock;
 
+		manip_src_hash = hash_by_src(net, &new_tuple);
 		srchash = hash_by_src(net,
 				      &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple);
 		lock = &nf_nat_locks[srchash % CONNTRACK_LOCKS];
 		spin_lock_bh(lock);
+		hlist_add_head_rcu(&ct->nat_by_manip_src,
+				   &nf_nat_by_manip_src[manip_src_hash]);
 		hlist_add_head_rcu(&ct->nat_bysource,
 				   &nf_nat_bysource[srchash]);
 		spin_unlock_bh(lock);
@@ -644,6 +776,7 @@ static void __nf_nat_cleanup_conntrack(struct nf_conn *ct)
 	h = hash_by_src(nf_ct_net(ct), &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple);
 	spin_lock_bh(&nf_nat_locks[h % CONNTRACK_LOCKS]);
 	hlist_del_rcu(&ct->nat_bysource);
+	hlist_del_rcu(&ct->nat_by_manip_src);
 	spin_unlock_bh(&nf_nat_locks[h % CONNTRACK_LOCKS]);
 }
 
@@ -1055,9 +1188,14 @@ static int __init nf_nat_init(void)
 	if (!nf_nat_bysource)
 		return -ENOMEM;
 
+	nf_nat_by_manip_src = nf_ct_alloc_hashtable(&nf_nat_htable_size, 0);
+	if (!nf_nat_by_manip_src)
+		return -ENOMEM;
+
 	ret = nf_ct_extend_register(&nat_extend);
 	if (ret < 0) {
 		kvfree(nf_nat_bysource);
+		kvfree(nf_nat_by_manip_src);
 		pr_err("Unable to register extension\n");
 		return ret;
 	}
@@ -1096,6 +1234,7 @@ static void __exit nf_nat_cleanup(void)
 		kfree(nf_nat_l4protos[i]);
 	synchronize_net();
 	kvfree(nf_nat_bysource);
+	kvfree(nf_nat_by_manip_src);
 	unregister_pernet_subsys(&nat_net_ops);
 }
 
diff --git a/net/netfilter/nf_nat_proto_common.c b/net/netfilter/nf_nat_proto_common.c
index 5d849d835561..6ee918302a02 100644
--- a/net/netfilter/nf_nat_proto_common.c
+++ b/net/netfilter/nf_nat_proto_common.c
@@ -34,12 +34,12 @@ bool nf_nat_l4proto_in_range(const struct nf_conntrack_tuple *tuple,
 }
 EXPORT_SYMBOL_GPL(nf_nat_l4proto_in_range);
 
-void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
-				 struct nf_conntrack_tuple *tuple,
-				 const struct nf_nat_range2 *range,
-				 enum nf_nat_manip_type maniptype,
-				 const struct nf_conn *ct,
-				 u16 *rover)
+int nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
+				struct nf_conntrack_tuple *tuple,
+				const struct nf_nat_range2 *range,
+				enum nf_nat_manip_type maniptype,
+				const struct nf_conn *ct,
+				u16 *rover)
 {
 	unsigned int range_size, min, max, i;
 	__be16 *portptr;
@@ -54,7 +54,7 @@ void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
 	if (!(range->flags & NF_NAT_RANGE_PROTO_SPECIFIED)) {
 		/* If it's dst rewrite, can't change port */
 		if (maniptype == NF_NAT_MANIP_DST)
-			return;
+			return 0;
 
 		if (ntohs(*portptr) < 1024) {
 			/* Loose convention: >> 512 is credential passing */
@@ -87,17 +87,27 @@ void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		off = (ntohs(*portptr) - ntohs(range->base_proto.all));
 	} else {
 		off = *rover;
+		if ((range->flags & NF_NAT_RANGE_FULLCONE) && (maniptype == NF_NAT_MANIP_SRC)) {
+			/* Try from the next L4 port in the range */
+			off++;
+		}
 	}
 
-	for (i = 0; ; ++off) {
+	for (i = 0; (i != range_size); ++i, ++off) {
 		*portptr = htons(min + off % range_size);
-		if (++i != range_size && nf_nat_used_tuple(tuple, ct))
-			continue;
+		if ((range->flags & NF_NAT_RANGE_FULLCONE) && (maniptype == NF_NAT_MANIP_SRC)) {
+			if (nf_nat_used_3_tuple(tuple, ct, maniptype))
+				continue;
+		} else {
+			if (nf_nat_used_tuple(tuple, ct))
+				continue;
+		}
 		if (!(range->flags & (NF_NAT_RANGE_PROTO_RANDOM_ALL|
 					NF_NAT_RANGE_PROTO_OFFSET)))
 			*rover = off;
-		return;
+		return 1;
 	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nf_nat_l4proto_unique_tuple);
 
diff --git a/net/netfilter/nf_nat_proto_dccp.c b/net/netfilter/nf_nat_proto_dccp.c
index 67ea0d83aa5a..68ef70bb55df 100644
--- a/net/netfilter/nf_nat_proto_dccp.c
+++ b/net/netfilter/nf_nat_proto_dccp.c
@@ -20,15 +20,15 @@
 
 static u_int16_t dccp_port_rover;
 
-static void
+static int
 dccp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  struct nf_conntrack_tuple *tuple,
 		  const struct nf_nat_range2 *range,
 		  enum nf_nat_manip_type maniptype,
 		  const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &dccp_port_rover);
+	return  nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
+					    &dccp_port_rover);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_sctp.c b/net/netfilter/nf_nat_proto_sctp.c
index 1c5d9b65fbba..a9d9070c36c8 100644
--- a/net/netfilter/nf_nat_proto_sctp.c
+++ b/net/netfilter/nf_nat_proto_sctp.c
@@ -14,15 +14,15 @@
 
 static u_int16_t nf_sctp_port_rover;
 
-static void
+static int
 sctp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  struct nf_conntrack_tuple *tuple,
 		  const struct nf_nat_range2 *range,
 		  enum nf_nat_manip_type maniptype,
 		  const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &nf_sctp_port_rover);
+	return nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
+					    &nf_sctp_port_rover);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_tcp.c b/net/netfilter/nf_nat_proto_tcp.c
index f15fcd475f98..1b039055421f 100644
--- a/net/netfilter/nf_nat_proto_tcp.c
+++ b/net/netfilter/nf_nat_proto_tcp.c
@@ -20,15 +20,15 @@
 
 static u16 tcp_port_rover;
 
-static void
+static int
 tcp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 struct nf_conntrack_tuple *tuple,
 		 const struct nf_nat_range2 *range,
 		 enum nf_nat_manip_type maniptype,
 		 const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &tcp_port_rover);
+	return nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
+					   &tcp_port_rover);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_udp.c b/net/netfilter/nf_nat_proto_udp.c
index 5790f70a83b2..0b26bb52aef6 100644
--- a/net/netfilter/nf_nat_proto_udp.c
+++ b/net/netfilter/nf_nat_proto_udp.c
@@ -19,15 +19,15 @@
 
 static u16 udp_port_rover;
 
-static void
+static int
 udp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 struct nf_conntrack_tuple *tuple,
 		 const struct nf_nat_range2 *range,
 		 enum nf_nat_manip_type maniptype,
 		 const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &udp_port_rover);
+	return nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
+					   &udp_port_rover);
 }
 
 static void
@@ -97,15 +97,15 @@ static bool udplite_manip_pkt(struct sk_buff *skb,
 	return true;
 }
 
-static void
+static int
 udplite_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		     struct nf_conntrack_tuple *tuple,
 		     const struct nf_nat_range2 *range,
 		     enum nf_nat_manip_type maniptype,
 		     const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &udplite_port_rover);
+	return nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
+					   &udplite_port_rover);
 }
 
 const struct nf_nat_l4proto nf_nat_l4proto_udplite = {
diff --git a/net/netfilter/nf_nat_proto_unknown.c b/net/netfilter/nf_nat_proto_unknown.c
index c5db3e251232..377a2938cd79 100644
--- a/net/netfilter/nf_nat_proto_unknown.c
+++ b/net/netfilter/nf_nat_proto_unknown.c
@@ -25,7 +25,7 @@ static bool unknown_in_range(const struct nf_conntrack_tuple *tuple,
 	return true;
 }
 
-static void unknown_unique_tuple(const struct nf_nat_l3proto *l3proto,
+static int unknown_unique_tuple(const struct nf_nat_l3proto *l3proto,
 				 struct nf_conntrack_tuple *tuple,
 				 const struct nf_nat_range2 *range,
 				 enum nf_nat_manip_type maniptype,
@@ -34,7 +34,7 @@ static void unknown_unique_tuple(const struct nf_nat_l3proto *l3proto,
 	/* Sorry: we can't help you; if it's not unique, we can't frob
 	 * anything.
 	 */
-	return;
+	return 0;
 }
 
 static bool
