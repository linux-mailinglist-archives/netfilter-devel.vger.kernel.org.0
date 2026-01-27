Return-Path: <netfilter-devel+bounces-10436-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDUKF545eWkZwAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10436-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:18:06 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B309AF6F
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB97A301CD90
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 22:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157B73570A0;
	Tue, 27 Jan 2026 22:18:03 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6034A797
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552283; cv=none; b=ZsFEcQQOx2qiLrFAZMyqJ0L92SNQNsNcOY+XRLvfNcq4WweV21qQLWWKYJpDqdR4Z3P3w6kIB6GARqh/G2vrnQxrXq/0VRn0SQobsCGP/5Gl94PckFOcf/k0kWGtf/mqlF4197HChXGkviKzgucmI1spjevA3agadmkrPWWFxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552283; c=relaxed/simple;
	bh=AJNIIkXKmNKksC0xQyB7TDB0IGRjt0PZqkH1kE4mmWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itAsg7VJ6HNESjUVp2Wo4JFGoHe1HFN48aUgTRYSezK8/Yu65AIFoFzqmtpJFkGJpyW2WGQmEOpLsnX4oMdeOQxJj9mgi4/KQUbA82KDDO066uS+nDWMPDM20f57RuHOLIpaMnAjye4YET1/ZcbdQgIbDhpqTMyMUqlaEJK7HLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8E14F602B6; Tue, 27 Jan 2026 23:17:58 +0100 (CET)
Date: Tue, 27 Jan 2026 23:17:59 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: nft.8: Describe iface_type data type
Message-ID: <aXk5l4AQ4XHvyBrx@strlen.de>
References: <20260127221252.27440-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127221252.27440-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10436-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: E2B309AF6F
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> An entry in data-types.txt offers space for a name-value table. Even if
> one would refer to ARPHRD_*, some names are not derived from the
> respective macro name and thus not intuitive.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  doc/data-types.txt         | 27 +++++++++++++++++++++++++++
>  doc/primary-expression.txt |  2 --
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/data-types.txt b/doc/data-types.txt
> index e44308b5322cb..0b350effbea68 100644
> --- a/doc/data-types.txt
> +++ b/doc/data-types.txt
> @@ -83,6 +83,33 @@ filter input iifname eth0
>  filter input iifname "(eth0)"
>  ----------------------------
>  
> +INTERFACE TYPE TYPE
> +~~~~~~~~~~~~~~~~~~~

TYPE TYPE?

