Return-Path: <netfilter-devel+bounces-10617-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMEaA+pug2lNmwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10617-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:08:10 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3665E9E9F
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABA7D3023A4A
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4E423A68;
	Wed,  4 Feb 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="HhBSV/GC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F699423A64
	for <netfilter-devel@vger.kernel.org>; Wed,  4 Feb 2026 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221233; cv=none; b=Yio3oj1Gp3APKmTNJ6s6kN5K87NxdpzqO+qFzZlsSu19bJRqbrvQpef20Y97Ql3SJcLtJTL1HITLTcLQcpeIhnxcwJVqI2TPSPl3izg2yb+oIP5IA8F/Jg4YAoXdvs+cGUYcXj3bdhUDa6birVtSTikRITgmmH3SSCcBBQU+ROs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221233; c=relaxed/simple;
	bh=W0tly3KGJPHXAE/ZVGcOXH81pGtXxTyyIjVNQuXWIno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJJtJDHdguyaB3McIjkUDq7fxqXFfooAKhLXll55p+U7cl1S/jUnqXeLwhbWYTQIZwwelquZ0FCjqeVdc8B1rkpQBlqXifIGoWvBPb9tJCsfH2Chqgnkaq06yeAIMCZT84FNxOJz+ekVAxPWIoC3gbo94EXBNXy2D03T8iIx5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=HhBSV/GC; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mteD/1KDK+T1fTRguVE6yXiEGI6sRP9jhnJ1qZb+a4s=; b=HhBSV/GCjzvCkXx6FzdhnXIfcT
	gaQsw/Ubqd8CoGnvVVbYGdcK55QS8QNIFYS4yMLeyUoly6ZkNKVd9ObR1GEEyY6jcQtckVJV5PtxS
	a8HKGS0ki7v7m2WMxqszsPOgN5L2p3g+N/ZVEDxFCxhE5m1Vs7mPyGV1KiM7RjfWX7S4QVE1Y3+xm
	shFUBfO1OuPad5SEcD2b0mMIRBke3v81GvWL60oDVa1xEDDJM3CKYI55IMmWqJaT5lAG5uhzpPqtG
	XJe5k+txxsZ58wb2wK8E8rLVusLBVKSZ7NBgour+Na0ht1XWLcyoFew3EJE96x2O/K6EM9EuLaZyo
	SlYLgpBA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vnfPI-000000004RN-2s5D;
	Wed, 04 Feb 2026 17:07:08 +0100
Date: Wed, 4 Feb 2026 17:07:08 +0100
From: Phil Sutter <phil@nwl.cc>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, fw@strlen.de,
	pablo@netfilter.org
Subject: Re: [PATCH nf-next v3] netfilter: nf_tables: add math expression
 support
Message-ID: <aYNurHgLqfnX07NB@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	fw@strlen.de, pablo@netfilter.org
References: <20260204152358.11396-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204152358.11396-1-fmancera@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10617-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: B3665E9E9F
X-Rspamd-Action: no action

Hi Fernando,

On Wed, Feb 04, 2026 at 04:23:58PM +0100, Fernando Fernandez Mancera wrote:
> Historically, users have requested support for increasing and decreasing
> TTL value in nftables in order to migrate from iptables.
> 
> Following the nftables spirit of flexible and multipurpose expressions,
> this patch introduces "nft_math" expression. This expression allows to
> increase and decrease u32, u16 and u8 values stored in the nftables
> registers.
> 
> The math expression intends to be flexible enough in case it needs to be
> extended in the future, e.g implement bitfields operations. For this
> reason, the length of the data is indicated in bits instead of bytes.
> 
> When loading a u8 or u16 payload into a register we don't know if the
> value is stored at least significant byte or most significant byte. In
> order to handle such cases, introduce a bitmask indicating what is the
> target bit and also use it to handle limits to prevent overflow.

This part puzzles me. IMO byteorder conversion is needed for arithmetic
on multi-byte values in non-host byte order.

Since nftables only knows host byte order and network byte order, the
only case to consider is Little Endian host with NBO data. Registers are
filled "from left to right", so (u16)0x1337 and (u32)0xfeedbabe look
like this when stored in Network Byte Order in registers:

{ 0x13, 0x37, 0x00, 0x00 }
{ 0xfe, 0xed, 0xba, 0xbe }

Interpreting those buffers as u16/u32 on Little Endian results in values
0x3713 and 0xbebaedfe. Any increment/decrement on those values leads to
wrong results.

Maybe there's a hidden secret in 'bit_unit', but even if you calculate
the right value to add/subtract from the right byte (0x100 and 0x1000000
in our examples), a possible carry-over bumps the wrong byte.

Assuming that I didn't entirely miss the point you might want to have a
look at recent libnftnl/nftables commits informing libnftnl of payload
byteorder for host byteorder independent debug output (with correct
values). Particularly interesting are nftnl_*_set_imm() functions. Maybe
this allows you to annotate math expression with data byteorder so it
may perform byteorder conversion as needed.

Cheers, Phil

