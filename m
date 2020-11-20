Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E582BA213
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Nov 2020 06:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgKTFxV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Nov 2020 00:53:21 -0500
Received: from z5.mailgun.us ([104.130.96.5]:44074 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgKTFxU (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Nov 2020 00:53:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605851599; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vxUipPgmuobw/jWrNXgIDgxFbEkbo3mm4Ldp975VoI8=;
 b=p5d2AU2gV+jKQQa1XdURdLGNRoCpjGXvVLM4e8yN1ZRuhGkxZpKlCJ+vNNQNgFBc1b1liprY
 hdQkKBlj2BLO/jcy67BUN63rdad/+ZvueF2GJLZzlx1Vqf2rjrEgIecT8DTmEw4fNhAgRFrr
 oappwLdIPZ9dsp6H6CsZWdCad94=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJlM2NhZSIsICJuZXRmaWx0ZXItZGV2ZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fb759cb7f0cfa6a164e845b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 05:53:15
 GMT
Sender: subashab=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB13DC433ED; Fri, 20 Nov 2020 05:53:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: subashab)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B49CFC433C6;
        Fri, 20 Nov 2020 05:53:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Nov 2020 22:53:13 -0700
From:   subashab@codeaurora.org
To:     Florian Westphal <fw@strlen.de>
Cc:     Will Deacon <will@kernel.org>, pablo@netfilter.org,
        Sean Tranchetti <stranche@codeaurora.org>,
        netfilter-devel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH nf] x_tables: Properly close read section with
 read_seqcount_retry
In-Reply-To: <20201118211007.GA15137@breakpoint.cc>
References: <20201116141810.GB22792@breakpoint.cc>
 <8256f40ba9b73181f121baafe12cac61@codeaurora.org>
 <20201116170440.GA26150@breakpoint.cc>
 <983d178e6f3aac81d491362ab60db61f@codeaurora.org>
 <20201116182028.GE22792@breakpoint.cc>
 <20201118121322.GA1821@willie-the-truck>
 <20201118124228.GJ22792@breakpoint.cc>
 <20201118125406.GA2029@willie-the-truck>
 <20201118131419.GK22792@breakpoint.cc>
 <7d52f54a7e3ebc794f0b775e793ab142@codeaurora.org>
 <20201118211007.GA15137@breakpoint.cc>
Message-ID: <7d8bc917b7a6790fa789085ba8324b08@codeaurora.org>
X-Sender: subashab@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

> The three _do_table() functions need to use rcu_dereference().
> 
> This looks wrong.  I know its ok, but perhaps its better to add this:
> 
> struct xt_table_info *xt_table_get_private_protected(const struct
> xt_table *table)
> {
>  return rcu_dereference_protected(table->private,
> mutex_is_locked(&xt[table->af].mutex));
> }
> EXPORT_SYMBOL(xt_table_get_private_protected);
> 
> to x_tables.c.
> 
> If you dislike this extra function, add
> 
> #define xt_table_get_private_protected(t) 
> rcu_access_pointer((t)->private)
> 
> in include/linux/netfilter/x_tables.h, with a bit fat comment telling
> that the xt table mutex must be held.
> 
> But I'd rather have/use the helper function as it documents when its
> safe to do this (and there will be splats if misused).
> AFAICS the local_bh_disable/enable calls can be removed too after this,
> if we're interrupted by softirq calling any of the _do_table()
> functions changes to the xt seqcount do not matter anymore.
> 
> 
> We need this additional hunk to switch to rcu for replacement/sync, no?
> 
> -       local_bh_enable();
> -
> -       /* ... so wait for even xt_recseq on all cpus */
> -       for_each_possible_cpu(cpu) {
> -               seqcount_t *s = &per_cpu(xt_recseq, cpu);
> -               u32 seq = raw_read_seqcount(s);
> -
> -               if (seq & 1) {
> -                       do {
> -                               cond_resched();
> -                               cpu_relax();
> -                       } while (seq == raw_read_seqcount(s));
> -               }
> -       }
> +       synchronize_rcu();

I've updated the patch with your comments.
Do you expect a performance impact either in datapath or perhaps more in
the rule installation with the rcu changes.
As a I understand, the change in the barrier types would be sufficient 
to
resolve the race.

diff --git a/include/linux/netfilter/x_tables.h 
b/include/linux/netfilter/x_tables.h
index 5deb099..8ebb641 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -227,7 +227,7 @@ struct xt_table {
  	unsigned int valid_hooks;

  	/* Man behind the curtain... */
-	struct xt_table_info *private;
+	struct xt_table_info __rcu *private;

  	/* Set this to THIS_MODULE if you are a module, otherwise NULL */
  	struct module *me;
@@ -448,6 +448,9 @@ xt_get_per_cpu_counter(struct xt_counters *cnt, 
unsigned int cpu)

  struct nf_hook_ops *xt_hook_ops_alloc(const struct xt_table *, 
nf_hookfn *);

+struct xt_table_info
+*xt_table_get_private_protected(const struct xt_table *table);
+
  #ifdef CONFIG_COMPAT
  #include <net/compat.h>

diff --git a/net/ipv4/netfilter/arp_tables.c 
b/net/ipv4/netfilter/arp_tables.c
index d1e04d2..dda5d8f 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -203,7 +203,7 @@ unsigned int arpt_do_table(struct sk_buff *skb,

  	local_bh_disable();
  	addend = xt_write_recseq_begin();
-	private = READ_ONCE(table->private); /* Address dependency. */
+	private = xt_table_get_private_protected(table);
  	cpu     = smp_processor_id();
  	table_base = private->entries;
  	jumpstack  = (struct arpt_entry **)private->jumpstack[cpu];
@@ -649,7 +649,7 @@ static struct xt_counters *alloc_counters(const 
struct xt_table *table)
  {
  	unsigned int countersize;
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);

  	/* We need atomic snapshot of counters: rest doesn't change
  	 * (other than comefrom, which userspace doesn't care
@@ -673,7 +673,7 @@ static int copy_entries_to_user(unsigned int 
total_size,
  	unsigned int off, num;
  	const struct arpt_entry *e;
  	struct xt_counters *counters;
-	struct xt_table_info *private = table->private;
+	struct xt_table_info *private = xt_table_get_private_protected(table);
  	int ret = 0;
  	void *loc_cpu_entry;

@@ -1330,7 +1330,7 @@ static int compat_copy_entries_to_user(unsigned 
int total_size,
  				       void __user *userptr)
  {
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);
  	void __user *pos;
  	unsigned int size;
  	int ret = 0;
diff --git a/net/ipv4/netfilter/ip_tables.c 
b/net/ipv4/netfilter/ip_tables.c
index f15bc21..5ec422c 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -258,7 +258,7 @@ ipt_do_table(struct sk_buff *skb,
  	WARN_ON(!(table->valid_hooks & (1 << hook)));
  	local_bh_disable();
  	addend = xt_write_recseq_begin();
-	private = READ_ONCE(table->private); /* Address dependency. */
+	private = xt_table_get_private_protected(table);
  	cpu        = smp_processor_id();
  	table_base = private->entries;
  	jumpstack  = (struct ipt_entry **)private->jumpstack[cpu];
@@ -791,7 +791,7 @@ static struct xt_counters *alloc_counters(const 
struct xt_table *table)
  {
  	unsigned int countersize;
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);

  	/* We need atomic snapshot of counters: rest doesn't change
  	   (other than comefrom, which userspace doesn't care
@@ -815,7 +815,7 @@ copy_entries_to_user(unsigned int total_size,
  	unsigned int off, num;
  	const struct ipt_entry *e;
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);
  	int ret = 0;
  	const void *loc_cpu_entry;

@@ -1543,7 +1543,7 @@ compat_copy_entries_to_user(unsigned int 
total_size, struct xt_table *table,
  			    void __user *userptr)
  {
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);
  	void __user *pos;
  	unsigned int size;
  	int ret = 0;
diff --git a/net/ipv6/netfilter/ip6_tables.c 
b/net/ipv6/netfilter/ip6_tables.c
index 2e2119b..91d8364 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -280,7 +280,7 @@ ip6t_do_table(struct sk_buff *skb,

  	local_bh_disable();
  	addend = xt_write_recseq_begin();
-	private = READ_ONCE(table->private); /* Address dependency. */
+	private = xt_table_get_private_protected(table);
  	cpu        = smp_processor_id();
  	table_base = private->entries;
  	jumpstack  = (struct ip6t_entry **)private->jumpstack[cpu];
@@ -807,7 +807,7 @@ static struct xt_counters *alloc_counters(const 
struct xt_table *table)
  {
  	unsigned int countersize;
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);

  	/* We need atomic snapshot of counters: rest doesn't change
  	   (other than comefrom, which userspace doesn't care
@@ -831,7 +831,7 @@ copy_entries_to_user(unsigned int total_size,
  	unsigned int off, num;
  	const struct ip6t_entry *e;
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);
  	int ret = 0;
  	const void *loc_cpu_entry;

@@ -1552,7 +1552,7 @@ compat_copy_entries_to_user(unsigned int 
total_size, struct xt_table *table,
  			    void __user *userptr)
  {
  	struct xt_counters *counters;
-	const struct xt_table_info *private = table->private;
+	const struct xt_table_info *private = 
xt_table_get_private_protected(table);
  	void __user *pos;
  	unsigned int size;
  	int ret = 0;
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index af22dbe..416a617 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1349,6 +1349,14 @@ struct xt_counters *xt_counters_alloc(unsigned 
int counters)
  }
  EXPORT_SYMBOL(xt_counters_alloc);

+struct xt_table_info
+*xt_table_get_private_protected(const struct xt_table *table)
+{
+	return rcu_dereference_protected(table->private,
+					 mutex_is_locked(&xt[table->af].mutex));
+}
+EXPORT_SYMBOL(xt_table_get_private_protected);
+
  struct xt_table_info *
  xt_replace_table(struct xt_table *table,
  	      unsigned int num_counters,
@@ -1356,7 +1364,6 @@ xt_replace_table(struct xt_table *table,
  	      int *error)
  {
  	struct xt_table_info *private;
-	unsigned int cpu;
  	int ret;

  	ret = xt_jumpstack_alloc(newinfo);
@@ -1366,8 +1373,7 @@ xt_replace_table(struct xt_table *table,
  	}

  	/* Do the substitution. */
-	local_bh_disable();
-	private = table->private;
+	private = xt_table_get_private_protected(table);

  	/* Check inside lock: is the old number correct? */
  	if (num_counters != private->number) {
@@ -1379,34 +1385,9 @@ xt_replace_table(struct xt_table *table,
  	}

  	newinfo->initial_entries = private->initial_entries;
-	/*
-	 * Ensure contents of newinfo are visible before assigning to
-	 * private.
-	 */
-	smp_wmb();
-	table->private = newinfo;
-
-	/* make sure all cpus see new ->private value */
-	smp_wmb();

-	/*
-	 * Even though table entries have now been swapped, other CPU's
-	 * may still be using the old entries...
-	 */
-	local_bh_enable();
-
-	/* ... so wait for even xt_recseq on all cpus */
-	for_each_possible_cpu(cpu) {
-		seqcount_t *s = &per_cpu(xt_recseq, cpu);
-		u32 seq = raw_read_seqcount(s);
-
-		if (seq & 1) {
-			do {
-				cond_resched();
-				cpu_relax();
-			} while (seq == raw_read_seqcount(s));
-		}
-	}
+	rcu_assign_pointer(table->private, newinfo);
+	synchronize_rcu();

  	audit_log_nfcfg(table->name, table->af, private->number,
  			!private->number ? AUDIT_XT_OP_REGISTER :
@@ -1442,12 +1423,12 @@ struct xt_table *xt_register_table(struct net 
*net,
  	}

  	/* Simplifies replace_table code. */
-	table->private = bootstrap;
+	rcu_assign_pointer(table->private, bootstrap);

  	if (!xt_replace_table(table, 0, newinfo, &ret))
  		goto unlock;

-	private = table->private;
+	private = xt_table_get_private_protected(table);
  	pr_debug("table->private->number = %u\n", private->number);

  	/* save number of initial entries */
@@ -1470,7 +1451,8 @@ void *xt_unregister_table(struct xt_table *table)
  	struct xt_table_info *private;

  	mutex_lock(&xt[table->af].mutex);
-	private = table->private;
+	private = xt_table_get_private_protected(table);
+	RCU_INIT_POINTER(table->private, NULL);
  	list_del(&table->list);
  	mutex_unlock(&xt[table->af].mutex);
  	audit_log_nfcfg(table->name, table->af, private->number,
