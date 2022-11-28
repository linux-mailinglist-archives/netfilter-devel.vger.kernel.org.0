Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCD63B2F4
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Nov 2022 21:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiK1UXZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Nov 2022 15:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiK1UXU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:23:20 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C176A11A06
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Nov 2022 12:23:18 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NLcNh6VNszMq3ZY;
        Mon, 28 Nov 2022 21:23:16 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NLcNh1vR1zMpr8Y;
        Mon, 28 Nov 2022 21:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1669666996;
        bh=i3j6PaslUJfw8oSWQiVXBsUnYf8vlCfXtdZyNu8S33Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=odPzlqNwFm38oA5v/ru5Tt1PORIqJopgNV0anJw1tmXnU2Mb+O+jAlK3g+8/o9DXX
         6w7ps3nVDVT0bzxReBZ9f/CDFXBN83uGKcnWbaxZn7OLOAJp9+sxJa4K8R5r1i3zf1
         hiJ+GDV1IVNrskayo88OW8KUYJzz91y9ELVj1mlk=
Message-ID: <fd4c0396-af56-732b-808b-887c150e5e6b@digikod.net>
Date:   Mon, 28 Nov 2022 21:23:15 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] landlock: Allow filesystem layout changes for domains
 without such rule type
Content-Language: en-US
To:     "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>
Cc:     artem.kuzin@huawei.com, gnoack3000@gmail.com,
        willemdebruijn.kernel@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
References: <5c6c99f7-4218-1f79-477e-5d943c9809fd@digikod.net>
 <20221117185509.702361-1-mic@digikod.net>
 <fb9a288a-aa86-9192-e6d7-d6678d740297@digikod.net>
 <4b23de18-2ae9-e7e3-52a3-53151e8802f9@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <4b23de18-2ae9-e7e3-52a3-53151e8802f9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 28/11/2022 04:04, Konstantin Meskhidze (A) wrote:
> 
> 
> 11/18/2022 12:16 PM, Mickaël Salaün пишет:
>> Konstantin, this patch should apply cleanly just after "01/12 landlock:
>> Make ruleset's access masks more generic". You can easily get this patch
>> with https://git.kernel.org/pub/scm/utils/b4/b4.git/
>> Some adjustments are needed for the following patches. Feel free to
>> review this patch.
     Do you have this patch online? Can I fetch it from your repo?

You can cherry-pick from here: https://git.kernel.org/mic/c/439ea2d31e662
