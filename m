Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8591CA777B
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2019 01:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfICXQZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 19:16:25 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:31927 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfICXQZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:16:25 -0400
Received: from [192.168.1.4] (unknown [58.38.6.224])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id E7C744116A;
        Wed,  4 Sep 2019 07:16:21 +0800 (CST)
Subject: Re: [PATCH nf-next v3] netfilter: nf_table_offload: Fix the incorrect
 rcu usage in nft_indr_block_cb
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
References: <1567480527-27473-1-git-send-email-wenxu@ucloud.cn>
 <20190903200649.vmc5mh56dz3f3jlo@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <30aeb7af-4b92-c727-e569-6c470d71b8c6@ucloud.cn>
Date:   Wed, 4 Sep 2019 07:16:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903200649.vmc5mh56dz3f3jlo@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVTUhIS0tLSU5PTUhKS09ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6LAw6Kjg6VjAhIywKEjUN
        TCMwCw1VSlVKTk1MTk5JTkNJSktNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWU5DVUhD
        VU1VSUlPWVdZCAFZQUlJTUw3Bg++
X-HM-Tid: 0a6cf96a31a12086kuqye7c744116a
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

yes, It's an another problem. I will send another patch to fix it.

在 2019/9/4 4:06, Pablo Neira Ayuso 写道:
> On Tue, Sep 03, 2019 at 11:15:27AM +0800, wenxu@ucloud.cn wrote:
>> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
>> index 113ac40..ca9e0cb 100644
>> --- a/net/netfilter/nf_tables_offload.c
>> +++ b/net/netfilter/nf_tables_offload.c
>> @@ -357,11 +357,12 @@ static void nft_indr_block_cb(struct net_device *dev,
>>  	const struct nft_table *table;
>>  	const struct nft_chain *chain;
>>  
>> -	list_for_each_entry_rcu(table, &net->nft.tables, list) {
>> +	mutex_lock(&net->nft.commit_mutex);
>> +	list_for_each_entry(table, &net->nft.tables, list) {
>>  		if (table->family != NFPROTO_NETDEV)
>>  			continue;
>>  
>> -		list_for_each_entry_rcu(chain, &table->chains, list) {
>> +		list_for_each_entry(chain, &table->chains, list) {
>>  			if (!nft_is_base_chain(chain))
>>  				continue;
> nft_indr_block_cb() does not check for the offload flag in the
> basechain...
>
