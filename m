Return-Path: <netfilter-devel+bounces-10633-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A1eKpP8g2kXwgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10633-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:12:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E17EDE4F
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2D2303526D
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF52288C08;
	Thu,  5 Feb 2026 02:10:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8F2765D7
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257432; cv=none; b=nDSgWxElKi1Fr+JEHVsDu1pETM+eB6vvQq3lHRtBdO3T+BT64x7PY+ed8thv3R7eJW0XzzfA+Gr/kDMmXRhbyq+IIwvjWtGs75WK2fpY8ULcRrZcY07zBVEZZIudKogu6bLNQX7Cb+4htJTFLZx7aVVfUdR0pdsV+0ScMW67vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257432; c=relaxed/simple;
	bh=Mi6TqFE7aORrdGRLbiuUv4EncCHs45NYZ+mDxtCY/gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXJPaIKfY1mULu7odxyYUdPAYnbncsKpmcZmhg3UMkmsXDuYBQ4KksUiSQQphB5p0lbR/RVbwIXfFG8LByAGgC6pZ7RZumP598ysGWN1ZdDxk75JrgVvu2WFUMQqXXRdi9tq88CnCfuaVuU7ocEDxj1gMUizB7umAicjEClsX9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 41D546033F; Thu, 05 Feb 2026 03:10:29 +0100 (CET)
Date: Thu, 5 Feb 2026 03:10:24 +0100
From: Florian Westphal <fw@strlen.de>
To: Yi Chen <yiche@redhat.com>
Cc: pablo@netfilter.org, phil@nwl.cc, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] test: shell: run-test.sh: introduce NFT_TEST_EXCLUDES
Message-ID: <aYP8ELzFrWADndpT@strlen.de>
References: <20260204144940.63422-1-yiche@redhat.com>
 <aYNgX-nh04sAQdU8@strlen.de>
 <CAJsUoE03i1S6QmnSC++Qijh-q3J+QXdHek=j6E46R7+8-oZ7=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJsUoE03i1S6QmnSC++Qijh-q3J+QXdHek=j6E46R7+8-oZ7=w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10633-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30E17EDE4F
X-Rspamd-Action: no action

Yi Chen <yiche@redhat.com> wrote:
> Some patches may be considered too aggressive to backport to
> downstream releases.
> 
> For example:
> netfilter: nf_reject: don't reply to ICMP error messages
>
> When this patch is missing,
> tests/shell/testcases/packetpath/reject_loopback reports a failure.

Right, that makes sense.

> In addition, introducing this exclude feature makes it easier for
> downstream streams to run this test suite while excluding known SKIP
> items.
> This also helps to quickly detect newly introduced SKIP items, which
> may indicate new bugs.

All good reasons, I'll place this in the commit message before applying.

Thanks!

