Return-Path: <netfilter-devel+bounces-13816-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 93WVOUcZUGr0tAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13816-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 23:57:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665D735E57
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 23:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b=CnkyCJx4;
	dmarc=pass (policy=reject) header.from=ssi.bg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13816-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13816-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBAFB300614A
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407783D8133;
	Thu,  9 Jul 2026 21:57:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633492744F;
	Thu,  9 Jul 2026 21:57:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634245; cv=none; b=iZh3EJPDbBoqaWwJWI/bD2F42U0FQiuIjzDh40sMLq9/8NWU5HJgWeNItd5TKGRj78R6QL9AiIdHbKpc9guMgydr5AkM/FhXDWARJMEWl6pitrPNxxpGwSVJtrqlGKeSr4Kw8FF9kr2CJmjUNeByNpokpLTFuoRmBKHmhJNjSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634245; c=relaxed/simple;
	bh=ACBkeS9XNknVuEPZSDfZO5k9ps6XIvEkYqibaggYl9s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VmGa8wKfMoguK1ZJ1KIQl7MEPLSlxfJcurO2njhm7A1PwvKFXB5CB1G4DpFodz58WNQlP5B6xu7ACYEbwXM1SurSIkwkhjQv8+JUJ7dBPM1ppA/f5N++r0nuAktcCiWkK9TRiK56QdCtKOsTFBOV4NCSvc0j6CDi1WaC000IrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=CnkyCJx4; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id DC56420254;
	Fri, 10 Jul 2026 00:57:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=q5qjQdB+QZF+GW3VJ661cbrEEmx2MfrLZLcjkUpQTck=; b=CnkyCJx4mZWk
	9bUZFSejBlrf5xH2aMIYdgsjqOh4D8aifACgWGS4VYaglxTnvZpy237xalqqL3tR
	q0wa48HOTaZtF/8tS5qHQiBz62xtQdgIQ8VpxBczTE1+gJnhgzPtjssdIp8DNJOn
	3y9w0FALVvqSpDj8KEKCoC2CIiyHWZznI3Scl6Cim2xx79JnMHQB42SBjpJO4AH1
	FEzeBk8uSaF/SR8LApY7US+8Jw0ZrwCo/IJuVe7Sh+kYY/GkdegSHxo7RX6pEJGj
	RVu70hjI0ZgVvNCSlih8sLUutr9abJSUJNlRNOMhmxbFhZ60owVREkwkoVQ8QPRp
	ENLNomtRMCFycbqY/PrtWLOJW+ANDvlqENVVzI5j58nVx0ZErBuZ9UJdmJOaxoWV
	Qdo1kHtBzM6Mi5+/Rtyrq4xmwXnEaCK04vF73R2ALQWr5EjNg1/iQtAmmPmvBi4D
	J8LIUgT20MoDAmffwpFkLzarThG4GBU00PqbQW0dr2y6ARUTAFjlb6WIqX6ZwhSX
	fa6d5uBTRMLU8DPPQ7nAU7LXxorN0b5KzuhMEO9xuBf4AIWr3kGmOd12W07nj29X
	+OWyAwzCxEopIcjPY+dS2JRZYffUO+pr6pf/z7lqarCZ44Ng1Ol7+XAdNbgO9K2i
	ct792feHMLSuj4+1VoYdsKycflstPBg=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 10 Jul 2026 00:57:16 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 171A960B2D;
	Fri, 10 Jul 2026 00:57:16 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 669LvFIN111749;
	Fri, 10 Jul 2026 00:57:15 +0300
Date: Fri, 10 Jul 2026 00:57:15 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Florian Westphal <fw@strlen.de>
cc: Simon Horman <horms@verge.net.au>, Pablo Neira Ayuso <pablo@netfilter.org>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] ipvs: fix the checksum validations
In-Reply-To: <alARhv8ezLbt2MBK@strlen.de>
Message-ID: <23d93011-2353-6c69-cb36-3daea07258be@ssi.bg>
References: <20260709202356.104307-1-ja@ssi.bg> <alARhv8ezLbt2MBK@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13816-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:horms@verge.net.au,m:pablo@netfilter.org,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ssi.bg:from_mime,ssi.bg:email,ssi.bg:mid,ssi.bg:dkim];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ssi.bg:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5665D735E57


	Hello,

On Thu, 9 Jul 2026, Florian Westphal wrote:

> Julian Anastasov <ja@ssi.bg> wrote:
> > TCP/UDP checksum validation for CHECKSUM_COMPLETE is broken
> > before the git history.
> > 
> > Expecting skb->csum to cover data starting from the protocol
> > header is wrong. As IPVS works at the IP layer, the csum for
> > the IP header is not subtracted yet.
> > 
> > ip_vs_in_icmp_v6() is missing checksum validation for ICMPv6
> > packets from clients.
> > 
> > Also, Sashiko points out that handle_response_icmp() being
> > common for IPv4 and IPv6 is missing the pseudo-header
> > calculation while validating ICMPv6 messages from real
> > servers which is a problem if checksum is not validated
> > by the hardware.
> > 
> > Fix the problems by creating ip_vs_checksum_common_check()
> > helper and use it for TCP/UDP/ICMP both for IPv4 and IPv6.
> > 
> > Also, ip_vs_checksum_complete() can be marked static.
> 
> Just FYI, I'll ignore the sashiko comment wrt.
> 'hardcoded sizeof(struct ipv6hdr)' as thats resolved by your
> earlier patch, so I plan to include this in tomorrows batch.

	Yep, both patches solve the reported problems there...

Regards

--
Julian Anastasov <ja@ssi.bg>


