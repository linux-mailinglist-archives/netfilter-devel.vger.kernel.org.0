Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD27C11F0EA
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Dec 2019 09:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfLNI0F (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Dec 2019 03:26:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36147 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfLNI0F (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:26:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1176455wma.1
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Dec 2019 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eiknm9VZCij8f2O1s4xNNb6ZJr6Q/a+qCn+AIB6rL7Y=;
        b=yFSObMzhCPZ+c8JsBfsxAZboFyHHRWsGHAq66P03TSH/f7akKE9XstwaNF9uJw9aX5
         Jz0yMRtC9fjTRi6I6b0qv9I6cfhvIX86KL8XFNo0H4g1/gEDD3Tx3j5VQo1CQVuROWcO
         SZM4l7URlW3uw7+Oimqxh9kCPhxsfV0yLINtVno7TKdNJutJ+bbOJsVT5nXxmYH7LJ+v
         3gkRW7YeqvGahxVNmdCdtIXnMGY47qhUbXONFjoyE0ciB2af3jvi9v0laa+LleCSXLiE
         RJSfba3ZGAEv53ROVR9zQjT0ZbiFFtAaok4B7l0Vj84+P5UxV+aMRq4VUD/VlGa6oiZ6
         iR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eiknm9VZCij8f2O1s4xNNb6ZJr6Q/a+qCn+AIB6rL7Y=;
        b=o+Dxtne++MDt0W1qhj64m5cPWLgHsE+4dongQiy6MqFYDTNsLEfHjjuWrstAsYiEt3
         iXw8A6BHLoFKNaTDnCyXmmlz49B5dgMLAO5RdjOEF/AWcBcfOI1Y1cSqbnpl0hK9TfV8
         +e4RMrQCSMaSJ1IfkKFAnkrt8Qd6fzxko2S3zzmd0rW1dt+ZFCV4ZUHIyb7efMNu8YKx
         ECHi/1Ui8wHFB9392bPEefDk9uvqzMDLfkX181T/KX3IM2gEPdNZkz6Lym8wb/De3Hq/
         q33wHGNDt9Rs3OAUMRWH7ocJE5Csub6XIWSjS9dzK6k+djjc131vxvgZWT8nwFhizCXW
         0LPw==
X-Gm-Message-State: APjAAAXOyuISHKZCl1xSiJWaDcweITRzX9937nABUO3iW7ei8oXIzUot
        +WBfm89GMHREMn6+Ia61ugN/1A==
X-Google-Smtp-Source: APXvYqw2FsEiHnuU9fxvIOr2+RcB8QpGSzGrsD57h7KR1o023qmbdAW0+qsplfJ6sxTVvYmVnhg7PA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr19476729wmg.66.1576311962903;
        Sat, 14 Dec 2019 00:26:02 -0800 (PST)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id l3sm12963815wrt.29.2019.12.14.00.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 00:26:02 -0800 (PST)
Date:   Sat, 14 Dec 2019 09:26:00 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCHv2 nf-next 1/5] netfilter: nft_tunnel: no need to call
 htons() when dumping ports
Message-ID: <20191214082600.GA5926@netronome.com>
References: <cover.1576226965.git.lucien.xin@gmail.com>
 <38e59ca61c8582cfc0bf1b90cccc53c4455f8357.1576226965.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38e59ca61c8582cfc0bf1b90cccc53c4455f8357.1576226965.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 13, 2019 at 04:53:05PM +0800, Xin Long wrote:
> info->key.tp_src and tp_dst are __be16, when using nla_put_be16()
> to dump them, htons() is not needed, so remove it in this patch.
> 
> v1->v2:
>   - add Fixes tag.
> 
> Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  net/netfilter/nft_tunnel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
> index 3d4c2ae..ef2065dd 100644
> --- a/net/netfilter/nft_tunnel.c
> +++ b/net/netfilter/nft_tunnel.c
> @@ -501,8 +501,8 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
>  static int nft_tunnel_ports_dump(struct sk_buff *skb,
>  				 struct ip_tunnel_info *info)
>  {
> -	if (nla_put_be16(skb, NFTA_TUNNEL_KEY_SPORT, htons(info->key.tp_src)) < 0 ||
> -	    nla_put_be16(skb, NFTA_TUNNEL_KEY_DPORT, htons(info->key.tp_dst)) < 0)
> +	if (nla_put_be16(skb, NFTA_TUNNEL_KEY_SPORT, info->key.tp_src) < 0 ||
> +	    nla_put_be16(skb, NFTA_TUNNEL_KEY_DPORT, info->key.tp_dst) < 0)
>  		return -1;
>  
>  	return 0;
> -- 
> 2.1.0
> 
