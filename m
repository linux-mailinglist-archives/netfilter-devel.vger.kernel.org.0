Return-Path: <netfilter-devel+bounces-12580-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDNhJIGlBGqrMQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12580-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 18:23:29 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEF536FC0
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE4FA30E98CD
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF740B6CD;
	Wed, 13 May 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="EAzWQ7ED"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5C382283
	for <netfilter-devel@vger.kernel.org>; Wed, 13 May 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686726; cv=none; b=FBw6ze4Ghu7NAHNNo99lI4bPT86ojzzbg5D7hCqHynU+yuIWj8Moo59DC7H8oOiymssekzzZgcoVoQrTMSCCXKDaMFOzYBnF2JGzZ9XpgWZmOBZQlxwEcOrropn/9DtlNsEOLraLxwLrXEkoW63Au31M0CXN0OMDl6Tv3RKpkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686726; c=relaxed/simple;
	bh=aQdWD38T1LxrGpHswW3VWazW4PNIkB2Hs7OWJzt2jNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp4pUMf5Hxvqx7LFAf25ee1GsXrY389zy0ZOCg4O+sKWsUHh1oeejUI1bZBPnmrVfX7eyLODMxV55KniYnnW2E6fIVwhlOS0hdx/MW+aAsUTrqw5UO7sQbB0ZisfqALfRyZl72+Osa5h+7RT8kP3LR6PwDIl90Ec69D+hWhRMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=EAzWQ7ED; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id B68746017F;
	Wed, 13 May 2026 17:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778686722;
	bh=AX4QIOepwUQPfN4zi4JgNxLyCsVHyZK/CDzZONGcM6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAzWQ7EDis0sEuxLsBk0aFD2r5/1HJb+TPZjpg/UjO9kEMs25MZ14mDUodqD37Wgf
	 WtKDV7IafYiCP249OIl5Zz6BDWQgpnxbP4HmEC6jgjuLJeR5RkpayxRMAxW1RsrsBU
	 x1YBFaLCtOoMugKgjqK54sD0nnvYdD/+qUFfb86mUdW0lMVNNBJ7JyWiQd/qdyz9lL
	 2GoQqD16FBClqh6rx4T2mPt/WGQJTiYN92bHPNw/xbE+mjb26mOBhBEvW6/hrcZXRw
	 ZY1C/2MTjmcHZqLo2Xq7R6M9Q7/oXySCf8nMye+98Sd7qoJlxysdAJwtZXO6LWiI7t
	 CdgOxHFrgywlw==
Date: Wed, 13 May 2026 17:38:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: add dead flag to helpers
Message-ID: <agSbAFn3wN-sU6uV@chamomile>
References: <20260512205823.803476-1-pablo@netfilter.org>
 <agRMzvHgYCblnbrO@strlen.de>
 <agSY1PyVKRhf4zDc@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agSY1PyVKRhf4zDc@chamomile>
X-Rspamd-Queue-Id: EBEEF536FC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12580-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:29:27PM +0200, Pablo Neira Ayuso wrote:
> On Wed, May 13, 2026 at 12:05:02PM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > Add a new NF_CT_HELPER_F_DEAD helper flag to notify the packet path that
> > > this helper is going away. Thus, helpers are effectively disabled and no
> > > new expectations are created while removing the expectations created by
> > > this helper as well as unhelping the existing conntrack entries.
> > > 
> > > Add the check for NF_CT_HELPER_F_DEAD in the packet path to:
> > > - Conntrack confirmation path which invokes the helper callback.
> > > - Propagation of helper to conntrack via expectation.
> > > - OVS ct helper invocation.
> > > 
> > > Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
> > > Reported-by: Florian Westphal <fw@strlen.de>
> > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > ---
> > >  include/net/netfilter/nf_conntrack_helper.h | 6 ++++++
> > >  net/netfilter/nf_conntrack_core.c           | 2 +-
> > >  net/netfilter/nf_conntrack_helper.c         | 5 ++++-
> > >  net/netfilter/nf_conntrack_ovs.c            | 3 +++
> > >  net/netfilter/nf_conntrack_proto.c          | 2 +-
> > >  5 files changed, 15 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/net/netfilter/nf_conntrack_helper.h b/include/net/netfilter/nf_conntrack_helper.h
> > > index de2f956abf34..1faa42efe42e 100644
> > > --- a/include/net/netfilter/nf_conntrack_helper.h
> > > +++ b/include/net/netfilter/nf_conntrack_helper.h
> > > @@ -25,6 +25,7 @@ struct module;
> > >  enum nf_ct_helper_flags {
> > >  	NF_CT_HELPER_F_USERSPACE	= (1 << 0),
> > >  	NF_CT_HELPER_F_CONFIGURED	= (1 << 1),
> > > +	NF_CT_HELPER_F_DEAD		= (1 << 2),
> > >  };
> > >  
> > >  #define NF_CT_HELPER_NAME_LEN	16
> > > @@ -63,6 +64,11 @@ struct nf_conntrack_helper {
> > >  	char nat_mod_name[NF_CT_HELPER_NAME_LEN];
> > >  };
> > >  
> > > +static inline bool nf_ct_helper_alive(const struct nf_conntrack_helper *helper)
> > > +{
> > > +	return likely(!(helper->flags & NF_CT_HELPER_F_DEAD));
> > > +}
> > > +
> > >  /* Must be kept in sync with the classes defined by helpers */
> > >  #define NF_CT_MAX_EXPECT_CLASSES	4
> > >  
> > > diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> > > index 8ba5b22a1eef..d54da6babcfe 100644
> > > --- a/net/netfilter/nf_conntrack_core.c
> > > +++ b/net/netfilter/nf_conntrack_core.c
> > > @@ -1818,7 +1818,7 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
> > >  			/* exp->master safe, refcnt bumped in nf_ct_find_expectation */
> > >  			ct->master = exp->master;
> > >  			assign_helper = rcu_dereference(exp->assign_helper);
> > > -			if (assign_helper) {
> > > +			if (assign_helper && nf_ct_helper_alive(assign_helper)) {
> > 
> > At this time, the new ct isn't in any hash.  As-is, I don't think this
> > will guarantee such nfct canot escape.  See below.
> > 
> > >  				help = nf_ct_helper_ext_add(ct, GFP_ATOMIC);
> > >  				if (help)
> > >  					rcu_assign_pointer(help->helper, assign_helper);
> > > diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> > > index b594cd244fe1..b3752ccca75e 100644
> > > --- a/net/netfilter/nf_conntrack_helper.c
> > > +++ b/net/netfilter/nf_conntrack_helper.c
> > > @@ -415,8 +415,11 @@ void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
> > >  	nf_ct_helper_count--;
> > >  	mutex_unlock(&nf_ct_helper_mutex);
> > >  
> > > +	me->flags |= NF_CT_HELPER_F_DEAD;
> > > +
> > 
> > Does this need to be toggled while under lock?
> > I don't think synchronize_rcu() is a barrier.
> > 
> > Also, it looks like this can be racing with nfnl_cthelper_update().
> > We probably need to add some new lock, or reuse existing one like
> > nf_ct_helper_mutex, or expectation spinlock.
> > 
> > >  	/* Make sure every nothing is still using the helper unless its a
> > > -	 * connection in the hash.
> > > +	 * connection in the hash, no more expectations are created after
> > > +	 * this rcu grace period.
> > >  	 */
> > >  	synchronize_rcu();
> > 
> > ... that makes things wait until we leave rcu protection.
> > I think we should also drop nfqueued packets here to make sure
> > they can't be reinjected.
> 
> See below, at the end of this email.
> 
> > Also, should __nf_ct_expect_check() also call nf_ct_helper_alive()
> > and refuse insertion of such exp into the table?
> > 
> > That would give following unreg sequence:
> > 1. Unlink from hash
> > 2. set flag -> prevent concurrent nf_ct_expect_related() from
> >    adding more expectations to the exp table
> 
> My understanding is that during the rcu grace period, packets
> might keep walking over the helper function and create an
> expectations. These expectations will be destroyed by
> nf_ct_expect_iterate_destroy(). 
> 
> But after the rcu grace period, new packets will start seeing the
> helper dead flag, hence skipping the helper logic / no new expectation
> is created. And the existing expectation cannot be reached, because
> _find_expect() is disabled.
> 
> > 3. synchronize_rcu() -> all skbs that had this helper have
> >    left RCU protection
> > 4. nf_ct_expect_iterate_destroy() removes all not-yet-found
> >    exp entries from table
> > 5. nf_ct_iterate_destroy() -> clear exp from nf_conn's that are
> >    *in conntrack table*
> > 
> > That still means we could have a NEW conntrack queued via nfqueue.
> > I think we also need to toss nfqueued packets after step 3) and
> > need to refuse queueing to userspace if the flag is set (-> drop).
> 
> Those conntrack entries would now have help->helper == NULL because of
> the unhelp call.

Oh, wait, _NEW_ conntracks are unreachable, so yes, that can happen.

Tossing nfqueued packets here is convenient when helper goes away.

> > We could have several nfqueue back to back:
> > -t mangle -A PREROUTING -j NFQUEUE
> > -t mangle -A FORWARD -j NFQUEUE
> > 
> > ... and each synchronize_rcu() might advance skb to next
> > 'queue' instead of nf_confirm().
> > 
> > But I think that this a good direction, I think its better than my
> > rather destructive temporarily-block-all-exps idea.
> 
> Thanks for your feedback, let me know if I still don't see anything
> obvious.

