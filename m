Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0D430149
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Oct 2021 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbhJPIvi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 16 Oct 2021 04:51:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55214 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbhJPIvc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 16 Oct 2021 04:51:32 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634374163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pf3j33rDAbySDl5cOguF6tugdjPAtD4nkYhsJAdV2lA=;
        b=ENucHSUMYfHCsTu9uSh4X5FqgWAOuzSKmsC0ZNwwf1ukx9b9y+kDG5CZVHe8czh2rJHK2K
        gfq0DBfjNtpcAOgArIFQgnDWeVMzZQSmQb2INIfb/Nfog+8+BqS0Hc+ubOGw8KkEAJmZi7
        NGavPLwE2BZTtru5ov8m87KWiXKIQW0C2HMDJUSDERofrFAN1fQ16JOo9Dkn9GsS2kpD7T
        Bd1wirMfLoDi3uoxQTZFVQRZ7HZQazKInD0cifXFkm9dMCV5QAoQi3KkFLPzQrDLukb+iV
        Oc3q9mEAkYFuDWTQMbaI1lWkzgszZP03Egcj7ske9FvEPmB26AV9sV4ZeHgl9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634374163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pf3j33rDAbySDl5cOguF6tugdjPAtD4nkYhsJAdV2lA=;
        b=ufhx3XghJXOl81/wM19zoyhn8b8cksOnux14z35homraLphQOAFMysTWuKecDud2sMznkw
        EPDDYIcWFy4jgHBQ==
To:     netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 9/9] net: sched: Remove Qdisc::running sequence counter
Date:   Sat, 16 Oct 2021 10:49:10 +0200
Message-Id: <20211016084910.4029084-10-bigeasy@linutronix.de>
In-Reply-To: <20211016084910.4029084-1-bigeasy@linutronix.de>
References: <20211016084910.4029084-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

The Qdisc::running sequence counter has two uses:

  1. Reliably reading qdisc's tc statistics while the qdisc is running
     (a seqcount read/retry loop at gnet_stats_add_basic()).

  2. As a flag, indicating whether the qdisc in question is running
     (without any retry loops).

For the first usage, the Qdisc::running sequence counter write section,
qdisc_run_begin() =3D> qdisc_run_end(), covers a much wider area than what
is actually needed: the raw qdisc's bstats update. A u64_stats sync
point was thus introduced (in previous commits) inside the bstats
structure itself. A local u64_stats write section is then started and
stopped for the bstats updates.

Use that u64_stats sync point mechanism for the bstats read/retry loop
at gnet_stats_add_basic().

For the second qdisc->running usage, a __QDISC_STATE_RUNNING bit flag,
accessed with atomic bitops, is sufficient. Using a bit flag instead of
a sequence counter at qdisc_run_begin/end() and qdisc_is_running() leads
to the SMP barriers implicitly added through raw_read_seqcount() and
write_seqcount_begin/end() getting removed. All call sites have been
surveyed though, and no required ordering was identified.

Now that the qdisc->running sequence counter is no longer used, remove
it.

Note, using u64_stats implies no sequence counter protection for 64-bit
architectures. This can lead to the qdisc tc statistics "packets" vs.
"bytes" values getting out of sync on rare occasions. The individual
values will still be valid.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  4 ----
 include/net/gen_stats.h   | 19 +++++++--------
 include/net/sch_generic.h | 33 +++++++++++---------------
 net/core/gen_estimator.c  | 16 ++++++++-----
 net/core/gen_stats.c      | 50 ++++++++++++++++++++++-----------------
 net/sched/act_api.c       |  9 +++----
 net/sched/act_police.c    |  2 +-
 net/sched/sch_api.c       | 16 +++----------
 net/sched/sch_atm.c       |  3 +--
 net/sched/sch_cbq.c       |  9 +++----
 net/sched/sch_drr.c       | 10 +++-----
 net/sched/sch_ets.c       |  3 +--
 net/sched/sch_generic.c   | 10 ++------
 net/sched/sch_hfsc.c      |  8 +++----
 net/sched/sch_htb.c       |  7 +++---
 net/sched/sch_mq.c        |  7 +++---
 net/sched/sch_mqprio.c    | 14 +++++------
 net/sched/sch_multiq.c    |  3 +--
 net/sched/sch_prio.c      |  4 ++--
 net/sched/sch_qfq.c       |  7 +++---
 net/sched/sch_taprio.c    |  2 +-
 21 files changed, 102 insertions(+), 134 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 173984414f387..f9cd6fea213f3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1916,7 +1916,6 @@ enum netdev_ml_priv_type {
  *	@sfp_bus:	attached &struct sfp_bus structure.
  *
  *	@qdisc_tx_busylock: lockdep class annotating Qdisc->busylock spinlock
- *	@qdisc_running_key: lockdep class annotating Qdisc->running seqcount
  *
  *	@proto_down:	protocol port state information can be sent to the
  *			switch driver and used to set the phys state of the
@@ -2250,7 +2249,6 @@ struct net_device {
 	struct phy_device	*phydev;
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
-	struct lock_class_key	*qdisc_running_key;
 	bool			proto_down;
 	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
@@ -2360,13 +2358,11 @@ static inline void netdev_for_each_tx_queue(struct =
net_device *dev,
 #define netdev_lockdep_set_classes(dev)				\
 {								\
 	static struct lock_class_key qdisc_tx_busylock_key;	\
-	static struct lock_class_key qdisc_running_key;		\
 	static struct lock_class_key qdisc_xmit_lock_key;	\
 	static struct lock_class_key dev_addr_list_lock_key;	\
 	unsigned int i;						\
 								\
 	(dev)->qdisc_tx_busylock =3D &qdisc_tx_busylock_key;	\
-	(dev)->qdisc_running_key =3D &qdisc_running_key;		\
 	lockdep_set_class(&(dev)->addr_list_lock,		\
 			  &dev_addr_list_lock_key);		\
 	for (i =3D 0; i < (dev)->num_tx_queues; i++)		\
diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index 52b87588f467b..7aa2b8e1fb298 100644
--- a/include/net/gen_stats.h
+++ b/include/net/gen_stats.h
@@ -46,18 +46,15 @@ int gnet_stats_start_copy_compat(struct sk_buff *skb, i=
nt type,
 				 spinlock_t *lock, struct gnet_dump *d,
 				 int padattr);
=20
-int gnet_stats_copy_basic(const seqcount_t *running,
-			  struct gnet_dump *d,
+int gnet_stats_copy_basic(struct gnet_dump *d,
 			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b);
-void gnet_stats_add_basic(const seqcount_t *running,
-			  struct gnet_stats_basic_sync *bstats,
+			  struct gnet_stats_basic_sync *b, bool running);
+void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b);
-int gnet_stats_copy_basic_hw(const seqcount_t *running,
-			     struct gnet_dump *d,
+			  struct gnet_stats_basic_sync *b, bool running);
+int gnet_stats_copy_basic_hw(struct gnet_dump *d,
 			     struct gnet_stats_basic_sync __percpu *cpu,
-			     struct gnet_stats_basic_sync *b);
+			     struct gnet_stats_basic_sync *b, bool running);
 int gnet_stats_copy_rate_est(struct gnet_dump *d,
 			     struct net_rate_estimator __rcu **ptr);
 int gnet_stats_copy_queue(struct gnet_dump *d,
@@ -74,13 +71,13 @@ int gen_new_estimator(struct gnet_stats_basic_sync *bst=
ats,
 		      struct gnet_stats_basic_sync __percpu *cpu_bstats,
 		      struct net_rate_estimator __rcu **rate_est,
 		      spinlock_t *lock,
-		      seqcount_t *running, struct nlattr *opt);
+		      bool running, struct nlattr *opt);
 void gen_kill_estimator(struct net_rate_estimator __rcu **ptr);
 int gen_replace_estimator(struct gnet_stats_basic_sync *bstats,
 			  struct gnet_stats_basic_sync __percpu *cpu_bstats,
 			  struct net_rate_estimator __rcu **ptr,
 			  spinlock_t *lock,
-			  seqcount_t *running, struct nlattr *opt);
+			  bool running, struct nlattr *opt);
 bool gen_estimator_active(struct net_rate_estimator __rcu **ptr);
 bool gen_estimator_read(struct net_rate_estimator __rcu **ptr,
 			struct gnet_stats_rate_est64 *sample);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 7882e3aa64482..baad2ab4d971c 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -38,6 +38,10 @@ enum qdisc_state_t {
 	__QDISC_STATE_DEACTIVATED,
 	__QDISC_STATE_MISSED,
 	__QDISC_STATE_DRAINING,
+	/* Only for !TCQ_F_NOLOCK qdisc. Never access it directly.
+	 * Use qdisc_run_begin/end() or qdisc_is_running() instead.
+	 */
+	__QDISC_STATE_RUNNING,
 };
=20
 #define QDISC_STATE_MISSED	BIT(__QDISC_STATE_MISSED)
@@ -108,7 +112,6 @@ struct Qdisc {
 	struct sk_buff_head	gso_skb ____cacheline_aligned_in_smp;
 	struct qdisc_skb_head	q;
 	struct gnet_stats_basic_sync bstats;
-	seqcount_t		running;
 	struct gnet_stats_queue	qstats;
 	unsigned long		state;
 	struct Qdisc            *next_sched;
@@ -143,11 +146,15 @@ static inline struct Qdisc *qdisc_refcount_inc_nz(str=
uct Qdisc *qdisc)
 	return NULL;
 }
=20
+/* For !TCQ_F_NOLOCK qdisc: callers must either call this within a qdisc
+ * root_lock section, or provide their own memory barriers -- ordering
+ * against qdisc_run_begin/end() atomic bit operations.
+ */
 static inline bool qdisc_is_running(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK)
 		return spin_is_locked(&qdisc->seqlock);
-	return (raw_read_seqcount(&qdisc->running) & 1) ? true : false;
+	return test_bit(__QDISC_STATE_RUNNING, &qdisc->state);
 }
=20
 static inline bool nolock_qdisc_is_empty(const struct Qdisc *qdisc)
@@ -167,6 +174,9 @@ static inline bool qdisc_is_empty(const struct Qdisc *q=
disc)
 	return !READ_ONCE(qdisc->q.qlen);
 }
=20
+/* For !TCQ_F_NOLOCK qdisc, qdisc_run_begin/end() must be invoked with
+ * the qdisc root lock acquired.
+ */
 static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 {
 	if (qdisc->flags & TCQ_F_NOLOCK) {
@@ -206,15 +216,8 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 * after it releases the lock at the end of qdisc_run_end().
 		 */
 		return spin_trylock(&qdisc->seqlock);
-	} else if (qdisc_is_running(qdisc)) {
-		return false;
 	}
-	/* Variant of write_seqcount_begin() telling lockdep a trylock
-	 * was attempted.
-	 */
-	raw_write_seqcount_begin(&qdisc->running);
-	seqcount_acquire(&qdisc->running.dep_map, 0, 1, _RET_IP_);
-	return true;
+	return test_and_set_bit(__QDISC_STATE_RUNNING, &qdisc->state);
 }
=20
 static inline void qdisc_run_end(struct Qdisc *qdisc)
@@ -226,7 +229,7 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 				      &qdisc->state)))
 			__netif_schedule(qdisc);
 	} else {
-		write_seqcount_end(&qdisc->running);
+		clear_bit(__QDISC_STATE_RUNNING, &qdisc->state);
 	}
 }
=20
@@ -592,14 +595,6 @@ static inline spinlock_t *qdisc_root_sleeping_lock(con=
st struct Qdisc *qdisc)
 	return qdisc_lock(root);
 }
=20
-static inline seqcount_t *qdisc_root_sleeping_running(const struct Qdisc *=
qdisc)
-{
-	struct Qdisc *root =3D qdisc_root_sleeping(qdisc);
-
-	ASSERT_RTNL();
-	return &root->running;
-}
-
 static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
 {
 	return qdisc->dev_queue->dev;
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index a73ad0bf324c4..4fcbdd71c59fa 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -42,7 +42,7 @@
 struct net_rate_estimator {
 	struct gnet_stats_basic_sync	*bstats;
 	spinlock_t		*stats_lock;
-	seqcount_t		*running;
+	bool			running;
 	struct gnet_stats_basic_sync __percpu *cpu_bstats;
 	u8			ewma_log;
 	u8			intvl_log; /* period : (250ms << intvl_log) */
@@ -66,7 +66,7 @@ static void est_fetch_counters(struct net_rate_estimator =
*e,
 	if (e->stats_lock)
 		spin_lock(e->stats_lock);
=20
-	gnet_stats_add_basic(e->running, b, e->cpu_bstats, e->bstats);
+	gnet_stats_add_basic(b, e->cpu_bstats, e->bstats, e->running);
=20
 	if (e->stats_lock)
 		spin_unlock(e->stats_lock);
@@ -113,7 +113,9 @@ static void est_timer(struct timer_list *t)
  * @cpu_bstats: bstats per cpu
  * @rate_est: rate estimator statistics
  * @lock: lock for statistics and control path
- * @running: qdisc running seqcount
+ * @running: true if @bstats represents a running qdisc, thus @bstats'
+ *           internal values might change during basic reads. Only used
+ *           if @bstats_cpu is NULL
  * @opt: rate estimator configuration TLV
  *
  * Creates a new rate estimator with &bstats as source and &rate_est
@@ -129,7 +131,7 @@ int gen_new_estimator(struct gnet_stats_basic_sync *bst=
ats,
 		      struct gnet_stats_basic_sync __percpu *cpu_bstats,
 		      struct net_rate_estimator __rcu **rate_est,
 		      spinlock_t *lock,
-		      seqcount_t *running,
+		      bool running,
 		      struct nlattr *opt)
 {
 	struct gnet_estimator *parm =3D nla_data(opt);
@@ -218,7 +220,9 @@ EXPORT_SYMBOL(gen_kill_estimator);
  * @cpu_bstats: bstats per cpu
  * @rate_est: rate estimator statistics
  * @lock: lock for statistics and control path
- * @running: qdisc running seqcount (might be NULL)
+ * @running: true if @bstats represents a running qdisc, thus @bstats'
+ *           internal values might change during basic reads. Only used
+ *           if @cpu_bstats is NULL
  * @opt: rate estimator configuration TLV
  *
  * Replaces the configuration of a rate estimator by calling
@@ -230,7 +234,7 @@ int gen_replace_estimator(struct gnet_stats_basic_sync =
*bstats,
 			  struct gnet_stats_basic_sync __percpu *cpu_bstats,
 			  struct net_rate_estimator __rcu **rate_est,
 			  spinlock_t *lock,
-			  seqcount_t *running, struct nlattr *opt)
+			  bool running, struct nlattr *opt)
 {
 	return gen_new_estimator(bstats, cpu_bstats, rate_est,
 				 lock, running, opt);
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index 5f57f761def69..5516ea0d5da0b 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -146,42 +146,42 @@ static void gnet_stats_add_basic_cpu(struct gnet_stat=
s_basic_sync *bstats,
 	_bstats_update(bstats, t_bytes, t_packets);
 }
=20
-void gnet_stats_add_basic(const seqcount_t *running,
-			  struct gnet_stats_basic_sync *bstats,
+void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b)
+			  struct gnet_stats_basic_sync *b, bool running)
 {
-	unsigned int seq;
+	unsigned int start;
 	u64 bytes =3D 0;
 	u64 packets =3D 0;
=20
+	WARN_ON_ONCE((cpu || running) && !in_task());
+
 	if (cpu) {
 		gnet_stats_add_basic_cpu(bstats, cpu);
 		return;
 	}
 	do {
 		if (running)
-			seq =3D read_seqcount_begin(running);
+			start =3D u64_stats_fetch_begin_irq(&b->syncp);
 		bytes =3D u64_stats_read(&b->bytes);
 		packets =3D u64_stats_read(&b->packets);
-	} while (running && read_seqcount_retry(running, seq));
+	} while (running && u64_stats_fetch_retry_irq(&b->syncp, start));
=20
 	_bstats_update(bstats, bytes, packets);
 }
 EXPORT_SYMBOL(gnet_stats_add_basic);
=20
 static int
-___gnet_stats_copy_basic(const seqcount_t *running,
-			 struct gnet_dump *d,
+___gnet_stats_copy_basic(struct gnet_dump *d,
 			 struct gnet_stats_basic_sync __percpu *cpu,
 			 struct gnet_stats_basic_sync *b,
-			 int type)
+			 int type, bool running)
 {
 	struct gnet_stats_basic_sync bstats;
 	u64 bstats_bytes, bstats_packets;
=20
 	gnet_stats_basic_sync_init(&bstats);
-	gnet_stats_add_basic(running, &bstats, cpu, b);
+	gnet_stats_add_basic(&bstats, cpu, b, running);
=20
 	bstats_bytes =3D u64_stats_read(&bstats.bytes);
 	bstats_packets =3D u64_stats_read(&bstats.packets);
@@ -210,10 +210,14 @@ ___gnet_stats_copy_basic(const seqcount_t *running,
=20
 /**
  * gnet_stats_copy_basic - copy basic statistics into statistic TLV
- * @running: seqcount_t pointer
  * @d: dumping handle
  * @cpu: copy statistic per cpu
  * @b: basic statistics
+ * @running: true if @b represents a running qdisc, thus @b's
+ *           internal values might change during basic reads.
+ *           Only used if @cpu is NULL
+ *
+ * Context: task; must not be run from IRQ or BH contexts
  *
  * Appends the basic statistics to the top level TLV created by
  * gnet_stats_start_copy().
@@ -222,22 +226,25 @@ ___gnet_stats_copy_basic(const seqcount_t *running,
  * if the room in the socket buffer was not sufficient.
  */
 int
-gnet_stats_copy_basic(const seqcount_t *running,
-		      struct gnet_dump *d,
+gnet_stats_copy_basic(struct gnet_dump *d,
 		      struct gnet_stats_basic_sync __percpu *cpu,
-		      struct gnet_stats_basic_sync *b)
+		      struct gnet_stats_basic_sync *b,
+		      bool running)
 {
-	return ___gnet_stats_copy_basic(running, d, cpu, b,
-					TCA_STATS_BASIC);
+	return ___gnet_stats_copy_basic(d, cpu, b, TCA_STATS_BASIC, running);
 }
 EXPORT_SYMBOL(gnet_stats_copy_basic);
=20
 /**
  * gnet_stats_copy_basic_hw - copy basic hw statistics into statistic TLV
- * @running: seqcount_t pointer
  * @d: dumping handle
  * @cpu: copy statistic per cpu
  * @b: basic statistics
+ * @running: true if @b represents a running qdisc, thus @b's
+ *           internal values might change during basic reads.
+ *           Only used if @cpu is NULL
+ *
+ * Context: task; must not be run from IRQ or BH contexts
  *
  * Appends the basic statistics to the top level TLV created by
  * gnet_stats_start_copy().
@@ -246,13 +253,12 @@ EXPORT_SYMBOL(gnet_stats_copy_basic);
  * if the room in the socket buffer was not sufficient.
  */
 int
-gnet_stats_copy_basic_hw(const seqcount_t *running,
-			 struct gnet_dump *d,
+gnet_stats_copy_basic_hw(struct gnet_dump *d,
 			 struct gnet_stats_basic_sync __percpu *cpu,
-			 struct gnet_stats_basic_sync *b)
+			 struct gnet_stats_basic_sync *b,
+			 bool running)
 {
-	return ___gnet_stats_copy_basic(running, d, cpu, b,
-					TCA_STATS_BASIC_HW);
+	return ___gnet_stats_copy_basic(d, cpu, b, TCA_STATS_BASIC_HW, running);
 }
 EXPORT_SYMBOL(gnet_stats_copy_basic_hw);
=20
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 585829ffa0c4c..4133b8ea5a57a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -501,7 +501,7 @@ int tcf_idr_create(struct tc_action_net *tn, u32 index,=
 struct nlattr *est,
 	if (est) {
 		err =3D gen_new_estimator(&p->tcfa_bstats, p->cpu_bstats,
 					&p->tcfa_rate_est,
-					&p->tcfa_lock, NULL, est);
+					&p->tcfa_lock, false, est);
 		if (err)
 			goto err4;
 	}
@@ -1173,9 +1173,10 @@ int tcf_action_copy_stats(struct sk_buff *skb, struc=
t tc_action *p,
 	if (err < 0)
 		goto errout;
=20
-	if (gnet_stats_copy_basic(NULL, &d, p->cpu_bstats, &p->tcfa_bstats) < 0 ||
-	    gnet_stats_copy_basic_hw(NULL, &d, p->cpu_bstats_hw,
-				     &p->tcfa_bstats_hw) < 0 ||
+	if (gnet_stats_copy_basic(&d, p->cpu_bstats,
+				  &p->tcfa_bstats, false) < 0 ||
+	    gnet_stats_copy_basic_hw(&d, p->cpu_bstats_hw,
+				     &p->tcfa_bstats_hw, false) < 0 ||
 	    gnet_stats_copy_rate_est(&d, &p->tcfa_rate_est) < 0 ||
 	    gnet_stats_copy_queue(&d, p->cpu_qstats,
 				  &p->tcfa_qstats,
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index c9383805222df..9e77ba8401e53 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -125,7 +125,7 @@ static int tcf_police_init(struct net *net, struct nlat=
tr *nla,
 					    police->common.cpu_bstats,
 					    &police->tcf_rate_est,
 					    &police->tcf_lock,
-					    NULL, est);
+					    false, est);
 		if (err)
 			goto failure;
 	} else if (tb[TCA_POLICE_AVRATE] &&
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 70f006cbf2126..efcd0b5e9a323 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -943,8 +943,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qd=
isc *q, u32 clid,
 		cpu_qstats =3D q->cpu_qstats;
 	}
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(q),
-				  &d, cpu_bstats, &q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(&d, cpu_bstats, &q->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(&d, &q->rate_est) < 0 ||
 	    gnet_stats_copy_queue(&d, cpu_qstats, &q->qstats, qlen) < 0)
 		goto nla_put_failure;
@@ -1265,26 +1264,17 @@ static struct Qdisc *qdisc_create(struct net_device=
 *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 	if (tca[TCA_RATE]) {
-		seqcount_t *running;
-
 		err =3D -EOPNOTSUPP;
 		if (sch->flags & TCQ_F_MQROOT) {
 			NL_SET_ERR_MSG(extack, "Cannot attach rate estimator to a multi-queue r=
oot qdisc");
 			goto err_out4;
 		}
=20
-		if (sch->parent !=3D TC_H_ROOT &&
-		    !(sch->flags & TCQ_F_INGRESS) &&
-		    (!p || !(p->flags & TCQ_F_MQROOT)))
-			running =3D qdisc_root_sleeping_running(sch);
-		else
-			running =3D &sch->running;
-
 		err =3D gen_new_estimator(&sch->bstats,
 					sch->cpu_bstats,
 					&sch->rate_est,
 					NULL,
-					running,
+					true,
 					tca[TCA_RATE]);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "Failed to generate new estimator");
@@ -1360,7 +1350,7 @@ static int qdisc_change(struct Qdisc *sch, struct nla=
ttr **tca,
 				      sch->cpu_bstats,
 				      &sch->rate_est,
 				      NULL,
-				      qdisc_root_sleeping_running(sch),
+				      true,
 				      tca[TCA_RATE]);
 	}
 out:
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
index fbfe4ce9497b5..4c8e994cf0a53 100644
--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -653,8 +653,7 @@ atm_tc_dump_class_stats(struct Qdisc *sch, unsigned lon=
g arg,
 {
 	struct atm_flow_data *flow =3D (struct atm_flow_data *)arg;
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &flow->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &flow->bstats, true) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &flow->qstats, flow->q->q.qlen) < 0)
 		return -1;
=20
diff --git a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
index f0b1282fae111..02d9f0dfe3564 100644
--- a/net/sched/sch_cbq.c
+++ b/net/sched/sch_cbq.c
@@ -1383,8 +1383,7 @@ cbq_dump_class_stats(struct Qdisc *sch, unsigned long=
 arg,
 	if (cl->undertime !=3D PSCHED_PASTPERFECT)
 		cl->xstats.undertime =3D cl->undertime - q->now;
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl->qstats, qlen) < 0)
 		return -1;
@@ -1518,7 +1517,7 @@ cbq_change_class(struct Qdisc *sch, u32 classid, u32 =
parentid, struct nlattr **t
 			err =3D gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err) {
 				NL_SET_ERR_MSG(extack, "Failed to replace specified rate estimator");
@@ -1619,9 +1618,7 @@ cbq_change_class(struct Qdisc *sch, u32 classid, u32 =
parentid, struct nlattr **t
=20
 	if (tca[TCA_RATE]) {
 		err =3D gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
+					NULL, true, tca[TCA_RATE]);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "Couldn't create new estimator");
 			tcf_block_put(cl->block);
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 7243617a3595f..18e4f7a0b2912 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -85,8 +85,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classi=
d, u32 parentid,
 		if (tca[TCA_RATE]) {
 			err =3D gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
-						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    NULL, true,
 						    tca[TCA_RATE]);
 			if (err) {
 				NL_SET_ERR_MSG(extack, "Failed to replace estimator");
@@ -119,9 +118,7 @@ static int drr_change_class(struct Qdisc *sch, u32 clas=
sid, u32 parentid,
=20
 	if (tca[TCA_RATE]) {
 		err =3D gen_replace_estimator(&cl->bstats, NULL, &cl->rate_est,
-					    NULL,
-					    qdisc_root_sleeping_running(sch),
-					    tca[TCA_RATE]);
+					    NULL, true, tca[TCA_RATE]);
 		if (err) {
 			NL_SET_ERR_MSG(extack, "Failed to replace estimator");
 			qdisc_put(cl->qdisc);
@@ -268,8 +265,7 @@ static int drr_dump_class_stats(struct Qdisc *sch, unsi=
gned long arg,
 	if (qlen)
 		xstats.deficit =3D cl->deficit;
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, cl_q->cpu_qstats, &cl_q->qstats, qlen) < 0)
 		return -1;
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index af56d155e7fca..0eae9ff5edf6f 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -325,8 +325,7 @@ static int ets_class_dump_stats(struct Qdisc *sch, unsi=
gned long arg,
 	struct ets_class *cl =3D ets_class_from_arg(sch, arg);
 	struct Qdisc *cl_q =3D cl->qdisc;
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, cl_q) < 0)
 		return -1;
=20
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 989186e7f1a02..b0ff0dff27734 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -304,8 +304,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, boo=
l *validate,
=20
 /*
  * Transmit possibly several skbs, and handle the return status as
- * required. Owning running seqcount bit guarantees that
- * only one CPU can execute this function.
+ * required. Owning qdisc running bit guarantees that only one CPU
+ * can execute this function.
  *
  * Returns to the caller:
  *				false  - hardware queue frozen backoff
@@ -606,7 +606,6 @@ struct Qdisc noop_qdisc =3D {
 	.ops		=3D	&noop_qdisc_ops,
 	.q.lock		=3D	__SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock),
 	.dev_queue	=3D	&noop_netdev_queue,
-	.running	=3D	SEQCNT_ZERO(noop_qdisc.running),
 	.busylock	=3D	__SPIN_LOCK_UNLOCKED(noop_qdisc.busylock),
 	.gso_skb =3D {
 		.next =3D (struct sk_buff *)&noop_qdisc.gso_skb,
@@ -867,7 +866,6 @@ struct Qdisc_ops pfifo_fast_ops __read_mostly =3D {
 EXPORT_SYMBOL(pfifo_fast_ops);
=20
 static struct lock_class_key qdisc_tx_busylock;
-static struct lock_class_key qdisc_running_key;
=20
 struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 			  const struct Qdisc_ops *ops,
@@ -917,10 +915,6 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_que=
ue,
 	lockdep_set_class(&sch->seqlock,
 			  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
=20
-	seqcount_init(&sch->running);
-	lockdep_set_class(&sch->running,
-			  dev->qdisc_running_key ?: &qdisc_running_key);
-
 	sch->ops =3D ops;
 	sch->flags =3D ops->static_flags;
 	sch->enqueue =3D ops->enqueue;
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 181c2905ff983..d3979a6000e7d 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -965,7 +965,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 p=
arentid,
 			err =3D gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err)
 				return err;
@@ -1033,9 +1033,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32=
 parentid,
=20
 	if (tca[TCA_RATE]) {
 		err =3D gen_new_estimator(&cl->bstats, NULL, &cl->rate_est,
-					NULL,
-					qdisc_root_sleeping_running(sch),
-					tca[TCA_RATE]);
+					NULL, true, tca[TCA_RATE]);
 		if (err) {
 			tcf_block_put(cl->block);
 			kfree(cl);
@@ -1328,7 +1326,7 @@ hfsc_dump_class_stats(struct Qdisc *sch, unsigned lon=
g arg,
 	xstats.work    =3D cl->cl_total;
 	xstats.rtwork  =3D cl->cl_cumul;
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch), d, NULL, &cl-=
>bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &cl->qstats, qlen) < 0)
 		return -1;
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index adceb9e210f61..cf1d45db4e84b 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1368,8 +1368,7 @@ htb_dump_class_stats(struct Qdisc *sch, unsigned long=
 arg, struct gnet_dump *d)
 		}
 	}
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    gnet_stats_copy_queue(d, NULL, &qs, qlen) < 0)
 		return -1;
@@ -1865,7 +1864,7 @@ static int htb_change_class(struct Qdisc *sch, u32 cl=
assid,
 			err =3D gen_new_estimator(&cl->bstats, NULL,
 						&cl->rate_est,
 						NULL,
-						qdisc_root_sleeping_running(sch),
+						true,
 						tca[TCA_RATE] ? : &est.nla);
 			if (err)
 				goto err_block_put;
@@ -1991,7 +1990,7 @@ static int htb_change_class(struct Qdisc *sch, u32 cl=
assid,
 			err =3D gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err)
 				return err;
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index cedd0b3ef9cfb..83d2e54bf303a 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -144,8 +144,8 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *s=
kb)
 		qdisc =3D netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
 		spin_lock_bh(qdisc_lock(qdisc));
=20
-		gnet_stats_add_basic(NULL, &sch->bstats, qdisc->cpu_bstats,
-				     &qdisc->bstats);
+		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, false);
 		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
 		sch->q.qlen +=3D qdisc_qlen(qdisc);
@@ -231,8 +231,7 @@ static int mq_dump_class_stats(struct Qdisc *sch, unsig=
ned long cl,
 	struct netdev_queue *dev_queue =3D mq_queue_get(sch, cl);
=20
 	sch =3D dev_queue->qdisc_sleeping;
-	if (gnet_stats_copy_basic(&sch->running, d, sch->cpu_bstats,
-				  &sch->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, sch->cpu_bstats, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
 	return 0;
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 3f7f756f92ca3..b29f3453c6eaf 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -402,8 +402,8 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buf=
f *skb)
 		qdisc =3D netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
 		spin_lock_bh(qdisc_lock(qdisc));
=20
-		gnet_stats_add_basic(NULL, &sch->bstats, qdisc->cpu_bstats,
-				     &qdisc->bstats);
+		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, false);
 		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
 		sch->q.qlen +=3D qdisc_qlen(qdisc);
@@ -519,8 +519,8 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, u=
nsigned long cl,
=20
 			spin_lock_bh(qdisc_lock(qdisc));
=20
-			gnet_stats_add_basic(NULL, &bstats, qdisc->cpu_bstats,
-					     &qdisc->bstats);
+			gnet_stats_add_basic(&bstats, qdisc->cpu_bstats,
+					     &qdisc->bstats, false);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
 			sch->q.qlen +=3D qdisc_qlen(qdisc);
@@ -532,15 +532,15 @@ static int mqprio_dump_class_stats(struct Qdisc *sch,=
 unsigned long cl,
 		/* Reclaim root sleeping lock before completing stats */
 		if (d->lock)
 			spin_lock_bh(d->lock);
-		if (gnet_stats_copy_basic(NULL, d, NULL, &bstats) < 0 ||
+		if (gnet_stats_copy_basic(d, NULL, &bstats, false) < 0 ||
 		    gnet_stats_copy_queue(d, NULL, &qstats, qlen) < 0)
 			return -1;
 	} else {
 		struct netdev_queue *dev_queue =3D mqprio_queue_get(sch, cl);
=20
 		sch =3D dev_queue->qdisc_sleeping;
-		if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch), d,
-					  sch->cpu_bstats, &sch->bstats) < 0 ||
+		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
+					  &sch->bstats, true) < 0 ||
 		    qdisc_qstats_copy(d, sch) < 0)
 			return -1;
 	}
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index e282e7382117a..cd8ab90c4765d 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -338,8 +338,7 @@ static int multiq_dump_class_stats(struct Qdisc *sch, u=
nsigned long cl,
 	struct Qdisc *cl_q;
=20
 	cl_q =3D q->queues[cl - 1];
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, cl_q->cpu_bstats, &cl_q->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, cl_q) < 0)
 		return -1;
=20
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 03fdf31ccb6af..3b8d7197c06bf 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -361,8 +361,8 @@ static int prio_dump_class_stats(struct Qdisc *sch, uns=
igned long cl,
 	struct Qdisc *cl_q;
=20
 	cl_q =3D q->queues[cl - 1];
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, cl_q->cpu_bstats,
+				  &cl_q->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, cl_q) < 0)
 		return -1;
=20
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index a35200f591a2d..0b7f9ba28deb0 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -451,7 +451,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 clas=
sid, u32 parentid,
 			err =3D gen_replace_estimator(&cl->bstats, NULL,
 						    &cl->rate_est,
 						    NULL,
-						    qdisc_root_sleeping_running(sch),
+						    true,
 						    tca[TCA_RATE]);
 			if (err)
 				return err;
@@ -478,7 +478,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 clas=
sid, u32 parentid,
 		err =3D gen_new_estimator(&cl->bstats, NULL,
 					&cl->rate_est,
 					NULL,
-					qdisc_root_sleeping_running(sch),
+					true,
 					tca[TCA_RATE]);
 		if (err)
 			goto destroy_class;
@@ -640,8 +640,7 @@ static int qfq_dump_class_stats(struct Qdisc *sch, unsi=
gned long arg,
 	xstats.weight =3D cl->agg->class_weight;
 	xstats.lmax =3D cl->agg->lmax;
=20
-	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
-				  d, NULL, &cl->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
 	    qdisc_qstats_copy(d, cl->qdisc) < 0)
 		return -1;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index b9fd18d986464..9ab068fa2672b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1977,7 +1977,7 @@ static int taprio_dump_class_stats(struct Qdisc *sch,=
 unsigned long cl,
 	struct netdev_queue *dev_queue =3D taprio_queue_get(sch, cl);
=20
 	sch =3D dev_queue->qdisc_sleeping;
-	if (gnet_stats_copy_basic(&sch->running, d, NULL, &sch->bstats) < 0 ||
+	if (gnet_stats_copy_basic(d, NULL, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
 	return 0;
--=20
2.33.0

