Return-Path: <netfilter-devel+bounces-12486-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BUTpBm0M/WmFXAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12486-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 00:04:29 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE684EF910
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8873003621
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 May 2026 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FC346E75;
	Thu,  7 May 2026 22:04:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E8332906
	for <netfilter-devel@vger.kernel.org>; Thu,  7 May 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191465; cv=none; b=LRfvjk8y5zFqvwSmnNGpqpbVvUlYZUuZJJkaG1ChHbwJrR4b81onhkmRSiX6rOae/+nHtchbJtWtibmJUbmPj9Mik8xgW7CAisD0lhSz3eazYGUhKV79WU1rmdEys0/bzixEOTLZ5ssulYqqqDfD7gTTimJaVEwXusuBGJH7/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191465; c=relaxed/simple;
	bh=9jukIn/2fv24sOGnWj6EB+Rmg+yMOfDzuJImuQo1g1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBUeHnT8w9elPYptcGYqlCjeLC6oGvZWR4f8vf0O8QYoc1gGZ2UWjRFYFfXF3V/dWjmn0OX7FFOIJEPGgredF05lktpkoUXDmNoTuDtlfs/JA5dQ0tJcD1Dn+LnTk6hCY6qBnEks4XuYGrpcowwm4wwWG6INHMc+lHPacvtcPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 40B5160D43; Fri, 08 May 2026 00:04:21 +0200 (CEST)
Date: Fri, 8 May 2026 00:04:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] scanner: Accept all statements' first words in all
 scopes
Message-ID: <af0MY2qPAuNwULFo@strlen.de>
References: <20260507203824.3560155-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507203824.3560155-1-phil@nwl.cc>
X-Rspamd-Queue-Id: 6DE684EF910
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-12486-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> To fix for token lookahead with exclusive start conditions, we must
> accept all keywords which may immediately follow the exclusive scope in
> that scope as well. This affects basically the first word of every
> statement which may follow a limit statement.

Hmm.  Can you give examples for some of these?

> -"@"			{ scanner_push_start_cond(yyscanner, SCANSTATE_AT); return AT; }
> +<*>"@"			{ scanner_push_start_cond(yyscanner, SCANSTATE_AT); return AT; }
> +<*>"set"		{ return SET; }

I have a hard time figureing these two out.

> +<*>"socket"		{ scanner_push_start_cond(yyscanner, SCANSTATE_EXPR_SOCKET); return SOCKET; }
> +<*>"tproxy"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_TPROXY); return TPROXY; }

Yes, I can see those at least theoretically.

> +<*>"delete"		{ return DELETE; }
> +<*>"update"		{ return UPDATE; }
> +<*>"add"		{ return ADD; }

Hmm.  Care to enlighten us?  Is this for a theoretical thing only?
(limit + flowtable...?)

> +<*>"reset"		{ scanner_push_start_cond(yyscanner, SCANSTATE_CMD_RESET); return RESET; }

?

> -"last"				{ scanner_push_start_cond(yyscanner, SCANSTATE_LAST); return LAST; }
> +<*>"last"		{ scanner_push_start_cond(yyscanner, SCANSTATE_LAST); return LAST; }

This one is also strange.  Normally, after limit, one would expect a
meaningful action (verdict, log, etc. -- something that has side
effects).

> +<*>"log"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_LOG); return LOG; }
> +<*>"queue"		{ scanner_push_start_cond(yyscanner, SCANSTATE_EXPR_QUEUE); return QUEUE;}

Makes sense.

> -"limit"			{ scanner_push_start_cond(yyscanner, SCANSTATE_LIMIT); return LIMIT; }
> +<*>"limit"		{ scanner_push_start_cond(yyscanner, SCANSTATE_LIMIT); return LIMIT; }

limit limit?


> -"quota"			{ scanner_push_start_cond(yyscanner, SCANSTATE_QUOTA); return QUOTA; }
> +<*>"quota"		{ scanner_push_start_cond(yyscanner, SCANSTATE_QUOTA); return QUOTA; }

limit + quota?  Strange combination, but ok.

> +<*>"reject"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_REJECT); return _REJECT; }

Makes sense.

> -"snat"			{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return SNAT; }
> -"dnat"			{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return DNAT; }
> -"masquerade"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return MASQUERADE; }
> -"redirect"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return REDIRECT; }
> +<*>"snat"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return SNAT; }
> +<*>"dnat"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return DNAT; }
> +<*>"masquerade"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return MASQUERADE; }
> +<*>"redirect"		{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_NAT); return REDIRECT; }

Make no sense IMO, combining limit with nat table?
Is there a use case for this or are you just being conservative to not
break some random stuff?

> +<*>"th"			{ scanner_push_start_cond(yyscanner, SCANSTATE_EXPR_TH); return TRANSPORT_HDR; }

Yes, however, I'm not sure its worth it.  Because its a strange flow.
th ... limit ... -> makes sense to me.

limit ... th ... -> not so much.

'meta mark' or 'mark', or 'ct' , yes those make sense because it would
be natual to e.g. 'mark set x' for traffic shaping for example.

[ This is not a nack, I am just curious ]

