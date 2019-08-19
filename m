Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCE921A3
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfHSKsw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 06:48:52 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:36936 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSKsw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:48:52 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1FEC8415F0;
        Mon, 19 Aug 2019 18:48:49 +0800 (CST)
Subject: Re: [PATCH nf-next] netfilter: nf_table_offload: Fix the incorrect
 rcu usage in nft_indr_block_get_and_ing_cmd
To:     Florian Westphal <fw@strlen.de>
Cc:     pablo@netfilter.org, netfilter-devel@vger.kernel.org
References: <1566208007-22513-1-git-send-email-wenxu@ucloud.cn>
 <20190819102123.GA2588@breakpoint.cc>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <2bde486e-dfe8-ad2b-8b77-babcad90d82e@ucloud.cn>
Date:   Mon, 19 Aug 2019 18:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819102123.GA2588@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS0NIQkJCTE5JQkJDSE5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6LTo5Kzg8Czg3CkIuHw1I
        NxoKFEtVSlVKTk1NSUpKTEhLSEJCVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSU9OQzcG
X-HM-Tid: 0a6ca97e674f2086kuqy1fec8415f0
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 8/19/2019 6:21 PM, Florian Westphal wrote:
> wenxu@ucloud.cn <wenxu@ucloud.cn> wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> The nft_indr_block_get_and_ing_cmd is called in netdevice notify
>> It is the incorrect rcu case, To fix it just traverse the list under
>> the commit mutex.
> What is an 'incorrect rcu case'?
>
> Please clarify, e.g. by including rcu warning/splat backtrace here.

according to http://patchwork.ozlabs.org/patch/1148283/

flow_block_ing_cmd() needs to call blocking functions while iterating block_ing_cb_list,

nft_indr_block_get_and_ing_cmd is in the cb_list, So it should also not in rcu for blocking

cases.

>
>> +	struct nft_ctx ctx = {
>> +		.net	= dev_net(dev),
>> +	};
> Why is this ctx needed?
>
>> +	mutex_lock(&ctx.net->nft.commit_mutex);
> net->nft.commit_mutex?

When traverse the list, the list is protected under commit_mutex like nf_tables_netdev_event

do in the netdevice notify callback

>
>> -		list_for_each_entry_rcu(chain, &table->chains, list) {
>> +		list_for_each_entry_safe(chain, nr, &table->chains, list) {
> Why is _safe needed rather than list_for_each_entry()?
yes list_for_each_entry() is better
>
