Return-Path: <netfilter-devel+bounces-13379-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VbR5M5U/OGpvaQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13379-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 21:46:29 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC36AB867
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 21:46:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=BXY+C2Tq;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13379-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13379-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF79C300AEFD
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 19:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4792C375A;
	Sun, 21 Jun 2026 19:46:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E72222CC;
	Sun, 21 Jun 2026 19:46:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782071187; cv=none; b=D50+sgC9uIEyZwNn2DumZhN/KdlFaPm9BOgVUVqQVYls4nH4Du0mbV1sS5P5K8n2nDc7oDosjS/t4EXO2D2gbzxBbp8Yl0i1oPzmAUionZSr5jfaHk9wCAIKNRBO9o582HJ85YJd8roIfNlhrB1nAFtjPQTSZ9gaLTibol7TAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782071187; c=relaxed/simple;
	bh=xxQgs3U1LGxap9Zk6Rf/li0+QovKR6ZkFWJsXhF9kJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X53+BAYO0hUGOzKtXbOybqhx43qwpHKzgrx5U42d6eazPxGu8dgXbPTTCZW5jefPxIkkQ+JRMUFm+NPoJq9NQRMc2g7doTblzHaWITOWl5nsVfBLN4tIj5eD0YdedNNhmXi1ZQzcQunh2yRKLdDHJ25VWcfWArL2XdwMDZYBQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=BXY+C2Tq; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 6A44B600B5;
	Sun, 21 Jun 2026 21:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782071181;
	bh=2RJCCs9Rni/4s1XKMzBHGfWg0+ybU5625IJdmGgJLfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXY+C2TqBy0FxIGDv3RvZO0Ygnb7q64EFWJKIAZdgzzcfVveMXq1UvdpwiK22DVIA
	 VgGP7xKP465Db8n3AnHbq4Tf4AikmI6dNoOqPAjsLzUCnioEetQyPelqEqko3yLYhY
	 fncPb/fO7NNCkGlWyuCVcAITHlIyjSJjrFbHCnZ5riEQHY/vs3ZzaKRzIoZlmfPDC0
	 MUnzDRZKqzaq7SMUMeZfgFiVnnO5ip1YcF8bZVc6fcxzPvaPs0Xvxp60zhadvVG5Ty
	 o8iBpQnkwAGGzbqtriZxyjpIxxalhULmoWDauYZkQ6PYfbN85gmesHdRbW424/3XUN
	 oea3QMvltKvsQ==
Date: Sun, 21 Jun 2026 21:46:19 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Kacper Kokot <kacper.kokot.44@gmail.com>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fmancera@suse.de,
	fw@strlen.de, david.laight.linux@gmail.com,
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v3] netfilter: TCPMSS: handle packets with
 unaligned MSS option
Message-ID: <ajg_ix9JO3YCgujy@chamomile>
References: <20260528223412.27311-1-kacper.kokot.44@gmail.com>
 <20260621184934.75832-1-kacper.kokot.44@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260621184934.75832-1-kacper.kokot.44@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kacper.kokot.44@gmail.com,m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,m:fmancera@suse.de,m:fw@strlen.de,m:david.laight.linux@gmail.com,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kacperkokot44@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,suse.de,strlen.de,gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13379-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chamomile:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32EC36AB867

On Sun, Jun 21, 2026 at 07:49:33PM +0100, Kacper Kokot wrote:
> RFC 9293 permits TCP options to begin on any octet boundary. Padding
> to a word boundary with NOPs is a sender convention, not a requirement,
> and robust receivers must handle unaligned options (MUST-64).
> 
> The xt_TCPMSS target's incremental checksum update assumes the MSS
> option is word-aligned. When it's not, the modified bytes straddle
> two checksum words and the resulting checksum is incorrect. The mangled
> packet may then fail checksum validation and be dropped downstream.
> That said, all mainstream stacks emit a word-aligned MSS, this change is
> motivated by spec conformance rather than a bug observed in the wild.
> 
> Extend the checksum update to handle unaligned MSS options. When the
> changed word is unaligned, the modified bytes b' and c' straddle two
> checksum words w1 and w2:
> 
>     | w1     | w2     |
> OLD |  a  b  |  c  d  |
> NEW |  a  b' |  c' d  |
> 
> The two-step update C' = C - w1 + w1' - w2 + w2' reduces algebraically
> to a single word incremental checksum update with byteswapped operands:
> 
>     C' = C - w1 - w2 + w1' + w2'
>        = C - (a * 2^8 + b)  - (c * 2^8 + d)
>            + (a * 2^8 + b') + (c' * 2^8 + d)
>        = C + 2^8 * (a - a + c' - c) + (b' - b + d - d)
>        = C + 2^8 * (c' - c) + (b' - b)
>        = C - (2^8 * c + b) + (2^8 * c' + b')
> 
> So the unaligned case adds no extra checksum operations.
> 
> Signed-off-by: Kacper Kokot <kacper.kokot.44@gmail.com>
> ---
> v3:
>  - Reframe as enhancement, not a fix (Pablo/Fernando)
>  - Rename subject to xt_TCPMSS, drop "fix" wording
>  - Reword commit message: packet may fail checksum validation and be
>    dropped downstream (Pablo)
>  - Target nf-next (Fernando)
>  - Use __be16 for csum_oldmss/csum_newmss (sparse warning from
>    kernel test robot)
>  - Reorder local variable declarations to reverse xmas tree (Fernando)
> 
> v2:
>  - Use get_unaligned_be16 (Fernando's suggestion)
>  - Fix alignment check expression (David)
>  - Mention it's a theoretical bug in the commit message
>  - Drop cc stable, the bug is only theoretical
> 
> diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
> index 80e1634bc51f..037add799d41 100644
> --- a/net/netfilter/xt_TCPMSS.c
> +++ b/net/netfilter/xt_TCPMSS.c
> @@ -116,9 +116,10 @@ tcpmss_mangle_packet(struct sk_buff *skb,
>  	opt = (u_int8_t *)tcph;
>  	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
>  		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
> +			__be16 csum_oldmss, csum_newmss;
>  			u_int16_t oldmss;
>  
> -			oldmss = (opt[i+2] << 8) | opt[i+3];
> +			oldmss = get_unaligned_be16(&opt[i + 2]);
>  
>  			/* Never increase MSS, even when setting it, as
>  			 * doing so results in problems for hosts that rely
> @@ -130,8 +131,25 @@ tcpmss_mangle_packet(struct sk_buff *skb,
>  			opt[i+2] = (newmss & 0xff00) >> 8;
>  			opt[i+3] = newmss & 0x00ff;
>  
> +			csum_oldmss = htons(oldmss);
> +			csum_newmss = htons(newmss);
> +
> +			if (((char *)&opt[i + 2] - (char *)tcph) & 0x1) {
> +				/* MSS option is unaligned: the modified bytes
> +				 * straddle two checksum words. Byteswapping
> +				 * the operands lets a single incremental
> +				 * update produce the correct checksum delta
> +				 * (see commit message for the derivation).
> +				 */
> +				csum_oldmss = htons(swab16(oldmss));
> +				csum_newmss = htons(swab16(newmss));
> +			} else {
> +				csum_oldmss = htons(oldmss);
> +				csum_newmss = htons(newmss);
> +			}

After seeing this unaligned in other areas in the Netfilter tree, I am
not sure it is worth to add workarounds everywhere in this codebase to
deal with updates that span two 16-bits words for such a hypothetical
case like this.

By now, patches that call get_unaligned_be16() for correctness are OK
IMO. This is to deal with arches which cannot cope with unaligned
access. This will corrupt such rare packet but that it addresses the
unaligned splats.

If we start seeing real stacks which provide real unaligned access
like this, maybe by then we can revisit.

So I am leaning towards a small patches to introduce
get_unaligned_be16() and document that this corrupts packets with such
a rare unaligned TCP option.

IIRC, x86_64 has a inet checksum function that can deal with 1-byte
words, although other arches cannot do that and still need to
operation with 16-bit words. Given Linux is multi-arch, this all need
to stick to the 16-bit word arithmetics when mangling packets

Maybe in the future all checksum functions in every arch are updated
too to deal with 1-byte word updates, and maybe real stacks pop up
with such a rare packets. But by then these ugly workaround won't be
needed at all.

> +
>  			inet_proto_csum_replace2(&tcph->check, skb,
> -						 htons(oldmss), htons(newmss),
> +						 csum_oldmss, csum_newmss,
>  						 false);
>  			return 0;
>  		}
> -- 
> 2.43.0
> 
> 

