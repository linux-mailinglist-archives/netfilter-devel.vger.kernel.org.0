Return-Path: <netfilter-devel+bounces-10990-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFYTGjt2qWl77wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10990-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 13:25:31 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87D21193B
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8CC83097BC0
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2026 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77D39C626;
	Thu,  5 Mar 2026 12:20:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FA39C643;
	Thu,  5 Mar 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713251; cv=none; b=RrVuuVPqxI9ZyqCaXCNKZjwStJfPotX8PO3XwT7kO3MeYhm7R9mTjRnrPkQWDfDH3DHiq9jie6uXuJNQdlmdsGjzmjEEz/dz/Sb6atJ5WB1fB9ww/2byG+ejIfyzDIbYk+jX0HUJcajF6ifvQgeODPWD1A/QLgCmM8ohXXun8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713251; c=relaxed/simple;
	bh=cAqafkhKv1XbRiaXRprWqxJBjtu3RCVvAOegzaeIZoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvVCrAYEGmLAJ/VAFG8da3K7AhrHEVPIw53fUQzKii0elAcBxOCEXoGm32bs6Cda7dD/olHcZzuT79afUusXC0LDUTmCFhMkDhpETb1HrIC1CQy4r8MsNX5e4nzyEZ1vuOy9eMX4EoEcSwtsawwztD1RqODxo4xN3BuniRMwO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0E9B460216; Thu, 05 Mar 2026 13:20:44 +0100 (CET)
Date: Thu, 5 Mar 2026 13:20:43 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net 0/4] netfilter: updates for net
Message-ID: <aal1G5h9AWfY8OgS@strlen.de>
References: <20260304172940.24948-1-fw@strlen.de>
 <aaiqrFrus1syOmlT@chamomile>
 <aalHS6-11HUHy-Dd@strlen.de>
 <aalPfgw5Ypsik8NY@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aalPfgw5Ypsik8NY@chamomile>
X-Rspamd-Queue-Id: 2A87D21193B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10990-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.908];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Yes, it looks broken.  I wonder why we have no tests for this stuff.
> > First a vlan push function that cannot have worked, ever, now this
> > seemingly reversing-headers variant:
> 
> This used to work, I just accidentally broke it when using
> skb_vlan_push() in net-next.
> 
> I will post fix.

Ok, thanks.

> > For PPPOE, its pushing the ppppe header to packet, so we get
> > strict ordering, later header coming in the stack gets placed on
> > top, before older one.
> > 
> > Here, first vlan push gets placed into hw tag in skb (which makes
> > sense, let HW take care of it).
> >
> > But if 2nd comes along, then that gets placed in the packet
> > and the hwaccel tag remains?
> >
> > What to do?  Should be nuke vlan offload support from flowtable?
> > It appears to be an unused feature.
> >
> > I have low confidence in this code.
> 
> Could you elaborate more precisely?

Add bug in nf_queue -> kselftest will likely barf
Add bug in nf_tables control plane -> nftables shell and/or
python tests will likely barf
Add bug in conntrack -> kselftest will likely barf

Add new bug in flowtable vlan -> nada.

I think we should refuse both new features and refactoring patches going
forward unless they come with either update to existing kselftest, or a
new test or a test in nftables.git.

