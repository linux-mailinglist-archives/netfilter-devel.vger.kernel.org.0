Return-Path: <netfilter-devel+bounces-6306-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC92A5C0B1
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Mar 2025 13:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A78189CF61
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Mar 2025 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B594525C6F4;
	Tue, 11 Mar 2025 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELuV462F"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C925BABA
	for <netfilter-devel@vger.kernel.org>; Tue, 11 Mar 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695006; cv=none; b=CgYNd+DHDqr45XxVDyiEQsPMGJtJFd9MPrZeWv2hb3SkXm9FnEuZ2wuwlk7JpyfH1lutBCbg488cklmUlXSMeHGWAS+9P2xr8tRPWmhKgNfbI3S5VW2Y/6tXL7CCWqg7Fch5/JMGyVsMeZ64ZPbaESWNzytXaI3ZC47J28BS0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695006; c=relaxed/simple;
	bh=ESptfUqJ8ikgFgaVLvh4qY5M7p0GdzNCQcLXBlXVRYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J0JgonozRXb9T7p/vkikQ2FsBe2PVNc47p8H5O9DzCdFq2JmCR535UAIeRT6GrBmJTHuXdhPBcEvVfPp6AVZSSJdDwU2hhGHQ8QDiXi438Q3HMS0Gf/uyyh+wdocw3TrGWeOgxJcxDu8l3HNfGQbI23RzV6PYJyCOK9udMYnx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELuV462F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741695003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5Yy7V0yOPn5gqt/RKUXcJgXRnOAYWX9pdMaDlNGSLw=;
	b=ELuV462FYt8mbQtui+q6QLrnBph4tQsufM/VvRHQfUuHB2mYKr1y6p7Iorlvg2b3voDtQf
	78zJI7zIdkJd/UTZwZr+9w8AZRYhlN+MIagUejox6hluL3Azxz5nWYaI1AbDXEkqEMfppY
	VUGrxsM4x6w72T5WVFMvZhXFyzM6L5I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-1s_Y9Ld9Oo2UhvxT1IZHSg-1; Tue, 11 Mar 2025 08:10:01 -0400
X-MC-Unique: 1s_Y9Ld9Oo2UhvxT1IZHSg-1
X-Mimecast-MFC-AGG-ID: 1s_Y9Ld9Oo2UhvxT1IZHSg_1741695001
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913f546dfdso1786536f8f.1
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Mar 2025 05:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695000; x=1742299800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5Yy7V0yOPn5gqt/RKUXcJgXRnOAYWX9pdMaDlNGSLw=;
        b=kGVpCUUTzvJl4joJJtClAUtnpy2VLTJrefrSWnhZU/xT+Az2CXiSZ6+4LssmN2rwGB
         ViVDU5WBqV0AndMOiX+qwZFjYfT6+1TpUGRNMg75nvXSsFIUWVoCG6YCmwh3q6KdZokp
         +cB4qOv/a01dMWCFrx/4U2Ac6SYiXvyQlr6mSjnknSLwig/BZMpSf8P9iFDu76HYc1Wn
         k3NA3Gasg6x1NiQraQrJha8BhE0eoSHrYqQjlAmhzMc28xt3kEF5sk2viHa4gxzzbYj1
         decxfzXNWU2/lYbZZVxhribtjwJZj60WNiDN3pbwJ4nLcuh1u6TyAw1OajYmQP4XOp6r
         p5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWQHdkNe4A7zqJQYogcXH+ft02rEh29Wf/1RPWm3RkRyvZUhBdYWfeGCMKA6n4Z5Q9YLXZ+4Yz9fGG6Qo8vdgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7mrRcO3ByGfhmwJSZAlHIB5wTns9+Z1eGoRRM7oZ/jINowgM
	9/mOkmXtLhi4qfHq56ugl7Pjkap6y0l3YPY4d5EWsArDkSnbwzpAMYUxFMwTuyvDDemRSHwx0N0
	XxaSXLK4OZroiL9mNs0uVkbSVrdo2YAqg3rvvAT0HrFyRgU/CnMDVOGsJzMbmJGMArA==
X-Gm-Gg: ASbGncsTp5z6AStc1+hks9tzYgCQFskwKaEXLQFei1Cj3iYSSE0CrWyOl7Dhzv+wSms
	IZJgeZ1DSmJKNk6uioGgP1BbTTgp2lq0fGPSBnDsg206AJD1yLOwyWSzNR/TO51OpJq7pLntLjK
	d6FOQ9o9Q4aWb3fgl3cyLVjuIWwleeMJFCFIVkoKj3jTvbG2gNgnDfqqLZGkqaM309vWsmIK/UT
	b0vgAio/lgZLCiW3D26Z4V2s19tnb/yBJD1YMZAEOZVQZZ7RipYtUB6BKs2l19tHV/o7KuQDwaD
	I29pHeeFGt1Ps/eGotaTe8p2dPdH0+HgqqQT/rgN9BmWiA==
X-Received: by 2002:a05:6000:1885:b0:390:fbdd:994d with SMTP id ffacd0b85a97d-39264694d6bmr4300663f8f.27.1741695000601;
        Tue, 11 Mar 2025 05:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs0csUBPlTbM/Cu4XdWOhmBdgqAf3K9Ljl//kp3p3I+7B7kyXy7IBboBlPsvDHYMFJWlRy/A==
X-Received: by 2002:a05:6000:1885:b0:390:fbdd:994d with SMTP id ffacd0b85a97d-39264694d6bmr4300622f8f.27.1741695000161;
        Tue, 11 Mar 2025 05:10:00 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfba9sm18248074f8f.39.2025.03.11.05.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 05:09:59 -0700 (PDT)
Message-ID: <62ae486d-621c-4b72-b9fa-d582f80cccd4@redhat.com>
Date: Tue, 11 Mar 2025 13:09:57 +0100
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 09/12] gro: prevent ACE field corruption &
 better AccECN handling
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 dsahern@gmail.com, davem@davemloft.net, edumazet@google.com,
 dsahern@kernel.org, joel.granados@kernel.org, kuba@kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, kory.maincent@bootlin.com, bpf@vger.kernel.org,
 kuniyu@amazon.com, andrew@lunn.ch, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
 <20250305223852.85839-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305223852.85839-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/25 11:38 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> There are important differences in how the CWR field behaves
> in RFC3168 and AccECN. With AccECN, CWR flag is part of the
> ACE counter and its changes are important so adjust the flags
> changed mask accordingly.
> 
> Also, if CWR is there, set the Accurate ECN GSO flag to avoid
> corrupting CWR flag somewhere.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/ipv4/tcp_offload.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index a4cea85288ff..ef12aee5deb4 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -329,7 +329,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  	th2 = tcp_hdr(p);
>  	flush = (__force int)(flags & TCP_FLAG_CWR);
>  	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
> -		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
> +		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
>  	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
>  	for (i = sizeof(*th); i < thlen; i += 4)
>  		flush |= *(u32 *)((u8 *)th + i) ^
> @@ -405,7 +405,7 @@ void tcp_gro_complete(struct sk_buff *skb)
>  	shinfo->gso_segs = NAPI_GRO_CB(skb)->count;
>  
>  	if (th->cwr)
> -		shinfo->gso_type |= SKB_GSO_TCP_ECN;
> +		shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  EXPORT_SYMBOL(tcp_gro_complete);

To recap: when an host implementing the above will receive a GSO_TCP_ECN
train transmitted by a RFC3168 endpoint, it will re-assemble it in 2
packets: a GSO one with !th->cwr and a non GSO one with th->cwr set.

When receiving a GSO train with constant CWR set on all the wire
packets, it will assemble it in a single SKB_GSO_TCP_ACCECN packet.

I think should work correctly.

Side note: the SKB_GSO_TCP_ACCECN flag is required: NETIF_F_TSO_ECN
enabled driver will likely unconditionally apply RFC3168-like TSO to any
GSO packet carrying the CWR flag, regardless of the skb gso_type.

@Eric: are you ok with this change?

Thanks,

Paolo


