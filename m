Return-Path: <netfilter-devel+bounces-13173-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +FcGBTKUKGr2GQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13173-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 00:31:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58778664967
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 00:31:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13173-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13173-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B244E3019BA9
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEDB3EF66A;
	Tue,  9 Jun 2026 22:25:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DE3655C4;
	Tue,  9 Jun 2026 22:25:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043936; cv=none; b=CffND7Ufgr/4kBvrv3zp10bAjEWJGg12UpnEa3sR9d/ThErU3Tspyfu2Qs+AsgiO/7uuFh9NlhnG6FCiIF0ThK1kw/KATzLNJ61CjTUhzx7WLFA6qslr6/8KFlMhmfesFQIVbTzmoAR198F7Kjus8C+WOBSHvKKkDcSgpK+chTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043936; c=relaxed/simple;
	bh=wxdEyR0Jsul6J54VQA36KmH/WMKdRF/uqmzrtbVrmq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADgzC9iUe/Y7Tzk4/ixa67l47W9vurQN2vnUdFUTB3qfN/GY5MhSI4bOwZjfXyt77YYrX0qZkR+FRyyiY2qt58kc3e+eowRZJG8g826EoNzw53F8o4zW5MITshhe66CrHKRccrqN9jhu8/UjtP3omRg2uJ+4lJsDNEFBja5NlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EF70F60C94; Wed, 10 Jun 2026 00:25:31 +0200 (CEST)
Date: Wed, 10 Jun 2026 00:25:30 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dummy: add phony ndo_setup_tc stub
Message-ID: <aiiS2igkkIvGLtpM@strlen.de>
References: <20260609142813.9197-1-fw@strlen.de>
 <20260609151517.186b1cac@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609151517.186b1cac@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13173-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58778664967

Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  9 Jun 2026 16:28:09 +0200 Florian Westphal wrote:
> > Unlike netdevsim, dummy is a data sink so no capabilities (e.g.
> > u32-style matcher, vport device redirects, PPPoE header push/pop etc).
> > have to be implemented.
> 
> If no "peer" is configured netdevsim is also a data sink.

Yes, but you can configure peers.  And then this fake offload stub
is a liar.

I would expect that offloads for netdevsim actually work, i.e.
that a shaper shapes, that ets offload does delay packets and
in case of flowtable that it will move skbs from one vport to
another (if that was requested).

> We added netdevsim because dummy and veth started accumulating
> "features" which were clearly just for test harnesses. Would be
> great if we could stay the course and put whatever changes you
> need in netdevsim, even if it requires some hacks.

Is a lot more work.  I don't have time ATM to implement a u32-style
packet matcher or a fake software flowtable.

> Is there anything fundamentally blocking the use of netdevsim?
> Or is it just convenience (since netdevsim is a bit of a PITA
> to create and establish the name of)?

I played with netdevsim, aside from the above (i.e., I don't expect
netdevsim to say 'offloaded' and then ignore all the offloaded
commands...) the worst part is the naming and the behaviour when
creating new devices while in a network namespace.  Test is spawned via
'unshare -n' -- I did not find a way to really extract the new device name
reliably except via 'ip link'.

I think thats solveable, so yes, I could make netdevsim lie instead.

But I don't think its the right thing to do.

If you disagree and think that this is fine I can retarget this to
netdevsim, no problem.

