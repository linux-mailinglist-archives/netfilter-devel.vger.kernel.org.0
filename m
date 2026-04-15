Return-Path: <netfilter-devel+bounces-11940-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNJiEUv032mMawAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11940-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 22:25:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 740AD4079FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4CFE3023FB0
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C913859D7;
	Wed, 15 Apr 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="QL9cHMuZ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED231D372;
	Wed, 15 Apr 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776284735; cv=none; b=n6djdQE4NxOCApdwspXKa59xvlxhVoUSIEGO6v0lA5nLJpqy983FqBdRI7lmYVTpkZMM8MZ+I4veBoNPt4e6u2bpdlSfGmF0pycfCY+aRNqGRwc7uh5dnbT5563qHThlzWIxLTpCFTQfn7n06JB72+7LcULWguyLLWkFVFLlvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776284735; c=relaxed/simple;
	bh=lTDSEfgLiPb6Zc6xiCp9O+PQaNg/usqGgZY7lpdsvjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI/Dm+l0VFXHYn3wxDzK4NqVP32925+06MXB9KM5ntzW/eYQTaQ5Blka38wvWsxwXYTw8wVK/v0h7zZXVEk6yBy1ukDS0KffSahpuQyvnD10HQdopdm16CJE9diH1L1YQngieC7E/gAISOTotA/lWwS4ljHStg0iZ1QLovuwgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=QL9cHMuZ; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 392A0600B9;
	Wed, 15 Apr 2026 22:25:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776284730;
	bh=05tOkxOHaDMCzwX9o+tLfnCgbcASN3tKZPZ703Z0qLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QL9cHMuZ7P9f/cOcS15BsGu1PaFGWrUUs0WXR/eAkKBrimFL5yZ/dDV0vqjSGO7WM
	 83e5Ilv4mfAWq35SWajTqRAbXA9UzcfM2+yTi0gMQsRHB8j5cp4tnirCu5oGvRHWEy
	 3wtnXH1joB67pNU0P6SqgzMHUQkJ0X/YBW3j7Vlrccm85wDmUs1gJymHQDtNP9MeLY
	 Jfw1NXqHrDAs4O6ferznZw6drjnWm+F79XG6cBJAohsVzVsv9/Ik4XbIN/ASVrItZo
	 6nO+Y5fxjmhtLRoEIZShNiH4vpgx5RSaKXMcz6FHTl5KtLUNve4U3G4PDdUW5R0nmp
	 sfnbdTlZfpHPQ==
Date: Wed, 15 Apr 2026 22:25:27 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, fw@strlen.de, horms@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH nf,v2 1/3] rculist: add list_splice_rcu() for private
 lists
Message-ID: <ad_0N6yAOenXeXR7@chamomile>
References: <20260415170844.41355-1-pablo@netfilter.org>
 <9210a276-8158-40f4-b3b5-6431f5f13541@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9210a276-8158-40f4-b3b5-6431f5f13541@paulmck-laptop>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11940-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[netfilter.org:server fail,sin.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,strlen.de,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 740AD4079FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:39:33AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 15, 2026 at 07:08:44PM +0200, Pablo Neira Ayuso wrote:
> > This patch adds a helper function, list_splice_rcu(), to safely splice
> > a private (non-RCU-protected) list into an RCU-protected list.
> > 
> > The function ensures that only the pointer visible to RCU readers
> > (prev->next) is updated using rcu_assign_pointer(), while the rest of
> > the list manipulations are performed with regular assignments, as the
> > source list is private and not visible to concurrent RCU readers.
> > 
> > This is useful for moving elements from a private list into a global
> > RCU-protected list, ensuring safe publication for RCU readers.
> > Subsystems with some sort of batching mechanism from userspace can
> > benefit from this new function.
> > 
> > The function __list_splice_rcu() has been added for clarity and to
> > follow the same pattern as in the existing list_splice*() interfaces,
> > where there is a check to ensure that that the list to splice is not
> > empty. Note that __list_splice_rcu() has no documentation for this
> > reason.
> > 
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > v2: including comments by Paul McKenney.
> > 
> >     Except, I have deliberately keep back the suggestion to squash
> >     __list_splice_rcu() into list_splice_rcu(), I instead removed
> >     the documentation for __list_splice_rcu(). I am looking
> >     at other existing list_splice*() function in list.h and rculist.h
> >     to get this aligned with __list_splice(), which also has no users
> >     in the tree and no documentation. I find it easier to read with
> >     __list_splice(), but if this explaination is not sound so...
> > 
> >     @Paul: I can post v3 squashing __list_splice_rcu(), just let me
> >            know.
> 
> Removing the comment addresses most of my concerns.  I do have a slight
> but not overwhelming preference for the squashed version, but either way:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Or if you want this to go in via RCU, please let us know.  My guess is
> that it would be easier for you to take it in with the code using it.

I'd prefer to take it through nf.git, I need this as a fix for an
invalid use of list_splice() on a RCU-protected list.

Thanks for your quick review Paul!

