Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B4141BFA
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2020 05:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgASEfZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 23:35:25 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:6656 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgASEfZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 23:35:25 -0500
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 5785A4119F;
        Sun, 19 Jan 2020 12:35:22 +0800 (CST)
Subject: Re: [PATCH nf-next v4 2/4] netfilter: flowtable: add indr block setup
 support
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <1578996040-6413-1-git-send-email-wenxu@ucloud.cn>
 <1578996040-6413-3-git-send-email-wenxu@ucloud.cn>
 <20200118200101.pgzyg7isgb6kc5wb@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <b73b3a65-253f-0041-166d-3cc743386d8d@ucloud.cn>
Date:   Sun, 19 Jan 2020 12:35:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200118200101.pgzyg7isgb6kc5wb@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVT0pPS0tLSk5ITk9KTk1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6Vhw6MDgwDjceF04TFRgT
        P0kwCQJVSlVKTkxCT0tDTklJT01PVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSUxKQzcG
X-HM-Tid: 0a6fbc157cae2086kuqy5785a4119f
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 1/19/2020 4:01 AM, Pablo Neira Ayuso wrote:
> On Tue, Jan 14, 2020 at 06:00:38PM +0800, wenxu@ucloud.cn wrote:
> [...]
>> @@ -891,10 +909,76 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
>>  }
>>  EXPORT_SYMBOL_GPL(nf_flow_table_offload_setup);
>>  
>> +static struct nf_flowtable *__nf_flow_table_offload_get(struct net_device *dev)
>> +{
>> +	struct nf_flowtable *n_flowtable;
>> +	struct nft_flowtable *flowtable;
>> +	struct net *net = dev_net(dev);
>> +	struct nft_table *table;
>> +	struct nft_hook *hook;
>> +
>> +	list_for_each_entry(table, &net->nft.tables, list) {
>> +		list_for_each_entry(flowtable, &table->flowtables, list) {
>> +			list_for_each_entry(hook, &flowtable->hook_list, list) {
>> +				if (hook->ops.dev != dev)
>> +					continue;
>> +
>> +				n_flowtable = &flowtable->data;
>> +				return n_flowtable;
>> +			}
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
> This assumes that there is a one to one mapping between flowtable and
> netdevices. Actually, there might be several flowtables to the same
> netdevice.

Currently with hardware offload a device can only bind with one indr flow-block,

So it also can only bind with one flowtable. 

Maybe it only need to check whether the flowtable with flag NF_FLOWTABLE_HW_OFFLOAD ?

>
> I'm still looking, it will take me a while to figure out where to go,
> please stay tuned.
>
> Thank you.
>
