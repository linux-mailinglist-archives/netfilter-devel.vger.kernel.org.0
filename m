Return-Path: <netfilter-devel+bounces-10678-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJT1LTiohGmI3wMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10678-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 15:24:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E2F3EAA
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 15:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C335F300952B
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B543EFD15;
	Thu,  5 Feb 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="gqZ4mYbc"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8C1221FCF
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301457; cv=none; b=ACS48H94YjENBmd0Q04k0E3P3jWKiNiBNH/vNWyWnI/nz1inRH4UqkfyiVJKCweC9ocEqri0Ma0S9+W/B4HrTpfCqOyzpaWQWGpTkfhpGwNaqhXwHv+vy+bdDtDPMhHIzl2hDyEe9dMQdJc3KJ0g5IoSOSHrTZAxCBccSMVb8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301457; c=relaxed/simple;
	bh=DGq3GlxZ62z6k+1hPJnfEACk5FtJw479R9kLcsqMTVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seILgRdFID7bLX7zFnWzYT9MCpo+k6j05c991yTPxvY2rB4vva2rC+P6+VxzvZ2pptJegL4YOtTGJDPggATFldoevTwk+CgxN40R7qH+ou2PX4mincr24It/PY2+k6EnPKpd01so8l04o/S/FmYLvRqXGNVyVlMi4lE8X7Kz02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=gqZ4mYbc; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pg/6Ow7Oj+9aUwVgvXulTV2GWNv7zW7OUBdw5dBQMog=; b=gqZ4mYbc9Na669M4G9f9IhGOOC
	lillsHBTSlGv2dZhd/lyuuog9HnXI0oAFDuhW6xKdjJ8qZjyc3ej+yTe7aUq6TDXcoxGOT6Ftb8TT
	CYDmRI16+ARytoc6Cyda3BBT0ctX+ZAzN4QT+Eq4/46BxnbA6kgpKBeJdoUV+u48T/0xsDyR1it9G
	2DNov3J1E/UfnUoW0sy0TH1RUf9v2JcxIdk2OA3x+rV6mIes63kaMrm427IaAGvMogDpPb9w5F69H
	qcRGK7DaY46YsRYzhSZZZXJozpTRGN2ZOeldxBCaCvu9f4LFupSl4vZiVzhoQfm3l39Xa9xla2bhH
	KvPqoWsA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vo0HG-000000002QM-39Ji;
	Thu, 05 Feb 2026 15:24:14 +0100
Date: Thu, 5 Feb 2026 15:24:14 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] Makefile: Set PKG_CONFIG_PATH env for 'make check'
Message-ID: <aYSoDgjTbH9t5Na6@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
References: <20260127221657.28148-1-phil@nwl.cc>
 <aYPzQOgGxpacVYMV@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYPzQOgGxpacVYMV@chamomile>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10678-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:email]
X-Rspamd-Queue-Id: 1E6E2F3EAA
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 02:32:48AM +0100, Pablo Neira Ayuso wrote:
> On Tue, Jan 27, 2026 at 11:15:58PM +0100, Phil Sutter wrote:
> > When building nftables git HEAD, I use a script which also builds libmnl
> > and libnftnl in their respective repositories and populates
> > PKG_CONFIG_PATH variable so nftables is linked against them instead of
> > host libraries. This is mandatory as host-installed libraries are
> > chronically outdated and linking against them would fail.
> 
> How do you use this?

Please kindly find aforementioned build script attached to this mail.
Then I just call 'make check' in the built nftables source tree.

This patch's logic is: "If a custom PKG_CONFIG_PATH was needed to build
the sources, it is needed for build test suite as well."

> > Same situation exists with build test suite. Luckily the PKG_CONFIG_PATH
> > variable value used to build the project is cached in Makefiles and
> > Automake supports populating test runners' environment.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> > Pablo: Could you please confirm this does not break your workflow? I
> > recall you relied upon build test suite while it never passed for me due
> > to the reasons described above.
> 
> Just run `make distcheck' or tests/build/ to check, I think that
> should be enough.

Well, 'make distcheck' should not be affected by this patch since it
does not run the test suites (df19bf51d49be ("Makefile: Enable support
for 'make check'")).

But you have a point there, the logic from above applies to the VPATH
build performed by 'make distcheck', too. I'll respin with added chunk:

| --- a/Makefile.am
| +++ b/Makefile.am
| @@ -23,7 +23,8 @@ libnftables_LIBVERSION = 2:0:1
|  ###############################################################################
|  
|  ACLOCAL_AMFLAGS = -I m4
| -AM_DISTCHECK_CONFIGURE_FLAGS = --enable-distcheck
| +AM_DISTCHECK_CONFIGURE_FLAGS = --enable-distcheck \
| +                              PKG_CONFIG_PATH=$(PKG_CONFIG_PATH)
|  
|  EXTRA_DIST =
|  BUILT_SOURCES =

Thanks, Phil

