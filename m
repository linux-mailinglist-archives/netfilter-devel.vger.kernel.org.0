Return-Path: <netfilter-devel+bounces-12437-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFx/MJzY+WmbEgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12437-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 13:46:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEC64CCE86
	for <lists+netfilter-devel@lfdr.de>; Tue, 05 May 2026 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7794B301B725
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 May 2026 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A137CD54;
	Tue,  5 May 2026 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="d55KOQ3O"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810230BB9B;
	Tue,  5 May 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980381; cv=none; b=HjVVix1xUTDzL7t9PHNQpqQOTwGnI6CZ8gINS8gIctBo7CzaKEhjtYfHGLfo0v3PSOfahxCW9o11W/8IYWFmgRSryYdmqLOKRBF3h3Kc9t4VX8aKsx2NQnv96K/RDAQIom2tIHCygCPvI2HD7UwU5dDwOA5z3CjSc+G4qZxXZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980381; c=relaxed/simple;
	bh=7S++6Oo8IYHQj13p7VGvjwzDLo+jg4mVRckTeoWDV6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFqWDCBFkAdh1L8Pu8zRiaLmMmJtk1BoeT7pP9fkTzkMhmpSOqJxtRjQP/yOrCJUD6l9yp6sbYCv5Ap3vqGJOEEMEyHiJPkusB92y7f5dhv6tvAmc1UL7eFlYuR6weCqq9vi2qOqHDbo7PvkoItwHVHBbNih7ec25bK7QIQToYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=d55KOQ3O; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0DF7C6017D;
	Tue,  5 May 2026 13:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777980372;
	bh=d2kwW7LYC0W+s6fmEBCRY95qolowGS4KQhIuL3oG/hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d55KOQ3OUyvokrRygwFKWRRGPoj9VzIHUV7/iZnNaMyIywwG7vM1x50On/2kxoZUA
	 jwafBubsnwiApU0PIn5vCEEIea4zhKyE0juPXWseiNZZ3xEWgjR3BqE98KYSJoaqQx
	 ljw/gNHP1/UpUkQJSoKiM8ih/zpbPgLK40tYYgKlZet7ba2mbBOu4DnztP2ioA82g5
	 DPIRulGzxVwEihEcS6tS5lLNExLW/aGAPLY5kwgfzQLsAINI3sQa0pa0wWOKzSgrnd
	 izO/illdy4+uRNcqeO4khN8mjmig13AcmRXyFTqovYRL/fzIKLD+mDyPeBtRJFJgsW
	 j3ghrU7htqifA==
Date: Tue, 5 May 2026 13:26:09 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net 06/12] netfilter: nf_conntrack_expect: honor
 expectation helper field
Message-ID: <afnT0Qtuap35mpCX@chamomile>
References: <20260326125153.685915-1-pablo@netfilter.org>
 <20260326125153.685915-7-pablo@netfilter.org>
 <8fd5d3a3-d1d7-4542-a0db-1678989940d4@ovn.org>
 <afSCXEg-X-ieL9cY@chamomile>
 <ef01005e-d867-4936-b138-b98f37e5f394@ovn.org>
 <afkosr2fDEPA_jX9@chamomile>
 <afkuhbWieFXRTirN@chamomile>
 <f0557cdd-738b-4d19-969d-94310b553d0b@ovn.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0557cdd-738b-4d19-969d-94310b553d0b@ovn.org>
X-Rspamd-Queue-Id: 1DEC64CCE86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12437-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim]

On Tue, May 05, 2026 at 01:01:22PM +0200, Ilya Maximets wrote:
> On 5/5/26 1:40 AM, Pablo Neira Ayuso wrote:
> > On Tue, May 05, 2026 at 01:16:05AM +0200, Pablo Neira Ayuso wrote:
> >> Thanks for the detailed report. It seems I changed the semantics of
> >> exp->helper, this used to be use to set a new helper for an expected
> >> connection, which is the case for sip and h323.
> >>
> >> Would this patch help address the issue you are observing?
> > 
> > Actually, this needs to set to NULL the new exp->assign_helper field,
> > see new patch, untested.
> 
> I ran this through OVS system tests and all passed.  So, this restores
> the old behavior, at least for FTP (we do not support sip/h323).  For
> that part:
> 
> Tested-by: Ilya Maximets <i.maximets@ovn.org>

Thanks! I will be posting a format patch asap, I will keep you on Cc.

