Return-Path: <netfilter-devel+bounces-10492-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sII/JI+cemlE8gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10492-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 00:32:31 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C5A9FAC
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 00:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE40A30157CE
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD661EB5C2;
	Wed, 28 Jan 2026 23:32:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC81531C1
	for <netfilter-devel@vger.kernel.org>; Wed, 28 Jan 2026 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643149; cv=none; b=qN+e3916blfLD2CW4dVs5QGfGwGnMIa13agTDK/t/jsO18XYBq0nUpb9U/kckhJSvSX27rHEoC74PvOUARPDq8g4dPM8oFU0ANhWvmJFhTo6wktZdtpPt5zp8HROZ0NjiuDAgYTlmkxllBD24IUcskl/FQFrIVTfbe0n7Hv+5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643149; c=relaxed/simple;
	bh=ZNqQxuh2fr7kqvOie97fbwUFLGLw5ChKMrWZ3pgoLSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJzEEEbIDdWG0scLs7IxHo2W8dS9S0LwhSDCtO4d9XHb648oiq9pynxB06hh2b3ziyaZq+qP3wmIK9l9XGqR1x61UR7tMzzGal83ONSfdLrEYgieTBAXMUbvoCPKja/FCdtz1WMtIdT/iu9bUZupiWewYmvdi7ZcxWLFrJhQ2vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 09DA760104; Thu, 29 Jan 2026 00:32:25 +0100 (CET)
Date: Thu, 29 Jan 2026 00:32:21 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl RFC] src: Do not include userdata content in debug
 output
Message-ID: <aXqchfDr4ct6HywO@strlen.de>
References: <20260128231821.22855-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128231821.22855-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-10492-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nwl.cc:email]
X-Rspamd-Queue-Id: D47C5A9FAC
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> This storage in rules and set elements is opaque by design, neither
> libnftnl nor kernel should deal with its content. Yet nftables enters data
> in host byte order which will lead to changing output depending on
> host's byte order. Avoid this problem for test suites checking the debug
> output by simply not printing userdata content. Merely print how much
> storage is used if at all.
> 
> If this is acceptable, commit f20dfa7824860 ("udata: Store u32 udata
> values in Big Endian") may be reverted.

Thanks Phil for following up.

> There is surprisingly little adjustment needed to this in test suites,
> BTW. In nftables, there is merely tests/py/ip6/srh.t.payload which
> tracks set element userdata. So while this fix is a bit clumsy, its
> impact is not too big at least.

The udata is used to store the exthdr flavour (here srh) for printing,
so in case this would ever be corrupted. the printed rule would fail
test validation as well.  IOW, I think we can do without libnftnl
dumping the udata stashed byte soup without compromising bigendian
tests.

My s390x vm passes both pyton and shell tests at this time, this was
never the case before.  Thanks a lot for making this happen.

