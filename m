Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D332235C7C2
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Apr 2021 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbhDLNgf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Apr 2021 09:36:35 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:54615 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239992AbhDLNgf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:36:35 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 09:36:34 EDT
Received: from sas1-0a2be8f95474.qloud-c.yandex.net (sas1-0a2be8f95474.qloud-c.yandex.net [IPv6:2a02:6b8:c08:f21f:0:640:a2b:e8f9])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id CEBEBF217AE;
        Mon, 12 Apr 2021 16:28:25 +0300 (MSK)
Received: from sas1-e20a8b944cac.qloud-c.yandex.net (sas1-e20a8b944cac.qloud-c.yandex.net [2a02:6b8:c14:6696:0:640:e20a:8b94])
        by sas1-0a2be8f95474.qloud-c.yandex.net (mxback/Yandex) with ESMTP id dEfCK1DYHl-SPI80Wd4;
        Mon, 12 Apr 2021 16:28:25 +0300
Authentication-Results: sas1-0a2be8f95474.qloud-c.yandex.net; dkim=pass
Received: by sas1-e20a8b944cac.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PNxO1PVF2N-SNKuOfoA;
        Mon, 12 Apr 2021 16:28:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH nf-next] netfilter: Dissect flow after packet mangling
To:     Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@gmail.com>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        dsahern@kernel.org, roopa@nvidia.com, nikolay@nvidia.com,
        mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
References: <20210411193251.1220655-1-idosch@idosch.org>
 <be90fae7-f634-1f54-992e-226c442fb894@gmail.com>
 <YHPt5nyML4I51COy@shredder.lan>
From:   Michal Soltys <msoltyspl@yandex.pl>
Message-ID: <c1c83fb7-d074-a0a8-0766-f8844c1e7e23@yandex.pl>
Date:   Mon, 12 Apr 2021 15:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHPt5nyML4I51COy@shredder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 4/12/21 8:51 AM, Ido Schimmel wrote:
> On Sun, Apr 11, 2021 at 06:18:05PM -0700, David Ahern wrote:
>> On 4/11/21 1:32 PM, Ido Schimmel wrote:
>>> From: Ido Schimmel <idosch@nvidia.com>
>>> <cut>
>>>
>>
>> Once this goes in, can you add tests to one of the selftest scripts
>> (e.g., fib_rule_tests.sh)?
> 
> Yes. I used Michal's scripts from here [1] to test. Will try to simplify
> it for a test case.
> 
> [1] https://lore.kernel.org/netdev/6b707dde-c6f0-ca3e-e817-a09c1e6b3f00@yandex.pl/
> 

Regarding those scripts:

- the commented out `-j TOS --set-tos 0x02` falls into ECN bits, so it's 
somewhat incorrect/obsolete
- the uidrange selector (that was also ignored) is missing in the 
sequence of ip rules

