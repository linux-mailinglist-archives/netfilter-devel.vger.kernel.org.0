Return-Path: <netfilter-devel+bounces-5842-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3FCA16350
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2025 18:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D337A1CC4
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2025 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841E1E0DAF;
	Sun, 19 Jan 2025 17:21:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65511DFDB2;
	Sun, 19 Jan 2025 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307270; cv=none; b=KPfzM5RwN70kvdA1NfJA2jZNMFY/tTY3WHCkoIv1E525lCio+nK5Tf7lCgT5S0w5COzbyPRKDKCp1du35a7XlV9bYJtYD1MZdzdGeqv9nB+2IgRTR5oUREU+jmOAfCiAK7BB+GKmQ7gZcE5fF5KA1I2j4wVqOfYpVjHWqL8CvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307270; c=relaxed/simple;
	bh=enPIXvVn72i/FT+7Pnu+nw7EUzwc2x4qSzCJMedsHjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDu0X+bCDBeW6yo6Y6BN4JCtADLNxkrOz/Ro1JinBB99+cF27kl76UM56gYsZoIwOfEp4pbxdcVANaFHgecSrc7ueWbbToofulFMd+faxyc+VdlZsDNmNKziodjK1V8uvpWBPaTw9711KN8EiFTIJQ7z0tct/6TWpevoowVko6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 12/14] netfilter: conntrack: rework offload nf_conn timeout extension logic
Date: Sun, 19 Jan 2025 18:20:49 +0100
Message-Id: <20250119172051.8261-13-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250119172051.8261-1-pablo@netfilter.org>
References: <20250119172051.8261-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Offload nf_conn entries may not see traffic for a very long time.

To prevent incorrect 'ct is stale' checks during nf_conntrack table
lookup, the gc worker extends the timeout nf_conn entries marked for
offload to a large value.

The existing logic suffers from a few problems.

Garbage collection runs without locks, its unlikely but possible
that @ct is removed right after the 'offload' bit test.

In that case, the timeout of a new/reallocated nf_conn entry will
be increased.

Prevent this by obtaining a reference count on the ct object and
re-check of the confirmed and offload bits.

If those are not set, the ct is being removed, skip the timeout
extension in this case.

Parallel teardown is also problematic:
 cpu1                                cpu2
 gc_worker
                                     calls flow_offload_teardown()
 tests OFFLOAD bit, set
                                     clear OFFLOAD bit
                                     ct->timeout is repaired (e.g. set to timeout[UDP_CT_REPLIED])
 nf_ct_offload_timeout() called
 expire value is fetched
 <INTERRUPT>
-> NF_CT_DAY timeout for flow that isn't offloaded
(and might not see any further packets).

Use cmpxchg: if ct->timeout was repaired after the 2nd 'offload bit' test
passed, then ct->timeout will only be updated of ct->timeout was not
altered in between.

As we already have a gc worker for flowtable entries, ct->timeout repair
can be handled from the flowtable gc worker.

This avoids having flowtable specific logic in the conntrack core
and avoids checking entries that were never offloaded.

This allows to remove the nf_ct_offload_timeout helper.
Its safe to use in the add case, but not on teardown.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_conntrack.h |  10 ---
 net/netfilter/nf_conntrack_core.c    |   6 --
 net/netfilter/nf_flow_table_core.c   | 105 ++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 3cbf29dd0b71..3f02a45773e8 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -312,16 +312,6 @@ static inline bool nf_ct_should_gc(const struct nf_conn *ct)
 
 #define	NF_CT_DAY	(86400 * HZ)
 
-/* Set an arbitrary timeout large enough not to ever expire, this save
- * us a check for the IPS_OFFLOAD_BIT from the packet path via
- * nf_ct_is_expired().
- */
-static inline void nf_ct_offload_timeout(struct nf_conn *ct)
-{
-	if (nf_ct_expires(ct) < NF_CT_DAY / 2)
-		WRITE_ONCE(ct->timeout, nfct_time_stamp + NF_CT_DAY);
-}
-
 struct kernel_param;
 
 int nf_conntrack_set_hashsize(const char *val, const struct kernel_param *kp);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 0149d482adaa..7f8b245e287a 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1544,12 +1544,6 @@ static void gc_worker(struct work_struct *work)
 
 			tmp = nf_ct_tuplehash_to_ctrack(h);
 
-			if (test_bit(IPS_OFFLOAD_BIT, &tmp->status)) {
-				nf_ct_offload_timeout(tmp);
-				if (!nf_conntrack_max95)
-					continue;
-			}
-
 			if (expired_count > GC_SCAN_EXPIRED_MAX) {
 				rcu_read_unlock();
 
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index bdde469bbbd1..35396f568ecd 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -304,7 +304,7 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 		return err;
 	}
 
-	nf_ct_offload_timeout(flow->ct);
+	nf_ct_refresh(flow->ct, NF_CT_DAY);
 
 	if (nf_flowtable_hw_offload(flow_table)) {
 		__set_bit(NF_FLOW_HW, &flow->flags);
@@ -424,15 +424,116 @@ static bool nf_flow_custom_gc(struct nf_flowtable *flow_table,
 	return flow_table->type->gc && flow_table->type->gc(flow);
 }
 
+/**
+ * nf_flow_table_tcp_timeout() - new timeout of offloaded tcp entry
+ * @ct:		Flowtable offloaded tcp ct
+ *
+ * Return: number of seconds when ct entry should expire.
+ */
+static u32 nf_flow_table_tcp_timeout(const struct nf_conn *ct)
+{
+	u8 state = READ_ONCE(ct->proto.tcp.state);
+
+	switch (state) {
+	case TCP_CONNTRACK_SYN_SENT:
+	case TCP_CONNTRACK_SYN_RECV:
+		return 0;
+	case TCP_CONNTRACK_ESTABLISHED:
+		return NF_CT_DAY;
+	case TCP_CONNTRACK_FIN_WAIT:
+	case TCP_CONNTRACK_CLOSE_WAIT:
+	case TCP_CONNTRACK_LAST_ACK:
+	case TCP_CONNTRACK_TIME_WAIT:
+		return 5 * 60 * HZ;
+	case TCP_CONNTRACK_CLOSE:
+		return 0;
+	}
+
+	return 0;
+}
+
+/**
+ * nf_flow_table_extend_ct_timeout() - Extend ct timeout of offloaded conntrack entry
+ * @ct:		Flowtable offloaded ct
+ *
+ * Datapath lookups in the conntrack table will evict nf_conn entries
+ * if they have expired.
+ *
+ * Once nf_conn entries have been offloaded, nf_conntrack might not see any
+ * packets anymore.  Thus ct->timeout is no longer refreshed and ct can
+ * be evicted.
+ *
+ * To avoid the need for an additional check on the offload bit for every
+ * packet processed via nf_conntrack_in(), set an arbitrary timeout large
+ * enough not to ever expire, this save us a check for the IPS_OFFLOAD_BIT
+ * from the packet path via nf_ct_is_expired().
+ */
+static void nf_flow_table_extend_ct_timeout(struct nf_conn *ct)
+{
+	static const u32 min_timeout = 5 * 60 * HZ;
+	u32 expires = nf_ct_expires(ct);
+
+	/* normal case: large enough timeout, nothing to do. */
+	if (likely(expires >= min_timeout))
+		return;
+
+	/* must check offload bit after this, we do not hold any locks.
+	 * flowtable and ct entries could have been removed on another CPU.
+	 */
+	if (!refcount_inc_not_zero(&ct->ct_general.use))
+		return;
+
+	/* load ct->status after refcount increase */
+	smp_acquire__after_ctrl_dep();
+
+	if (nf_ct_is_confirmed(ct) &&
+	    test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
+		u8 l4proto = nf_ct_protonum(ct);
+		u32 new_timeout = true;
+
+		switch (l4proto) {
+		case IPPROTO_UDP:
+			new_timeout = NF_CT_DAY;
+			break;
+		case IPPROTO_TCP:
+			new_timeout = nf_flow_table_tcp_timeout(ct);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			break;
+		}
+
+		/* Update to ct->timeout from nf_conntrack happens
+		 * without holding ct->lock.
+		 *
+		 * Use cmpxchg to ensure timeout extension doesn't
+		 * happen when we race with conntrack datapath.
+		 *
+		 * The inverse -- datapath updating ->timeout right
+		 * after this -- is fine, datapath is authoritative.
+		 */
+		if (new_timeout) {
+			new_timeout += nfct_time_stamp;
+			cmpxchg(&ct->timeout, expires, new_timeout);
+		}
+	}
+
+	nf_ct_put(ct);
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
+	bool teardown = test_bit(NF_FLOW_TEARDOWN, &flow->flags);
+
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
 	    nf_flow_custom_gc(flow_table, flow))
 		flow_offload_teardown(flow);
+	else if (!teardown)
+		nf_flow_table_extend_ct_timeout(flow->ct);
 
-	if (test_bit(NF_FLOW_TEARDOWN, &flow->flags)) {
+	if (teardown) {
 		if (test_bit(NF_FLOW_HW, &flow->flags)) {
 			if (!test_bit(NF_FLOW_HW_DYING, &flow->flags))
 				nf_flow_offload_del(flow_table, flow);
-- 
2.30.2


