Return-Path: <netfilter-devel+bounces-13845-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ocYaDZ5OUWqkCAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13845-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 21:57:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7846573DF69
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 21:57:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iuKSXN87;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13845-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13845-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7E03012251
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5BB38F259;
	Fri, 10 Jul 2026 19:56:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8A38F656
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 19:56:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713401; cv=pass; b=imcKIVgV3UkWE301MDiO34AhGUOxtNL+nFzPumlQPfEE958O9Iah5zGGs20haq+aS5bu+9ONDKb/Nnd/uIt57UXyOPIsB1sd+ZlUorfsip0lPH7/QNzOgJjRu9fcd7363IKvMmYqgTwFVd0Tl7xSdsgkSfwPn0/aITn9FD8Hhv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713401; c=relaxed/simple;
	bh=pmU4K+R53fmUDaUnWZIOI4rwMkfDJ0AuYw2+GUikOaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRVGRz/guVWoqjfIg02Pac1NEW+GNtP3GoNXpQ/8+6d8QwfCjNr6xaevl51Lta3DFz2nSHH9mB6wnq73dLrz3y5CI4i5itkimb2s5w6O4EXKBu2z18M3D29mAL5fwPwPbL2cTNFPob36Ek5Ue/+Eag6sSEBtSyDFwKDOUH2IEbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuKSXN87; arc=pass smtp.client-ip=74.125.224.42
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664c6304683so1384841d50.2
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 12:56:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783713397; cv=none;
        d=google.com; s=arc-20260327;
        b=Xxw3/KkvV1T/PADvq13Y9+qdY/TVFyzUcz20/VKmoD55vIwP7cmuns4Ek97bZ8TMo+
         C7fcaZjCBcNWMyx8Uq+zofjrOiTWMcZz6iHMEsERc/YkUEYsSHUFlaZV3ImvhYDWmLmv
         4XoQJUY4AnYMsmMn6bQY1mVUDbSLf8Cw93J2zYvnrkk1/mvALdnKEx7y1up6NbzIQKOS
         VpjbMzCoAQHBSKdspA/LmK5uWJWWZ8LWTunhnvDbRWZW4dZqPIK0k9E4Z4/lj7RAGqIb
         l8geFHz5irfm8ziBILW+hhh9w293Zhs9Q5PB9VbjCrbiMpG0IKtIt3xZotThLwnMmk1B
         lP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1VoY9lj8yUJr9QUfv7BwhgFS9R6vEGoD0YOTF01By+U=;
        fh=sWunJObW40wC9mQ4a7QrK/qy7kji+583Qr+lrn42S9U=;
        b=CniJOsoYWNU72xI0QFml9afUtCZPHboP66O8ZFLZ3FaLy4RI4iwzN0wAR5gFXWxePS
         kCUrlsijCrUBfb0y+q7yqZRo2PWGufC+kiBB7M5Al3BNPNUffC1sOqfx+nQeuUJjLIuT
         TTnTYUO3Achv6Dsd3ktkLoqTiGTY//TVBxRqdqzuz5DE1uTbldORV7jr7ac36x1IKHu4
         YOMRLIf+hK9aMROjgfyrXMgOm1w77qIMrpkXcCk/8QtW1R9OvH+ISo6ik6YocnKyWkEG
         pIyzubbbHyMMQ3WZh+iFPCB+AWHPGXhW2W6dWlzxVvQzkXfV8KRrNUE3fJEYjTQm8YEg
         FGew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783713397; x=1784318197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1VoY9lj8yUJr9QUfv7BwhgFS9R6vEGoD0YOTF01By+U=;
        b=iuKSXN87KyTm0njNBJtFGwW1EMuFAWMheJgfYXUAFNx85YuntW+Asj0slCyWQAnTXR
         Q8CEeXv+5suINzTZw7b+6OGhqzHzOBU3Aarr68eCzAqyZtXghcWQfcd7sQCCOnT//pJI
         d4bN8GUlbO2eXjSkQxfWWmFjWJNAObnKbWkehcjBxNt4zCIB4+ftPhFBNIwLKiGd0QQl
         XC+ugYyIjcfOMOD1KdYvFbcINz/Vk6kHMHdrHb9PVszkbP7y161x3R/votocbiyyfrkK
         lzP7Pq13Na476OvsI5NNsvSYM3DPk8Si0CMOD3HL5z4TLA7qHOsK6ilHUyFhQK1zsY3q
         g1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783713397; x=1784318197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VoY9lj8yUJr9QUfv7BwhgFS9R6vEGoD0YOTF01By+U=;
        b=Nh5t1FKXRx4spiTErzNz/DZxNK96Rt+rmhVUkcYGntlMO7pfV4PxUH+Aphf1ILZarM
         XhDBm84kwOIJNJTScIpaCUnO/Y4kCNZjFMZU0UNBIPOp+tqJ7k/FVv4d3qumGBloBNcN
         hqE2w/MHYRFhun8RGG86pLkCkUVbOaW32tbzG8LVhbCgzUVtcwosrUiiLWmUfVfP5CQW
         nQINWo/CgpOuzmts51cO1mH+Cbq6I/qjFISycuWlbP0Ew5GENaERJ87bTprGhN9YQ1w3
         5dM1Pokro2nScw1d9ixyb5IgBRAJqy4Mm1nLsy47H2D24IcxzyoJ8/MiCjBYsCkYAE7l
         eSeQ==
X-Gm-Message-State: AOJu0YxxvMTHgZs9UORqQ9iiuIrY+aVDzywceIsTgPMCQZ9RSd1wRTIE
	RQWvXIyiwguDILvs2+RIp7h3MG49YnZacK3VB+/nhU7+KYGvHWIQuweL6ZiuwqmfCpwyYsXK57j
	Nea3MdQ4NnjNRg7BGWWPJ0BtOqwHMwecNFnuGcXtxkg==
X-Gm-Gg: AfdE7ck3hCCqNiinL8STzzICJGPDumrQT75c6aoG4+ICOeD/x5ls6uk65uicx1Dvp0e
	Oem1FghxiopVYIb6KhXj39PgQbHd+TRtRk3b2ZWmrq+9DZcV/apmMoye+X+3VIduC6vujo2Yn3G
	W3SUsVFKoVs7eRNbqdAtvFoEZVYLydEM5ab30nF5HWsgS6lvhkM49/kUHn7luKge0PFBjB2GbPQ
	J9cl24ThANylu2s/C1e/3BjCtfD+Z4nSn05MHL0eKAsy7n+vWQmoFK1w5P6KV6OKn1XMP1yWg==
X-Received: by 2002:a05:690e:4419:b0:667:a83f:28f7 with SMTP id
 956f58d0204a3-667d7b001fcmr491419d50.21.1783713397402; Fri, 10 Jul 2026
 12:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710075409.1360085-1-pablo@netfilter.org>
In-Reply-To: <20260710075409.1360085-1-pablo@netfilter.org>
From: Ahmed Zaki <anzaki@gmail.com>
Date: Fri, 10 Jul 2026 13:55:59 -0600
X-Gm-Features: AUfX_mzrAh7DEdoRMtZozHu1D6f6VCvrCLFUzTYKlFIoowXkBFiwJoLF45hfdwY
Message-ID: <CANczwAEqpv+zALby0crkzO5tX63efo-0JrVHVJUWbNgtxsKqSA@mail.gmail.com>
Subject: Re: [PATCH nf,v2] netfilter: flowtable: tear down flow entries with
 stale dst from GC
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[anzaki@gmail.com,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13845-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7846573DF69

On Fri, Jul 10, 2026 at 1:54=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> In case of route updates, tear down flow entries with stale dst to give
> them a chance to obtain a fresh route.
>
> This is specifically useful for hardware offloaded entries, where the
> flowtable software dataplane sees no packet, where the existing check
> for stale dst entries does not help.
>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> v2: - reuse nf_flow_dst_check(), move it to .h file
>     - use correct logic in nf_flow_dst_check() from GC step
>
> This patch has been repurposed to the nf.git tree, because net-next.git i=
s
> still missing a recent fix and I would like sashiko kicks it for review.
> So I am still leaning towards including this in nf-next.
>
>  include/net/netfilter/nf_flow_table.h | 8 ++++++++
>  net/netfilter/nf_flow_table_core.c    | 2 ++
>  net/netfilter/nf_flow_table_ip.c      | 8 --------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilte=
r/nf_flow_table.h
> index ce414118962f..a090ec3ffef2 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -310,6 +310,14 @@ int flow_offload_add(struct nf_flowtable *flow_table=
, struct flow_offload *flow)
>  void flow_offload_refresh(struct nf_flowtable *flow_table,
>                           struct flow_offload *flow, bool force);
>
> +static inline bool nf_flow_dst_check(struct flow_offload_tuple *tuple)
> +{
> +       if (!tuple->dst_cache)
> +               return true;
> +
> +       return dst_check(tuple->dst_cache, tuple->dst_cookie);
> +}

I am testing this patch and keep getting some splats. I am testing
with a MTK7621 hw which
to my understanding, marks the tuple's xmit_type DIRECT (not neigh or XFRM)=
.

In nft_dev_forward_path(), out.h_source is set and this overrides the
dst_cache (same union)
this seems to be causing the splat when the dst_cache is dereferenced.
(btw, not like his patch,
in the latest HEAD, nf_flow_dst_check() guards tuple->dst_****  by
checks on xmit_type)

So, to support DIRECT types, we can:
1 - go back to my v1 patch (no dependency on dst_cache)
2 - same patch but use dst_check() only for NEIGH/XFRM
3 - or maybe we can have the dst_cache out of the union and available
for all xmit_types.

I have some time to work on this, let me know if I can help.

Thanks.

