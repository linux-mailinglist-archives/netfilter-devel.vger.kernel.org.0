Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A3C4F5465
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Apr 2022 06:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiDFEuG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Apr 2022 00:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1850367AbiDFCwO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:52:14 -0400
Received: from mail-wm1-x362.google.com (mail-wm1-x362.google.com [IPv6:2a00:1450:4864:20::362])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8196B179B12
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Apr 2022 16:52:09 -0700 (PDT)
Received: by mail-wm1-x362.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so2585373wmb.4
        for <netfilter-devel@vger.kernel.org>; Tue, 05 Apr 2022 16:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:content-transfer-encoding;
        bh=tjab0l+xfYR0aZEj5soCABbrSjfcWfiSiNw5bb6ADcc=;
        b=6jO2aSMSmK9A/p10aL67j5dpThrj7xNgjXytOoXduLDhiveuNv/6iWf7F9OH4AEQ8m
         nMgt8ZXVBmxylvGh8utqy00DfZmUWKIC4BcSJkDneu9SsTBy0OlDJ92DwhJgC8kxtHd9
         SMmjgI/2ycPH1Qqw/k0xxn1Lv+kxR/wcnf0h2PKzRyz6R5iHr+SApVITsOtgPTQ8XWrf
         jefGIrFZp6ehHbv6cowT5AnSzM30l+NErkwLJaUygnLy0YHYJe4in6b0gSbXR50Gz2IJ
         U+54Euqq8g0RFy5N88LONR/kWiFcFD0CPdwvOK+CyllvTbh2WMG8ZfU9U9jzblg6NauG
         ubwA==
X-Gm-Message-State: AOAM530ZsSwLK2mW6BzwcA/+JNDwt0xjIzYhy3//6YlkZ/8TPE0X9dI7
        gnLXhC9DUoh5V3RFi2GYe7+HwKHzF3MHzcCC99DTQJUi/vqy
X-Google-Smtp-Source: ABdhPJzjXl9lYXef6+e9Ggc2Y85pcIUJDGm5uhvKfava0TB3KoHRk4M3HKy4QO+yz963G18cVxs/3dEmP3Ap
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr5174267wmj.98.1649202721448;
        Tue, 05 Apr 2022 16:52:01 -0700 (PDT)
Received: from smtp.aristanetworks.com (smtp.aristanetworks.com. [52.0.43.43])
        by smtp-relay.gmail.com with ESMTPS id f13-20020a05600c4e8d00b0038c994092fbsm439961wmq.0.2022.04.05.16.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Apr 2022 16:52:01 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.70.41])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 28C603002D04;
        Tue,  5 Apr 2022 16:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1649202720;
        bh=tjab0l+xfYR0aZEj5soCABbrSjfcWfiSiNw5bb6ADcc=;
        h=From:To:Cc:Subject:Date:From;
        b=woP9fF3qZzunKXrRcPgDSyac21eIvuWWbeTXc12/yEUdySijANk8sRKdptJl6l5cV
         iLcWQenoSPX2Ua0bGFCFKIClIsbbT65yMydGSEo0ET6l5uKpuHqFK61RohyHNSI0Kq
         N+MjUi8fnrUaLZTjxB92POD5qaaEiDgFmSq4TIzgFSShKcjV2p+U/2HajpkGw7oVwX
         Xbnd+gf0pkHohKyV6TZIsm4APNq+F+u8GWZm4iBIUbO2G1UxNT0QdN6rOWgHAL3CD+
         qbi6ht0AIfArtaytZm0+cEir6F5+2bHfzNrmyt+2AcBxSrm/nEmbNJqmeleAy7LBGo
         xAWf0YU6uw5RQ==
Received: from kevmitch by chmeee with local (Exim 4.95)
        (envelope-from <kevmitch@chmeee>)
        id 1nbsxp-00188V-Sp;
        Tue, 05 Apr 2022 16:51:57 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
Cc:     kevmitch@arista.com, gal@nvidia.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: [PATCH v2 0/1] UDP traceroute packets with no checksum
Date:   Tue,  5 Apr 2022 16:51:15 -0700
Message-Id: <20220405235117.269511-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is v2 of https://lkml.org/lkml/2022/1/14/1060

That patch was discovered to cause problems with UDP tunnels as
described here:

https://lore.kernel.org/netdev/7eed8111-42d7-63e1-d289-346a596fc933@nvidia.com/

This version addresses the issue by instead explicitly handling zero UDP
checksum in the nf_reject_verify_csum() helper function.

Unlike the previous patch, this one only allows zero UDP checksum in
IPv4. I discovered that the non-netfilter IPv6 path would indeed drop
zero UDP checksum packets, so it's probably best to remain consistent.

-- 
2.35.1

