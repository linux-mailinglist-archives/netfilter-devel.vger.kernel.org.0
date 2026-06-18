Return-Path: <netfilter-devel+bounces-13329-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W/s7CL8mNGr4PwYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13329-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 19:11:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF26A1D6C
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 19:11:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=UEbw8RsX;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13329-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13329-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C5C93006D57
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83031E832;
	Thu, 18 Jun 2026 17:11:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1C258EDA
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 17:11:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802680; cv=none; b=L8mbqCtD7p6VtfNeCDHrCfMa2/UsFmC21kvp34UjoaaDeHGFxuVwMF+y1F8W9I8mgEoSkyXKjFP/ghZAQhuqGJTPqU1csqFC8A8u+OZCxx0f6pGBB5ZVeak203+JZHAcjRUxSUtBRCk2v+JlpNH7l1dh14NSubqswgBUPOJHHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802680; c=relaxed/simple;
	bh=lnzE9u1I0NWwIVsZzfY6Y4FbldrxGpPG3Ffbe0wdHZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2qif8w5B4t6qGOvv5jW4T/rUSykk427FD0QAQiOKqWWqYR7u/OZ4r7v28mouMKqufJH+sTyBj7SpcpAsrjzEW4QFltMHcUaLxIKV9PWQHIqCXxQf/aCz+YRKHcL8H/0ouvY4xL7t0DbaRM3mGoj2+hoyYHk9MyiMhlnbC6Z7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=UEbw8RsX; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 8583C6017E;
	Thu, 18 Jun 2026 19:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781802675;
	bh=khfYhs/nfiaoQuQBKqdd5IYnrJQC4nBa1y+o/R+dWv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEbw8RsXLtd8jUlZ3aXNaGAsq/9+iK6GC0KoaGYxYnAoJw4WrK6cN+b0btlG0wAnu
	 Bf+GPcZnSYlwDaLSrU+3ye6+SEkp/j5KB+eT+da/ViaZa4stkeWvh1383Mb4cr65aw
	 nkl13kF3LTSQZMzfdPC2xTIKanz4XjG2UB+KHlXfFdsLay0bBP+Rz24yz/P+1sAqwK
	 3so3tIWznEIIKZEjp/oHpgiESiTVjVG/nsDxV+yjQZmcCUZPCxzRfN520vuWrNniy4
	 h6Mbn3Vc1jk9sNJ+qEgJm4ERyzIXTrQuk9cSSe5ZgfNE+Wz4gu73yVq1YjvlSjAt+c
	 kfn1YU281CvNA==
Date: Thu, 18 Jun 2026 19:11:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc,
	fw@strlen.de
Subject: Re: [PATCH 4/9 nf-next] netfilter: conntrack: use
 DEBUG_NET_WARN_ON_ONCE on packet paths
Message-ID: <ajQmsQsCbwJb5P7W@chamomile>
References: <20260601193049.8131-1-fmancera@suse.de>
 <20260601193049.8131-5-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601193049.8131-5-fmancera@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:phil@nwl.cc,m:fw@strlen.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13329-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:from_mime,suse.de:email,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23AF26A1D6C

Hi Fernando,

I'm a making a bit more in-depth review for this specific patch.

I think, in general about this series, it would be good to avoid,
things like:

        DEBUG_NET_WARN_ON_ONCE(blah);

        func(blah->info, ...);

but it might not be trivial in all cases, sometimes it is simply
better to remove in that case.

The patch in this series for nf_tables (already upstream) always
follow the idiom:

        if (cond) {
                DEBUG_NET_WARN_ON_ONCE(1);
                terminal statament (ie. return, break...)
        }

I will try to provide you with hints on what to do in other patches in
this series to speed up inclusion.

Now comments on this specific patch, see below.

On Mon, Jun 01, 2026 at 09:30:44PM +0200, Fernando Fernandez Mancera wrote:
> Replace WARN_ON and WARN_ON_ONCE with DEBUG_NET_WARN_ON_ONCE inside
> conntrack confirmation, extension management, helper assignment, and
> protocol parsing loops. This prevents unnecessary system panics when
> panic_on_warn=1 is enabled in production systems.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/netfilter/nf_conntrack_core.c       | 2 +-
>  net/netfilter/nf_conntrack_extend.c     | 3 ++-
>  net/netfilter/nf_conntrack_helper.c     | 4 +++-
>  net/netfilter/nf_conntrack_ovs.c        | 2 +-
>  net/netfilter/nf_conntrack_proto_icmp.c | 3 ++-
>  net/netfilter/nf_conntrack_seqadj.c     | 2 +-
>  net/netfilter/nf_conntrack_sip.c        | 5 ++++-
>  7 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> index 8ba5b22a1eef..51e2d8ebe756 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -1244,7 +1244,7 @@ __nf_conntrack_confirm(struct sk_buff *skb)
>  	 * unconfirmed conntrack.
>  	 */
>  	if (unlikely(nf_ct_is_confirmed(ct))) {
> -		WARN_ON_ONCE(1);
> +		DEBUG_NET_WARN_ON_ONCE(1);
>  		nf_conntrack_double_unlock(hash, reply_hash);
>  		local_bh_enable();
>  		return NF_DROP;

OK, explicit drop, fine. Keep it.

> diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntrack_extend.c
> index dd62cc12e775..68169007aea2 100644
> --- a/net/netfilter/nf_conntrack_extend.c
> +++ b/net/netfilter/nf_conntrack_extend.c
> @@ -95,7 +95,8 @@ void *nf_ct_ext_add(struct nf_conn *ct, enum nf_ct_ext_id id, gfp_t gfp)
>  	struct nf_ct_ext *new;
>  
>  	/* Conntrack must not be confirmed to avoid races on reallocation. */
> -	WARN_ON(nf_ct_is_confirmed(ct));
> +	if (unlikely(nf_ct_is_confirmed(ct)))
> +		DEBUG_NET_WARN_ON_ONCE(1);

Keep it, but return NULL here. It provide good context, extensions can
only be added with a unconfirmed conntrack.

>  	/* struct nf_ct_ext uses u8 to store offsets/size */
>  	BUILD_BUG_ON(total_extension_size() > 255u);
> diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> index 17e971bd4c74..0a0e41dd4c95 100644
> --- a/net/netfilter/nf_conntrack_helper.c
> +++ b/net/netfilter/nf_conntrack_helper.c
> @@ -198,8 +198,10 @@ int __nf_ct_try_assign_helper(struct nf_conn *ct, struct nf_conn *tmpl,
>  	if (test_bit(IPS_HELPER_BIT, &ct->status))
>  		return 0;
>  
> -	if (WARN_ON_ONCE(!tmpl))
> +	if (unlikely(!tmpl)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
>  		return 0;
> +	}

Useless for netfilter:

        if (!exp && tmpl)
                __nf_ct_try_assign_helper(ct, tmpl, GFP_ATOMIC);

_BUT_ it can catch bugs in other existing users, eg. net/sched/act_ct.c

        if (!nf_ct_is_confirmed(ct) && commit && p->helper && !nfct_help(ct)) {
                err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);

keep it.

it is also fine that there is a branch and return (to skip it).

>  	help = nfct_help(tmpl);
>  	if (help != NULL) {
> diff --git a/net/netfilter/nf_conntrack_ovs.c b/net/netfilter/nf_conntrack_ovs.c
> index a6988eeb1579..26f12dd0c1a4 100644
> --- a/net/netfilter/nf_conntrack_ovs.c
> +++ b/net/netfilter/nf_conntrack_ovs.c
> @@ -53,7 +53,7 @@ int nf_ct_helper(struct sk_buff *skb, struct nf_conn *ct,
>  		break;
>  	}
>  	default:
> -		WARN_ONCE(1, "helper invoked on non-IP family!");
> +		DEBUG_NET_WARN_ONCE(1, "helper invoked on non-IP family!");
>  		return NF_DROP;

OK, this is in a branch with an explicit action (drop packet) LGTm.

>  	}
>  
> diff --git a/net/netfilter/nf_conntrack_proto_icmp.c b/net/netfilter/nf_conntrack_proto_icmp.c
> index 32148a3a8509..0f39cb147c4f 100644
> --- a/net/netfilter/nf_conntrack_proto_icmp.c
> +++ b/net/netfilter/nf_conntrack_proto_icmp.c
> @@ -117,7 +117,8 @@ int nf_conntrack_inet_error(struct nf_conn *tmpl, struct sk_buff *skb,
>  	enum ip_conntrack_dir dir;
>  	struct nf_conn *ct;
>  
> -	WARN_ON(skb_nfct(skb));
> +	if (unlikely(skb_nfct(skb)))
> +		DEBUG_NET_WARN_ON_ONCE(1);

nf_conntrack_in
 [ reset skb->nfct ]
 nf_conntrack_handle_icmp
  nf_conntrack_icmpv4_error
   nf_conntrack_inet_error

There is nf_conntrack_inet_error() which performs the ct lookup.
There is resolve_normal_ct() too, but these two are coming later.

[ ... snippet that resets skb->nfct ... ]
unsigned int
nf_conntrack_in(struct sk_buff *skb, const struct nf_hook_state *state)
{
        enum ip_conntrack_info ctinfo;
        struct nf_conn *ct, *tmpl;
        u_int8_t protonum;
        int dataoff, ret;
 
        tmpl = nf_ct_get(skb, &ctinfo);
        if (tmpl || ctinfo == IP_CT_UNTRACKED) {
                /* Previously seen (loopback or untracked)?  Ignore. */
                if ((tmpl && !nf_ct_is_template(tmpl)) ||
                     ctinfo == IP_CT_UNTRACKED)
                        return NF_ACCEPT;
                skb->_nfct = 0; <---------  this is reset here.
        }
[ end of snippet ]

I don't remember to have seen this WARN_ON, so remove it.

>  	zone = nf_ct_zone_tmpl(tmpl, skb, &tmp);
>  
>  	/* Are they talking about one of our connections? */
> diff --git a/net/netfilter/nf_conntrack_seqadj.c b/net/netfilter/nf_conntrack_seqadj.c
> index 7ab2b25b57bc..2bf49f0b9406 100644
> --- a/net/netfilter/nf_conntrack_seqadj.c
> +++ b/net/netfilter/nf_conntrack_seqadj.c
> @@ -38,7 +38,7 @@ int nf_ct_seqadj_set(struct nf_conn *ct, enum ip_conntrack_info ctinfo,
>  		return 0;
>  
>  	if (unlikely(!seqadj)) {
> -		WARN_ONCE(1, "Missing nfct_seqadj_ext_add() setup call\n");
> +		DEBUG_NET_WARN_ONCE(1, "Missing nfct_seqadj_ext_add() setup call\n");

This WARN_ONCE is now gone in the nf.git/nf-next.git.

>  		return 0;
>  	}
>  
> diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
> index e69941f1a101..7e9237c810a0 100644
> --- a/net/netfilter/nf_conntrack_sip.c
> +++ b/net/netfilter/nf_conntrack_sip.c
> @@ -599,7 +599,10 @@ int ct_sip_parse_header_uri(const struct nf_conn *ct, const char *dptr,
>  
>  	ret = ct_sip_walk_headers(ct, dptr, dataoff ? *dataoff : 0, datalen,
>  				  type, in_header, matchoff, matchlen);
> -	WARN_ON(ret < 0);
> +	if (unlikely(ret < 0)) {
> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -1;
> +	}

ct_sip_walk_headers() can never return < 0. This WARN_ON can be
removed.

>  	if (ret == 0)
>  		return ret;

Thanks.

