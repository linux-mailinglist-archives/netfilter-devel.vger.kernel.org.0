Return-Path: <netfilter-devel+bounces-12202-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPqKDjz77mlT2gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12202-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 07:59:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9646D644
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 07:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D022E3011F25
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79A338595;
	Mon, 27 Apr 2026 05:56:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E436998F
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269402; cv=none; b=l1mHVs+TRiE0ue9c/g5aoFSw21ewdM2Gm+5MSWy45T7XT/yAPgKy07Z1qUhwRReJi4T7+JbLjIZUZbWufb3TVUNAX4LgqL0tREBeI+ELqS/lGoqVbsP6pto5Xzoq9VRysVj8O+j6B7immSjZgLD2CPg8BKGWouttP469HTiaa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269402; c=relaxed/simple;
	bh=PIG9bW07NR3ONaKyaZFCOHDv3oEp2APTvF/He80COsU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1iDmpveJVKrQ8VH4axqePsWa2euXerjuGj5VFgkmPOF/0UsMcYF7jEICG0Pk7elylPolSz4AikGqR3TXsEluZ+qV2AVNdwRdmwy3s7I09MMvcn3dtdZq8tynVWrUKOuOnkTwZAQh3MGz4gA2DZ4/e4u/CrLkFc+N0y2sa5d/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 05F3060640; Mon, 27 Apr 2026 07:56:37 +0200 (CEST)
Date: Mon, 27 Apr 2026 07:56:37 +0200
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: add test case for netdev + dormant
 table
Message-ID: <ae76lUWtvOUDuOCz@strlen.de>
References: <20260426144456.146241-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426144456.146241-1-fw@strlen.de>
X-Rspamd-Queue-Id: 7BD9646D644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12202-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]

Florian Westphal <fw@strlen.de> wrote:
> both commit update and abort path need to release memory associated with
> netdev hooks.  kfree gets skipped because it mixes registration and
> allocation.

I have a kernel fix for this bug but I am waiting for the pending PR to
get merged before sending it, the fix depends on the new unlink+free
helper and doesn't apply to main branch.

