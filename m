Return-Path: <netfilter-devel+bounces-10380-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AJBJ2dCcmnpfAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10380-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 16:29:43 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17B68D53
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C14A7C8758
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jan 2026 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BC3346B8;
	Thu, 22 Jan 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="T6U467dG"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160D34FF55
	for <netfilter-devel@vger.kernel.org>; Thu, 22 Jan 2026 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093204; cv=none; b=Kc75aji0uFcb1YGhWVwolZTJBilDqdNRohDXLcrywpb7R7e2+n3aGKyV5SIg6AOw1ppvAYxEqDmk5/PfapljgUPPA/+nD0on9etqjHCPf0QUNB7OUKQmDihlKkxX98gfbE6hpbPgJdfS5k7IC14wybSaNIwWklomDgZ7Iv/kb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093204; c=relaxed/simple;
	bh=zep8wq5gteP9Kyn4pR2qoU4f24V1u/0md2qAf1P/ZKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAT3ChMUhKS/Fyz1n/NgMtdvILuicsyODhZpHEQF9T0lpHlCHneFCR47YDQCiORINEKXEXqRvuEaep83AcCUb7Nz92mmhD/8X4VUg8XC0jLs18ek6Ixq/cic8UvXk4FsO9LxvUPfKNG315vTdhLH11rKWZ30xd0cfNqQx1FqgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=T6U467dG; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PmjDjiwKTxE8/Tc5xRxY57nUr8b8qvrRLTLXGn0ZyxY=; b=T6U467dGsDGjnGefZ6xjLkM9e/
	IxNE0nU6W5v3Fnx0ouIyR3kBcg1boiKcpiP896jezilUG96e9txI+gd3s886RsAGukucHyag2xO/c
	I3hWOMLdPgW/FDF3q5pGnEOwHaYG8i13NpWAU44dMdt00OYcvC3iPzS4nrGjghATWz43Zjeol8Kj8
	dvnacaQ9DnzaoaFasE+RGEYBxtoj8AWfzESSqyzuHKk4fGwNhnNQ9g7kkiyyG8X1s8ddDqkVjcOGy
	zAVtmigm2ToEadO8fLMfhN1qDm1QYTbwcEJfA3MW2y4iX1YqqvZA8l2BboEKxS3bnAjMG7cri1KcN
	wmbd83bg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vivxG-0000000063M-2qVI;
	Thu, 22 Jan 2026 15:46:38 +0100
Date: Thu, 22 Jan 2026 15:46:38 +0100
From: Phil Sutter <phil@nwl.cc>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: FYI: Code coverage of nft test suites
Message-ID: <aXI4Tm08hPZjbgjy@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
References: <aXANvUVv8nX-wPeM@orbyte.nwl.cc>
 <54e7d5ac-8cae-4fd7-9440-21ae982b4a22@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e7d5ac-8cae-4fd7-9440-21ae982b4a22@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10380-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[nwl.cc];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nwl.cc:url,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: 3F17B68D53
X-Rspamd-Action: no action

Hi Ferfer, ;)

On Thu, Jan 22, 2026 at 03:36:15PM +0100, Fernando Fernandez Mancera wrote:
> On 1/21/26 12:20 AM, Phil Sutter wrote:
> > Hi,
> > 
> > I recalled there was an effort to increase code coverage of the nft test
> > suites so I ran 'make check' in a '--coverage'-enabled build. Here's
> > the result for HEAD at commit dda050bd78245 ("doc: clarify JSON rule
> > positioning with handle field"):
> > 
> > http://nwl.cc/~n0-1/nft_testsuites_coverage/index.html
> > 
> > I plan to pick at least a few low hanging fruits from there, but anyone
> > interested is more than welcome to chime in!
> > 
> 
> Thank you Phil! I would love to.

Cool! I have written a test for src/trace.c and am currently working on
one for src/xt.c. So these two are already taken care of. Feel free to
pick anything else worth improving.

Thanks, Phil

