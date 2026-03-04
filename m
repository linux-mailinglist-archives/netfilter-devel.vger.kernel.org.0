Return-Path: <netfilter-devel+bounces-10947-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kb3N+vDp2mYjgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10947-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 06:32:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DD1FADD1
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 06:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7203029245
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 05:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9E30E84D;
	Wed,  4 Mar 2026 05:32:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8663368BD;
	Wed,  4 Mar 2026 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772602344; cv=none; b=SK16R/eSLis1Wq75a0xjYKtfmXUhkDPEUMwRLfEMfeZG+rh5dD/TXoNj0o1Wb0Vj4AuvCus1WllTMK6hQOT5R7begE0iVfmflsQ1THyF86wYwEgl3E8J8+92BFXxhgGaZbEvaMtrL4IwXloqmvEk7A23iwjALWWaWIq/kvFwvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772602344; c=relaxed/simple;
	bh=xoqHvfs/WmMCAA44T1hWY8qugXUi3Ofc4llwLvOxpUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfI92bgJaELKxh7FBrml3IL4/h7hnUDRGXeTwKNb89RlzGbTbqFsXTIEo+e6NlVD5IjEH7lBSX7txtvPBmbGpT9wLJsEa1rbGxU47F8bx5G4vn5hg1L8/ECPy3xCF7S+/zTYcX4NyfBSUHsKz07lHCXS9n0r5qz7cXSptw5YKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7005560492; Wed, 04 Mar 2026 06:32:20 +0100 (CET)
Date: Wed, 4 Mar 2026 06:32:15 +0100
From: Florian Westphal <fw@strlen.de>
To: Helen Koike <koike@igalia.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, phil@nwl.cc,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] netfilter: nf_tables: fix use-after-free on ops->dev
Message-ID: <aafD369eE31dh1VP@strlen.de>
References: <20260302212605.689909-1-koike@igalia.com>
 <aaYYiPTO5JYOlhhY@chamomile>
 <17499d82-ad03-44a9-ab3a-429d2ebea02f@igalia.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17499d82-ad03-44a9-ab3a-429d2ebea02f@igalia.com>
X-Rspamd-Queue-Id: 2E1DD1FADD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10947-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Helen Koike <koike@igalia.com> wrote:

Phil, can you please take a look at this?

The reg/unregister logic is ... strange.

> But if I understood correctly from your comment below, the proper 
> solution would be to fix the order that the hooks are released, is my 
> understanding correct?

I don't think its about ordering.  I think the code allows to register
devices multiple times in the same flowtable, but UNREG doesn't handle
that.

static int nft_flowtable_event(unsigned long event, struct net_device *dev,
			       struct nft_flowtable *flowtable, bool changename)
{
	struct nf_hook_ops *ops;
	struct nft_hook *hook;
	bool match;

	list_for_each_entry(hook, &flowtable->hook_list, list) {
		ops = nft_hook_find_ops(hook, dev);
		match = !strncmp(hook->ifname, dev->name, hook->ifnamelen);

		switch (event) {
		case NETDEV_UNREGISTER:
			/* NOP if not found or new name still matching */
			if (!ops || (changename && match))
				continue;

			/* flow_offload_netdev_event() cleans up entries for us. */
			nft_unregister_flowtable_ops(dev_net(dev),
						     flowtable, ops);
			list_del_rcu(&ops->list);
			kfree_rcu(ops, rcu);
			break;
		case NETDEV_REGISTER:
			/* NOP if not matching or already registered */
			if (!match || (changename && ops))
				continue;

And *THIS* looks buggy.
Shouldn't that simply be:
			if (!match || ops)
				continue;

Or can you explain why changename has any relevance here?
changename means dev->name has already been updated.

So, we want to skip a new registration if either:
1. the name doesn't match
2. it matches but its already registered.

In case changename is true, only UNREGISTER: case is
relevant: If its not matching anymore -> unregister.

Still matching?  Keep it.  In that case, we havn't
registered the device again because 'ops' was non-null in
REGISTER case.

		}
		break;

If its allowed to register the same device twice (or more), then the
above 'break' needs to be removed, AND one has to alter UNREGISTER
above to loop until no more ops are found, i.e.
		case NETDEV_UNREGISTER:
			/* NOP if not found or new name still matching */
			if (!ops || (changename && match))
				continue;

			do {
				/* flow_offload_netdev_event() cleans up entries for us. */
				nft_unregister_flowtable_ops(dev_net(dev),
							     flowtable, ops);
				list_del_rcu(&ops->list);
				kfree_rcu(ops, rcu);
				ops = nft_hook_find_ops(hook, dev);
			} while (ops);
			break;

Phil, can you please have a look?  Thanks!

