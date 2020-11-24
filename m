Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B358C2C1F6D
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Nov 2020 09:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgKXIHP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Nov 2020 03:07:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8396 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKXIHO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:07:14 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CgGnf0yswz72tj;
        Tue, 24 Nov 2020 16:06:46 +0800 (CST)
Received: from [10.174.179.81] (10.174.179.81) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 16:07:01 +0800
Subject: Re: [PATCH net v2] ipvs: fix possible memory leak in
 ip_vs_control_net_init
To:     Julian Anastasov <ja@ssi.bg>
CC:     Simon Horman <horms@verge.net.au>, <pablo@netfilter.org>,
        <christian@brauner.io>, <lvs-devel@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>
References: <20201120082610.60917-1-wanghai38@huawei.com>
 <21af4c92-8ca6-cce9-64bc-c4e88b6d1e8a@ssi.bg>
 <66825441-bb06-3d18-0424-df355d596c5f@huawei.com>
 <9c409f4a-42df-1dd8-e69a-d5d3bab8d0c0@ssi.bg>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <506b722c-e049-eab1-3f19-f30473467fff@huawei.com>
Date:   Tue, 24 Nov 2020 16:07:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9c409f4a-42df-1dd8-e69a-d5d3bab8d0c0@ssi.bg>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


在 2020/11/24 3:04, Julian Anastasov 写道:
> 	Hello,
>
> On Mon, 23 Nov 2020, wanghai (M) wrote:
>
>> 在 2020/11/22 19:20, Julian Anastasov 写道:
>>>   Hello,
>>>
>>> On Fri, 20 Nov 2020, Wang Hai wrote:
>>>
>>>> +	if (!proc_create_net_single("ip_vs_stats_percpu", 0,
>>>> ipvs->net->proc_net,
>>>> +			ip_vs_stats_percpu_show, NULL))
>>>> +		goto err_percpu;
>>> 	Make sure the parameters are properly aligned to function open
>>> parenthesis without exceeding 80 columns:
>>>
>>> linux# scripts/checkpatch.pl --strict /tmp/file.patch
>> Thanks, I'll perfect it.
>>> 	It was true only for first call due to some
>>> renames for the others two in commit 3617d9496cd9 :(
>> It does indeed rename in commit 3617d9496cd9.
>> But I don't understand what's wrong with my patch here.
> 	Visually, they should look like this:
>
>          if (!proc_create_net("ip_vs", 0, ipvs->net->proc_net,
>                               &ip_vs_info_seq_ops, sizeof(struct ip_vs_iter)))
>                  goto err_vs;
>          if (!proc_create_net_single("ip_vs_stats", 0, ipvs->net->proc_net,
>                                      ip_vs_stats_show, NULL))
>                  goto err_stats;
>          if (!proc_create_net_single("ip_vs_stats_percpu", 0,
>                                      ipvs->net->proc_net,
>                                      ip_vs_stats_percpu_show, NULL))
>                  goto err_percpu;

Thank you for your patient explanation, I got it.

I just sent v3

"[PATCH net v3] ipvs: fix possible memory leak in ip_vs_control_net_init"

> 	The first one explained:
>
> <1  TAB>if (!proc_create_net("ip_vs", 0, ipvs->net->proc_net,
> <  open parenthesis is here  ^ and all next lines align to first parameter>
> <1  TAB><1  TAB><1 TAB><5 SP>&ip_vs_info_seq_ops, sizeof(struct ip_vs_iter)))
> <1  TAB><1  TAB>goto err_vs;
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>
