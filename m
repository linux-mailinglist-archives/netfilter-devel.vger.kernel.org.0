Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD73124399
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRJr4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 04:47:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJr4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:47:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so1533077wru.4
        for <netfilter-devel@vger.kernel.org>; Wed, 18 Dec 2019 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWK6tplw8qlGD2BEjCDaCak/uVHFXrMGjJQnLjUJJTU=;
        b=I6WLoW2qYlf1eUT69t6WTES1iib/TEzwfT9cBjSpL/jHFprIhMnvz1o9eqjhduXSVU
         fVOJIZXZsEOdjM08L+Ruzkw6GQIqFZSf+z9rjrtWzds8OWvDc0rsZZzkrQpialt8dCUc
         +BOwJiOJqYP6Lm3D7VmFYoXpk7YAQW+CS16MWGwkj3mVY1rOyumKQjcidj10ERn7Pn66
         EhErQAvYslTznTyjbaPReDIEX9K3+E3hezbEKkudzKWmwPEq55PzcSqjYE6PAHZXFswl
         e1niJEKCJMcUPVYo0RKGv2UAKZekhqh8JCgBoT+RHreSEpNZYoCk2zsMDGjHMI1jC1fx
         rU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWK6tplw8qlGD2BEjCDaCak/uVHFXrMGjJQnLjUJJTU=;
        b=hgjDzmXlz3xRfzXlaGMgycXp8BfzSYAREygc7OAqpp3r735Ow9b3DO+gH4hhIkUz32
         4nptFNJle3pbIoDiUjoGfT20VX6OmfP9kved8jr1hoSA6Yg8qBTpGx4giDCjj30LTdJ3
         P1zBFkfqn5a4sQ3K0AdGlT5KjUg5GqyIJ0q1S1XhOmSkAk0asLHKZey/fALzMFIayh9T
         hP+nd4QaWIqWlz+UNSulw521HPb3Fbl5+nO4GfqmhHQqFiXQ5O7gq8z6koZdW2MCELxl
         5Yqz7Om+gX9O7pIkoX5tFb2gkZEqO+7JT2+krak06zeCtvarVeZSLyfIII8dP6Np+grU
         FUtw==
X-Gm-Message-State: APjAAAXk2emqVoH1W7pGHtMM/f9n8GrvIdtWLWsETiKt8lkZZfAnpEf+
        5BLCDYd9b0hEeakY3lDFU5whuIfBtzA=
X-Google-Smtp-Source: APXvYqw42ArB3QvbXO16aMF2GJ30kEWLpD0ZKuyNi5JuD/bG24Y7Y7ZWuRL2bQyQRlYS2W2yO77FnQ==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr1818077wrq.348.1576662474256;
        Wed, 18 Dec 2019 01:47:54 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id n16sm1937883wro.88.2019.12.18.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:47:53 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:47:53 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCHv2 nf-next 2/5] netfilter: nft_tunnel: add the missing
 ERSPAN_VERSION nla_policy
Message-ID: <20191218094752.GA22367@netronome.com>
References: <cover.1576226965.git.lucien.xin@gmail.com>
 <7bcaa9e0507fa9a5b6a48f56768a179281bf4ab2.1576226965.git.lucien.xin@gmail.com>
 <20191214082630.GB5926@netronome.com>
 <20191217213945.5ti7ktxc725emec3@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217213945.5ti7ktxc725emec3@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:39:45PM +0100, Pablo Neira Ayuso wrote:
> On Sat, Dec 14, 2019 at 09:26:31AM +0100, Simon Horman wrote:
> > On Fri, Dec 13, 2019 at 04:53:06PM +0800, Xin Long wrote:
> > > ERSPAN_VERSION is an attribute parsed in kernel side, nla_policy
> > > type should be added for it, like other attributes.
> > > 
> > > Fixes: af308b94a2a4 ("netfilter: nf_tables: add tunnel support")
> > 
> > Is this really a fix?
> 
> I think so. Netlink attribute validation for
> NFTA_TUNNEL_KEY_ERSPAN_VERSION is missing.

Ok, I accept that reasoning.
