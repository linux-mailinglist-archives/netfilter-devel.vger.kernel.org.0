Return-Path: <netfilter-devel+bounces-13549-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M0x9HWDRQ2opjQoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13549-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 16:23:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E56E5632
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 16:23:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=f5HKDHn9;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13549-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13549-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23B1F30B9CAB
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375C425CF7;
	Tue, 30 Jun 2026 14:21:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D3425CD9
	for <netfilter-devel@vger.kernel.org>; Tue, 30 Jun 2026 14:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829261; cv=none; b=VmvP8wQ8vucLq8z8GOeBppDXSw2wv6dhQCsJ40HZ2oK96Zv4Yw4b/OP9QaVTyCRDHSYrYOPd+LFsKODecZNiKmNW60Y7FG8d5UkbECPNUNXRK5+23o/cgCMlGMVrvvnhxMzsWLrXbso/hARfpPzkV/amlkuJmFyxVPbIGKg0kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829261; c=relaxed/simple;
	bh=I1DU033bxIGKzOjn7IMoeuviasisvZ2UOun0UxXAZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN8EkPWRpP76+ukqsknVgIe6+hbvB6rV7El2Ao0c+JnUUkkUO6mWWS3CzmMh+gXTyWomRlCp66FD4cSwksAz6AIbG7MDcsrIaZiJHyTvQpWpVm1DjSNSZkiASU0qbj4k7ZW8lAggERkH6GSvQrQYu2DdVaV1ErZCNiwvhXe6LWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=f5HKDHn9; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 6A9F76058B;
	Tue, 30 Jun 2026 16:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782829256;
	bh=Kek63HMsceeGd2JQEljcZ/Y3kbZewHt/SDPvyBJDwfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5HKDHn9lVLbCJOqSK0amZCFbr4z9P/3uuNGn/a9GUQ9vcDWQLqAo8zleKk1TDlvV
	 psY5wLbnIfPBaTu6UNbpTn5HCJswlq1p5yyi5R4gITWBuT0o3SSeazTdW1lI1C4WzM
	 UuWZQu0CzaH7vtPRY8xyNeXUg/G9NHngQbNgh9UjP16EtZdoIcQ/CBInPob+VQud/B
	 nWqDXGTr4lBshFVzL3sW08FjDSuR9QLlzcby9Ui56DMbDtKG9WwQdhnkRWaGshGcom
	 8CWNtl3daH/2OVhZqHwoAWaheEGmvgt6iSErC7kEvhENfxGHxzwcAKeWzTQJi4XILq
	 CllvodCqVtCag==
Date: Tue, 30 Jun 2026 16:20:53 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: nft_ct: support expectation
 creation for natted flows
Message-ID: <akPQxd6Hqu96EUw9@chamomile>
References: <20260630060311.2504-1-fw@strlen.de>
 <akOVqk9WOTpIKCss@chamomile>
 <akOitclorHvJsREK@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akOitclorHvJsREK@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
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
	TAGGED_FROM(0.00)[bounces-13549-lists,netfilter-devel=lfdr.de];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:email,netfilter.org:from_mime,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E65E56E5632

On Tue, Jun 30, 2026 at 01:04:42PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > +#if IS_ENABLED(CONFIG_NF_NAT)
> > > +	nf_ct_expect_iterate_destroy(expect_iter_nat, NULL);
> > > +	synchronize_rcu();
> > > +#endif
> > 
> > Not sure sashiko is signalling a real issue here.
> 
> I could use the nf_nat_helper_register/unregister interface which would
> support dump/restore via ctnetlink / conntrackd. 
> Not sure its worth it.
> 
> This isn't using nat-follow-master directly to avoid a module dependency
> on the nat core.
> 
> > static void __exit nf_nat_cleanup(void) 
> > {
> >         struct nf_nat_proto_clean clean = {}; 
> >             
> >         nf_ct_iterate_destroy(nf_nat_proto_clean, &clean);
> > 
> > all NATted master conntracks are destroyed here, including their
> > expectations, which might have the expectations using
> > nat_follow_master.
> 
> Yes, but users can remove nft_ct and leave nf nat core loaded,
> so above function won't run.  The expect_iter_nat cb will zap
> expectations that are still in the table that point to the
> internal expectfn (i.e. into the module thats going away).

Right.

> The alternative to the manual nf_ct_iterate_destroy() is to use
> nf_ct_helper_expectfn_destroy() and a real struct nf_ct_helper_expectfn.

For the scenario you describe, I think it should be possible to
register a dummy helper for this expectation type, with a NULL
callback. Helper unregistration should deal with removing the pending
expectations that are left behind on module removal.

By adding this dummy helper, this special type of expectations gets
aligned with the existing helpers.

I can take a look if you busy with something else, let me know.

Thanks Florian.

> > And nf_nat_cleanup() can only be called if all there is no more nat
> > chains in place, correct?
> 
> Yes, but I don't think thats related to the sashiko comment at
> https://sashiko.dev/#/patchset/20260630060311.2504-1-fw%40strlen.de

