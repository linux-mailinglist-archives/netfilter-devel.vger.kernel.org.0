Return-Path: <netfilter-devel+bounces-12078-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMVoMjpr5mmBwAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12078-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 20:06:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46128432761
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8205A306037C
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D039B965;
	Mon, 20 Apr 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="HVd1+u0Q"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B62336EC0
	for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707989; cv=none; b=t4IGfLcdN3w4AkdOr2aDLZHduE9aJkf0uOJxzg6PYw5yN6ZJSvy/bbPqG6SvAK0s1m5taLsv58+5I/UK0OoB9dso+OgZyDyQjYG6brsy1rMlCRNQ/lZd8vbWwUH23LpNCFwbaxflfIGuw1XJhCqGosDpuZ4Depc4yZMsZoGTtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707989; c=relaxed/simple;
	bh=n+MoRSBLbQcDX5EnPfdSzCcHI594EAszfh1XJtzcbfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCOABgJtFkib7B4wxlJZ9Xm8eqEoc/89NAeTuxaD4q8xDDRcNeDmzaWr7DNIX5RCKKW+PZ8PRY9QVBQYBdTpW2BCA2/tUdvF02vt+aKuCl2YIGSARVFFi3XTIowdV9EQMla99whXFzu7oR4yr4AZOeH5MhoEDB4OXQzJh4cyXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=HVd1+u0Q; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id DE9E260251;
	Mon, 20 Apr 2026 19:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776707987;
	bh=b9r5tKZxpj2XvGdc3uUVQj5hcoi+n4W1An6UVwPgDnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVd1+u0Qifkw5cWg3Db4SjCqg6vQngY6qYL3OtqXx/67a6nv6a6fNENDdlAqmIvIg
	 QrqGNrE6CCpHFyokF12odpBOhKKhO6RqRIi8VgzqVDFRJ9Bm2Sby76+fsc3ekQUlt5
	 3GX8EGj1k53P+r1RJpueuGMd69yFz3kQgIoI46XzLp3wTeTprWnbb31H+roN0h95s+
	 zQtsjwdSQz6jLs56fNmlplNnbF7vzC/2l+NCaklwsCmHoq3cVNYQTaWK/aVSfh9FK5
	 NQZ3SJx2DQ4317sfXWKCXbQAvn2vejQRTlvbeHZykjYMjOkugy7eToDthLy4Qs5lZg
	 8xlvJM/oACrlA==
Date: Mon, 20 Apr 2026 19:59:43 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_compat: run checkentry() from .validate
Message-ID: <aeZpj9r368paudyZ@chamomile>
References: <20260420174227.13087-1-pablo@netfilter.org>
 <aeZoiqyPFP0NJkz9@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeZoiqyPFP0NJkz9@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12078-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email]
X-Rspamd-Queue-Id: 46128432761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 07:55:22PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Several matches and one target check that the hook is correct from
> > checkentry(), however, the basechain is only available from
> > nft_table_validate().
> > 
> > This patch calls checkentry() for matches and targets from the
> > nft_compat expression .validate path for the following matches/target:
> 
> I worry that this is fragile.  Not all ->checkentry callbacks are pure.
> Some create /proc entries or bump reference counts.

xt_set does bump the reference count. This calls xt.destroy to restore it.
I am only calling them for the list of expression you mentioned.

> > +		if (!strcmp(target->name, "TCPMSS")) {
> 
> This is missing "SET".

I can add this.

