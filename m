Return-Path: <netfilter-devel+bounces-12582-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BZRLXCjBGogMQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12582-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 18:14:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D2536DE9
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 18:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47D963047764
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD03B583D;
	Wed, 13 May 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="iqWnmOyU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE9391E7C
	for <netfilter-devel@vger.kernel.org>; Wed, 13 May 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687550; cv=none; b=TzHlI4jXJcMGkYcyaWqaxT84s3OmLyGMT3wS5stlv3q4npeo5RZYwUhDlnxe7PHVZucnC5S1jBgQ1fy7DN8/4BR+asaRVVb2i/K/xk53K1B/bmXYHp/L6wGeZdPjRklx9dav9Cm3yzcw1MnFGy4mrESLEtZ/7IcwV29npFJ/njQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687550; c=relaxed/simple;
	bh=OXRVSBntJaY4dNcBDStfk+26qUYAt9IpzLS01HrBe3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvsHf7tEvuKPIgX49UUuyOg6WDwlQ/ry9b0cuoz0wtDnCEmWe4HXhdl3iYizJTpW6TzSFi2KodtIFhZHYRA74HmAnsdwo9FkyBplg7571hLJMZP5KBy++Mw5AiUudlHFBlRxEOFK2sLiq8mdfnt6ZFUvhHwQbz9EeoafDj00ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iqWnmOyU; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id D0B8C601B0;
	Wed, 13 May 2026 17:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778687546;
	bh=Qoy5zlYo7xePVugMRKri7PL+vvuS3HtkruiXkfIUOvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqWnmOyUsyqyIsliv1Nea3hbuASS8UJBr9wAZuUxzu8KKD3vrF4EnNJU0qfDKl7fS
	 EIRIwb2ASqgeSo+2BXFPfNRG9wZm8K+sdGOQqN7+OJBNsFdVqGRFeOvn0wsWhnHqdf
	 +P+oB10Oh2G8Ky5D7ucFhIYC37QXi+da+c76toY8PdBPZfTzwaUgD3oG+INK2wzt+e
	 lC5eDLyUBVdfSsyJVn30QWlZ3HSk6u3lAqwrH3jTzmfPuq4irbaK3pjEoTSBEcWZHF
	 Iu9PFX97+vca/SkQai3lQ/7CQSwCp1fcbAwQJGtVHVuF/TCPBbGm0bqycerMDglYs6
	 fSXY1NmNHt/iA==
Date: Wed, 13 May 2026 17:52:24 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: add dead flag to helpers
Message-ID: <agSeOKr6DNf2CU3y@chamomile>
References: <20260512205823.803476-1-pablo@netfilter.org>
 <agRMzvHgYCblnbrO@strlen.de>
 <agSY1PyVKRhf4zDc@chamomile>
 <agSbAFn3wN-sU6uV@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agSbAFn3wN-sU6uV@chamomile>
X-Rspamd-Queue-Id: 1E7D2536DE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-12582-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 05:38:43PM +0200, Pablo Neira Ayuso wrote:
> On Wed, May 13, 2026 at 05:29:27PM +0200, Pablo Neira Ayuso wrote:
> > On Wed, May 13, 2026 at 12:05:02PM +0200, Florian Westphal wrote:
[...]
> > > 3. synchronize_rcu() -> all skbs that had this helper have
> > >    left RCU protection
> > > 4. nf_ct_expect_iterate_destroy() removes all not-yet-found
> > >    exp entries from table
> > > 5. nf_ct_iterate_destroy() -> clear exp from nf_conn's that are
> > >    *in conntrack table*
> > > 
> > > That still means we could have a NEW conntrack queued via nfqueue.
> > > I think we also need to toss nfqueued packets after step 3) and
> > > need to refuse queueing to userspace if the flag is set (-> drop).
> > 
> > Those conntrack entries would now have help->helper == NULL because of
> > the unhelp call.
> 
> Oh, wait, _NEW_ conntracks are unreachable, so yes, that can happen.
> 
> Tossing nfqueued packets here is convenient when helper goes away.

Hm, but nf_ct_iterate_destroy() already deals with unconfirmed conntrack.

