Return-Path: <netfilter-devel+bounces-10863-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBdqL55XnmkjUwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10863-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Feb 2026 02:59:58 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA01905A1
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Feb 2026 02:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA49C3096677
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Feb 2026 01:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0209E25EF9C;
	Wed, 25 Feb 2026 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nymQXvCz"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C391FE45D;
	Wed, 25 Feb 2026 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984377; cv=none; b=kZbZyOs69f8NkoPpT0MuSlOkVpvUuTYOJ1cGxQqI5cwUrTmje3PONabYfSc3NMeLvV22yrWw5TnGubmGM9FdEqEhU203J1f6QW6Vg51954UvgK1uVGdnRQqFV/zAEt3N8aGZ9bnrBNB8LhG3uq9PX1CgJlAz3/ZehNlHNKtG3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984377; c=relaxed/simple;
	bh=i/biUd2rDEtE2nEDkGOA3//Fh0kr3ME9dH02WVsIbs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/4RWBdH/+aazfHkKPV1SF4l85mFPs1mlY1wFZ/fpjwS4r8HJDun6gwdJ/D+7QXS/dIOlMlV9DTFKfI875yX0hyMr1rJsFmLTVos8F08ROyfAhFDanL17ZpMl1NrpBdJXHYx3NyL+huykUL8b6qcoLIPtMfmRegq1Byk2Nkyph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nymQXvCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAC7C19424;
	Wed, 25 Feb 2026 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984377;
	bh=i/biUd2rDEtE2nEDkGOA3//Fh0kr3ME9dH02WVsIbs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nymQXvCzy4P7iuBwuxxkqnsRGGu3X5oOqtVpt1S5x1t9Nj8AO9/DP3DXBIf19QvgL
	 idHWbDhSxNHl0ZlIqSxxiME6eN3X9hPJyqyvQ7QVw+w4Rk8CkvfPTdcVb1DVgPBITv
	 6uiaEnN+/QOAK+PaGbPCdVVdT9srT/p2LF1SyPVCs8LMxD1w55QiNgjMqDdL1aR88b
	 /6x9eqnArIYVvGkVn4Kf4j0niD1TzR3uUVf+CcW1KtctktnVS+dYV0W8cGQ/lUtZaV
	 2hiNOyJF0sMo1O3wccYynMzF/4QPJ1SDqr9owauyBGmzqtmJvaXnP664PQ4QhvG0Qw
	 V4TS1CsnHZOyw==
From: Jakub Kicinski <kuba@kernel.org>
To: ericwouds@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	mostrows@earthlink.net,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	fw@strlen.de,
	pablo@netfilter.org,
	andrew+netdev@lunn.ch,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	phil@nwl.cc
Subject: Re: [v19,nf-next,4/5] netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
Date: Tue, 24 Feb 2026 17:52:56 -0800
Message-ID: <20260225015256.967692-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224065307.120768-5-ericwouds@gmail.com>
References: <20260224065307.120768-5-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10863-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,earthlink.net,vger.kernel.org,redhat.com,google.com,blackwall.org,strlen.de,netfilter.org,lunn.ch,nvidia.com,davemloft.net,lists.linux.dev,nwl.cc];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 61BA01905A1
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "The tracking of feedback in the AI bot is often wrong,
but FWIW this is what it has to say about the submission"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument

This commit adds the ability to specify an offset when calling
nft_set_pktinfo_ipv4/6_validate() for cases where the IP header is not
at skb_network_header().

> diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
> index fcf967286e37..bd354937134f 100644
> --- a/include/net/netfilter/nf_tables_ipv4.h
> +++ b/include/net/netfilter/nf_tables_ipv4.h

[ ... ]

> diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
> index c53ac00bb974..1e84a891f268 100644
> --- a/include/net/netfilter/nf_tables_ipv6.h
> +++ b/include/net/netfilter/nf_tables_ipv6.h
> @@ -24,17 +24,17 @@ static inline void nft_set_pktinfo_ipv6(struct nft_pktinfo *pkt)
>  	pkt->fragoff = frag_off;
>  }
>
> -static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
> +static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt, u32 nhoff)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
>  	unsigned int flags = IP6_FH_F_AUTH;
>  	struct ipv6hdr *ip6h, _ip6h;
> -	unsigned int thoff = 0;
> +	unsigned int thoff = nhoff;
                             ^^^^^

When nhoff != 0, does ipv6_find_hdr() interpret 'thoff' as a relative or
absolute offset?

Looking at the IPv6 header read above:

	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb) + nhoff,
				  sizeof(*ip6h), &_ip6h);

The IPv6 header is at absolute offset 'skb_network_offset(pkt->skb) + nhoff'.

But when ipv6_find_hdr() is called:

	protohdr = ipv6_find_hdr(pkt->skb, &thoff, -1, &frag_off, &flags);

ipv6_find_hdr() interprets a non-zero *offset as an absolute offset from
skb->data (it does: ip6 = skb_header_pointer(skb, *offset, ...) and
start = *offset + sizeof(struct ipv6hdr)).

In bridge contexts where skb_network_offset != 0 (typically 14 for Ethernet),
ipv6_find_hdr() will read from the wrong location when nhoff != 0. Shouldn't
this be 'unsigned int thoff = skb_network_offset(pkt->skb) + nhoff;' to match
how the IPv6 header is read?

The IPv4 version correctly computes absolute offsets:

	pkt->thoff = skb_network_offset(pkt->skb) + nhoff + thoff;

All current callers pass nhoff=0, so this is dormant until a future patch
enables non-zero nhoff (which this commit is designed to support).

>  	unsigned short frag_off;
>  	u32 pkt_len, skb_len;
>  	int protohdr;
>
> -	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb),
> +	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb) + nhoff,
>  				  sizeof(*ip6h), &_ip6h);
>  	if (!ip6h)
>  		return -1;

[ ... ]

Florian Westphal raised a concern in v18 about a build warning in
include/uapi/linux/if_pppox.h:153:29 ('array of flexible structures').
He requested a new version to fix this. The author addressed this in v19 by
adding patch 1/5 'net: pppoe: avoid zero-length arrays in struct pppoe_hdr'
that wraps the flexible arrays in '#ifndef __KERNEL__' guards.

Reference: https://lore.kernel.org/netdev/aZynSuGMtK7JOOCj@strlen.de/

