Return-Path: <netfilter-devel+bounces-12736-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HavFiGnDWpr1AUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12736-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 14:20:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0558D87D
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5654304E97A
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2F3DC4A7;
	Wed, 20 May 2026 12:17:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06F3D7D82
	for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279460; cv=none; b=NwmFSmdBowpP7uqknwIWx2c6bDTyZxFkHDhLokf014ZPP/xpdxyt6PYgZvQRpPL92nzpkVvQCJv4t/3UaraDcW2BiXf+zK8dzxqMJSK3qoa+Us6CxazDewkYwdYbBpvXQM7iOiSwbPDQ4cttsh6Y3dghfUhK5BZGdyGO7MvjPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279460; c=relaxed/simple;
	bh=yIabCz2BEUUI51YoOBYPpuyLDXGTJemzSWFTWnHysgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcmXx41eU70mOY5m/TOBGL6gaOg/ln8b++qjUQH9YBFou+O1hVYSRyfDbKQbdy/isDB91NZ4OqPKxS+WRPzQmH5Qv78oLg9fjPuBh2Sd4lzRhA9RnUjqS7EsDPywZXTzJFANDY3eGoLxKgzCp7/mk8XegNFGctMK3km4DWa4cSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 503E3607BF; Wed, 20 May 2026 14:17:36 +0200 (CEST)
Date: Wed, 20 May 2026 14:17:34 +0200
From: Florian Westphal <fw@strlen.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Igor Garofano <igorgarofano@gmail.com>, security@kernel.org,
	pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [SECURITY] nft_byteorder: incorrect u32* stride in 64-bit
 byteorder eval leading to firewall bypass
Message-ID: <ag2mXk1L4bL55GV1@strlen.de>
References: <CAOOOOYyfpwO7inyq2wXtpT0kY0s19-n4OZf2MCR62WRi7vzMMg@mail.gmail.com>
 <2026052028-grain-pencil-0d8b@gregkh>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026052028-grain-pencil-0d8b@gregkh>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,netfilter.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12736-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DMARC_DNSFAIL(0.00)[strlen.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,strlen.de:mid]
X-Rspamd-Queue-Id: 51C0558D87D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greg KH <gregkh@linuxfoundation.org> wrote:
> Can you turn this into a real patch that can be applied so you get full
> credit for resolving this issue?

No need, this code will be removed.  There are no users.
Patch is already pending in patchwork.

