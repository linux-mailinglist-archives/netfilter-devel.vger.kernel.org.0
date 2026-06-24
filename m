Return-Path: <netfilter-devel+bounces-13437-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KXTYBNghO2qXRQgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13437-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 02:16:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E36BAB3A
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 02:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=tPX8BQwq;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13437-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13437-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D20E304DCE7
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E582EAB82;
	Wed, 24 Jun 2026 00:16:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5113D539
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 00:16:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260181; cv=none; b=WDDOZprE0aWtscY+0YgqSZSKw1MdFGm6FE5hCQdl0MgGONjMEYqIMWbyTrFOf4u1kUxctMV+6hMvsx5R+TGR5UX4i8ADr5LGF4lvNek1VXC2E4ms0HXNlzNgUM7Tircsx7kFf1vJQai7HoWyeClXbXULZ+KHl91FqxUBQbPUZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260181; c=relaxed/simple;
	bh=Z2L3QKKaPwrhMvxKy7aG/ll9Q7ylGLT9jsp6cnSFA9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hM7Ypr52XEhol7MXiPWwtVjwEH9811NifYza7BoGPj5w8KyNYQD1sD+nBWRbdq2jm6aLQsatBd0rBgpJjtFjjem/svUa6PYA/kNCAKGba4ENqSsI/0AU0LHmYKxyZzwieIQsSqp370vJVUAVc3V8Qh1UJzfrjSbQkjagU6130vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tPX8BQwq; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c6c8d7503so308163eec.0
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 17:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782260179; x=1782864979; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UAkNveefuJTgsJ0NBHhwMmRem65M6YgSNW6+kcyow4=;
        b=tPX8BQwqKIYyKGevK+lArVvqtKms8VW2Nmkxaid5f4rIpmnYp64BVWCZJC1Ls8uj/I
         cYehJhGYFrwpeM0cy5HM3pDT66FwBo2c6cbDlXu6nGMEi65CVdmvaurO7dnBUfEO7BYi
         WTeMJAoJl0VZrj2FKuoUCyp2QROySeX5mUgp4MV3gKWpWL4HFH+JoQU3EUWeyOLuWRuU
         jxcLWMqfUbX6odu/ACTNCBuiPMJozO1tyKvO2t5Gsvx73Nb64V6Cliwv7PmBLvRR5eyr
         3lVSCMDTPXTxlzb6PkTRH+6iO7zTeLKIyXW3kHAv84YzCmn25E1lHVCnyCTQExTuObO5
         BmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782260179; x=1782864979;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UAkNveefuJTgsJ0NBHhwMmRem65M6YgSNW6+kcyow4=;
        b=U6W6u60YE99Su268CclO0PKflZ6d9oAS4Z0W1wsZ4Dp44NPSWwd29sa3nEJ1KSkplG
         KhxukZkIJxYhsvhTY3zFSCogRduuqz2NHjVApsq8eGHdCjGqLp+f80PEkayvLIIKQzft
         DBNyGaknL3BAWTc5jF3cMd4LxefNAwbFJtwGOsvbrhtuHqepq99FY5qVQvgbT6tE0Ye7
         JBYAi/8IoV5tSaZxSjRCCCBWfIgYkpVyeaVn4zonBcNixMu2gGDNjCtq6N6DXDZpdddj
         tpst6KlwQDC9EFQefoQOGisy4vMwSt2065csgM0J9jqoMIPBHM7kQ7j+3O8gYapU8Hfh
         fywQ==
X-Forwarded-Encrypted: i=1; AHgh+RoARUcX3GUIUbQqYohllLPdKEfS1fnnrC1OUujVWiw/99SmUoaH1xTQrKEUvDVRQWdbkwT/+hIIjgUAD8Z+RxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgG+rpv8SaFu5TMWbemmBhaj5lPqX1xemwUZ0QEv3cgALTge/w
	bUcHsaW7p0nsM1sw/Exx67uBlNmg5uLgQ31AlSf7wtSMvIuMvguiVYh47jqMoSn3eMA=
X-Gm-Gg: AfdE7cn7dsEzBM3qdClRHKBgqUoi61FabwSfctFvOw/IxgpKg5XcvyLfJRQbM2nAmQd
	/mUw/vQbeyck+LNXmSMKAap3TZeyKf5aiZTO8VET6zytLzUlgOn1MBrBSbEGwpSLJ0G6nT/ywIp
	k6A52BFeMHx+rXP6kUZS+vpTMhvoOP+EvrOWYr807Q/ympORSq2qqku8+w5qcob5vahcU3suGh/
	VbLZCrPhFI5/0KptvJ23LEpTSZNNiGaLiRnF4rZHkYySMwa5yTdeVV7Wul3v0j+RWE8hmK0unIl
	YRZ36b2KlUYpXboFcSipmPQpi6EwGqLQH+ynaYphYTtosDsHqTGqEntH7gyu2pqGGDvLCpAU33b
	xlgq1l2m3B9sY1dFmqlE1W5snqM4MLjhlrRmzcNM5tLJJ79jFdRbw0ws7Ea0lE4WOPOwHVA==
X-Received: by 2002:a05:7300:3210:b0:30b:dd58:e167 with SMTP id 5a478bee46e88-30c6938c45bmr1378913eec.29.1782260178724;
        Tue, 23 Jun 2026 17:16:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c44ec51b9sm11937449eec.29.2026.06.23.17.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 17:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 20:16:16 -0400
Message-Id: <DJGUI5XWVR5Q.25HFEU8BW6QT4@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 2/7] net: move netfilter
 nf_reject6_fill_skb_dst to core ipv6
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-3-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-3-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,m:mahetardy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13437-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jrife.io:email,vger.kernel.org:from_smtp,etsalapatis-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 788E36BAB3A

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> Move and rename nf_reject6_fill_skb_dst from
> ipv6/netfilter/nf_reject_ipv6 to ip6_route_reply_fill_dst in
> ipv6/route.c so that it can be reused in the following patches by BPF
> kfuncs.
>
> Netfilter uses nf_ip6_route that is almost a transparent wrapper around
> ip6_route_output so this patch inlines it.
>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  include/net/ip6_route.h             |  2 ++
>  net/ipv6/netfilter/nf_reject_ipv6.c | 17 +----------------
>  net/ipv6/route.c                    | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index 09ffe0f13ce7..eb5a60d3babe 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -100,6 +100,8 @@ static inline struct dst_entry *ip6_route_output(stru=
ct net *net,
>  	return ip6_route_output_flags(net, sk, fl6, 0);
>  }
>
> +int ip6_route_reply_fill_dst(struct sk_buff *skb);
> +
>  /* Only conditionally release dst if flags indicates
>   * !RT6_LOOKUP_F_DST_NOREF or dst is in uncached_list.
>   */
> diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_=
reject_ipv6.c
> index ef5b7e85cffa..7d2f577e72b8 100644
> --- a/net/ipv6/netfilter/nf_reject_ipv6.c
> +++ b/net/ipv6/netfilter/nf_reject_ipv6.c
> @@ -293,21 +293,6 @@ nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
>  						   sizeof(struct tcphdr), 0));
>  }
>
> -static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
> -{
> -	struct dst_entry *dst =3D NULL;
> -	struct flowi fl;
> -
> -	memset(&fl, 0, sizeof(struct flowi));
> -	fl.u.ip6.daddr =3D ipv6_hdr(skb_in)->saddr;
> -	nf_ip6_route(dev_net(skb_in->dev), &dst, &fl, false);
> -	if (!dst)
> -		return -1;
> -
> -	skb_dst_set(skb_in, dst);
> -	return 0;
> -}
> -
>  void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *ol=
dskb,
>  		    int hook)
>  {
> @@ -440,7 +425,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff=
 *skb_in,
>  	if (hooknum =3D=3D NF_INET_LOCAL_OUT && skb_in->dev =3D=3D NULL)
>  		skb_in->dev =3D net->loopback_dev;
>
> -	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
> +	if (!skb_dst(skb_in) && ip6_route_reply_fill_dst(skb_in) < 0)
>  		return;
>
>  	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 6361ad2fcf77..0fa56c801178 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2732,6 +2732,24 @@ struct dst_entry *ip6_route_output_flags(struct ne=
t *net,
>  }
>  EXPORT_SYMBOL_GPL(ip6_route_output_flags);
>
> +int ip6_route_reply_fill_dst(struct sk_buff *skb)
> +{
> +	struct dst_entry *result;
> +	struct flowi6 fl =3D {
> +		.daddr =3D ipv6_hdr(skb)->saddr
> +	};
> +	int err;
> +
> +	result =3D ip6_route_output(dev_net(skb->dev), NULL, &fl);
> +	err =3D result->error;
> +	if (err)
> +		dst_release(result);
> +	else
> +		skb_dst_set(skb, result);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(ip6_route_reply_fill_dst);
> +
>  struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry =
*dst_orig)
>  {
>  	struct rt6_info *rt, *ort =3D dst_rt6_info(dst_orig);
> --
> 2.34.1


