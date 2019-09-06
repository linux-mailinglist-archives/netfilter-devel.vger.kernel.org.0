Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE6AB0EC
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2019 05:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfIFDZ3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 23:25:29 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:17520 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391317AbfIFDZ3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:25:29 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id A6CBA4185D;
        Fri,  6 Sep 2019 11:25:26 +0800 (CST)
Subject: Re: [PATCH nf-next v3 3/4] netfilter: nf_tables_offload: add
 nft_offload_netdev_iterate function
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <1567656019-6881-1-git-send-email-wenxu@ucloud.cn>
 <1567656019-6881-4-git-send-email-wenxu@ucloud.cn>
 <20190906003412.eftkpvvhqedmq3de@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <eb51cdce-96dc-2dea-7538-d09142eb0708@ucloud.cn>
Date:   Fri, 6 Sep 2019 11:25:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906003412.eftkpvvhqedmq3de@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSENNS0tLSk5NT0tJTkJZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQg6Lww4FTgwHzcQHwwNSi8U
        HT0wCk9VSlVKTk1MTE9LSElNQ0lNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSkJPQjcG
X-HM-Tid: 0a6d049af3642086kuqya6cba4185d
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 9/6/2019 8:34 AM, Pablo Neira Ayuso wrote:
> On Thu, Sep 05, 2019 at 12:00:18PM +0800, wenxu@ucloud.cn wrote:
> [...]
>> +static void nft_indr_block_cb(struct net_device *dev,
>> +			      flow_indr_block_bind_cb_t *cb, void *cb_priv,
>> +			      enum flow_block_command cmd)
>> +{
>> +	struct net *net = dev_net(dev);
>> +	struct nft_chain *chain;
>> +
>> +	mutex_lock(&net->nft.commit_mutex);
>> +	chain = nft_offload_netdev_iterate(dev);
> Ah, right, not an interator. Probably __nft_offload_get_basechain(dev) ?
>
> The initial __nft_... suggests the reader that the mutex is required.
Yes, it is better.
>
