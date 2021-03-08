Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FD330597
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 02:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhCHBZM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Mar 2021 20:25:12 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45545 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhCHBYk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Mar 2021 20:24:40 -0500
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D5D06891AF;
        Mon,  8 Mar 2021 14:24:34 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1615166674;
        bh=h5zjiaPi53htwfieg4zJHY8IMyXSCI5OhfPmaJ6RZdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AapleeujZQy8kyVloduDQXnOEN5g2SZLkHp27teYWxJkc0l6h+VvkbwF1+0OcTZR5
         ggQsaCH21fGOUsgvQBfgTctrtKXj/lGiiyvZyM7jIAnzAeFLtqfVVfYztEedrzBBBv
         IeUJCbGp+NBeYyS5IlgSFIYalk35HmHl2fjYBZYsq5prlVnWUgbAv+lrYlcIP7canc
         03JlVyvf7NK5ANvfNvXurva5MbhfB52JYCfd8Enbnm6RfTbhRYRYbrJ7vrmK1aLYYN
         QxmkBQ3wK4BxL3V3tUChZsmR0suDiQBlIuGdeAHZPGVDDBLzC2p6S77RZ2sTwjkD/J
         MSpFkQ1BEVhXA==
Received: from smtp (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60457cd20002>; Mon, 08 Mar 2021 14:24:34 +1300
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 91E9B13EF9C;
        Mon,  8 Mar 2021 14:24:46 +1300 (NZDT)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 9C186340FAE; Mon,  8 Mar 2021 14:24:34 +1300 (NZDT)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc:     subashab@codeaurora.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH v2 2/3] Revert "netfilter: x_tables: Switch synchronization to RCU"
Date:   Mon,  8 Mar 2021 14:24:12 +1300
Message-Id: <20210308012413.14383-3-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308012413.14383-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20210308012413.14383-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7uXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=dESyimp9J3IA:10 a=xwK3dqCpR-QJmR0bAu4A:9 a=ac-FA1p4njwWedJd:21 a=emDAxxbydI8RoRrh:21
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts commit cc00bcaa589914096edef7fb87ca5cee4a166b5c.

This (and the preceding) patch basically re-implemented the RCU
mechanisms of patch 784544739a25. That patch was replaced because of the
performance problems that it created when replacing tables. Now, we have
the same issue: the call to synchronize_rcu() makes replacing tables
slower by as much as an order of magnitude.

Prior to using RCU a script calling "iptables" approx. 200 times was
taking 1.16s. With RCU this increased to 11.59s.

Revert these patches and fix the issue in a different way.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 include/linux/netfilter/x_tables.h |  5 +--
 net/ipv4/netfilter/arp_tables.c    | 14 ++++-----
 net/ipv4/netfilter/ip_tables.c     | 14 ++++-----
 net/ipv6/netfilter/ip6_tables.c    | 14 ++++-----
 net/netfilter/x_tables.c           | 49 +++++++++++++++++++++---------
 5 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter=
/x_tables.h
index 8ebb64193757..5deb099d156d 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -227,7 +227,7 @@ struct xt_table {
 	unsigned int valid_hooks;
=20
 	/* Man behind the curtain... */
-	struct xt_table_info __rcu *private;
+	struct xt_table_info *private;
=20
 	/* Set this to THIS_MODULE if you are a module, otherwise NULL */
 	struct module *me;
@@ -448,9 +448,6 @@ xt_get_per_cpu_counter(struct xt_counters *cnt, unsig=
ned int cpu)
=20
 struct nf_hook_ops *xt_hook_ops_alloc(const struct xt_table *, nf_hookfn=
 *);
=20
-struct xt_table_info
-*xt_table_get_private_protected(const struct xt_table *table);
-
 #ifdef CONFIG_COMPAT
 #include <net/compat.h>
=20
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tab=
les.c
index 563b62b76a5f..d1e04d2b5170 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -203,7 +203,7 @@ unsigned int arpt_do_table(struct sk_buff *skb,
=20
 	local_bh_disable();
 	addend =3D xt_write_recseq_begin();
-	private =3D rcu_access_pointer(table->private);
+	private =3D READ_ONCE(table->private); /* Address dependency. */
 	cpu     =3D smp_processor_id();
 	table_base =3D private->entries;
 	jumpstack  =3D (struct arpt_entry **)private->jumpstack[cpu];
@@ -649,7 +649,7 @@ static struct xt_counters *alloc_counters(const struc=
t xt_table *table)
 {
 	unsigned int countersize;
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
=20
 	/* We need atomic snapshot of counters: rest doesn't change
 	 * (other than comefrom, which userspace doesn't care
@@ -673,7 +673,7 @@ static int copy_entries_to_user(unsigned int total_si=
ze,
 	unsigned int off, num;
 	const struct arpt_entry *e;
 	struct xt_counters *counters;
-	struct xt_table_info *private =3D xt_table_get_private_protected(table)=
;
+	struct xt_table_info *private =3D table->private;
 	int ret =3D 0;
 	void *loc_cpu_entry;
=20
@@ -807,7 +807,7 @@ static int get_info(struct net *net, void __user *use=
r, const int *len)
 	t =3D xt_request_find_table_lock(net, NFPROTO_ARP, name);
 	if (!IS_ERR(t)) {
 		struct arpt_getinfo info;
-		const struct xt_table_info *private =3D xt_table_get_private_protected=
(t);
+		const struct xt_table_info *private =3D t->private;
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
=20
@@ -860,7 +860,7 @@ static int get_entries(struct net *net, struct arpt_g=
et_entries __user *uptr,
=20
 	t =3D xt_find_table_lock(net, NFPROTO_ARP, get.name);
 	if (!IS_ERR(t)) {
-		const struct xt_table_info *private =3D xt_table_get_private_protected=
(t);
+		const struct xt_table_info *private =3D t->private;
=20
 		if (get.size =3D=3D private->size)
 			ret =3D copy_entries_to_user(private->size,
@@ -1017,7 +1017,7 @@ static int do_add_counters(struct net *net, sockptr=
_t arg, unsigned int len)
 	}
=20
 	local_bh_disable();
-	private =3D xt_table_get_private_protected(t);
+	private =3D t->private;
 	if (private->number !=3D tmp.num_counters) {
 		ret =3D -EINVAL;
 		goto unlock_up_free;
@@ -1330,7 +1330,7 @@ static int compat_copy_entries_to_user(unsigned int=
 total_size,
 				       void __user *userptr)
 {
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
 	void __user *pos;
 	unsigned int size;
 	int ret =3D 0;
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_table=
s.c
index 6e2851f8d3a3..f15bc21d7301 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -258,7 +258,7 @@ ipt_do_table(struct sk_buff *skb,
 	WARN_ON(!(table->valid_hooks & (1 << hook)));
 	local_bh_disable();
 	addend =3D xt_write_recseq_begin();
-	private =3D rcu_access_pointer(table->private);
+	private =3D READ_ONCE(table->private); /* Address dependency. */
 	cpu        =3D smp_processor_id();
 	table_base =3D private->entries;
 	jumpstack  =3D (struct ipt_entry **)private->jumpstack[cpu];
@@ -791,7 +791,7 @@ static struct xt_counters *alloc_counters(const struc=
t xt_table *table)
 {
 	unsigned int countersize;
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
=20
 	/* We need atomic snapshot of counters: rest doesn't change
 	   (other than comefrom, which userspace doesn't care
@@ -815,7 +815,7 @@ copy_entries_to_user(unsigned int total_size,
 	unsigned int off, num;
 	const struct ipt_entry *e;
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
 	int ret =3D 0;
 	const void *loc_cpu_entry;
=20
@@ -964,7 +964,7 @@ static int get_info(struct net *net, void __user *use=
r, const int *len)
 	t =3D xt_request_find_table_lock(net, AF_INET, name);
 	if (!IS_ERR(t)) {
 		struct ipt_getinfo info;
-		const struct xt_table_info *private =3D xt_table_get_private_protected=
(t);
+		const struct xt_table_info *private =3D t->private;
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
=20
@@ -1018,7 +1018,7 @@ get_entries(struct net *net, struct ipt_get_entries=
 __user *uptr,
=20
 	t =3D xt_find_table_lock(net, AF_INET, get.name);
 	if (!IS_ERR(t)) {
-		const struct xt_table_info *private =3D xt_table_get_private_protected=
(t);
+		const struct xt_table_info *private =3D t->private;
 		if (get.size =3D=3D private->size)
 			ret =3D copy_entries_to_user(private->size,
 						   t, uptr->entrytable);
@@ -1173,7 +1173,7 @@ do_add_counters(struct net *net, sockptr_t arg, uns=
igned int len)
 	}
=20
 	local_bh_disable();
-	private =3D xt_table_get_private_protected(t);
+	private =3D t->private;
 	if (private->number !=3D tmp.num_counters) {
 		ret =3D -EINVAL;
 		goto unlock_up_free;
@@ -1543,7 +1543,7 @@ compat_copy_entries_to_user(unsigned int total_size=
, struct xt_table *table,
 			    void __user *userptr)
 {
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
 	void __user *pos;
 	unsigned int size;
 	int ret =3D 0;
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tab=
les.c
index c4f532f4d311..2e2119bfcf13 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -280,7 +280,7 @@ ip6t_do_table(struct sk_buff *skb,
=20
 	local_bh_disable();
 	addend =3D xt_write_recseq_begin();
-	private =3D rcu_access_pointer(table->private);
+	private =3D READ_ONCE(table->private); /* Address dependency. */
 	cpu        =3D smp_processor_id();
 	table_base =3D private->entries;
 	jumpstack  =3D (struct ip6t_entry **)private->jumpstack[cpu];
@@ -807,7 +807,7 @@ static struct xt_counters *alloc_counters(const struc=
t xt_table *table)
 {
 	unsigned int countersize;
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
=20
 	/* We need atomic snapshot of counters: rest doesn't change
 	   (other than comefrom, which userspace doesn't care
@@ -831,7 +831,7 @@ copy_entries_to_user(unsigned int total_size,
 	unsigned int off, num;
 	const struct ip6t_entry *e;
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
 	int ret =3D 0;
 	const void *loc_cpu_entry;
=20
@@ -980,7 +980,7 @@ static int get_info(struct net *net, void __user *use=
r, const int *len)
 	t =3D xt_request_find_table_lock(net, AF_INET6, name);
 	if (!IS_ERR(t)) {
 		struct ip6t_getinfo info;
-		const struct xt_table_info *private =3D xt_table_get_private_protected=
(t);
+		const struct xt_table_info *private =3D t->private;
 #ifdef CONFIG_COMPAT
 		struct xt_table_info tmp;
=20
@@ -1035,7 +1035,7 @@ get_entries(struct net *net, struct ip6t_get_entrie=
s __user *uptr,
=20
 	t =3D xt_find_table_lock(net, AF_INET6, get.name);
 	if (!IS_ERR(t)) {
-		struct xt_table_info *private =3D xt_table_get_private_protected(t);
+		struct xt_table_info *private =3D t->private;
 		if (get.size =3D=3D private->size)
 			ret =3D copy_entries_to_user(private->size,
 						   t, uptr->entrytable);
@@ -1189,7 +1189,7 @@ do_add_counters(struct net *net, sockptr_t arg, uns=
igned int len)
 	}
=20
 	local_bh_disable();
-	private =3D xt_table_get_private_protected(t);
+	private =3D t->private;
 	if (private->number !=3D tmp.num_counters) {
 		ret =3D -EINVAL;
 		goto unlock_up_free;
@@ -1552,7 +1552,7 @@ compat_copy_entries_to_user(unsigned int total_size=
, struct xt_table *table,
 			    void __user *userptr)
 {
 	struct xt_counters *counters;
-	const struct xt_table_info *private =3D xt_table_get_private_protected(=
table);
+	const struct xt_table_info *private =3D table->private;
 	void __user *pos;
 	unsigned int size;
 	int ret =3D 0;
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index acce622582e3..af22dbe85e2c 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1349,14 +1349,6 @@ struct xt_counters *xt_counters_alloc(unsigned int=
 counters)
 }
 EXPORT_SYMBOL(xt_counters_alloc);
=20
-struct xt_table_info
-*xt_table_get_private_protected(const struct xt_table *table)
-{
-	return rcu_dereference_protected(table->private,
-					 mutex_is_locked(&xt[table->af].mutex));
-}
-EXPORT_SYMBOL(xt_table_get_private_protected);
-
 struct xt_table_info *
 xt_replace_table(struct xt_table *table,
 	      unsigned int num_counters,
@@ -1364,6 +1356,7 @@ xt_replace_table(struct xt_table *table,
 	      int *error)
 {
 	struct xt_table_info *private;
+	unsigned int cpu;
 	int ret;
=20
 	ret =3D xt_jumpstack_alloc(newinfo);
@@ -1373,20 +1366,47 @@ xt_replace_table(struct xt_table *table,
 	}
=20
 	/* Do the substitution. */
-	private =3D xt_table_get_private_protected(table);
+	local_bh_disable();
+	private =3D table->private;
=20
 	/* Check inside lock: is the old number correct? */
 	if (num_counters !=3D private->number) {
 		pr_debug("num_counters !=3D table->private->number (%u/%u)\n",
 			 num_counters, private->number);
+		local_bh_enable();
 		*error =3D -EAGAIN;
 		return NULL;
 	}
=20
 	newinfo->initial_entries =3D private->initial_entries;
+	/*
+	 * Ensure contents of newinfo are visible before assigning to
+	 * private.
+	 */
+	smp_wmb();
+	table->private =3D newinfo;
+
+	/* make sure all cpus see new ->private value */
+	smp_wmb();
=20
-	rcu_assign_pointer(table->private, newinfo);
-	synchronize_rcu();
+	/*
+	 * Even though table entries have now been swapped, other CPU's
+	 * may still be using the old entries...
+	 */
+	local_bh_enable();
+
+	/* ... so wait for even xt_recseq on all cpus */
+	for_each_possible_cpu(cpu) {
+		seqcount_t *s =3D &per_cpu(xt_recseq, cpu);
+		u32 seq =3D raw_read_seqcount(s);
+
+		if (seq & 1) {
+			do {
+				cond_resched();
+				cpu_relax();
+			} while (seq =3D=3D raw_read_seqcount(s));
+		}
+	}
=20
 	audit_log_nfcfg(table->name, table->af, private->number,
 			!private->number ? AUDIT_XT_OP_REGISTER :
@@ -1422,12 +1442,12 @@ struct xt_table *xt_register_table(struct net *ne=
t,
 	}
=20
 	/* Simplifies replace_table code. */
-	rcu_assign_pointer(table->private, bootstrap);
+	table->private =3D bootstrap;
=20
 	if (!xt_replace_table(table, 0, newinfo, &ret))
 		goto unlock;
=20
-	private =3D xt_table_get_private_protected(table);
+	private =3D table->private;
 	pr_debug("table->private->number =3D %u\n", private->number);
=20
 	/* save number of initial entries */
@@ -1450,8 +1470,7 @@ void *xt_unregister_table(struct xt_table *table)
 	struct xt_table_info *private;
=20
 	mutex_lock(&xt[table->af].mutex);
-	private =3D xt_table_get_private_protected(table);
-	RCU_INIT_POINTER(table->private, NULL);
+	private =3D table->private;
 	list_del(&table->list);
 	mutex_unlock(&xt[table->af].mutex);
 	audit_log_nfcfg(table->name, table->af, private->number,
--=20
2.30.1

