Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919C255D69
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Aug 2020 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH1PId (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Aug 2020 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgH1PIZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:08:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BDC061264
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 08:08:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so1614750wrk.5
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ona2SramZlOzoBjP/aJ5NnGGdz2GwYgLuTlQT94U0hE=;
        b=CTzbyprJ6gg7Ng1f7JKIYOiw19rZ8MsC9LXJxlx1AUjvXqxdfbD7dUGt3IY+jvLe6/
         w7naHbgmd77NXUXb4Vfa+purkaMUDniQwUQXNIKfDhV81NR3364+sIm5RLgTZzLgWlwI
         ojDrAV+OcPffbUyPYUIK1Zxt3Ty08sUiirCXxPAWVdz6svj2Q5BkWrvd0qjcCbQ4MJvD
         k7b03bFx/7Ovmf+ESu1OU1HPF9nSDa6Uhlvw27gxmlGiFvyL1xZnSqDwcmzk9jAhbv0Q
         DI62eXPsDO1pV6eBdjcGLp23bZNQJbPK90UdQ/w7qiE5gWZ/0mxLikOR4vzljPUUaTy6
         kMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ona2SramZlOzoBjP/aJ5NnGGdz2GwYgLuTlQT94U0hE=;
        b=kaZd7IBCeG3fcNjp+pm7F+Wk/Ap2qwKZAVfuH1cRfrxvE1qhDWzO/ZfRk4V2eRAWPp
         KhfIFYBS9IpLg6PttYdD+fFTAxmczuidacNJQzyqPHtFTL0izU+P6tYytz3vWJWJej2I
         /iskEub6WPp5lpKYLDqmCI9JATYjia43xYqUXIYHPMYWYC9z+hGADXNbjoTgbgSj6INZ
         CUQUZ/RgBRe972SbkVANk4j1f1wInirVJG6aKIokWYsJuFsEa50Rxw13Ra+1X1xO6Ild
         ctXTL39NSDdD003qVCO/evieJ6zSoehS/WdVZwQ4wHvhhZFUAe2Qh9zYSlHqZaxSmHVz
         gVVQ==
X-Gm-Message-State: AOAM532l2gTNsJPwuoE1u4MmcrAgZw6fVaeJTE9bOjtMtUafRW+cj8uu
        KjVPUIluuU7TXFCjG90dnVfmYA==
X-Google-Smtp-Source: ABdhPJyqK2T9Ry68896tVj6D58pAxeSIYSJcpFTiLME6ybN+vbrbFEM19hvPratI33Gdch0THPDEzw==
X-Received: by 2002:a5d:5352:: with SMTP id t18mr1851532wrv.407.1598627302028;
        Fri, 28 Aug 2020 08:08:22 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:584b:67d:d1b3:7399? ([2a01:e0a:410:bb00:584b:67d:d1b3:7399])
        by smtp.gmail.com with ESMTPSA id 5sm2731995wmz.22.2020.08.28.08.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:08:21 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] Remove ipvs v6 dependency on iptables
To:     Lach <iam@lach.pw>, ja@ssi.bg
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <alpine.LFD.2.23.451.2008272357240.4567@ja.home.ssi.bg>
 <20200827220715.6508-1-iam@lach.pw>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <e4765a73-e6a1-f5ba-dd8b-7c1ee1e5883d@6wind.com>
Date:   Fri, 28 Aug 2020 17:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827220715.6508-1-iam@lach.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Le 28/08/2020 à 00:07, Lach a écrit :
> This dependency was added in 63dca2c0b0e7a92cb39d1b1ecefa32ffda201975, because this commit had dependency on
> ipv6_find_hdr, which was located in iptables-specific code
> 
> But it is no longer required, because f8f626754ebeca613cf1af2e6f890cfde0e74d5b moved them to a more common location
> ---
Your 'Signed-off-by' is missing, the commit log lines are too long, a commit
should not be referenced like this.
Please run checkpatch on your submissions.


Regards,
Nicolas
