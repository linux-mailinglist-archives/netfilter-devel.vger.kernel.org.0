Return-Path: <netfilter-devel+bounces-10845-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePL9FAHKnWmxSAQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10845-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 16:55:45 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1FB189691
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ADD631CE41A
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C613A7851;
	Tue, 24 Feb 2026 15:49:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C853A640B;
	Tue, 24 Feb 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948181; cv=none; b=ZtfUfrpxJnLzjkdLEAP6DG0I7Jn0frFfbE8+xdp/WbUWHqj5hnlGFdfmIkffU+Ugquz3XXgNdt5yxlm57HllkirIFie9O8jgUz2dW9Xy9EQwTRfwMQ8+FJ4HvNrRkPqsMgixU+M5YiPA5kHlzFIklcYQaTEYhDXq3I9SveJNU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948181; c=relaxed/simple;
	bh=U2RtSpfnbX3HeINOo1ldILPGhn8ittpRr0t8kSUEClM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATyBbnWcXzxPq1Gz17OAk7UfOMbBNjSR/MUuPEqj1rpup8DWIj1wu0Zvr1sox6J2GhkStO8sJS2WHplAIKOUjALbHYb1Hq0jaHxPEQpSNeC2St/EboRa8r/llfonr4I7yv8M4YPFuhWBFVQwDERqZatPHfuEJ96GwVYzIgAOv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5556D604AA; Tue, 24 Feb 2026 16:49:37 +0100 (CET)
Date: Tue, 24 Feb 2026 16:49:33 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] netfilter: xt_owner: no longer acquire
 sk_callback_lock in mt_owner()
Message-ID: <aZ3IjYUe7MbiPX15@strlen.de>
References: <20260224122856.3152608-1-edumazet@google.com>
 <aZ2fA2x5nHsnQoBu@strlen.de>
 <CANn89iLP2xFerYywu=x8bnox_+vjrDVUxkEf-nUEJM0VmNfVdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLP2xFerYywu=x8bnox_+vjrDVUxkEf-nUEJM0VmNfVdA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10845-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,netfilter.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB1FB189691
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> wrote:
> Sure, I will remove the rcu_read_lock()/rcu_read_unlock()
> 
> Do you think adding lockdep_assert_in_rcu_read_lock() would be useful
> or would it be too much, iptables/nftables willl always be run under RCU
> and this is well understood ?

I don't think the lockdep assertion is needed; but I don't mind if you
add one.

All netfilter hooks run under rcu:

static inline int nf_hook(u_int8_t pf, unsigned int hook, struct net *net,
                          struct sock *sk, struct sk_buff *skb,
                          struct net_device *indev, struct net_device *outdev,
                          int (*okfn)(struct net *, struct sock *, struct sk_buff *))
{
        struct nf_hook_entries *hook_head = NULL;
        int ret = 1;

	[..]

        rcu_read_lock();
        switch (pf) {
        case NFPROTO_IPV4:
                hook_head = rcu_dereference(net->nf.hooks_ipv4[hook]);
	[..]
	if (hook_head) {

                ret = nf_hook_slow(skb, &state, hook_head, 0);
        }
        rcu_read_unlock();
	[..]

Thanks Eric!

