Return-Path: <netfilter-devel+bounces-13786-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SJHSHeGFT2rvigIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13786-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 13:28:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42A6730522
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 13:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=kzlrHabr;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13786-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13786-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 887FA3066432
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4538039903B;
	Thu,  9 Jul 2026 11:02:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE5224AFA;
	Thu,  9 Jul 2026 11:02:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594955; cv=none; b=INAzvajh6AeDBHUuu6jGdliQN2Pv1TDyUF+IdkaekZ2lHDcdyH7UUBQdTkkEGO5VaIYiXgUUBVAUoRas3b47YLHQXHEMuxCXCwsZwMybKwltdjzjrxAyXtXbiv+hdA3Vm4ye0uoX9S3dORAwZww9FcgjrBlvoNH9H31sg6jInkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594955; c=relaxed/simple;
	bh=nnk5Rz1kYw2zZULDVt8awFwRNPvlIZWfLgoZWp7dgMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVpoUmObt1IEZCPLs6uYstvT8spkUxbpJXmOkoVpmNWW11jCXRAsmSHOwsZEeVp8KlqaUyLwQVoH6AjzmmVgjkL8CeXIy0H6IAnJz54Vwd9BPF556LxEfVvFE2C+4qQqSrZmJfJI+AfnC3iyvcF8Hk9BYyU6I6LWshjpkdEpuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=kzlrHabr; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7xjQJMviFKnzTELuYGNmzcaww74kqC+HYMZ9FxE7SQA=; b=kzlrHabrD+u5h9b4AXLuKKICJO
	xW6h7ZntbErzk97qbSjzUF4hiQmC/rVoGMwCul5w9PjNB4RPrc+pPjddtNT3URedcRCG4GFPfDiTY
	1hxpK0ymyYUdteOgDLIaW8eaBu10BcC8h8gmV0ltn8j24oEUHZAaNPkZ8xeIHvZKFa/igGewICfOP
	JpKt2bjgqyafej8eQb62zPnPBtvIq1j9jN8GKJDoI0RTWF85WOzHuCp9LA15s9/OY8ScHT3WFo8w2
	UEt8OP/vGVaxeKjM1Q/Uu3Ewhty/ZjCLrhO+WnywVt9nH2dS0BtKPp6YwQwgCQKrsk/5muX6vRYUL
	bA6cw3DQ==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whmWP-000000004eG-2c12;
	Thu, 09 Jul 2026 13:02:25 +0200
Date: Thu, 9 Jul 2026 13:02:25 +0200
From: Phil Sutter <phil@nwl.cc>
To: Zhixing Chen <running910@gmail.com>
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: ip6tables: set hotdrop for malformed
 extension header matches
Message-ID: <ak9_wZz054a6JMb5@orbyte.nwl.cc>
References: <20260709063012.33160-1-running910@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709063012.33160-1-running910@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	TAGGED_FROM(0.00)[bounces-13786-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:running910@gmail.com,m:fw@strlen.de,m:pablo@netfilter.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nwl.cc:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C42A6730522

Hi,

On Thu, Jul 09, 2026 at 02:30:12PM +0800, Zhixing Chen wrote:
> The hbh, srh and ipv6header matches have paths that return false for
> malformed IPv6 extension header packets without setting hotdrop.
> 
> For hbh, strict option parsing stops when the option type or length field
> cannot be read, or when advancing to the next requested option would
> exceed the available header data. Mark these packets for hotdrop instead
> of treating them as a rule mismatch.

There is another candidate for hotdrop in there, e.g. the "Packet
smaller than it's length field" check in line 76. Or is this a
legitimate non-match?

Given the many common blocks, maybe introduce a 'hotdrop' goto label to
jump to instead of break/return?

> 
> For srh, keep a missing SRH as a normal mismatch, but set hotdrop when
> header lookup fails for other reasons, when the SRH fixed header is not
> present, when the advertised SRH length exceeds the available skb data, or
> when SID selector reads fail.

I think the 'srh->segments_left > srh->first_segment' case is also a
candidate:

According to RFC8200, segments_left contains the "Number of route
segments remaining, i.e., number of explicitly listed intermediate nodes
still to be visited before reaching the final destination."

RFC8754 reads: "Last Entry:  contains the index (zero based), in the
Segment List, of the last element of the Segment List." ('first_segment'
is called Last Entry in there.)

AIUI, segments_left should never exceed first_segment in a packet.
Though RFC8754 mentions a case where "Segments Left is greater than Last
Entry", but it's about HMAC verification and it doesn't explain why it
should happen.

[...]
> diff --git a/net/ipv6/netfilter/ip6t_ipv6header.c b/net/ipv6/netfilter/ip6t_ipv6header.c
> index c52ff929c93b..0568eb99eb1c 100644
> --- a/net/ipv6/netfilter/ip6t_ipv6header.c
> +++ b/net/ipv6/netfilter/ip6t_ipv6header.c
> @@ -53,8 +53,10 @@ ipv6header_mt6(const struct sk_buff *skb, struct xt_action_param *par)
>  			break;
>  		}
>  		/* Is there enough space for the next ext header? */
> -		if (len < (int)sizeof(struct ipv6_opt_hdr))
> +		if (len < (int)sizeof(struct ipv6_opt_hdr)) {
> +			par->hotdrop = true;
>  			return false;
> +		}

This check is actually redundant, no? The following call to
skb_header_pointer() should discover the skb->len underrun?

Cheers, Phil

