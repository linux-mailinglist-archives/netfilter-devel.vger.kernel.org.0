Return-Path: <netfilter-devel+bounces-13130-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JxFnADY2J2p/tQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13130-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 23:37:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062B65AB32
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 23:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=MRPvNEZE;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13130-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13130-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B77300CBC6
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0D3AEF59;
	Mon,  8 Jun 2026 21:36:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B139E9D5
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2026 21:36:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954610; cv=none; b=cPQ1wD/xjHyL9WbM4IcKkeHKp/HLTDjcWjcx3+cROP4dMLuEtFbRCzE0buZZucw+/MoHEzQh1vPPX0L6n2N8pOKxShGIQptqUJqDVSq3+13RO7uM+be16qAVz/ITaeBTLM4VUsnQHs5R1LPNzlLeVpeMC5O66JHvQwXl+X+t1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954610; c=relaxed/simple;
	bh=ifPlikER/a9tdzGFgsssFDIP1wHLdthQ2ZhC/TUrs/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn/b2x9zCcW/3xoqFt4Bn8iIMjZ7TCePF4vkoRI8AqRptdT1ctnsEpUxv6KvinSAUNlIOWVjtUcutgOQxFBgBdyj06zRwJeH0XBs63wrpZoTXcskNVyc0Dk7+tDmnAzc0j0FGSM+2iNkefe7+oM6h1SYaHxvXtRdHHyYBMvz7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=MRPvNEZE; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id B4E6660181;
	Mon,  8 Jun 2026 23:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780954607;
	bh=TQypTEqc0+m7yV9EhZMqG5bA2PrG1mAXiQO6LxvyoOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRPvNEZE3nBwLpRNQGdRkkoMRWH08kKIZ4yk0jKgwy0E4xECRWK3LbKOTvfKkEEec
	 BmTD6W8L8RGu1wnxvKrP5nf7Ug9aTeodypOfpsh8EfHNuIw7nbJic6snHe0y4O9b8o
	 So8diSIAjIEnSrAlJXCCH5UncHIkReKX+YgmonUbcXL8AUoMQcM5tk7nw/YBSbjSu1
	 7XXFmHi/cFS5tJZ2awr2+/O/nggtyX8r0jhQ+nA3pijIQLQFjNzAGq5iMf/tpahRH2
	 oiN53PLrnQC5MRFSufj2yPBCJSBYz0uUMbwv2IF8aldT502QDa+IK0+5PbTSk/tbnb
	 0sMQ6X5rIoRhg==
Date: Mon, 8 Jun 2026 23:36:45 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: conntrack: check NULL when calling
 nf_ct_ext_find()
Message-ID: <aic17bHQFhPshKlH@chamomile>
References: <20260608212120.68828-1-pablo@netfilter.org>
 <aiczgrv5J-m-7jo8@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiczgrv5J-m-7jo8@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13130-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:email,netfilter.org:from_mime,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5062B65AB32

On Mon, Jun 08, 2026 at 11:26:29PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > nf_ct_ext_find() might return NULL since ct extensions may be declared
> > stale because of object dependencies or modules that are going away.
> > 
> > When helper is removed, nf_ct_iterate_destroy() unhelps the conntrack
> > entries. Then, the nf_ct_ext_find() might return NULL if the extension
> > is stale for unconfirmed conntracks if the genid validation fails.
> > 
> > Add the null check to:
> > 
> > - nfct_help()
> > - nfct_help_data()
> > - nfct_seqadj()
> > 
> > that call this function since packet path could be walking over helper
> > while it is being removed.
> > 
> > While at it, fetch ct helper area in nf_ct_expect_related_report() only
> > once and pass it on to other ancilliary functions. Replace WARN_ON()
> > by WARN_ON_ONCE() in nf_ct_unlink_expect_report().
> > 
> > Fixes: c56716c69ce1 ("netfilter: extensions: introduce extension genid count")
> 
> I'm not sure this tag is correct.
> 
> The genid checks are only for unconfirmed entries, not in hash.
> 
> nfct_help() and nfct_help_data() can return NULL as you say, but
> I don't see how this relates to the above commit either.
> 
> That said, I agree with the patch.

No problem, I will remove the tag.

