Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2274811F0ED
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Dec 2019 09:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNI0x (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Dec 2019 03:26:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36855 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfLNI0x (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Dec 2019 03:26:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so1258526wru.3
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Dec 2019 00:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifHRVJ+DQHL4cu36VQ6gKFWnRF/qcS7BFNg5rZGaKFk=;
        b=bTehaJxnrzsN7hD21n4gdPNm35iYGHim+o7ZnYkFhVC8QOj54zawqgNN3E+fT3IZlC
         WtFgtYdGOD20UzJ4wGLYNSFHlXu4xH4pkNEU4m10RBXzVRLHK5o8QoSRIW1Jfs6lB4g2
         EB+kG1i+yXEgcH5QjtVwYo8HbVDB6ZBoJtVwUhZAvPv0JNXYb7qLIRLejLxIP4/iV9GC
         izIL++vdp1jU45HmgQqTGFdovgtz3I7dqwfszG9mqYfU7hx4UpauxGP7wFO037j9ywaf
         RJ/DHVSKEwmvD39x7yV7UDPlB6bFbojRTgHVzVflTuTTSIldZ4IOM2kgc9FGXhdldsi+
         S6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifHRVJ+DQHL4cu36VQ6gKFWnRF/qcS7BFNg5rZGaKFk=;
        b=V2PRXHyLHmN9DZXBGT9UHuGEWarQxQPZ+kbLDKOsk6QSVXcI/cVaM6r6Gj9Eux7XyP
         StsmzJtsFNZJxGVKa+k0YVOAO9uRFIPGv/EDtoVbbrwf8ijWtnQqPw/yDltOkMTWeLrW
         sTKBPn7uXgWc5qxwJ8u9e8sepkDBGb1UTYXsrZ/2lj6Yl+2O5XIpEY3YlRqmyMNhaz0v
         mWGzOg8NZFbm4m0i9Veuiu15qvd4aka6nymLde1r/z2wgixG5kKoDJNRrZDQ7DX/okrn
         W8jE1NU73nd/U8an8VCuuXedM+6uXB9Y5J/TXg9O+TRFVTnfDO1szVLUINr+fcjqR1Xs
         sDUw==
X-Gm-Message-State: APjAAAWoXbRDH6UN1NlY7ivsw5fkV9NWHrvPvYp+LdmF18CWVx+MQV+v
        3zxxiBz5uxLKhipGF6E7EY/IJA==
X-Google-Smtp-Source: APXvYqzQOhfjfrfXWxHUpCanCxoee+GJMqIKpYp7Ziopp8SZ3b80NJfjwr72yQKEdOwaojhOmZ5zPQ==
X-Received: by 2002:adf:a109:: with SMTP id o9mr18723835wro.189.1576312011733;
        Sat, 14 Dec 2019 00:26:51 -0800 (PST)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id v14sm13079504wrm.28.2019.12.14.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 00:26:51 -0800 (PST)
Date:   Sat, 14 Dec 2019 09:26:50 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCHv2 nf-next 3/5] netfilter: nft_tunnel: also dump
 ERSPAN_VERSION
Message-ID: <20191214082649.GC5926@netronome.com>
References: <cover.1576226965.git.lucien.xin@gmail.com>
 <46a6912e0996a23b79a6d52eaf9ed501a1dab86b.1576226965.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a6912e0996a23b79a6d52eaf9ed501a1dab86b.1576226965.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 13, 2019 at 04:53:07PM +0800, Xin Long wrote:
> This is not necessary, but it'll be easier to parse in userspace,
> also given that other places like act_tunnel_key, cls_flower and
> ip_tunnel_core are also doing so.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  net/netfilter/nft_tunnel.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
> index 6538895..b3a9b10 100644
> --- a/net/netfilter/nft_tunnel.c
> +++ b/net/netfilter/nft_tunnel.c
> @@ -479,6 +479,9 @@ static int nft_tunnel_opts_dump(struct sk_buff *skb,
>  				 htonl(opts->u.vxlan.gbp)))
>  			return -1;
>  	} else if (opts->flags & TUNNEL_ERSPAN_OPT) {
> +		if (nla_put_be32(skb, NFTA_TUNNEL_KEY_ERSPAN_VERSION,
> +				 htonl(opts->u.erspan.version)))
> +			return -1;
>  		switch (opts->u.erspan.version) {
>  		case ERSPAN_VERSION:
>  			if (nla_put_be32(skb, NFTA_TUNNEL_KEY_ERSPAN_V1_INDEX,
> -- 
> 2.1.0
> 
