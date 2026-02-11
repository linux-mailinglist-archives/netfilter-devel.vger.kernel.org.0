Return-Path: <netfilter-devel+bounces-10734-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CH+CszbjGm3uAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10734-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 20:43:08 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C29391273BF
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 20:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E888B3004DEA
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAB352C4F;
	Wed, 11 Feb 2026 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="lqTh2TOa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4722EA151
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838985; cv=none; b=TijlBbORRmy2kizZzhxgnjFc1W1b9XFKCjRR/oqTn/r8ngarS3v4+rNHGNi5/CSKP2op5nEvPtMvvj6kQ2TQswym0CwGDOVqrv6IxFY1xchLcvmr3NJ3bfSgX+i0SNvzKqNx6fCYU03cvy0QQzUvtM2owlNR+9g420+arhmct0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838985; c=relaxed/simple;
	bh=BNBlHwnfdLcmMhp4kWo5PVvJjvEb5yg+/wcYwSDUtBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fROzvGY7QyPt4mNa7fDYCcg+iZa2kannOb33Ui851ATNHhvPa2SlaBFglcos2CjUrmvQm5v3/2szkYPCkqU/FY3wH8QTQELvWL4uNv8VewuUIY99ve3Qk68QDi8iH/o2rAWCS7a5Eq5dzHl7ArqXCkAnExGXSYFlQ5syfU9tbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=lqTh2TOa; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oZA/cjs3FTs2lHKqYku8KxL+cEU4DIrbQnejs+MiMDs=; b=lqTh2TOasTe234S3bYt7q74uty
	2CT+BN/uVDFGwfK8fwZdD0CYhmTrJ5FL0ruDVOuX85IAvr7Rrf9TmGd3+khAN9qR9xs0Sfme0rfLD
	vqoAM3kXJWuJAxwXzPpfjNOkNLrKHFt4DVTSu3iGIfxF0k1SYKEozWAsK1R/2keYO3vD4fKqcDqGk
	bItxbaEwC+0LJeOaR8ocz40ErsaEXG/BXcTHU1pybK92Lkuz2Q5doSGlS3hNUU8Fgf6hXLmQt8Lta
	Mc1x5GAejoF8BxSHWbcBlpHnA4JWZv0m2r46aQrA741GQ/tn75f+pZULFRUuULvg2QZLX9jVKWj+B
	LwHbgR3Q==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vqG75-000000007kh-0u3T;
	Wed, 11 Feb 2026 20:43:03 +0100
Date: Wed, 11 Feb 2026 20:43:03 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Ilia Kashintsev <ilia.kashintsev@gmail.com>,
	netfilter-devel@vger.kernel.org
Subject: Re: Global buffer overflow in parse_ip6_mask()
Message-ID: <aYzbx0c5wIiXdzxL@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Ilia Kashintsev <ilia.kashintsev@gmail.com>,
	netfilter-devel@vger.kernel.org
References: <CAF6ebR70NXKv54uEE=kGC2O9tg5K+LoB5gZCm7tKJJaJRGLZcg@mail.gmail.com>
 <aUQTNcIKD-7YzYQQ@orbyte.nwl.cc>
 <aYx_Wupq7R-2ndbc@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYx_Wupq7R-2ndbc@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10734-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C29391273BF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:08:42PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > The reason why the second memset() call may mis-behave is the broken
> > div-round-up in there: It does (bits / 8) + 1 when it should do
> > (bits + 7) / 8 instead. Fixed that, only the p[bits / 8] field access
> > needs to remain conditional:
> > 
> > @@ -364,8 +364,9 @@ static struct in6_addr *parse_ip6_mask(char *mask)
> >         if (bits != 0) {
> >                 char *p = (char *)&maskaddr;
> >                 memset(p, 0xff, bits / 8);
> > -               memset(p + (bits / 8) + 1, 0, (128 - bits) / 8);
> > -               p[bits / 8] = 0xff << (8 - (bits & 7));
> > +               memset(p + (bits + 7) / 8, 0, (128 - bits) / 8);
> > +               if (bits & 7)
> > +                       p[bits / 8] = 0xff << (8 - (bits & 7));
> >                 return &maskaddr;
> >         }
> 
> Phil, would you mind formally submitting this as fix?

DONE, thanks for the reminder.

