Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7655C1B4CBF
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2020 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgDVShF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Apr 2020 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgDVShE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:37:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E4C03C1A9
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2020 11:37:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so5616019wme.1
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2020 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BzEbY6n24pAiclZvkqJCJvgtLdLrTnWtF3jVZ/Y2T4w=;
        b=ev1zMmv5x75rqxSm1rb6jV9qsuGDXNXRPEK2GHL9Rg5suad3rExIMrBpZSbTKPic9+
         3HWCAfLpDni+NqQnsOpr4ZEvfmayzVP/p9YN/taLEpPiQIhS2ZpP09K/FEdDuUBvDd7O
         iyXKm7xzphyyIkGdpVuDYB4/7s7UYCbHRFIBjqixS5snaGEmFPo457UYviwbf8vkGpKk
         YppoUxHKUCF3e+b6gMp9XbPoMixwzEhps1fqsp591vNHpMcCZndgC5GtzZtGLjs/DmaH
         cA+Mg6O4b4paSi8P3JNcrSrli+Cj6PX3o/8ZPlqfrC7nvp7nGrOH9iRtUQiMDJjnR10m
         E84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BzEbY6n24pAiclZvkqJCJvgtLdLrTnWtF3jVZ/Y2T4w=;
        b=ZPUeek9/45Klag3bJLNEpeIAWZwEzZIR7gWUzepTiS2CFnMfyU3yKllQ1x9UUJxPn0
         /U/Hp32NSzl7w+qhPM7zgRxW8TVNVs446AENeK8xSw49w7JGRNMJXWyJbBsyq6K+9krG
         OTniU7prCRzMy0SVZj2lu0NWHcNidi6pXgCiJuyQbFyT+aO9L+SDaQoeYzWWqWwQ5GYZ
         hd7g5Rsk0zT/wGdC9IM1eEHSU+kikXB5jZ1bg4HK9mv1Rz2GzY9qf2BYQHEg6VIBiTTi
         stXaigIC0COQtRMjxpvmPDvEe9xT3Z22iq//B1caSkAQOfpcamKvtstmjEVsokrf0rbd
         fL0Q==
X-Gm-Message-State: AGi0Pua4ONBXyEsUCZ319591cfTHDL1CuLY8QKIfBKw3Ac7huAp1S4Hf
        9zYh6bGEpJUYkWYDI2iAGDSMOg0s9rE=
X-Google-Smtp-Source: APiQypINYxffuYcQkXZwauDbhBTnOV/AQnIU4ZG7KlbZaSlZXCt42Bbl494FXjXJMICg61ZoH9/mQQ==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr12571970wma.78.1587580623194;
        Wed, 22 Apr 2020 11:37:03 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id l9sm32429wrq.83.2020.04.22.11.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 11:37:02 -0700 (PDT)
Date:   Wed, 22 Apr 2020 20:37:01 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Edward Cree <ecree@solarflare.com>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net] net: flow_offload: skip hw stats check for
 FLOW_ACTION_HW_STATS_DISABLED
Message-ID: <20200422183701.GN6581@nanopsycho.orion>
References: <20200420090505.pr6wsunozfh7afaj@salvia>
 <20200420091302.GB6581@nanopsycho.orion>
 <20200420100341.6qehcgz66wq4ysax@salvia>
 <20200420115210.GE6581@nanopsycho.orion>
 <3980eea4-18d8-5e62-2d6d-fce0a7e7ed4c@solarflare.com>
 <20200420123915.nrqancwjb7226l7e@salvia>
 <20200420134826.GH6581@nanopsycho.orion>
 <20200420135754.GD32392@breakpoint.cc>
 <20200420141422.GK6581@nanopsycho.orion>
 <20200420191832.ppxjjebls2idrshh@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420191832.ppxjjebls2idrshh@salvia>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mon, Apr 20, 2020 at 09:18:32PM CEST, pablo@netfilter.org wrote:
>On Mon, Apr 20, 2020 at 04:14:22PM +0200, Jiri Pirko wrote:
>> Mon, Apr 20, 2020 at 03:57:54PM CEST, fw@strlen.de wrote:
>[...]
>> >I mean, the user is forced to use SW datapath just because HW can't turn
>> >off stats?!  Same for a config change, why do i need to change my rules
>> 
>> By default, they are on. That is what user should do in most of the
>> cases.
>
>Fair enough, I can workaround this problem by using
>FLOW_ACTION_HW_STATS_ANY. However, I still don't need counters and
>there is no way to say "I don't care" to the drivers.
>
>Note that the flow_offload infrastructure is used by ethtool,
>netfilter, flowtable and tc these days.
>
>* ethtool's default behaviour is no counters.
>* netfilter's default behaviour is no counters.
>* flowtable's default behaviour is no counters.
>
>
>I understand FLOW_ACTION_HW_STATS_DISABLED means disabled, strictly.
>But would you allow me to introduce FLOW_ACTION_HW_STATS_DONT_CARE to
>fix ethtool, netfilter and flowtable? :-)
>
>FLOW_ACTION_HW_STATS_DONT_CARE means "this front-end doesn't need
>counters, let driver decide what it is best".
>
>Thank you.

>diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
>index 3619c6acf60f..ae09d1911912 100644
>--- a/include/net/flow_offload.h
>+++ b/include/net/flow_offload.h
>@@ -164,17 +164,21 @@ enum flow_action_mangle_base {
> };
> 
> enum flow_action_hw_stats_bit {
>+	FLOW_ACTION_HW_STATS_DONT_CARE_BIT,
> 	FLOW_ACTION_HW_STATS_IMMEDIATE_BIT,
> 	FLOW_ACTION_HW_STATS_DELAYED_BIT,
> };
> 
> enum flow_action_hw_stats {
> 	FLOW_ACTION_HW_STATS_DISABLED = 0,
>+	FLOW_ACTION_HW_STATS_DONT_CARE =
>+		BIT(FLOW_ACTION_HW_STATS_DONT_CARE_BIT),
> 	FLOW_ACTION_HW_STATS_IMMEDIATE =
> 		BIT(FLOW_ACTION_HW_STATS_IMMEDIATE_BIT),
> 	FLOW_ACTION_HW_STATS_DELAYED = BIT(FLOW_ACTION_HW_STATS_DELAYED_BIT),
> 	FLOW_ACTION_HW_STATS_ANY = FLOW_ACTION_HW_STATS_IMMEDIATE |
>-				   FLOW_ACTION_HW_STATS_DELAYED,
>+				   FLOW_ACTION_HW_STATS_DELAYED |
>+				   FLOW_ACTION_HW_STATS_DONT_CARE,

"Any" can't be "don't care". TC User expects stats. That's default.


Let's have "don't care" bit only and set it for
ethtool/netfilter/flowtable. Don't change any. Teach the drivers to deal
with "don't care", most probably using the default checker.


> };
> 
> typedef void (*action_destr)(void *priv);

