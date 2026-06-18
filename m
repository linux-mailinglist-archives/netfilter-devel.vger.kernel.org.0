Return-Path: <netfilter-devel+bounces-13323-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KfyEH8XUM2rsGwYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13323-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 13:21:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88269FB7A
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 13:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=p6BAlZlL;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13323-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13323-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC3943036738
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F83B42E5;
	Thu, 18 Jun 2026 11:21:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005422E7362
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 11:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781699; cv=none; b=k0AcfoHPnmxti+w6TX178Q+nu/Pr2dU3muKbR/noxw9D+mvljf/oe8Bh2az9nutMaBxhaN4bzq0WVtukWIpM/FjmefNpEXpi5YILgCMTWlmEW3yETJN9koJVHYpq2OGT9cg7sMeQGYzG0xVwHt3LuO7CrGYgyB+ym0f1oUdGxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781699; c=relaxed/simple;
	bh=HScNzBW22fj2FvtbJ10gpqehTqeMjNltIZgbfQVa9U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKyLFtT8SsWm/mukSeVeJu7NCKMT/xUcJDB4RkfYcOKDLF2BHsCggnlhzxui6McuFqywWB/kRhO29HCx9EpazpE5EsO35J/CBpypKgdOgKDGHrygMc8qPZnUGtZ1mi0nt06as4VyVJLvbt516Q9Uemj3ltQDkgzw0g8PFwBTln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=p6BAlZlL; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OVFkkM/GruT6vmSClbx/FeGj2QI5dOKtceL3B1X5GpY=; b=p6BAlZlLHbAikTwoXpPriDhbTX
	yJXNaMnCZ8sakyq+8yIr9eKzdEBFFwZjmp9A6Hde/ebH+9tiNHUancVvhoORX76co8XB2okUr8gjs
	hrm6li/4Y5gRYpRZVJKcHc94KpE5vb4dgOXmrL7ghyoX5x2UvsTSaLRTdqMdOKbaw/6TnUsAnKjmw
	4+LKwOq4nn6v5SLnvw5nwEESmuMowFX7pEyJlP8E+BvagRzgpsknQ6p6byeFt5geNMwChJgw5S6VE
	qg+Fvo1a/EXqcp+O+RWgnbHkH8/tXlXsdKWRM+NdgupQrHNL1Q7gNh8lBxlbMH/zi9MNLqu9ukaMe
	ebY0Q/XQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1waAoS-0000000033H-1uLR;
	Thu, 18 Jun 2026 13:21:36 +0200
Date: Thu, 18 Jun 2026 13:21:36 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests: shell: Run tests with a fixed TZ
Message-ID: <ajPUwKZ2ZGqaff2A@orbyte.nwl.cc>
References: <20260618111743.3001357-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618111743.3001357-1-phil@nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13323-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nwl.cc:from_mime,nwl.cc:email,orbyte.nwl.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF88269FB7A

On Thu, Jun 18, 2026 at 01:17:43PM +0200, Phil Sutter wrote:
> Inheriting the system's local TZ is problematic with meta time/hour
> expressions in dumps. Use UTC-2 since that matches what py test suite is
> using.
> 
> While at it, fix up the first two dumps containing such expressions.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Applied.

