Return-Path: <netfilter-devel+bounces-10723-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCkRFP2IjGn3qgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10723-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 14:49:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED14124F0E
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36B63016EEB
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC242D0C7A;
	Wed, 11 Feb 2026 13:49:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775120DD48
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817786; cv=none; b=s7LnWs3IO9hlnqbrd8xO8l2DWJW7dv92+Qob/4D4HTyjlsariiOdSSO5YrMlHnyUGrspHSmUggxatES2TA5SBNGywTzvyDSsSV1Uj5HlQAV5y2POv2BDGl1bVUemzqD7Uj1pZ+D+V8e6ijBdmpJuIILzz6UhX5wx//zNo1TQ8GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817786; c=relaxed/simple;
	bh=+sDedu1pFb7/6RahhERpL+g5yqWpcAa58pyj4TbQ+MU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvCmWrzGHLC7Gs8puFSsj/x1kvOKZikPoB3Oh535dstiuo8zrBL/deCVirAuG8HJbWzwgygZGibeH/g1X0lLOotAY89ibKESUMj7nVlBtFvxdmBwdaBWeEIkWYqEVCQHNMS4BELJflikEUKWYdGnloOw8wHupQ5mAv5KpF2S5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 067DA605E7; Wed, 11 Feb 2026 14:49:42 +0100 (CET)
Date: Wed, 11 Feb 2026 14:49:42 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Alyssa Ross <hi@alyssa.is>, netfilter-devel@vger.kernel.org,
	Joshua Lant <joshualant@googlemail.com>
Subject: Re: [PATCH nftables] include: fix for musl with iptables v1.8.11
Message-ID: <aYyI9kN4FAgbFUA-@strlen.de>
References: <20241219231001.1166085-2-hi@alyssa.is>
 <Z2VaEv0u3ZPcWqye@orbyte.nwl.cc>
 <v654rm6mbtymzhavlbg2fu7irth4mkz4motq7vb7rzjql5ccqa@u7xv7uvdfvsl>
 <Z2VkJrkSLRmY9lAE@orbyte.nwl.cc>
 <Z38Ladz49yJcTC8p@calendula>
 <Z38PIVmu2jAVl1k2@orbyte.nwl.cc>
 <Z38STV2bWSlz4uxo@calendula>
 <Z3-emP_FzgGAYGUJ@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3-emP_FzgGAYGUJ@orbyte.nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nwl.cc,netfilter.org,alyssa.is,vger.kernel.org,googlemail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10723-lists,netfilter-devel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:email]
X-Rspamd-Queue-Id: 9ED14124F0E
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> On Thu, Jan 09, 2025 at 01:03:25AM +0100, Pablo Neira Ayuso wrote:
> > Hm. I am looking at include/uapi/linux/netfilter_bridge.h and...
> > 
> > #include <linux/in.h>
> > #include <linux/netfilter.h>
> > #include <linux/if_ether.h>
> > #include <linux/if_vlan.h>
> > #include <linux/if_pppox.h>
> > 
> > I don't understand why all those #include need to be there, this
> > header file contains only defines an enumeration... git annotate takes
> > me to:
> > 
> >   607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux")
> > 
> > Silly question: Does it break any netfilter userspace software if
> > #include <linux/if_ether.h> is moved from that kernel header file to
> > to the non-uapi netfilter_bridge.h header file.
> 
> Silly counter question: Does removing an include statement break UAPI?

Yes, it risks uapi breakage.

> BTW: I see only a single UAPI kernel header include from netinet space
> (include/uapi/linux/mptcp.h) and it's for compat reasons (06e445f740c1
> ("mptcp: fix conflict with <netinet/in.h>")). Speaking of which, what if
> we added:
> 
> | #ifndef __KERNEL__
> | #include <netinet/if_ether.h>
> | #endif
> 
> early into include/uapi/linux/if_ether.h? Aside from any header caches,
> this should fix all of user space at once, no?

Phil, would you send a formal patch to make this workaround *ONLY* in
netfilter_bridge.h (06e445f740c1)?

That way the fix can be propagated to nftables.git without having to
adjust cached headers on every update.

