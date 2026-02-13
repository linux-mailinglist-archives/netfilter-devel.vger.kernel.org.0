Return-Path: <netfilter-devel+bounces-10761-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOFhC5kMj2kgHgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10761-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 12:35:53 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC70135C0C
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 629C030089B0
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Feb 2026 11:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4729DB88;
	Fri, 13 Feb 2026 11:35:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128821B85F8
	for <netfilter-devel@vger.kernel.org>; Fri, 13 Feb 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982550; cv=none; b=J/WX/adsiNb5agOkruh8BP71U2kogNOjH4luH1Vez60Bc5nvJCrF5CgFtX5kySjppLp8ZM00CX5cDIbV6nXct8oKQKGRmqHhy3RiuOzRVdpNkHwCErClHEeIyDdrlgodHj+YuzgpgCvcIce01HC4kpCWkNB0ZuM8/Ady9Zdj5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982550; c=relaxed/simple;
	bh=sdX/wvw4wVNQrjHWPT9Cb7w5hysFWvPF64wS6zXPUi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCGJL+Zih4iERP3ynEhIujcR/nvIjORy5cb6Ut+i2JrP8Efjd0/g50VVqFULP+gc3XbsGiVJkAWWxpFQOaJo9lFVA/fWCS37q2JTtbl3uWJWBlncWEbdEt9EczeMgaVi5kgbmuxIB0TMwyOu8hgRWN2VD+JF9IkFg5OoupCqDME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5CA5D608AD; Fri, 13 Feb 2026 12:35:47 +0100 (CET)
Date: Fri, 13 Feb 2026 12:35:47 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v4] configure: Implement --enable-profiling option
Message-ID: <aY8Mk5eCymlbN8UA@strlen.de>
References: <20260212205023.32010-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212205023.32010-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10761-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: CCC70135C0C
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> This will set compiler flag --coverage so code coverage may be inspected
> using gcov.
> 
> In order to successfully profile processes which are killed or
> interrupted as well, add a signal handler for those cases which calls
> exit(). This is relevant for test cases invoking nft monitor.

LGTM, thanks Phil.  Feel free to push this out.

