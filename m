Return-Path: <netfilter-devel+bounces-12449-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLR4Hqjs+mn3UQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12449-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 09:24:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56124D72C6
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 09:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D0F3014688
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2026 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CCF36AB5E;
	Wed,  6 May 2026 07:24:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171B285C8B
	for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052257; cv=none; b=fBPgjLSXddeg9PWSLedQe6h8p93ttkURDRIiTGdG6WAoesFoTjzg2CbBO0VVmIPpq3kZBNxnX+ZORXkQiffl8eGpOnFDsFIUIn9L7SbGUN10BX04KCCut8/ZIXLd+13cIv5twAooSGR0KoW0r+enD3lSvcysxPLSxs/LjJBXJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052257; c=relaxed/simple;
	bh=Iud3jS8pVNX73szR1PWxLLIbcpL+lsS2CBaiOpY+iO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZpfk7Ity+T3TgSRygKrjBPdXiSrfNpxYyBUZ243FMxbZbqL2Gb+K7t6y7ou5SqeT+tekg/gkPhPChIJA7MFjVAWkLxV5J82fVL/abFSzubbq9uszDWSisHbE+/mbT+Pe0hanG+4VDwlXfmiBDBPPWgmpD12sEWf1XH+ZHb41qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 38A9C605F3; Wed, 06 May 2026 09:24:07 +0200 (CEST)
Date: Wed, 6 May 2026 09:24:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] scanner: enable verdicts in rate scope too
Message-ID: <afrsln49qZ8NEw_G@strlen.de>
References: <20260505103739.25949-1-fw@strlen.de>
 <afn7YBi361kCLOcY@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afn7YBi361kCLOcY@orbyte.nwl.cc>
X-Rspamd-Queue-Id: E56124D72C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12449-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]

Phil Sutter <phil@nwl.cc> wrote:
> On Tue, May 05, 2026 at 12:37:30PM +0200, Florian Westphal wrote:
> > Blamed commit added first use of exclusive start conditions in the
> > nftables parser.
> > 
> > Inclusive start conditions extend the grammar:
> >  - token NEW_COND will start to match in scanner.l
> >  - all other known tokens remain valid
> >  - bison calls back into scanner.l (via scanner_pop_start_cond())
> >    when it has parsed a complete rule.
> > 
> > Exclusive start conditions work in the same way, but with a slight
> > difference: Once we enter SCANSTATE_RATE, ALL OTHER tokens that are
> > not SCANSTATE_RATE or tagged as <*>, will stop matching.
> > 
> > This was done to allow something like 1 mbytes/second get handled
> > via NUM MBYTES SLASH SECOND rather than STRING (which is no longer
> > in scope).
> > 
> > This is a problem: in nftables, there is no end-token for
> > the 'rate' keyword.  The scanstate is popped the same way as for
> > the inclusive start conditions.  But flex is greedy.  By the time
> > we call scanner_pop_start_cond(), next token has already been parsed
> > according to RATE rules.
> 
> Oh crap, sorry for the mess. Looks like I relied too much on 'make
> check' instead of verifying Bison's lookahead doesn't break it.
> 
> > This breaks following rule:
> >   nft add rule .. limit rate over 1 mbytes/second drop
> >   Error: syntax error, unexpected junk
> >   expected any of: end of file, newline, semicolon, [..] drop, continue ...
> > 
> > Problem is that flex parsed 'd'(rop) while in SCANSTATE_RATE.
> 
> Yes, this is the '<*>. { return JUNK; }' rule which catches invalid
> input.
> 
> > There is no good solution for this problem (aside from altering the
> > grammar to be explicitly scoped, e.g. limit rate { over ... }
> 
> Not an option, right?
> 
> > Another alternative might be to add some string-alike catchall rule to
> > <SCANSTATE_RATE> in scanner.l and use that to pop state + rescan via
> > yyless(0).  But it feels even more gross than this.
> 
> I tested this using the following in scanner.l:
> 
> -<*>.                   { return JUNK; }
> +<SCANSTATE_RATE>.      { scanner_pop_start_cond(yyscanner, SCANSTATE_RATE); yyless(0); }
> +.                      { return JUNK; }
> 
> It causes "start-condition stack underflow" with below sample rule, so I
> also had to turn 'close_scope_rate' into a NOP in parser_bison.y.

Yes, I forgot to mention this.  Yes, with above rule RATE state exits
from scanner.l only.

> Is
> this implicit scan state dropping upon reading junk OK? Should we follow
> that path with exclusive start conditions?

No idea.  I *think* enabling the relevant keywords via <*> is the safer
approach, yyless undo seems worse to me.

> Explicitly marking "global" tokens as such could be regarded syntactic
> sugar for further attempts at reducing tokens accepted in global scope.
> If you think that's fine, I'll prepare a patch (and an excessive test
> case, I guess).

I think its fine.  Thanks for extending test cases.

