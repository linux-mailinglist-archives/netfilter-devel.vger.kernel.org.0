Return-Path: <netfilter-devel+bounces-10401-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGtGM6yMc2mGxAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10401-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 15:58:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DF77544
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 15:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD39C3022579
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jan 2026 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED0263F34;
	Fri, 23 Jan 2026 14:58:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846B330B12
	for <netfilter-devel@vger.kernel.org>; Fri, 23 Jan 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180314; cv=none; b=QRfpkv6VoeK2YIwKQZXd/WtbuECNGaLKXesHeIQvTUiqTO8QS3g1r3AFy7ImTcWT5NZLVwgveT+QzmRA7L1S1djoYgM83yieZQdneizm1GEmCL99erIs6claJzE3VkHpDVTTdfLJsjniAcBi5fC2hmxQtnMK92w9Tkq2FAWMNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180314; c=relaxed/simple;
	bh=+n4+wo67lvHrgogSdtjigLx0luxBuYlIb3VlY96hpZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR01S93vMGl9sNcggYbL5LT85j+qCMkwS9uhUNNDbRP5ZvnLc9NcyXtFHc+fCzobghn91DHI370pM2X9F5jDiQkwAQGuHfpxW1klQggvMBlVyTmwVcrCaKc8/ND8OXBu0QfHjC41WBDZelf+b09VX+lS/wUrxYAO/gD6w05PIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 68BD0602D9; Fri, 23 Jan 2026 15:58:29 +0100 (CET)
Date: Fri, 23 Jan 2026 15:58:24 +0100
From: Florian Westphal <fw@strlen.de>
To: scott.k.mitch1@gmail.com
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH v7] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
Message-ID: <aXOMkP9ovdFwLjwO@strlen.de>
References: <20260123135404.21118-1-scott.k.mitch1@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123135404.21118-1-scott.k.mitch1@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-10401-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,key.net:url,strlen.de:mid]
X-Rspamd-Queue-Id: 6B0DF77544
X-Rspamd-Action: no action

scott.k.mitch1@gmail.com <scott.k.mitch1@gmail.com> wrote:

LGTM, just a few minor nits.

> diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
> index 4aeffddb7586..e6803831d6af 100644
> --- a/include/net/netfilter/nf_queue.h
> +++ b/include/net/netfilter/nf_queue.h
> @@ -6,11 +6,13 @@
>  #include <linux/ipv6.h>
>  #include <linux/jhash.h>
>  #include <linux/netfilter.h>
> +#include <linux/rhashtable-types.h>
>  #include <linux/skbuff.h>
>  
>  /* Each queued (to userspace) skbuff has one of these. */
>  struct nf_queue_entry {
>  	struct list_head	list;
> +	struct rhash_head	hash_node;
>  	struct sk_buff		*skb;
>  	unsigned int		id;
>  	unsigned int		hook_index;	/* index in hook_entries->hook[] */
> @@ -20,6 +22,7 @@ struct nf_queue_entry {
>  #endif
>  	struct nf_hook_state	state;
>  	u16			size; /* sizeof(entry) + saved route keys */
> +	u16			queue_num;
>  
>  	/* extra space to store route keys */
>  };
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 8b7b39d8a109..e7372955c5a8 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
>  #define NFQNL_MAX_COPY_RANGE (0xffff - NLA_HDRLEN)
>  
> +/* Composite key for packet lookup: (net, queue_num, packet_id) */
> +struct nfqnl_packet_key {
> +	struct net *net;

possible_net_t net;

so we don't have this member for CONFIG_NET_NS=n

> +	u32 packet_id;
> +	u16 queue_num;
> +};
> +
> +/* Global rhashtable - one for entire system, all netns */
> +static struct rhashtable nfqnl_packet_map __read_mostly;
> +
>  struct nfqnl_instance {
>  	struct hlist_node hlist;		/* global list of queues */
>  	struct rcu_head rcu;
> @@ -100,6 +114,45 @@ static inline u_int8_t instance_hashfn(u_int16_t queue_num)
>  	return ((queue_num >> 8) ^ queue_num) % INSTANCE_BUCKETS;
>  }
>  
> +/* Extract composite key from nf_queue_entry for hashing */
> +static u32 nfqnl_packet_obj_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const struct nf_queue_entry *entry = data;
> +	struct nfqnl_packet_key key;
> +
> +	/* Zero entire struct including padding to ensure deterministic hashing */
> +	memset(&key, 0, sizeof(key));
> +	key.net = entry->state.net;

write_pnet()

> +	/* jhash2 requires size to be a multiple of sizeof(u32) */
> +	BUILD_BUG_ON(sizeof(key) % sizeof(u32) != 0);

I wonder if this works on 32bit.

If not, alternative is to either add __align to the struct or
to resort to jhash_3words().

Up to you.

> +/* Compare stack-allocated key against entry */
> +static int nfqnl_packet_obj_cmpfn(struct rhashtable_compare_arg *arg,
> +				  const void *obj)
> +{
> +	const struct nfqnl_packet_key *key = arg->key;
> +	const struct nf_queue_entry *entry = obj;
> +
> +	return entry->state.net != key->net ||

net_eq(entry->state.net, read_pnet( ...

> +static inline int
>  __enqueue_entry(struct nfqnl_instance *queue, struct nf_queue_entry *entry)
>  {

Is the inline keyword needed here?

> +	memset(&key, 0, sizeof(key));
> +	key.net = net;
> +	key.packet_id = id;
> +	key.queue_num = queue->queue_num;

Maybe its worth to add a small helper that fills the structure.

> +	/* Insert into hash BEFORE unicast. If failure don't send to userspace. */
> +	err = __enqueue_entry(queue, entry);
> +	if (unlikely(err)) {
> +		if (queue->flags & NFQA_CFG_F_FAIL_OPEN) {
> +			failopen = 1;
> +			err = 0;
> +		} else {
> +			queue->queue_dropped++;
> +			net_warn_ratelimited("nf_queue: hash insert failed: %d\n", err);
> +		}
> +		goto err_out_free_nskb;

This repeated conditional is not so nice, is there a way to avoid it?
E.g. new common helper or via goto.

> +	status = rhashtable_init(&nfqnl_packet_map, &nfqnl_rhashtable_params);
> +	if (status < 0) {
> +		pr_err("failed to init packet hash table\n");

Please remove this pr_err, kernel gets quite noisy when
it starts to run out of memory.  The other pr_err()s init .init
are just historic artefacts.

