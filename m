Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C3D4C0EC5
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Feb 2022 10:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiBWJC1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Feb 2022 04:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiBWJCY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:02:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF87045516
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Feb 2022 01:01:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d17so3545625wrc.9
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Feb 2022 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=F3lw3AMJP9Ga81FBJryvKm8lxqU7b7R5OHLuGuLasjI=;
        b=C6DdE4N85D6pQFVHzn6jZFm/iv9eb8AsBCwZAW1eM85pLLDNB9yT311R4gWnv7CP8h
         Jz7EhgmZttIEccO9PNFEoTk/V3OZ8n9rYlrKtBQB7D4ShRsr57vYQciIKpvuwLM+Zddt
         UySsAWV7ta2uboNdN23fJp3aqNtO42BxdrwR30L0v00Oxv4Ef2a/PMMSXW9hzXIdwj3Q
         MJgGn2LsZVxxNcv/jUZivDKm1jgFH2Ix7obyjW71amWhoPFGay2s4Uonk9ur7PHqdMZC
         AMhwGscsGlsyIANAU2JuPU7jlXNjo4vKxuwDS3yeII1Gi0rRX8uoh8U7e0FWroCtx592
         VPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:organization
         :in-reply-to:content-transfer-encoding;
        bh=F3lw3AMJP9Ga81FBJryvKm8lxqU7b7R5OHLuGuLasjI=;
        b=0vyFjnuDCn/WrgPxJykPAqk/YTJs/gfanXHhpPpSEoyXxh783ZWxzNrQNy40SP2jHn
         NvKSfnKfvaqYyYrRiopWf6xF79NPF7T5UCqIjruqVUMH+K+qn7JMVWJ99TqkJd6UUDar
         dXEUs0PwRY1DaxhRZnXPrGj0VsHLcLT8h90aMumuFEqpAp6vWZNvaUn3YNBF1C8/b153
         QUTSaI5X462CnWhkU6qPPBQm2zrS631Jjah1jEkXZRJXuGtKarD7zAlTt+5UFxKjBhTM
         TUUaTqu8J6n3QU282GCDykhaGKpnjsayttajvULCChmjT9tBJ3boiv1oD9kqKrThgeyR
         xWyQ==
X-Gm-Message-State: AOAM5314jbJdpq+/qE9hnJB1MqjFiDXL1lEhhHQBiXKQovpAJR9qxjKX
        M6miEqOzcKPvj6iUc0wXOLe0DQ==
X-Google-Smtp-Source: ABdhPJxYELuoQHan0HeRhlLsZKKFSMQGcVcyH9JgxnQ1M5L8G2CGHFGeTZBRhF60E1d9IGIp0TZ7UQ==
X-Received: by 2002:a05:6000:1881:b0:1e8:f75c:591d with SMTP id a1-20020a056000188100b001e8f75c591dmr20669003wri.257.1645606910257;
        Wed, 23 Feb 2022 01:01:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:5d35:a5e8:9cb4:e326? ([2a01:e0a:b41:c160:5d35:a5e8:9cb4:e326])
        by smtp.gmail.com with ESMTPSA id b2sm37255686wri.35.2022.02.23.01.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 01:01:49 -0800 (PST)
Message-ID: <e926bd60-7653-f528-ec15-2758a4ffc89a@6wind.com>
Date:   Wed, 23 Feb 2022 10:01:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH libnetfilter_queue] libnetfilter_queue: add support of
 skb->priority
Content-Language: en-US
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
References: <Yfy2YxiwvDLtLvTo@salvia>
 <20220204102637.4272-1-nicolas.dichtel@6wind.com>
 <8c08a4e0-83a0-9fc1-798b-dbd6a53f7231@6wind.com>
 <20220204120126.GB15954@breakpoint.cc> <Yf02PG/793enEF4r@salvia>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <Yf02PG/793enEF4r@salvia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


Le 04/02/2022 à 15:20, Pablo Neira Ayuso a écrit :
> On Fri, Feb 04, 2022 at 01:01:26PM +0100, Florian Westphal wrote:
>> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>>
>>> Le 04/02/2022 à 11:26, Nicolas Dichtel a écrit :
>>>> Available since linux v5.18.
>>>>
>>>> Link: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
>>>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>>> ---
>>>
>>> Should I send another patch for the 'set' part?
>>> In this case, a nfq_set_verdict3(). The name is a bit ugly ;-)
>>> Any suggestions?
>>
>> I think we should just let the old api die and tell users
>> to use the mnl interface, that allows to add the new attribute
>> as soon as its available.
> 
> We have to provide a simple API based on mnl which ressembles the
> existing old API.
> 
> Feedback in these years is that there are a users that do not need to
> know about netlink details / advanced handling.
If I understand well, libnetfilter_queue is deprecated?
If this is right, maybe it could be advertised on the project page:
https://netfilter.org/projects/libnetfilter_queue/index.html


Regards,
Nicolas
