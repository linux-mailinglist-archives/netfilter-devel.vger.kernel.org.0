Return-Path: <netfilter-devel+bounces-12160-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIH8DZ0x6mkCwwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12160-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 16:50:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B39AF453E12
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 16:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14B543051DBC
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7E33ADAD;
	Thu, 23 Apr 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Qh14OlXS"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3D345CDD
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955775; cv=none; b=ittrFcCxKH99JijC217ZiND3BT5AOJJKUyzz+bhveFbTzTfKEp7P5VMowW3l442izbXPzqRB8++aQAjP1p+MmVu8Zt+w825s/Nrt/i7TB8WT8MELOpjAZr42czbIzB4E+SVRFK7MQBwQ8G4tAw88Yft15cXzV9grJHO+0Hf/f/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955775; c=relaxed/simple;
	bh=Im3s3l6La04cHuAvGtXslXJ3BSsgWgrL7thXajHd0lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwY2Q+x38GVMbX+KLFsQJbGN4EhEx0rwX6/OB24YKTNlYZy80Umuo6JHXwpIsK7i04anjwD38WLuujvC233Oecq/I016OGpXfWqET8VMK4nuU1MXKlMY0JMJAR9MrpReo3/jycMxdtb87NKU59PDoe8FNlyI0t6ySR0CkESbRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Qh14OlXS; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 67C94600B5;
	Thu, 23 Apr 2026 16:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776955771;
	bh=0v72fqubfTQNdYCo9Auszz3CYWpluFRxpItdShQ57fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qh14OlXSk/1tL0cLpvD6ZmCda/IIiJKEal9ha+zGyfQnL5OG3gwh7lFC58EOBtgXx
	 FHq3UsnVJcMuTL4lmyUmHoDccZ4TffWKw+kEjStmPI7wiwSCDCOoeSFvpB43TFZBRs
	 LOPxbAHXQnB2uCSx7QsqoIlF9WU35ILmKsPB3/zWMGGnjweAfcu46uXWy4aw7H6Rft
	 SODw+heEeB+c9HiBGnj+UmsvUmKw5MAAJ32TdsL6Q5Jw5EJm5h7dp0d9CRb8DEPcxL
	 9RnQmevoS0KQS1WemZjRewQ5VtnNP7Oq3zgU3j7HQQWwerIcYnGQPRNU62QOzn5nQm
	 lkay+WUQCcgXg==
Date: Thu, 23 Apr 2026 16:49:28 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	jeremy@azazel.net, phil@nwl.cc
Subject: Re: [PATCH nf v2] netfilter: nft_bitwise: fix dst corruption in same
 register shifts
Message-ID: <aeoxeHoufCrJrNHn@chamomile>
References: <20260423120538.3704-1-fmancera@suse.de>
 <aeoQMCJ7x0tGoUFC@strlen.de>
 <684ec011-3785-4df4-a9ee-457025dcd447@suse.de>
 <aeoStjrp12qNUeDL@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeoStjrp12qNUeDL@strlen.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12160-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: B39AF453E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 02:38:14PM +0200, Florian Westphal wrote:
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> > On 4/23/26 2:27 PM, Florian Westphal wrote:
> > > We should support overlaps (src == dst).  But partial overlaps?
> > > Does nft generate such byte code?
> > > 
> > 
> > No, not at all.
> 
> Phew. :-)
> 
> > Fine for me. I could not find any situation where this could be useful 
> > but I was afraid of breaking some weird setups. If we have agreement 
> > that this isn't useful I am fine rejecting it from control plane with 
> > something like (not tested):
> 
> Lets wait for Pablos take on this, but I would prefer reject from
> control plane.

I'd rather reject this from control plane too, thanks!

