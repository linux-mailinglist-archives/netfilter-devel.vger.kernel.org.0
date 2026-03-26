Return-Path: <netfilter-devel+bounces-11455-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM1SMLpIxWkU8wQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11455-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 15:54:50 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 565F33371B2
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 15:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E5E300D44D
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F637F740;
	Thu, 26 Mar 2026 14:46:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD937C0F2
	for <netfilter-devel@vger.kernel.org>; Thu, 26 Mar 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536418; cv=none; b=DHyWTXEVmB2pstSL89Uk0UjKXmKsS0x9o64GEVAI54TjiTlAGOc9n7gRZZCTsuN1G/JZYIRplr6WYdU5Nm3TVOWfS4thdkeAZvteimKe3myOzTn5dNgQPOMIF640mGE9Ou/Mkp58HmQ0txrrFkgKcxCLEKfSz89vjRHGjzOiMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536418; c=relaxed/simple;
	bh=COFoneHZFvbC0AyE7OLl+QiItRNCVIvT0WlZje+vp0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaIPPXao9LsUr7cL9o8KmFskaJo6IwmjWquHsE0FQhfWD79Z3REKTxFeMjZo0VwQSnoLXlAvSUEyI6kmT4yHUGXmOeaFRt50eZXSoABZdPaKCkyMKUZhFIwSoqcmbFYfmb+yFWI9RnhajaiwwtTS6juTby1HwFX6j99hEpy9NhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B195B608BD; Thu, 26 Mar 2026 15:46:54 +0100 (CET)
Date: Thu, 26 Mar 2026 15:46:34 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net,v3 00/12] Netfilter for net
Message-ID: <acVGyl-UKiUQShXH@strlen.de>
References: <20260326125153.685915-1-pablo@netfilter.org>
 <acUxw826gEzIv8Zp@strlen.de>
 <acVGWE6APd2itKyu@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVGWE6APd2itKyu@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
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
	TAGGED_FROM(0.00)[bounces-11455-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 565F33371B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > If anything, we should also consider this (not even compile tested):
> 
> This chunk below looks easier to understand.
> 
> The issue can only happen from nft_compat, correct?

I don't think so.  I think you can request any module that
registers for NFPROTO_UNSPEC from arptables, which, unlike
bridge, doesn't have compatible hook flags.

So we need the existing patch (or a variant of it) in any case.

