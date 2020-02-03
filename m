Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99B150CCE
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Feb 2020 17:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgBCQjg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Feb 2020 11:39:36 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:59396 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731337AbgBCQhd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:33 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1iyej4-0005Yq-RL; Mon, 03 Feb 2020 17:37:30 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH nf 4/4] netfilter: conntrack: allow insertion of clashing entries
Date:   Mon,  3 Feb 2020 17:37:07 +0100
Message-Id: <20200203163707.27254-5-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203163707.27254-1-fw@strlen.de>
References: <20200203163707.27254-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch further relaxes the need to drop an skb due to a clash with
an existing conntrack entry.

Current clash resolution handles the case where the clash occurs between
two identical entries (distinct nf_conn objects with same tuples), i.e.:

                    Original                        Reply
existing: 10.2.3.4:42 -> 10.8.8.8:53      10.2.3.4:42 <- 10.0.0.6:5353
clashing: 10.2.3.4:42 -> 10.8.8.8:53      10.2.3.4:42 <- 10.0.0.6:5353

... existing handling will discard the unconfirmed clashing entry and
makes skb->_nfct point to the existing one.  The skb can then be
processed normally just as if the clash would not have existed in the
first place.

For other clashes, the skb needs to be dropped.
This frequently happens with DNS resolvers that send A and AAAA queries
back-to-back when NAT rules are present that cause packets to get
different DNAT transformations applied, for example:

-m statistics --mode random ... -j DNAT --dnat-to 10.0.0.6:5353
-m statistics --mode random ... -j DNAT --dnat-to 10.0.0.7:5353

In this case the A or AAAA query is dropped which incurs a costly
delay during name resolution.

This patch alos allows this collision type:
                       Original                   Reply
existing: 10.2.3.4:42 -> 10.8.8.8:53      10.2.3.4:42 <- 10.0.0.6:5353
clashing: 10.2.3.4:42 -> 10.8.8.8:53      10.2.3.4:42 <- 10.0.0.7:5353

In this case, clash is in original direction -- the reply direction
is still unique.

The change makes it so that when the 2nd colliding packet is received,
the clashing conntrack is tagged with new IPS_NAT_CLASH_BIT, gets a fixed
1 second timeout and is inserted in the reply direction only.

The entry is hidden from 'conntrack -L', it will time out quickly
and it can be early dropped because it will never progress to the
ASSURED state.

To avoid special-casing the delete code path to special case
the ORIGINAL hlist_nulls node, a new helper, "hlist_nulls_add_fake", is
added so hlist_nulls_del() will work.

Example:

      CPU A:                               CPU B:
1.  10.2.3.4:42 -> 10.8.8.8:53 (A)
2.                                         10.2.3.4:42 -> 10.8.8.8:53 (AAAA)
3.  Apply DNAT, reply changed to 10.0.0.6
4.                                         10.2.3.4:42 -> 10.8.8.8:53 (AAAA)
5.                                         Apply DNAT, reply changed to 10.0.0.7
6. confirm/commit to conntrack table, no collisions
7.                                         commit clashing entry

Reply comes in:

10.2.3.4:42 <- 10.0.0.6:5353 (A)
 -> Finds a conntrack, DNAT is reversed & packet forwarded to 10.2.3.4:42
10.2.3.4:42 <- 10.0.0.7:5353 (AAAA)
 -> Finds a conntrack, DNAT is reversed & packet forwarded to 10.2.3.4:42
    The conntrack entry is deleted from table, as it has the NAT_CLASH
    bit set.

In case of a retransmit from ORIGINAL dir, all further packets will get
the DNAT transformation to 10.0.0.6.

I tried to come up with other solutions but they all have worse
problems.

Alternatives considered were:
1.  Confirm ct entries at allocation time, not in postrouting.
 a. will cause uneccesarry work when the skb that creates the
    conntrack is dropped by ruleset.
 b. in case nat is applied, ct entry would need to be moved in
    the table, which requires another spinlock pair to be taken.
 c. breaks the 'unconfirmed entry is private to cpu' assumption:
    we would need to guard all nfct->ext allocation requests with
    ct->lock spinlock.

2. Make the unconfirmed list a hash table instead of a pcpu list.
   Shares drawback c) of the first alternative.

3. Document this is expected and force users to rearrange their
   ruleset (e.g. by using "-m cluster" instead of "-m statistics").
   nft has the 'jhash' expression which can be used instead of 'numgen'.

   Major drawback: doesn't fix what I consider a bug, not very realistic
   and I believe its reasonable to have the existing rulesets to 'just
   work'.

4. Document this is expected and force users to steer problematic
   packets to the same CPU -- this would serialize the "allocate new
   conntrack entry/nat table evaluation/perform nat/confirm entry", so
   no race can occur.  Similar drawback to 3.

Another advantage of this patch compared to 1) and 2) is that there are
no changes to the hot path; things are handled in the udp tracker and
the clash resolution path.

Cc: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 CC RCU maintainers because of new helper added to rculist_nulls.h.
 Previous version open-coded it but I think its more readable this way.

 include/linux/rculist_nulls.h                 |  7 ++
 .../linux/netfilter/nf_conntrack_common.h     | 12 ++-
 net/netfilter/nf_conntrack_core.c             | 76 ++++++++++++++++++-
 net/netfilter/nf_conntrack_proto_udp.c        | 20 ++++-
 4 files changed, 108 insertions(+), 7 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index e5b752027a03..9670b54b484a 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -145,6 +145,13 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	}
 }
 
+/* after that hlist_nulls_del will work */
+static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
+{
+	n->pprev = &n->next;
+	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
diff --git a/include/uapi/linux/netfilter/nf_conntrack_common.h b/include/uapi/linux/netfilter/nf_conntrack_common.h
index 336014bf8868..b6f0bb1dc799 100644
--- a/include/uapi/linux/netfilter/nf_conntrack_common.h
+++ b/include/uapi/linux/netfilter/nf_conntrack_common.h
@@ -97,6 +97,15 @@ enum ip_conntrack_status {
 	IPS_UNTRACKED_BIT = 12,
 	IPS_UNTRACKED = (1 << IPS_UNTRACKED_BIT),
 
+#ifdef __KERNEL__
+	/* Re-purposed for in-kernel use:
+	 * Tags a conntrack entry that clashed with an existing entry
+	 * on insert.
+	 */
+	IPS_NAT_CLASH_BIT = IPS_UNTRACKED_BIT,
+	IPS_NAT_CLASH = IPS_UNTRACKED,
+#endif
+
 	/* Conntrack got a helper explicitly attached via CT target. */
 	IPS_HELPER_BIT = 13,
 	IPS_HELPER = (1 << IPS_HELPER_BIT),
@@ -110,7 +119,8 @@ enum ip_conntrack_status {
 	 */
 	IPS_UNCHANGEABLE_MASK = (IPS_NAT_DONE_MASK | IPS_NAT_MASK |
 				 IPS_EXPECTED | IPS_CONFIRMED | IPS_DYING |
-				 IPS_SEQ_ADJUST | IPS_TEMPLATE | IPS_OFFLOAD),
+				 IPS_SEQ_ADJUST | IPS_TEMPLATE | IPS_UNTRACKED |
+				 IPS_OFFLOAD),
 
 	__IPS_MAX_BIT = 15,
 };
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 3f069eb0f0fc..1927fc296f95 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -940,11 +940,71 @@ static int __nf_ct_resolve_clash(struct sk_buff *skb,
 	return NF_DROP;
 }
 
+/**
+ * nf_ct_resolve_clash_harder - attempt to insert clashing conntrack entry
+ *
+ * @skb: skb that causes the collision
+ * @repl_idx: hash slot for reply direction
+ *
+ * Called when origin or reply direction had a clash.
+ * The skb can be handled without packet drop provided the reply direction
+ * is unique or there the existing entry has the identical tuple in both
+ * directions.
+ *
+ * Caller must hold conntrack table locks to prevent concurrent updates.
+ *
+ * Returns NF_DROP if the clash could not be handled.
+ */
+static int nf_ct_resolve_clash_harder(struct sk_buff *skb, u32 repl_idx)
+{
+	struct nf_conn *loser_ct = (struct nf_conn *)skb_nfct(skb);
+	const struct nf_conntrack_zone *zone;
+	struct nf_conntrack_tuple_hash *h;
+	struct hlist_nulls_node *n;
+	struct net *net;
+
+	zone = nf_ct_zone(loser_ct);
+	net = nf_ct_net(loser_ct);
+
+	/* Reply direction must never result in a clash, unless both origin
+	 * and reply tuples are identical.
+	 */
+	hlist_nulls_for_each_entry(h, n, &nf_conntrack_hash[repl_idx], hnnode) {
+		if (nf_ct_key_equal(h,
+				    &loser_ct->tuplehash[IP_CT_DIR_REPLY].tuple,
+				    zone, net))
+			return __nf_ct_resolve_clash(skb, h);
+	}
+
+	/* We want the clashing entry to go away real soon: 1 second timeout. */
+	loser_ct->timeout = nfct_time_stamp + HZ;
+
+	/* IPS_NAT_CLASH removes the entry automatically on the first
+	 * reply.  Also prevents UDP tracker from moving the entry to
+	 * ASSURED state, i.e. the entry can always be evicted under
+	 * pressure.
+	 */
+	loser_ct->status |= IPS_FIXED_TIMEOUT | IPS_NAT_CLASH;
+
+	__nf_conntrack_insert_prepare(loser_ct);
+
+	/* fake add for ORIGINAL dir: we want lookups to only find the entry
+	 * already in the table.  This also hides the clashing entry from
+	 * ctnetlink iteration, i.e. conntrack -L won't show them.
+	 */
+	hlist_nulls_add_fake(&loser_ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode);
+
+	hlist_nulls_add_head_rcu(&loser_ct->tuplehash[IP_CT_DIR_REPLY].hnnode,
+				 &nf_conntrack_hash[repl_idx]);
+	return NF_ACCEPT;
+}
+
 /**
  * nf_ct_resolve_clash - attempt to handle clash without packet drop
  *
  * @skb: skb that causes the clash
  * @h: tuplehash of the clashing entry already in table
+ * @hash_reply: hash slot for reply direction
  *
  * A conntrack entry can be inserted to the connection tracking table
  * if there is no existing entry with an identical tuple.
@@ -963,10 +1023,18 @@ static int __nf_ct_resolve_clash(struct sk_buff *skb,
  * exactly the same, only the to-be-confirmed conntrack entry is discarded
  * and @skb is associated with the conntrack entry already in the table.
  *
+ * Failing that, the new, unconfirmed conntrack is still added to the table
+ * provided that the collision only occurs in the ORIGINAL direction.
+ * The new entry will be added after the existing one in the hash list,
+ * so packets in the ORIGINAL direction will continue to match the existing
+ * entry.  The new entry will also have a fixed timeout so it expires --
+ * due to the collision, it will not see bidirectional traffic.
+ *
  * Returns NF_DROP if the clash could not be resolved.
  */
 static __cold noinline int
-nf_ct_resolve_clash(struct sk_buff *skb, struct nf_conntrack_tuple_hash *h)
+nf_ct_resolve_clash(struct sk_buff *skb, struct nf_conntrack_tuple_hash *h,
+		    u32 reply_hash)
 {
 	/* This is the conntrack entry already in hashes that won race. */
 	struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
@@ -987,6 +1055,10 @@ nf_ct_resolve_clash(struct sk_buff *skb, struct nf_conntrack_tuple_hash *h)
 	if (ret == NF_ACCEPT)
 		return ret;
 
+	ret = nf_ct_resolve_clash_harder(skb, reply_hash);
+	if (ret == NF_ACCEPT)
+		return ret;
+
 drop:
 	nf_ct_add_to_dying_list(loser_ct);
 	NF_CT_STAT_INC(net, drop);
@@ -1101,7 +1173,7 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	return NF_ACCEPT;
 
 out:
-	ret = nf_ct_resolve_clash(skb, h);
+	ret = nf_ct_resolve_clash(skb, h, reply_hash);
 dying:
 	nf_conntrack_double_unlock(hash, reply_hash);
 	local_bh_enable();
diff --git a/net/netfilter/nf_conntrack_proto_udp.c b/net/netfilter/nf_conntrack_proto_udp.c
index 7365b43f8f98..760ca2422816 100644
--- a/net/netfilter/nf_conntrack_proto_udp.c
+++ b/net/netfilter/nf_conntrack_proto_udp.c
@@ -81,6 +81,18 @@ static bool udp_error(struct sk_buff *skb,
 	return false;
 }
 
+static void nf_conntrack_udp_refresh_unreplied(struct nf_conn *ct,
+					       struct sk_buff *skb,
+					       enum ip_conntrack_info ctinfo,
+					       u32 extra_jiffies)
+{
+	if (unlikely(ctinfo == IP_CT_ESTABLISHED_REPLY &&
+		     ct->status & IPS_NAT_CLASH))
+		nf_ct_kill(ct);
+	else
+		nf_ct_refresh_acct(ct, ctinfo, skb, extra_jiffies);
+}
+
 /* Returns verdict for packet, and may modify conntracktype */
 int nf_conntrack_udp_packet(struct nf_conn *ct,
 			    struct sk_buff *skb,
@@ -116,8 +128,8 @@ int nf_conntrack_udp_packet(struct nf_conn *ct,
 		if (!test_and_set_bit(IPS_ASSURED_BIT, &ct->status))
 			nf_conntrack_event_cache(IPCT_ASSURED, ct);
 	} else {
-		nf_ct_refresh_acct(ct, ctinfo, skb,
-				   timeouts[UDP_CT_UNREPLIED]);
+		nf_conntrack_udp_refresh_unreplied(ct, skb, ctinfo,
+						   timeouts[UDP_CT_UNREPLIED]);
 	}
 	return NF_ACCEPT;
 }
@@ -198,8 +210,8 @@ int nf_conntrack_udplite_packet(struct nf_conn *ct,
 		if (!test_and_set_bit(IPS_ASSURED_BIT, &ct->status))
 			nf_conntrack_event_cache(IPCT_ASSURED, ct);
 	} else {
-		nf_ct_refresh_acct(ct, ctinfo, skb,
-				   timeouts[UDP_CT_UNREPLIED]);
+		nf_conntrack_udp_refresh_unreplied(ct, skb, ctinfo,
+						   timeouts[UDP_CT_UNREPLIED]);
 	}
 	return NF_ACCEPT;
 }
-- 
2.24.1

