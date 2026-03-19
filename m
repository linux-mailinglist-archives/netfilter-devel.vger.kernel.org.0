Return-Path: <netfilter-devel+bounces-11285-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KCyJ3W7u2mtmwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11285-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:01:41 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE472C845F
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1969302CE37
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B63AE19D;
	Thu, 19 Mar 2026 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="as64b8Co"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599436EA8C
	for <netfilter-devel@vger.kernel.org>; Thu, 19 Mar 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910605; cv=none; b=qCbv/abMGpByo+1WxZYDyStpNOmE/Ca5lAxesG8Xi90rGhJd2yDSVHtIlUWKb5kzfMEd0i1AJ+uairVu8Lvp8A3dD2Wn7Uw0agahzGw9oowqDQgFMECgmIhE2hq8ieEtwLUzbSF46bJRN5HFxW45+IAZ5if9MmK19igXK3xSFNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910605; c=relaxed/simple;
	bh=HPoXnmS8UefZPURYIDqtu/pKRKWygCSk0bYBc7rP7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBpN6ZEOpY8rrxdVF8xR1kFyrGT5bQ4qnb4vBoIN+B6oHAgQgaatLud4caYo/nQZZXN2jpiQmPnBfwdnmUPuyS1ojo3Xk75GLGWpopQuS65Lj4sIwKv9MahAqQvlCAmscEvKFIF0dLdqra5/74S/k21+F0Z+HzZQYOPEY98rfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=as64b8Co; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HPoXnmS8UefZPURYIDqtu/pKRKWygCSk0bYBc7rP7Tw=; b=as64b8CoXVXO2R6UAb86DtQGLy
	FU1q54a2GHSzIdNUp60x54lXjZ19JUuNeZSqwAsj+ErsGAlyL8s5ASd49sUYnM9/eRusabqc8x8OO
	AVmjkN+/8BO1ulYwFO+cIqzTMT/rh+z/309pualw1MHEh0tQwL7BxltiyAfSHxZPZkMpnNb04bkHE
	AlpPsDCW4GLW0n+1BoiQV1GWI1RJFBjWb2gxDCz8odCbpJGhKrBjvKhngORSNItUvqkx0fBCUU3Ru
	EpF5U4mAvLWjMiCzFWODdO17NPbwesn3tGx1hwCm2LnUYrXtxVFMNbDy0jN307hT0VkUTnpa1BtIo
	ldbho81Q==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1w39BI-000000000NS-2860;
	Thu, 19 Mar 2026 09:56:40 +0100
Date: Thu, 19 Mar 2026 09:56:40 +0100
From: Phil Sutter <phil@nwl.cc>
To: Chloro Dose <chlorodose@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] src: Export nftnl_set_clone symbol
Message-ID: <abu6SAYnM6SJfXMv@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Chloro Dose <chlorodose@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
References: <20260318025651.151116-1-chlorodose@gmail.com>
 <abqCdqPLJyKmBQc-@orbyte.nwl.cc>
 <abra_o50miSi49Aw@chamomile>
 <abr0mqg2A0V0DiWb@orbyte.nwl.cc>
 <CALUf4NpY__xsCa4=RHw-D+Hixvnj_1yuS7K_qJ6WJ0qSoTyRDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALUf4NpY__xsCa4=RHw-D+Hixvnj_1yuS7K_qJ6WJ0qSoTyRDg@mail.gmail.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11285-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.065];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orbyte.nwl.cc:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AE472C845F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chloro,

On Thu, Mar 19, 2026 at 08:15:35AM +0800, Chloro Dose wrote:
> I have a use case where I want to construct a daemon that keeps a
> reference to an nft_set and repeatedly uses it to handle requests to
> add elems. I assume I must clone the nft_set from a clean copy each
> time, otherwise I'll resend all previous elements to the kernel. But
> I'm just starting to learn nftables, so I'm not sure my understanding
> is correct. Am I misunderstanding something here?

All you need to keep record of is the set's name and that of the table
it belongs to as well as the latter's family. With this data you may
generate a NFT_MSG_NEWSETELEM-type message for the kernel to add one or
many elements to an existing set. For reference, mnl_nft_setelem_batch()
in nftables.git/src/mnl.c should be a good example of how to do this
using libnftnl and libmnl.

Cheers, Phil

