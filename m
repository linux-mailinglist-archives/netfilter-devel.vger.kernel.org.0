Return-Path: <netfilter-devel+bounces-10754-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOG+EFgrjmn5AQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10754-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 20:34:48 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09C130BCD
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 20:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B542C3005149
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 19:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA1279903;
	Thu, 12 Feb 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kb+xtoCp"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6481C84A6
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924882; cv=none; b=NUEo6fDv11111xsDaSzsqBHv8Q31agy/+5T+7Kxi+Ivx/pIm85yCsSAc5IaUmFAZyAjiV57BOKXkX4KGaNXugkgSCZlMOUm02WrV9GwaZv9fAjBy6nmUMVXdMpvOXAKpqMGEU/vyEA7hE530bgSGaRJSjJtf8ioJ7uhCCHN6HZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924882; c=relaxed/simple;
	bh=mqb2rtLMJPOHoy/Sg+7A0lcfEs17VWIlZc4eTas+35Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcuhxuD7D713R6a+4lQJ0noV4pAMLR1GV4I6CmUVVXVsNt+g5EwAKRLXkDDEKxkOnw3SFhco159lUdVfSKCaKw7pdf53Zr/qPO9cXYFgH60vpP4kD8RtMEUVK5ngVbkHbEor1njxjqSOGOsWHYMo0YSUIaS+CXmpkX5tFZR3lLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kb+xtoCp; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770924872; x=1771184072;
	bh=mbb9toBspLjuIWRg9CHO+FfLiLLMISjVO31cACojoys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kb+xtoCpLT2B1xX+gbyHdYoafKgoYtCYLVJEHiR9HFnLDXkzx6j/T/8bmz5LgSsnv
	 e2yOE6BzZ1/xfJm2bpez7QCN/70cTcUnNj4y6fXQBeIPTqDY0ToYLiZHA6J0zGoZwF
	 gBPo0Jc3WQev6lAsvOTSEsGrJmrS4/N66qqcywOHrV+6MCLswOzwBp7+2yNrO2o1bt
	 ZFiS2wvuiKLxftj4c4mqKqiQbEbqNmmEaymaHXtIVMzvZFGA0iRFR2LSUb/72l2BXV
	 faslPNWYt2Jmhf3e3/ef3taFs2QODqwWmWMTJYhqW19c4jCVQniy5f+e34lJzu4bnQ
	 wB7svd6kgB6Mg==
Date: Thu, 12 Feb 2026 19:34:29 +0000
To: Phil Sutter <phil@nwl.cc>
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH] iptables: fix null dereference parsing bitwise operations
Message-ID: <wsfxGCi6FNb3Qj2_tw3b9WZS2spw8DyUe34OgpSzj8UQg7tNdw0RReS7iwQBnoVIHfZOIFoCUFf6mVAVOAGCSabgUgWBa9yABVwyAzNI_lc=@protonmail.com>
In-Reply-To: <aYz2eUev4mUdN7uX@orbyte.nwl.cc>
References: <20260202101408.745532-1-one-d-wide@protonmail.com> <aYz2eUev4mUdN7uX@orbyte.nwl.cc>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: fc3c8ce49783a234273b9af3b9e0488abb9f49c7
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10754-lists,netfilter-devel=lfdr.de];
	FREEMAIL_FROM(0.00)[protonmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:mid,protonmail.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A09C130BCD
X-Rspamd-Action: no action

On Wednesday, February 11th, 2026 at 21:37, Phil Sutter <phil@nwl.cc> wrote=
:

> On Mon, Feb 02, 2026 at 10:14:52AM +0000, Remy D. Farley wrote:
> > diff --git a/iptables/nft-ruleparse.c b/iptables/nft-ruleparse.c
> > index cdf1af4f..1a9084e3 100644
> > --- a/iptables/nft-ruleparse.c
> > +++ b/iptables/nft-ruleparse.c
> > @@ -232,6 +232,11 @@ static void nft_parse_bitwise(struct nft_xt_ctx *c=
tx, struct nftnl_expr *e)
> >  =09const void *data;
> >  =09uint32_t len;
> >
> > +=09if (nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_OP) !=3D 0 /* empty or=
 MASK_XOR */) {
> > +=09=09ctx->errmsg =3D "unsupported bitwise operation";
> > +=09=09return;
> > +=09}
> > +
>=20
> This is redundant wrt. the stricter compatibility check below, right? Or
> did you find a call to nft_rule_to_iptables_command_state() which is not
> guarded by nft_is_table_compatible()?


Yeah, I wasn't sure that was the case. I'll remove this check.


> Anyway, I would add two checks to that function like so:
>=20
> | if (!data) {
> | =09ctx->errmsg =3D "missing bitwise xor attribute";
> | =09return;
> | }
>=20
> (And the same for bitwise mask.) It will sanitize the function's code
> irrespective of expression content, readers won't have to be aware of
> (and rely upon) bitwise expression semantics with NFTNL_EXPR_BITWISE_OP
> attribute value being zero.
>=20
> >  =09if (!sreg)
> >  =09=09return;
> >
> > diff --git a/iptables/nft.c b/iptables/nft.c
> > index 85080a6d..661fac29 100644
> > --- a/iptables/nft.c
> > +++ b/iptables/nft.c
> > @@ -4029,7 +4029,6 @@ static const char *supported_exprs[] =3D {
> >  =09"payload",
> >  =09"meta",
> >  =09"cmp",
> > -=09"bitwise",
> >  =09"counter",
> >  =09"immediate",
> >  =09"lookup",
> > @@ -4056,6 +4055,10 @@ static int nft_is_expr_compatible(struct nftnl_e=
xpr *expr, void *data)
> >  =09    nftnl_expr_is_set(expr, NFTNL_EXPR_LOG_GROUP))
> >  =09=09return 0;
> >
> > +=09if (!strcmp(name, "bitwise") &&
> > +=09    nftnl_expr_get_u32(expr, NFTNL_EXPR_BITWISE_OP) =3D=3D 0 /* emp=
ty or MASK_XOR */)
>=20
> '=3D=3D NFT_BITWISE_MASK_XOR' and drop the comment.


It took me a while to realize iptables/linux headers are quite outdated,
so NFT_BITWISE_MASK_XOR is still called NFT_BITWISE_BOOL in there.


>
> Thanks, Phil

