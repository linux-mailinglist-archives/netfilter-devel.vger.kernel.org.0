Return-Path: <netfilter-devel+bounces-11251-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCHeELWbuWlzLAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11251-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Mar 2026 19:21:41 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E402B0D89
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Mar 2026 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D979A3006B51
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Mar 2026 18:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E672137C0F0;
	Tue, 17 Mar 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="PU7+Cn9d"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EF37F73E
	for <netfilter-devel@vger.kernel.org>; Tue, 17 Mar 2026 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771643; cv=none; b=bSMHI0zRbvCatlLKuQJwBsYjPshNoPNggVyJUnwWW2IOFhJc4OVtcCTNJiv7xMGp4RmRX4c4WQPTdB7MJpu8+7zo5No49BCaePylv4OE/m56053y7jFLyV62ot1zorKXLyM3WfnGdPqqLzXrG7mvnbD6f5I9SWog/4z+2d2G8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771643; c=relaxed/simple;
	bh=7tk0b9XslUT1TBOdfPaJM7yBjiBu6+sf/e5KL6Z55cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt5YhYo5BonffXzYAcoFO6JC4Ta24DsyqEQIYGBZeIas6dipZjiXezdKlI9VgcqN0/MfvD7jewQbj/rM7ygjHE2dXarWv5pmxDSWGdYGURGfqCDNcutiqfeWtG9+HqhRCsYHuBiCgQ4u6ivWOMd3cA7W/XpfRhXPxiclwMK5nrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=PU7+Cn9d; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 23E2660181;
	Tue, 17 Mar 2026 19:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773771640;
	bh=HiDMoXVPTtnjIAXOdLZfyLPRE3SeM8nw4lZaHb0Oc8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PU7+Cn9dT06an4nZUk75ZlmQMSZhtf5mEAwnobZjHM5zpH/PBLYKFqAgh5j9FTA99
	 bzT7Ux5VRwtomNiozaryMTETPL4+nIBI6EaTLP7Xr9sSBWzGfDMcqEJKl2rXXk30sM
	 E3Ifbr3a6VYcjH2l9RFZ/T5gbcd+25IQ3a1Zr2MDxXb/kUX2+PL+aewnrveS62UQib
	 sC2otTyShxxKrQYOnJsGarPT8GQ5k46UfbIV4uisD8TZwMuC7HB+H0HIbCexT9rQy5
	 jVqbv2PGsioX07P+LVSBQcdTjW5BZnyTuiCILPBF9MIlUqv6VefAqSCF+26elwR3+Y
	 m2fWs5/PC2gLw==
Date: Tue, 17 Mar 2026 19:20:37 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: mingqian591@gmail.com
Subject: Re: [PATCH nf] netfilter: nf_tables: release flowtable after rcu
 grace period on error
Message-ID: <abmbdQX2u-837rpj@chamomile>
References: <20260317175952.26821-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317175952.26821-1-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-11251-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_CC(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 01E402B0D89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 06:59:52PM +0100, Pablo Neira Ayuso wrote:
> Use kfree_rcu() to release flowtable from error path, since a hook that
> already refers to this flowtable can be already registered, exposing
> this flowtable to packet path and nfnetlink_hook control plane.
> 
> Uncovered by KASAN reported as use-after-free from nfnetlink_hook path
> when dumping hooks.
> 
> The number of flowtable objects in a ruleset are expected to be small,
> the increment is memory consumption should be negligible. In older
> kernels, users could mistype device names leading to this error path,
> I prefer struct rcu_head here instead of explicit synchronize_rcu()
> call.

Scratch this, I will post v2, flowtable->name is also released
inmediately, this needs to happen after rcu grace period.

