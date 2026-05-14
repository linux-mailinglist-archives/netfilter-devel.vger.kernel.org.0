Return-Path: <netfilter-devel+bounces-12613-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLzSGHhgBmoMjQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12613-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 01:53:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB16547DD5
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 01:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8DB3017C03
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 May 2026 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDE3A0B3F;
	Thu, 14 May 2026 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="v0QCapox"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304225B094
	for <netfilter-devel@vger.kernel.org>; Thu, 14 May 2026 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778802805; cv=none; b=T5Y22HkvurOD+LZ1cQVfaj9tNz0NaepkIBVcH9K+9E5K7iCCB9lCLBbesjx/i84pbS5iUdoYXKTsjBppWFxOBrqtGrC/iAY/n/O99DjH5Dzb+2k2D9dpEp0orMG29V68natjh+ho516fZVNKBdGijLjHrfsSRFF1rxpPLUM+PxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778802805; c=relaxed/simple;
	bh=ZmH7NSbHlB39Xu9kXURZZsd07crZbGiUT2t5ZPvyNBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiFQAiurMdJrYt04iJyQepBYswf9ltOS4UJyjch+jn4/XwCKBy5lEr6HNLVFWlaPmwlBElZ2/e8yU5E+sgz3D/PuGWlk5wBFrddhXo42SmxVykCkBeF2M84hZDN76qwseIuhS+LI1dd8B4c4MEivXUIZHM/tNWHaJZwS/Sg2dJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=v0QCapox; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C87566017F;
	Fri, 15 May 2026 01:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778802801;
	bh=lmj6wBPWHPnVyAIyNek8j+KFlqpdtMdqJFuhiNDsnXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v0QCapox1qiBI+LHX1eEahKab0ESeIzH+gmz2YyKiYEe3X+afyuycJVolJW1axI+2
	 arsh/L8lnXAZdwErzyI+KXO4qdc6j/u1rQwTE830cIylP/qNCTBvK0HorBkAB/8Rqr
	 bCddEXCIyh4StOzEmHnhCfyOYr9TlDfuocy9Aw2Y86dE5uTwz43YM7Myiz9Z8ZSPoy
	 8iKepBEzjZDWsj1ulyXmFlXRn/Mg2yb/Y1QbIShCf0junGCRjflmll5pKpqmcopfzU
	 S323sMKwjHmhqbIZ0GvE2AHWkjkbF6KCxz+iFkYhl9BknEnp4X5sHh5SYyc+16GjCw
	 UY2yEOUlkU7kg==
Date: Fri, 15 May 2026 01:53:18 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2] netfilter: conntrack: add dead flag to helpers
Message-ID: <agZgbk_F3Clt1bQ5@chamomile>
References: <20260514143016.874811-1-pablo@netfilter.org>
 <agXfhQb8Dcl9p5ce@strlen.de>
 <agXl-3NDpK3YUZiF@chamomile>
 <agXt-m9yN-oayY1G@strlen.de>
 <agZbFvp_KgGUr2Kw@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agZbFvp_KgGUr2Kw@chamomile>
X-Rspamd-Queue-Id: ADB16547DD5
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
	TAGGED_FROM(0.00)[bounces-12613-lists,netfilter-devel=lfdr.de];
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

On Fri, May 15, 2026 at 01:30:33AM +0200, Pablo Neira Ayuso wrote:
> On Thu, May 14, 2026 at 05:44:58PM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > On Thu, May 14, 2026 at 04:43:17PM +0200, Florian Westphal wrote:
> > > > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > > Add a new NF_CT_HELPER_F_DEAD helper flag to notify the packet path that
> > > > > this helper is going away. Thus, helpers are effectively disabled and no
> > > > > new expectations are created while removing the expectations created by
> > > > > this helper as well as unhelping the existing conntrack entries.
> > > > > 
> > > > > Add the check for NF_CT_HELPER_F_DEAD in the packet path to:
> > > > > - Conntrack confirmation path which invokes the helper callback.
> > > > > - Propagation of helper to conntrack via expectation.
> > > > > - OVS ct helper invocation.
> > > > 
> > > > Not sure this is enough.  New conntracks are not in any hash table /
> > > > unreachable, and synchronize_rcu() doesn't guarantee they get confirmed
> > > > (can get queued).
> > > 
> > > nf_ct_iterate_destroy() calls nf_queue_nf_hook_drop() for each netns.
> > 
> > But is that enough?  Consider:
> > 
> > cpu0						cpu1
> > 						recieves verdict
> > 						unlink from nfqueue list
> > drop_queued_packets (misses unlinked)
> > 						... going on ..
> 
> This looks like a general problem with nf_queue_nf_hook_drop().
> 
> > I think to properly resolve this, there is a need to check
> > for this new dead flag after queueing to userspace (after its on list)
> > and again when receiving the verdict.
> >
> > Arguably this is kind of different bug, because this comment is wrong:
> > 
> > /* a skb w. unconfirmed conntrack could have been reinjected just
> >  * before we called nf_queue_nf_hook_drop().
> >  *
> >  * This makes sure its inserted into conntrack table.
> >  */
> >  synchronize_net();
> > 
> > (it could have been requeued).
> >
> > I think a more generic fix is to add a seqcnt to nf_queue_entry.
> > When queueing, record current seqcnt.
> >
> > On reinject, drop if unconfirmed and seqcnt_now != entry->seqcnt.
> > Not nice, but I don't see a better way ATM.
> 
> But you would need to check right before enqueueing (adding to the
> hashtable/list), so the race would still be there? 
> 
> > The seqcnt can be pernet and it can be restricted to nfnetlink_queue.
> > 
> > Any better idea?
> 
> Maybe add a helper_id which is set at helper registration time. Then
> nf_conn_help stores this helper_id field.  Unconfirmed conntrack on
> reinject use this helper_id to re-lookup the helper when reinjecting.
> This would force a slow path for unconfirmed conntracks, to
> re-validate if the helper is still there.
> 
> cttimeout would need this too, a lookup to check if the timeout policy
> is still around.

Hm.

struct nf_ct_ext {
        u8 offset[NF_CT_EXT_NUM];
        u8 len;
        unsigned int gen_id;   <---- There is already a gen_id here.

And nf_ct_ext_bump_genid() is called from nf_ct_iterate_destroy().

Maybe we could simply check if there is a mismatch in this generation
id from reinject path?

