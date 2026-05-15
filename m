Return-Path: <netfilter-devel+bounces-12616-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KnQDjlnBmrOjQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12616-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 02:22:17 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB114547F6C
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 02:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58D503026F1F
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 00:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E83248F57;
	Fri, 15 May 2026 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="KL7OuS7h"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E812248B3
	for <netfilter-devel@vger.kernel.org>; Fri, 15 May 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804484; cv=none; b=ZxGEowYwKqRBKggQuCUnUoiuJAc/TiiziA8ske3qxwu9MXeGKleMEgD2VJmxQepXTbEuY3R4CCxgiaYV63uLW1OaBL/K5/voX4Sh0ZYc42y6u+Rk69ANf2O7YjJmCEIO/UN32gjZU1FEiujVX0ih9Qq0PUmRW93/GeaYpmBeaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804484; c=relaxed/simple;
	bh=byjtG+ZSQ8h4qoBR7s4vkZe1QcJIZ05swQp6ddgU1NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/wbws12UwSXKkHlpKGaLc3jE58TPr3jbd2VUvu4Bs3aWhLsGhnWfHvy4kA84ubBcYPnSMRlPywJJR3z6lU0nSWdZVeW2sVpCrM0P2jCd1x33JzPTk48UDgMiC7j686KhrEzI/9it7kmum10MuVa2O00jCPn3G9ot5foj5+Msqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KL7OuS7h; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 253C66019F;
	Fri, 15 May 2026 02:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778804479;
	bh=wiOWg5glLdNXTUGGVQlfvXgP+PcllrGNMTPa9vHsGE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KL7OuS7hTGo8O2nc7QZYWOj22tPvSIk6N3VqOuuVbxwredDm9/JYJh/5v2uWqBNDS
	 hDQBPGVVT7Zu/Y7Ck5N4AnpCdVlkP59kyxEwTUi3qow+zO5T7DCmlbJ50sWpoF4JL0
	 rX7Hb0yMZxoAtLfJpMhu+qtqGINbNpd6VFcb45h4vN+bkoZVjcC7wxgs0DsvJb0v8E
	 1q/ykvqJAxuyUyf00k9bxY+MbCeZT0Xm7p1gsL7PAXCCIDs/D40nXYGus7fU/GrxgR
	 vittxpOFjtMvhxqzJB3YTHKTFG66xFRg35U1/iNnU4JlJfZN+VeZ1mVi4rxg6wCoO0
	 gZIbdHX9DbPnA==
Date: Fri, 15 May 2026 02:21:16 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2] netfilter: conntrack: add dead flag to helpers
Message-ID: <agZm_JyKhSFOrV94@chamomile>
References: <20260514143016.874811-1-pablo@netfilter.org>
 <agXfhQb8Dcl9p5ce@strlen.de>
 <agXl-3NDpK3YUZiF@chamomile>
 <agXt-m9yN-oayY1G@strlen.de>
 <agZbFvp_KgGUr2Kw@chamomile>
 <agZg3JjBx6xXyEnW@strlen.de>
 <agZkiu4q1Ln9ImR4@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agZkiu4q1Ln9ImR4@chamomile>
X-Rspamd-Queue-Id: DB114547F6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-12616-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:10:53AM +0200, Pablo Neira Ayuso wrote:
> On Fri, May 15, 2026 at 01:55:08AM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > The seqcnt can be pernet and it can be restricted to nfnetlink_queue.
> > > > 
> > > > Any better idea?
> > > 
> > > Maybe add a helper_id which is set at helper registration time. Then
> > > nf_conn_help stores this helper_id field.  Unconfirmed conntrack on
> > > reinject use this helper_id to re-lookup the helper when reinjecting.
> > > This would force a slow path for unconfirmed conntracks, to
> > > re-validate if the helper is still there.
> > > 
> > > cttimeout would need this too, a lookup to check if the timeout policy
> > > is still around.
> > 
> > Hmm, maybe just re-use the nf_conntrack_ext_genid for this?
> > I think this unreg/rmmod isn't so frequent.
> 
> nf_ct_iterate_destroy() is called for both cthelper/cttimeout, which
> already bumps nf_conntrack_ext_genid.
> 
> Simply add the check from nf_reinject() path then?

If the module reference grab does not work, maybe add:
 
        if (unlikely(nf_conntrack_ext_genid() != ext->id)
                return NULL;
 
to nfct_help() and nfct_timeout()? So access to these ct extension
area is always validated before hand?

> > Another alternative would be to give up on this design completely
> > and just grab module references :-)
> 
> But that would not be enough for userspace ct helpers, right?

