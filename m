Return-Path: <netfilter-devel+bounces-10660-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGEmH+lyhGnI2wMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10660-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 11:37:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 46577F165E
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06392300AB0A
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272473A784A;
	Thu,  5 Feb 2026 10:37:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1B2E03EA
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287842; cv=none; b=PNRqovMfIQ04TRP/mDXMbsanB/6VJzP9U6UrA9AH5KnKC4xJpyQp47SGv7SW+Lrie1I4utGwY/Ksl+jteqPri59Z3aEEUhlyLb7b3pMgtAV/grrViiAHXTDg7EpR0le1lt+TohtTY2L9FMXzknDROBSTt8ztkCtajGagLQMiV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287842; c=relaxed/simple;
	bh=g/H9e+MWNXCMMFLUwkMgHJ1O4UnXFXt15XsCUyKyi8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qajyxvXbOT5qMh/WCmLnNU9N6xrdL03BTh2UwD9ONgwwsvp187eB7fePJ+ma4awQWt5ZX96ukqkRIeSYn+sJ/VPd2GwYBI61cBX9lPRCxOCnEImERpjSwYpNHc1zR4yusvCbEgRhZ/ACaRXbvYsX/Ypm6AuyZrVwAjYPUshKcsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 735C160610; Thu, 05 Feb 2026 11:37:19 +0100 (CET)
Date: Thu, 5 Feb 2026 11:37:19 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft,v2 00/20] prepare for EXPR_SET_ELEM removal
Message-ID: <aYRy36z5j9qAFAQa@strlen.de>
References: <20260205024130.1470284-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205024130.1470284-1-pablo@netfilter.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10660-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.986];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 46577F165E
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This is v2 of the update to prepare for the removal of EXPR_SET_ELEM.
> This series is slightly larger than v1, including more preparation work.
> No functional changes are intended. No memory footprint reduction at
> this stage. This slightly increases LoC because of the patches that add
> assertions on EXPR_SET_ELEM.
> 
> This is passing tests/shell.
> 
> Apologies for this large series...

Thanks for the quick resend.  I have no comments, if you are happy with
it feel free to push this out.

I also checked this with both nf and nf-next and did not see any errors
running shell tests.

