Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892452B8CF1
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Nov 2020 09:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgKSIQH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Nov 2020 03:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgKSIQH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:16:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE9C0613D4
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Nov 2020 00:16:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t9so4879299edq.8
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Nov 2020 00:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0N03fUfoN8yfl3q/oDJDvpvzt8NJMQouo/L6XzQZyqE=;
        b=1pzoHtWyRoTkv4lqbFhi5pTwVfsmr0MSDurmgfcXMgBob/7SAGtVi24jGa5GrmG2rs
         r3ceIE/MYG/nfTYlUgkNsnd/qXHMLdF5rh0bK04g0degO5jT43dTT9tJZw/NOjdOd6lk
         PC4rf1+BHegMRRYpO08FN56xpg0Fer7FHMlDtzQ7efTyN92wqFdp2io92c1WXYB4i/Hl
         XQhpI1HAu8tfHjRXVk9n4oXtuGjlw6FHVcnO6zpNbFPfrQ/7ZrxPa8KnzuXF0dgr6vRV
         +llHTbCOd6xqIzKGF9WPIIgq7YCeVJQtsBWBYVbQLpd6F1a7NBzqKtQJRicVuqFIUotN
         xQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0N03fUfoN8yfl3q/oDJDvpvzt8NJMQouo/L6XzQZyqE=;
        b=CWtXVanfnc5SkUrgwdgFrOfht1Zegs8Ixw/fUmfvbHAGV4ZG/wr/Jnskz3s77J4jVC
         eJNZUxqRJSr1NHMClDgiallJo9ysNhi4iSwmLOiDCo50/CVjLbm0RvGF8A1SnB9Awp03
         Gauak/6NuEeThC7jrF7Aq+msoFK1FPAcUF6l/KOTElX17gZcDeGaSRw1isQKUt7YnhVu
         B9e7KJTC/hyqvAlK5Ze5XnF/ueNdB9yRHwCkXgFLZ+ebAIkYk5hAnhrgBP9Sl42QIabA
         r+5VChygIkI/RewnP4s3iNShywTD54gNd96L1iXp/lMwLVn5knbecMqiVV29I/R1OQqJ
         qUzg==
X-Gm-Message-State: AOAM5329LhtqqvGIOTvjT9Kw9FddrIRvs9WPQxuTRbrWSNYn1FSSJZgs
        Oambv++yZNzpaI5dkUxg3gL9dA==
X-Google-Smtp-Source: ABdhPJzCyLol7tDRuOKIesbLbReSC+eycr32hWVDSpLjGpuMpF1hcZXdQ22LcclRTimvBOOCNCvyAg==
X-Received: by 2002:a50:a845:: with SMTP id j63mr30780645edc.32.1605773765277;
        Thu, 19 Nov 2020 00:16:05 -0800 (PST)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:f696:2fcd:4e91:8958])
        by smtp.gmail.com with ESMTPSA id y4sm14658940edr.20.2020.11.19.00.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 00:16:04 -0800 (PST)
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, mptcp@lists.01.org
Cc:     Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Geliang Tang <geliangtang@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>
References: <CA+G9fYvkRAKBzthvdurQ44q_f9HimG2ur9+M=bgyZ0c+XWucgg@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP] WARNING: net/mptcp/protocol.c:719
 mptcp_reset_timer+0x40/0x50
Message-ID: <67f05a8c-d582-1748-bf74-9fa9a761427b@tessares.net>
Date:   Thu, 19 Nov 2020 09:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CA+G9fYvkRAKBzthvdurQ44q_f9HimG2ur9+M=bgyZ0c+XWucgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Naresh,

On 19/11/2020 08:04, Naresh Kamboju wrote:
> While running kselftest net/mptcp: mptcp_join.sh on x86_64 device running
> linux next 20201118 tag the following warning was noticed.

Thank you for testing MPTCP and having reported this bug!

It looks like it is similar to what syzbot reported yesterday:

https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/thread/N4IWIL6CYR6VSOOOXF25N3EWDW4GTQ6A/

If it is the same, a patch has already been sent to netdev ML:

https://patchwork.kernel.org/project/netdevbpf/patch/1a72039f112cae048c44d398ffa14e0a1432db3d.1605737083.git.pabeni@redhat.com/

If it is easy for you to reproduce the issue, please feel free to 
validate Paolo's patch :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
