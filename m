Return-Path: <netfilter-devel+bounces-13267-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N6zsIy8rL2rj8QQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13267-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 00:29:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3B6826A3
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 00:29:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=su9oJQAZ;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13267-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13267-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D43A130013AD
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jun 2026 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6837CD4E;
	Sun, 14 Jun 2026 22:28:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68533AD9A;
	Sun, 14 Jun 2026 22:28:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476135; cv=none; b=StFRC56Zg+jdzsnGsvcr4+f2z/52dgCmwqvd2hMpm2OB/uEnVwK/nqUK6Cw/1sVhTWhZTnsLsN9H2/g9b9rzKGfQsITvI89ou/BrHWdsiaYt2XtACSHJ1jrVkF+58jxUbSbhYmKL84sBc3lthI5idR1Nv2WD7cct3M04XY6gtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476135; c=relaxed/simple;
	bh=ABURyU1V3mecvrhWUnHt39hy2OScN13aV8oQpR0sbVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDCOslxhVtmYPMEuRCIcZNp9bslOp+5YZy2+Lxi8Uvr0jstnP14sqMHsDFNOd5EyIkCtOr0j/0wP1CCOMQlCPJqK9Jl/jhKie4yzqrqivVH1XlMmO95E8CndSBeJ8VzMq9/qME8A62tl4P2eCZPf+DJkCxEmgVKuvROO+wvbals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=su9oJQAZ; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 339F8600B5;
	Mon, 15 Jun 2026 00:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781476124;
	bh=+y0oMMzJ8dGenJ1y6ujNCOKYta4OAPczMAXEIb9g7zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=su9oJQAZAHHzjoP5TIpOvfhcDt9EjuD3+SizHqmsWtkE2Yw532y+27DPGDntzOCsz
	 DKILpuMP/TcePqDzXZ3S2Ue3vKCuZXAZCGUtI9Df9L7QWpYEzn4RyqZqi2E7HhKKMF
	 DGacrdOAN9BrvnITPKNXuaZervYcsr4xezHaFOgHw4C2kakoqNjigWlE6eZpECNYAE
	 UjHnGrF2onVdMqbAOD/epwl8FqIHZbWIzn7mmePWCjyMNIFD8mFrjCera3ZyqNeZ4L
	 PSTgw70wEZelUYum+Tz1L/9NO+C5Lrs89E44WdA7cFsQhjXB7NKIWIgR09ctlHH+vA
	 oH8TH8cTJIt2Q==
Date: Mon, 15 Jun 2026 00:28:41 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: XIAO WU <xiaowu.417@qq.com>
Cc: Mark Bundschuh <mkbund@amazon.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH 6.6.y] netfilter: ctnetlink: ensure safe access to master
 conntrack
Message-ID: <ai8rGfyUPgAe-eg_@chamomile>
References: <20260612202408.1045757-1-mkbund@amazon.com>
 <tencent_DFE6466C14D93204DE976442E459443CB807@qq.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_DFE6466C14D93204DE976442E459443CB807@qq.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiaowu.417@qq.com,m:mkbund@amazon.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13267-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BB3B6826A3

Hi,

On Sun, Jun 14, 2026 at 10:38:16PM +0800, XIAO WU wrote:
> Hi,
> 
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Holding reference on the expectation is not sufficient, the master
> > conntrack object can just go away, making exp->master invalid.
> >
> > [...]
> >
> > This patch goes for extending the nf_conntrack_expect_lock section
> > to address this issue for simplicity, in the cases that are described
> > below this is just slightly extending the lock section.
> 
> I tested this patch on 6.6.142-g005cf9204c4e with KASAN + lockdep
> enabled and found that the lock extension in ctnetlink_get_expect()
> and ctnetlink_del_expect() does address the expectation-lookup paths,
> but one other path still races:
> 
>   clean_from_lists()
>     nf_ct_remove_expectations()          // holds nf_conntrack_expect_lock
>       list_for_each_entry_safe(exp, ...)
>         nf_ct_remove_expect(exp)
>           del_timer(&exp->timeout)       // returns false if timer is
>                                          // already executing on another CPU
>           // expectation NOT unlinked
>   ...
>   nf_conntrack_free(ct)                  // master is freed
> 
>   // meanwhile, on another CPU:
>   nf_ct_expectation_timed_out()          // timer callback fires
>     nf_ct_unlink_expect_report(exp, ...) // acquires
> nf_conntrack_expect_lock
>       nf_ct_expect_event_report(...)
>         e = nf_ct_ecache_find(exp->master);  // UAF -- master already freed
> 
> nf_ct_remove_expect() already has the lockdep annotation added by this
> patch:
> 
> > +    lockdep_nfct_expect_lock_held();
> > +
> >      if (del_timer(&exp->timeout)) {
> >          nf_ct_unlink_expect(exp);
> >          nf_ct_expect_put(exp);
> 
> But holding the lock is not enough: del_timer() cannot cancel a timer
> that is already running on another CPU.  When it returns false, the
> expectation stays in the hash table, the master is freed immediately
> afterward, and the in-flight timer callback hits a dangling exp->master.
> 
> The same del_timer() pattern also exists in ctnetlink_del_expect(),
> which the patch already extends:
> 
> > +        spin_lock_bh(&nf_conntrack_expect_lock);
> > +
> >          /* bump usage count to 2 */
> >          exp = nf_ct_expect_find_get(info->net, &zone, &tuple);
> > [...]
> >          /* after list removal, usage count == 1 */
> > -        spin_lock_bh(&nf_conntrack_expect_lock);
> >          if (del_timer(&exp->timeout)) {
> >              nf_ct_unlink_expect_report(exp, NETLINK_CB(skb).portid,
> >                             nlmsg_report(info->nlh));
> 
> This del_timer() call has the same vulnerability -- just holding the
> lock doesn't prevent the timer from executing concurrently before the
> lock was acquired.  The timer callback will spin-wait for the lock,
> acquire it after ctnetlink_del_expect() drops it, and then access the
> now-freed (or about-to-be-freed) master.

Thanks for your report.

I started a patch to replace the existing expectation timers by GC
workqueue to address this issue.

