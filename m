Return-Path: <netfilter-devel+bounces-6023-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC79A37468
	for <lists+netfilter-devel@lfdr.de>; Sun, 16 Feb 2025 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D013AFCCD
	for <lists+netfilter-devel@lfdr.de>; Sun, 16 Feb 2025 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFB197A7A;
	Sun, 16 Feb 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KYcsgBhS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWLMmVQr"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02257197A67
	for <netfilter-devel@vger.kernel.org>; Sun, 16 Feb 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710768; cv=none; b=WaLBvEKVH9swRe4vGxFEP2j8+ZGRUOFiKbHwu+tBxdSIMJ2AZrWN8Rq6CmLj319BjMOU8/x/TEuoONzkAMjozL08xQ/Kr1Cmw2T+lZEey22bDBoc6NXPkN4qdjbeIBcNIH9peG/MJG6f8P79REgBpmaqwROFLrQ8wA46DXnIZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710768; c=relaxed/simple;
	bh=thCb4GEN7ociup/FSD6Ka7gobGnuFiYk6GGgKi+7BIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWRp9CNs/imIqaUmz8Z+sAdP12PqHC3I24Bxqwugv5dFYMHDogtH/idArk2WbjtLTf50rAuROLU1Ja7RPRjY87CzBrCEoSyQ973iBBFgHq8fBUCUpZPgmEjvEKstk3Ol5yKoM9GVjxhQy6XWM0U+cufwwnbd+mKO+m67+4SXecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KYcsgBhS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWLMmVQr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739710302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKaZnR07XoQPY5vketSAVHit4PEfWw2yK9/rBe2OLpg=;
	b=KYcsgBhSwAED6MAipZAnUjOWAnb+5j4o8oSNI/I55q+xG0gfQhn/yBT6eQ3eWND1WJKay1
	z9tQ9OPfzvOw9cxJd/y9nH9pV8DkVZ1EYVhm+QFj8sedEGEbtCe1OoqrlA4kfFmfV1yPsP
	pn++fw78HKb1KEX+tax3lNQ9Vu0SXb4fVlLM6suzng02tbm7mElZgaRl21N467o/hrkMMw
	o8xRRg2FGBzoXOHO9XdwAomUSQmZ0/w2tV6wIiYHjDOrjR56VjwqwI4YxQiLxe9FG2uKbD
	pBpSFgKkHiQMpZDaQNElPGqQfRdSM+RvKmcS/P2+8ws2Wh0/vE2rV7ENfaGlvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739710302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HKaZnR07XoQPY5vketSAVHit4PEfWw2yK9/rBe2OLpg=;
	b=sWLMmVQrNbzy4Ch5QvhTKsV3iC/XJPrCk5iY/HXwp75Xkbcy3N1P6hDL0FgaCrjR8D03Rp
	elexCDLDfXGq0EAw==
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-rt-devel@lists.linux.dev
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 3/3] netfilter: Use u64_stats for counters in xt_counters_k.
Date: Sun, 16 Feb 2025 13:51:35 +0100
Message-ID: <20250216125135.3037967-4-bigeasy@linutronix.de>
In-Reply-To: <20250216125135.3037967-1-bigeasy@linutronix.de>
References: <20250216125135.3037967-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using u64_stats for statistics has the advantage that the seqcount_t
synchronisation can be reduced to 32bit architectures only. On 64bit
architectures the update can happen lockless given there is only one
writter.

The critical section (xt_write_recseq_begin() - xt_write_recseq_end())
can be reduced to just the update of the value since the reader and its
xt_table_info::private access is RCU protected.

Use u64_stats_t in xt_counters_k for statistics. Add xt_counter_add() as
a helper to update counters within the critical section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netfilter/x_tables.h | 71 ++++++------------------------
 net/ipv4/netfilter/arp_tables.c    | 23 ++++------
 net/ipv4/netfilter/ip_tables.c     | 23 ++++------
 net/ipv6/netfilter/ip6_tables.c    | 23 ++++------
 net/netfilter/x_tables.c           |  6 +--
 5 files changed, 43 insertions(+), 103 deletions(-)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x=
_tables.h
index fc52a2ba90f6b..df429d0198c92 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -269,10 +269,21 @@ struct xt_table_info {
=20
 struct xt_counters_k {
 	/* Packet and byte counter */
-	__u64 pcnt;
-	__u64 bcnt;
+	u64_stats_t pcnt;
+	u64_stats_t bcnt;
 };
=20
+DECLARE_PER_CPU(struct u64_stats_sync, xt_syncp);
+
+static inline void xt_counter_add(struct xt_counters_k *xt_counter,
+				  unsigned int bytes, unsigned int packets)
+{
+	u64_stats_update_begin(this_cpu_ptr(&xt_syncp));
+	u64_stats_add(&xt_counter->pcnt, packets);
+	u64_stats_add(&xt_counter->bcnt, bytes);
+	u64_stats_update_end(this_cpu_ptr(&xt_syncp));
+}
+
 union xt_counter_k {
 	struct xt_counters_k __percpu *pcpu;
 	struct xt_counters_k local;
@@ -346,16 +357,6 @@ void xt_proto_fini(struct net *net, u_int8_t af);
 struct xt_table_info *xt_alloc_table_info(unsigned int size);
 void xt_free_table_info(struct xt_table_info *info);
=20
-/**
- * xt_recseq - recursive seqcount for netfilter use
- *
- * Packet processing changes the seqcount only if no recursion happened
- * get_counters() can use read_seqcount_begin()/read_seqcount_retry(),
- * because we use the normal seqcount convention :
- * Low order bit set to 1 if a writer is active.
- */
-DECLARE_PER_CPU(seqcount_t, xt_recseq);
-
 bool xt_af_lock_held(u_int8_t af);
 static inline struct xt_table_info *nf_table_private(const struct xt_table=
 *table)
 {
@@ -368,52 +369,6 @@ static inline struct xt_table_info *nf_table_private(c=
onst struct xt_table *tabl
  */
 extern struct static_key xt_tee_enabled;
=20
-/**
- * xt_write_recseq_begin - start of a write section
- *
- * Begin packet processing : all readers must wait the end
- * 1) Must be called with preemption disabled
- * 2) softirqs must be disabled too (or we should use this_cpu_add())
- * Returns:
- *  1 if no recursion on this cpu
- *  0 if recursion detected
- */
-static inline unsigned int xt_write_recseq_begin(void)
-{
-	unsigned int addend;
-
-	/*
-	 * Low order bit of sequence is set if we already
-	 * called xt_write_recseq_begin().
-	 */
-	addend =3D (__this_cpu_read(xt_recseq.sequence) + 1) & 1;
-
-	/*
-	 * This is kind of a write_seqcount_begin(), but addend is 0 or 1
-	 * We dont check addend value to avoid a test and conditional jump,
-	 * since addend is most likely 1
-	 */
-	__this_cpu_add(xt_recseq.sequence, addend);
-	smp_mb();
-
-	return addend;
-}
-
-/**
- * xt_write_recseq_end - end of a write section
- * @addend: return value from previous xt_write_recseq_begin()
- *
- * End packet processing : all readers can proceed
- * 1) Must be called with preemption disabled
- * 2) softirqs must be disabled too (or we should use this_cpu_add())
- */
-static inline void xt_write_recseq_end(unsigned int addend)
-{
-	/* this is kind of a write_seqcount_end(), but addend is 0 or 1 */
-	smp_wmb();
-	__this_cpu_add(xt_recseq.sequence, addend);
-}
-
 /*
  * This helper is performance critical and must be inlined
  */
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_table=
s.c
index ce3d73155ca9b..6b957de58d2cf 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -194,7 +194,6 @@ unsigned int arpt_do_table(void *priv,
 	unsigned int cpu, stackidx =3D 0;
 	const struct xt_table_info *private;
 	struct xt_action_param acpar;
-	unsigned int addend;
=20
 	if (!pskb_may_pull(skb, arp_hdr_len(skb->dev)))
 		return NF_DROP;
@@ -204,7 +203,6 @@ unsigned int arpt_do_table(void *priv,
=20
 	local_bh_disable();
 	rcu_read_lock();
-	addend =3D xt_write_recseq_begin();
 	private =3D rcu_dereference(table->priv_info);
 	cpu     =3D smp_processor_id();
 	table_base =3D private->entries;
@@ -229,7 +227,7 @@ unsigned int arpt_do_table(void *priv,
 		}
=20
 		counter =3D xt_get_this_cpu_counter(&e->counter_pad);
-		ADD_COUNTER(*counter, arp_hdr_len(skb->dev), 1);
+		xt_counter_add(counter, arp_hdr_len(skb->dev), 1);
=20
 		t =3D arpt_get_target_c(e);
=20
@@ -279,7 +277,6 @@ unsigned int arpt_do_table(void *priv,
 			break;
 		}
 	} while (!acpar.hotdrop);
-	xt_write_recseq_end(addend);
 	rcu_read_unlock();
 	local_bh_enable();
=20
@@ -607,7 +604,7 @@ static void get_counters(const struct xt_table_info *t,
 	unsigned int i;
=20
 	for_each_possible_cpu(cpu) {
-		seqcount_t *s =3D &per_cpu(xt_recseq, cpu);
+		struct u64_stats_sync *syncp =3D &per_cpu(xt_syncp, cpu);
=20
 		i =3D 0;
 		xt_entry_foreach(iter, t->entries, t->size) {
@@ -617,10 +614,10 @@ static void get_counters(const struct xt_table_info *=
t,
=20
 			tmp =3D xt_get_per_cpu_counter(&iter->counter_pad, cpu);
 			do {
-				start =3D read_seqcount_begin(s);
-				bcnt =3D tmp->bcnt;
-				pcnt =3D tmp->pcnt;
-			} while (read_seqcount_retry(s, start));
+				start =3D u64_stats_fetch_begin(syncp);
+				bcnt =3D u64_stats_read(&tmp->bcnt);
+				pcnt =3D u64_stats_read(&tmp->pcnt);
+			} while (u64_stats_fetch_retry(syncp, start));
=20
 			ADD_COUNTER(counters[i], bcnt, pcnt);
 			++i;
@@ -641,7 +638,8 @@ static void get_old_counters(const struct xt_table_info=
 *t,
 			struct xt_counters_k *tmp;
=20
 			tmp =3D xt_get_per_cpu_counter(&iter->counter_pad, cpu);
-			ADD_COUNTER(counters[i], tmp->bcnt, tmp->pcnt);
+			ADD_COUNTER(counters[i], u64_stats_read(&tmp->bcnt),
+				    u64_stats_read(&tmp->pcnt));
 			++i;
 		}
 		cond_resched();
@@ -1011,7 +1009,6 @@ static int do_add_counters(struct net *net, sockptr_t=
 arg, unsigned int len)
 	const struct xt_table_info *private;
 	int ret =3D 0;
 	struct arpt_entry *iter;
-	unsigned int addend;
=20
 	paddc =3D xt_copy_counters(arg, len, &tmp);
 	if (IS_ERR(paddc))
@@ -1033,15 +1030,13 @@ static int do_add_counters(struct net *net, sockptr=
_t arg, unsigned int len)
=20
 	i =3D 0;
=20
-	addend =3D xt_write_recseq_begin();
 	xt_entry_foreach(iter,  private->entries, private->size) {
 		struct xt_counters_k *tmp;
=20
 		tmp =3D xt_get_this_cpu_counter(&iter->counter_pad);
-		ADD_COUNTER(*tmp, paddc[i].bcnt, paddc[i].pcnt);
+		xt_counter_add(tmp, paddc[i].bcnt, paddc[i].pcnt);
 		++i;
 	}
-	xt_write_recseq_end(addend);
  unlock_up_free:
 	rcu_read_unlock();
 	local_bh_enable();
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 95f917f5bceef..c5c90e2f724ba 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -236,7 +236,6 @@ ipt_do_table(void *priv,
 	unsigned int stackidx, cpu;
 	const struct xt_table_info *private;
 	struct xt_action_param acpar;
-	unsigned int addend;
=20
 	/* Initialization */
 	stackidx =3D 0;
@@ -258,7 +257,6 @@ ipt_do_table(void *priv,
 	local_bh_disable();
 	rcu_read_lock();
 	private =3D rcu_dereference(table->priv_info);
-	addend =3D xt_write_recseq_begin();
 	cpu        =3D smp_processor_id();
 	table_base =3D private->entries;
 	jumpstack  =3D (struct ipt_entry **)private->jumpstack[cpu];
@@ -296,7 +294,7 @@ ipt_do_table(void *priv,
 		}
=20
 		counter =3D xt_get_this_cpu_counter(&e->counter_pad);
-		ADD_COUNTER(*counter, skb->len, 1);
+		xt_counter_add(counter, skb->len, 1);
=20
 		t =3D ipt_get_target_c(e);
 		WARN_ON(!t->u.kernel.target);
@@ -354,7 +352,6 @@ ipt_do_table(void *priv,
 		}
 	} while (!acpar.hotdrop);
=20
-	xt_write_recseq_end(addend);
 	rcu_read_unlock();
 	local_bh_enable();
=20
@@ -746,7 +743,7 @@ get_counters(const struct xt_table_info *t,
 	unsigned int i;
=20
 	for_each_possible_cpu(cpu) {
-		seqcount_t *s =3D &per_cpu(xt_recseq, cpu);
+		struct u64_stats_sync *syncp =3D &per_cpu(xt_syncp, cpu);
=20
 		i =3D 0;
 		xt_entry_foreach(iter, t->entries, t->size) {
@@ -756,10 +753,10 @@ get_counters(const struct xt_table_info *t,
=20
 			tmp =3D xt_get_per_cpu_counter(&iter->counter_pad, cpu);
 			do {
-				start =3D read_seqcount_begin(s);
-				bcnt =3D tmp->bcnt;
-				pcnt =3D tmp->pcnt;
-			} while (read_seqcount_retry(s, start));
+				start =3D u64_stats_fetch_begin(syncp);
+				bcnt =3D u64_stats_read(&tmp->bcnt);
+				pcnt =3D u64_stats_read(&tmp->pcnt);
+			} while (u64_stats_fetch_retry(syncp, start));
=20
 			ADD_COUNTER(counters[i], bcnt, pcnt);
 			++i; /* macro does multi eval of i */
@@ -780,7 +777,8 @@ static void get_old_counters(const struct xt_table_info=
 *t,
 			const struct xt_counters_k *tmp;
=20
 			tmp =3D xt_get_per_cpu_counter(&iter->counter_pad, cpu);
-			ADD_COUNTER(counters[i], tmp->bcnt, tmp->pcnt);
+			ADD_COUNTER(counters[i], u64_stats_read(&tmp->bcnt),
+				    u64_stats_read(&tmp->pcnt));
 			++i; /* macro does multi eval of i */
 		}
=20
@@ -1164,7 +1162,6 @@ do_add_counters(struct net *net, sockptr_t arg, unsig=
ned int len)
 	const struct xt_table_info *private;
 	int ret =3D 0;
 	struct ipt_entry *iter;
-	unsigned int addend;
=20
 	paddc =3D xt_copy_counters(arg, len, &tmp);
 	if (IS_ERR(paddc))
@@ -1185,15 +1182,13 @@ do_add_counters(struct net *net, sockptr_t arg, uns=
igned int len)
 	}
=20
 	i =3D 0;
-	addend =3D xt_write_recseq_begin();
 	xt_entry_foreach(iter, private->entries, private->size) {
 		struct xt_counters_k *tmp;
=20
 		tmp =3D xt_get_this_cpu_counter(&iter->counter_pad);
-		ADD_COUNTER(*tmp, paddc[i].bcnt, paddc[i].pcnt);
+		xt_counter_add(tmp, paddc[i].bcnt, paddc[i].pcnt);
 		++i;
 	}
-	xt_write_recseq_end(addend);
  unlock_up_free:
 	rcu_read_unlock();
 	local_bh_enable();
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_table=
s.c
index f4877b1b2463e..5a6a592cd53dc 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -259,7 +259,6 @@ ip6t_do_table(void *priv, struct sk_buff *skb,
 	unsigned int stackidx, cpu;
 	const struct xt_table_info *private;
 	struct xt_action_param acpar;
-	unsigned int addend;
=20
 	/* Initialization */
 	stackidx =3D 0;
@@ -280,7 +279,6 @@ ip6t_do_table(void *priv, struct sk_buff *skb,
 	local_bh_disable();
 	rcu_read_lock();
 	private =3D rcu_dereference(table->priv_info);
-	addend =3D xt_write_recseq_begin();
 	cpu        =3D smp_processor_id();
 	table_base =3D private->entries;
 	jumpstack  =3D (struct ip6t_entry **)private->jumpstack[cpu];
@@ -319,7 +317,7 @@ ip6t_do_table(void *priv, struct sk_buff *skb,
 		}
=20
 		counter =3D xt_get_this_cpu_counter(&e->counter_pad);
-		ADD_COUNTER(*counter, skb->len, 1);
+		xt_counter_add(counter, skb->len, 1);
=20
 		t =3D ip6t_get_target_c(e);
 		WARN_ON(!t->u.kernel.target);
@@ -372,7 +370,6 @@ ip6t_do_table(void *priv, struct sk_buff *skb,
 			break;
 	} while (!acpar.hotdrop);
=20
-	xt_write_recseq_end(addend);
 	rcu_read_unlock();
 	local_bh_enable();
=20
@@ -763,7 +760,7 @@ get_counters(const struct xt_table_info *t,
 	unsigned int i;
=20
 	for_each_possible_cpu(cpu) {
-		seqcount_t *s =3D &per_cpu(xt_recseq, cpu);
+		struct u64_stats_sync *syncp =3D &per_cpu(xt_syncp, cpu);
=20
 		i =3D 0;
 		xt_entry_foreach(iter, t->entries, t->size) {
@@ -773,10 +770,10 @@ get_counters(const struct xt_table_info *t,
=20
 			tmp =3D xt_get_per_cpu_counter(&iter->counter_pad, cpu);
 			do {
-				start =3D read_seqcount_begin(s);
-				bcnt =3D tmp->bcnt;
-				pcnt =3D tmp->pcnt;
-			} while (read_seqcount_retry(s, start));
+				start =3D u64_stats_fetch_begin(syncp);
+				bcnt =3D u64_stats_read(&tmp->bcnt);
+				pcnt =3D u64_stats_read(&tmp->pcnt);
+			} while (u64_stats_fetch_retry(syncp, start));
=20
 			ADD_COUNTER(counters[i], bcnt, pcnt);
 			++i;
@@ -797,7 +794,8 @@ static void get_old_counters(const struct xt_table_info=
 *t,
 			const struct xt_counters_k *tmp;
=20
 			tmp =3D xt_get_per_cpu_counter(&iter->counter_pad, cpu);
-			ADD_COUNTER(counters[i], tmp->bcnt, tmp->pcnt);
+			ADD_COUNTER(counters[i], u64_stats_read(&tmp->bcnt),
+				    u64_stats_read(&tmp->pcnt));
 			++i;
 		}
 		cond_resched();
@@ -1181,7 +1179,6 @@ do_add_counters(struct net *net, sockptr_t arg, unsig=
ned int len)
 	const struct xt_table_info *private;
 	int ret =3D 0;
 	struct ip6t_entry *iter;
-	unsigned int addend;
=20
 	paddc =3D xt_copy_counters(arg, len, &tmp);
 	if (IS_ERR(paddc))
@@ -1201,15 +1198,13 @@ do_add_counters(struct net *net, sockptr_t arg, uns=
igned int len)
 	}
=20
 	i =3D 0;
-	addend =3D xt_write_recseq_begin();
 	xt_entry_foreach(iter, private->entries, private->size) {
 		struct xt_counters_k *tmp;
=20
 		tmp =3D xt_get_this_cpu_counter(&iter->counter_pad);
-		ADD_COUNTER(*tmp, paddc[i].bcnt, paddc[i].pcnt);
+		xt_counter_add(tmp, paddc[i].bcnt, paddc[i].pcnt);
 		++i;
 	}
-	xt_write_recseq_end(addend);
  unlock_up_free:
 	rcu_read_unlock();
 	local_bh_enable();
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index e3f48539f81d6..d9a31ee920fc0 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1330,8 +1330,8 @@ void xt_compat_unlock(u_int8_t af)
 EXPORT_SYMBOL_GPL(xt_compat_unlock);
 #endif
=20
-DEFINE_PER_CPU(seqcount_t, xt_recseq);
-EXPORT_PER_CPU_SYMBOL_GPL(xt_recseq);
+DEFINE_PER_CPU(struct u64_stats_sync, xt_syncp);
+EXPORT_PER_CPU_SYMBOL_GPL(xt_syncp);
=20
 struct static_key xt_tee_enabled __read_mostly;
 EXPORT_SYMBOL_GPL(xt_tee_enabled);
@@ -1977,7 +1977,7 @@ static int __init xt_init(void)
 	int rv;
=20
 	for_each_possible_cpu(i) {
-		seqcount_init(&per_cpu(xt_recseq, i));
+		u64_stats_init(&per_cpu(xt_syncp, i));
 	}
=20
 	xt =3D kcalloc(NFPROTO_NUMPROTO, sizeof(struct xt_af), GFP_KERNEL);
--=20
2.47.2


