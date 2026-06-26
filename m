Return-Path: <netfilter-devel+bounces-13483-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7pb4JaVrPmo0FwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13483-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 14:08:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 892396CCD0A
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 14:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13483-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13483-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB643307A4D8
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E43806D6;
	Fri, 26 Jun 2026 11:58:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1A2E7368
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jun 2026 11:58:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475134; cv=none; b=ERtmWYrl5qe08mZ8dFoSGosMkQyKOkMU5PdnflgH3BnN1A+3fAPt607EecbyR6444JVoibf8Efb6NXvVgszkVXS/uCL++1DVmNa6yun9svi8712EoeD/6DIi2v3yxh+xOjIK+74JKrYFhEfoF1U7m8ybOxpJ7FRDR6g2ip2qgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475134; c=relaxed/simple;
	bh=kxC7Zwj7WPiFdyPhDOi28ejhrTVCprouGIlBTwaNJ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDYaE1PihOKl5AaVWbvi605DyfCuPAjCB9+2Utr4yrULHrV/iLZYGAutC5W96GgjKz3HN7lr1U0uEXWVSbFKXTkdzkj76OKoXgNYD8Rye2/9iAbmfkkzRBXKy3CxpiOjplJnvFDclWEo1QMTmejQGuNqcoVMBx2FZ9UsCSuRCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E0D5660299; Fri, 26 Jun 2026 13:58:43 +0200 (CEST)
Date: Fri, 26 Jun 2026 13:58:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_conntrack_expect: zero at allocation
 time
Message-ID: <aj5pc-9CKwnuG5iE@strlen.de>
References: <20260625001356.16478-1-fw@strlen.de>
 <aj5h9eFJE1glpYfz@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj5h9eFJE1glpYfz@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13483-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 892396CCD0A

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Thu, Jun 25, 2026 at 02:13:53AM +0200, Florian Westphal wrote:
> > There are occasional LLM hints wrt. leaking uninitialized data to
> > userspace via ctnetlink.  Just zero at allocation time, expectations are
> > not frequently used these days.
> 
> Fine with me. IIRC hints came because of real issue, ie. paths where
> I was missing to initial something.


> > @@ -389,6 +389,7 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
> >  #if IS_ENABLED(CONFIG_NF_NAT)
> >  	memset(&exp->saved_addr, 0, sizeof(exp->saved_addr));
> >  	memset(&exp->saved_proto, 0, sizeof(exp->saved_proto));
> > +	exp->dir = 0;
> 
> Hm. But now area is expect is zeroed, right?
> 
> Maybe nf_ct_expect_init() needs to be updated to remove needless
> zeroing too?

See:
> > Intentionally keeps _init as-is because we could theoretically support
> > re-init, so add the missing exp->dir there.

If you say we are guaranteed to always have:

exp = nf_ct_expect_alloc(ct);
nf_ct_expect_init(exp)

then we could remove it.  But then I'd question why we even have this
alloc / init split and not:

exp = nf_ct_expect_new(rtp_exp, NF_CT_EXPECT_CLASS_DEFAULT, nf_ct_l3num(ct),
                       &ct->tuplehash[!dir].tuple.src.u3,
                       &ct->tuplehash[!dir].tuple.dst.u3,
                       IPPROTO_UDP, NULL, &rtp_port);

