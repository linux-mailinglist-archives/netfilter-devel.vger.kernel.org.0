Return-Path: <netfilter-devel+bounces-11220-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPAVIU7ht2lDWwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11220-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 11:54:06 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE002984B2
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 11:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E74D3300292C
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1538F953;
	Mon, 16 Mar 2026 10:54:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0338F94B;
	Mon, 16 Mar 2026 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658441; cv=none; b=GrEDFAyW3IopIT/0eN4UycDCin9Aqu1Lr/4BeQ6FGoxtE32AllBIxvc4S78VUNr+y4zcwTrrWs4s0nm22BaMpuhaCcn7blZdiOxqX/vDPwoaYegZY33EB59iI3Dhkt+f4A/xoNgLTtInuhyQOTKx0KZ/s3ZKwa63Iw3FrgT/0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658441; c=relaxed/simple;
	bh=dUY7N59lXSwH+T+TmmlAhBRmr9UHI1MWpYkGQ/BXsvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZv8SENb/ab8XQLQHVxYnO938kzW5wssr69qSHPrb0AuORPWMOUZG5DuHQwIO5SLP9e5xBRi7ZkKYBBfv28vjCyQ+CYTdA/IXINdn2kI+b8k+TB9EIRrTW1ONC0ThlGcTtnfmNz1Dec0+aXxPph+bd9QDaHtwukmlx8/oaYGQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B604D605C3; Mon, 16 Mar 2026 11:53:56 +0100 (CET)
Date: Mon, 16 Mar 2026 11:53:56 +0100
From: Florian Westphal <fw@strlen.de>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <abfhRFfZ1LOgWEsf@strlen.de>
References: <aaxe-uH2Qr6qM4E9@v4bel>
 <aax2yZtJce0d19gd@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aax2yZtJce0d19gd@strlen.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11220-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FE002984B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Florian Westphal <fw@strlen.de> wrote:
> Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > flow_action_entry_next() increments num_entries and returns a pointer
> > into the flow_action_entry array without any bounds checking.  The array
> > is allocated with a fixed size of NF_FLOW_RULE_ACTION_MAX (16) entries,
> > but certain combinations of IPv6 + SNAT + DNAT + double VLAN (QinQ)
> > require 17 or more entries, causing a slab-out-of-bounds write in the
> > kmalloc-4k slab.
> > 
> > The maximum possible entry count is:
> >   tunnel(2) + eth(4) + VLAN(4) + IPv6_NAT(10) + redirect(1) = 21
> > 
> > Increase NF_FLOW_RULE_ACTION_MAX to 24 (with headroom) to cover the
> >  
> > -#define NF_FLOW_RULE_ACTION_MAX	16
> > +#define NF_FLOW_RULE_ACTION_MAX	24
> 
> This fix looks rather fragile.
> 
> What guarantees that this stays right-sized?
> 
> Can you add a BUILD_BUG_ON or if needed, run-time check?

Ping.  I'm not even sure if there is a bug to begin with, see Pablos
response.  How did you conclude there is a missing bounds check and that
this increase is the best fix?

Normally there should be a check that prevents such a configuration.
If thats missing, please add one instead of increasing this define.

