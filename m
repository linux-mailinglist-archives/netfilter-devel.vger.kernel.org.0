Return-Path: <netfilter-devel+bounces-12624-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF3nHecXB2qQrgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12624-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 14:56:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A940554FFE5
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 14:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC17530FCF11
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 May 2026 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE33AC0E4;
	Fri, 15 May 2026 12:26:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E33A1681
	for <netfilter-devel@vger.kernel.org>; Fri, 15 May 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848001; cv=none; b=SsjwYm6n+9j8gUvGhGBp6tqLGIMIS0Mc9PQdOOs2jvwqLZGeVbsf0BYYpqsG5RSrjuy6wxtdQDH0pBUDA+CkpWOtDwezc1romQOyc2QWCx8wfkF6fIYqV2pUYZXPie9jQyoSripGecDWq3I4/CW187lfk1zJN9HrWw9S4yVR1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848001; c=relaxed/simple;
	bh=geIHtmr4VBKMNYlR3hh7ZZELKr7UUUcifzwhV5eFboE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnYXij+sthU0LFv1KZcAHyEba2CXIc1pMQqX/GVXZiXm8dfU/5AgyBygC3jEMKVPJcYqH/L4ZJLv/LoZhQ96DgrF3WPZKbf4icjwX48eKILvVjD9EzBRC4Yr3bwnmFdXQA0QrmFgVZoCnsxDcZ+n1W+nKyUKHtLX8P7/ODHX9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A9C166084A; Fri, 15 May 2026 14:26:37 +0200 (CEST)
Date: Fri, 15 May 2026 14:26:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2] netfilter: conntrack: add dead flag to helpers
Message-ID: <agcQ90JCmlkojf6s@strlen.de>
References: <20260514143016.874811-1-pablo@netfilter.org>
 <agXfhQb8Dcl9p5ce@strlen.de>
 <agXl-3NDpK3YUZiF@chamomile>
 <agXt-m9yN-oayY1G@strlen.de>
 <agZbFvp_KgGUr2Kw@chamomile>
 <agZg3JjBx6xXyEnW@strlen.de>
 <agZkiu4q1Ln9ImR4@chamomile>
 <agZm_JyKhSFOrV94@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agZm_JyKhSFOrV94@chamomile>
X-Rspamd-Queue-Id: A940554FFE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12624-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> If the module reference grab does not work, maybe add:
>  
>         if (unlikely(nf_conntrack_ext_genid() != ext->id)
>                 return NULL;
>  
> to nfct_help() and nfct_timeout()? So access to these ct extension
> area is always validated before hand?
> 
> > > Another alternative would be to give up on this design completely
> > > and just grab module references :-)
> > 
> > But that would not be enough for userspace ct helpers, right?

This is a mess:

https://sashiko.dev/#/patchset/20260515103501.18669-1-fw%40strlen.de

No idea how to fix this yet.  Is it ok to disable cross-helper-attach
via ctnetlink?  I don't see a way to validate nfct_help_data().

Proposal: Get rid of data[] and nfct_help_data().  Explicit structure,
explicit helpers (e.g. nfct_help_data_sip(), type enum in nf_conn_help.

Callers must handle NULL return value everywhere (wrong helper type,
helper invalidated, etc).

unhelp will have to be changed to invoke the helper
destructor as well:

static int unhelp(struct nf_conn *ct, void *me)
{
        struct nf_conn_help *help = nfct_help(ct);

        if (help && rcu_dereference_raw(help->helper) == me) {
                nf_conntrack_event(IPCT_HELPER, ct);
                RCU_INIT_POINTER(help->helper, NULL);
        }

This can't be right, we lose the ->destroy() CB?

Ideally we could get rid of ->destroy, but that would require
permanent removal of pptp.

