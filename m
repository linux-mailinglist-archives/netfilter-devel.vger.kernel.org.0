Return-Path: <netfilter-devel+bounces-10427-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHp6FPG2eGlzsQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10427-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 14:00:33 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4925949B0
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C98F3019116
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00282737F9;
	Tue, 27 Jan 2026 13:00:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E01A267;
	Tue, 27 Jan 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518830; cv=none; b=nP7aStKlY6c22XsKd47zcHS47SDRg6fiw1ZfKwJ9NHIV2qUGlBlU5ZDSthSV7/yINKMGAgq9usSRXqklCE31V2rCfjMTrZGc5grLBQp+UxuEu1RrvzVJR8hc0wAN9ErufwAnyVpbwmueS+EqVUjrJZRMXcKN6Qis1nTAfU2vZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518830; c=relaxed/simple;
	bh=oLR+gZMbDd/CCv9Wa5C4E2lll9KuLUj11Zia3brqlHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Q0zC7TjSXjIBxY8ZCHq9KiJOt/23b6Z8RIyQTwJ5bT/UWCXoNwz2JAbfUbcLtYHALNBuXKY1obgbl8y+pmdrrmjk4TBRpS2QWJu/4nlGk5HkAKYvi/j6lSiejDPVaSuIB894FQcR3qe8OQO9s15SrRBRRjmJjdrtp1s0WlHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 23DA96033F; Tue, 27 Jan 2026 14:00:27 +0100 (CET)
Date: Tue, 27 Jan 2026 14:00:27 +0100
From: Florian Westphal <fw@strlen.de>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH v6 5/6] doc/netlink: nftables: Add getcompat operation
Message-ID: <aXi26_vIXqQPhopG@strlen.de>
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
 <20260121184621.198537-6-one-d-wide@protonmail.com>
 <aXiiYOxuXVn5YhXG@strlen.de>
 <Y2VtJPFWA2Kgxe16KslviULQU9LRZsdYFsoUD6VZ9CH-49a2P2fwiQ9B03i3Rmfq6tUczD-oiGpWCCs9aPGwwD2N-vVzy4cFIZT7F7-83Fc=@protonmail.com>
 <aXiwkXKg7uvIon4p@strlen.de>
 <2mi8BfZGa57pxicf4pXNT_oDJ3bvV7pByJOBhG8e7u_3eBbjubS3YJ88xHp4oDiMi3iY20zcG6FgF8_m5nsJJ_3CYHNftjAL_4EAqN5zeU0=@protonmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2mi8BfZGa57pxicf4pXNT_oDJ3bvV7pByJOBhG8e7u_3eBbjubS3YJ88xHp4oDiMi3iY20zcG6FgF8_m5nsJJ_3CYHNftjAL_4EAqN5zeU0=@protonmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10427-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,nwl.cc];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: B4925949B0
X-Rspamd-Action: no action

Remy D. Farley <one-d-wide@protonmail.com> wrote:
> > Its used by compatibility mode, it requires an nft binary linked
> > to libxtables, native nftables doesn't need it.
> > 
> > I would prefer not to mention its existence.
> 
> Ah, I see. Netlink-bindings have a tool to decode netlink communication, so
> it's a bit awkward to show a bunch of unkown-operations on a common command.
> I'm fine keeping it downstream.

No, showing unknown-operations is even worse.
Maybe just document in commit message that this is to avoid
clutter and present something more readable.

And perhaps mention that this is only for iptables-nft in the yaml file too.
(nft uses it on 'nft list' only if it encounters a rule added by iptables-nft).

