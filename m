Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0017D4A0
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Aug 2019 06:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfHAErp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Aug 2019 00:47:45 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:58138 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHAErp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:47:45 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id A20BA412E2;
        Thu,  1 Aug 2019 12:47:38 +0800 (CST)
Subject: Re: [PATCH net-next v5 6/6] netfilter: nf_tables_offload: support
 indr block call
To:     Yunsheng Lin <linyunsheng@huawei.com>, jiri@resnulli.us,
        pablo@netfilter.org, fw@strlen.de, jakub.kicinski@netronome.com
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
References: <1564628627-10021-1-git-send-email-wenxu@ucloud.cn>
 <1564628627-10021-7-git-send-email-wenxu@ucloud.cn>
 <71694067-b07f-bed6-c472-4ec37dbeba3d@huawei.com>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <6aa3104f-b675-a4bd-e01b-51de55c18fe8@ucloud.cn>
Date:   Thu, 1 Aug 2019 12:47:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <71694067-b07f-bed6-c472-4ec37dbeba3d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS0NJQkJCQ0lOT0xMTVlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBA6GSo6Dzg2Lk85OjIQISIy
        HC0wCjVVSlVKTk1PTUhPQ05CSE5PVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSktKSU83Bg++
X-HM-Tid: 0a6c4b8145b82086kuqya20ba412e2
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 8/1/2019 11:58 AM, Yunsheng Lin wrote:
> On 2019/8/1 11:03, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> nftable support indr-block call. It makes nftable an offload vlan
>> and tunnel device.
>>
>> nft add table netdev firewall
>> nft add chain netdev firewall aclout { type filter hook ingress offload device mlx_pf0vf0 priority - 300 \; }
>> nft add rule netdev firewall aclout ip daddr 10.0.0.1 fwd to vlan0
>> nft add chain netdev firewall aclin { type filter hook ingress device vlan0 priority - 300 \; }
>> nft add rule netdev firewall aclin ip daddr 10.0.0.7 fwd to mlx_pf0vf0
>>
>> Signed-off-by: wenxu <wenxu@ucloud.cn>
>> ---
>> v5: add nft_get_default_block
>>
>>  include/net/netfilter/nf_tables_offload.h |   2 +
>>  net/netfilter/nf_tables_api.c             |   7 ++
>>  net/netfilter/nf_tables_offload.c         | 156 +++++++++++++++++++++++++-----
>>  3 files changed, 141 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
>> index 3196663..ac69087 100644
>> --- a/include/net/netfilter/nf_tables_offload.h
>> +++ b/include/net/netfilter/nf_tables_offload.h
>> @@ -63,6 +63,8 @@ struct nft_flow_rule {
>>  struct nft_flow_rule *nft_flow_rule_create(const struct nft_rule *rule);
>>  void nft_flow_rule_destroy(struct nft_flow_rule *flow);
>>  int nft_flow_rule_offload_commit(struct net *net);
>> +bool nft_indr_get_default_block(struct net_device *dev,
>> +				struct flow_indr_block_info *info);
>>  
>>  #define NFT_OFFLOAD_MATCH(__key, __base, __field, __len, __reg)		\
>>  	(__reg)->base_offset	=					\
>> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
>> index 605a7cf..6a1d0b2 100644
>> --- a/net/netfilter/nf_tables_api.c
>> +++ b/net/netfilter/nf_tables_api.c
>> @@ -7593,6 +7593,11 @@ static void __net_exit nf_tables_exit_net(struct net *net)
>>  	.exit	= nf_tables_exit_net,
>>  };
>>  
>> +static struct flow_indr_get_block_entry get_block_entry = {
>> +	.get_block_cb = nft_indr_get_default_block,
>> +	.list = LIST_HEAD_INIT(get_block_entry.list),
>> +};
>> +
>>  static int __init nf_tables_module_init(void)
>>  {
>>  	int err;
>> @@ -7624,6 +7629,7 @@ static int __init nf_tables_module_init(void)
>>  		goto err5;
>>  
>>  	nft_chain_route_init();
>> +	flow_indr_add_default_block_cb(&get_block_entry);
>>  	return err;
>>  err5:
>>  	rhltable_destroy(&nft_objname_ht);
>> @@ -7640,6 +7646,7 @@ static int __init nf_tables_module_init(void)
>>  
>>  static void __exit nf_tables_module_exit(void)
>>  {
>> +	flow_indr_del_default_block_cb(&get_block_entry);
>>  	nfnetlink_subsys_unregister(&nf_tables_subsys);
>>  	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
>>  	nft_chain_filter_fini();
>> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
>> index 64f5fd5..59c9629 100644
>> --- a/net/netfilter/nf_tables_offload.c
>> +++ b/net/netfilter/nf_tables_offload.c
>> @@ -171,24 +171,114 @@ static int nft_flow_offload_unbind(struct flow_block_offload *bo,
>>  	return 0;
>>  }
>>  
>> +static int nft_block_setup(struct nft_base_chain *basechain,
>> +			   struct flow_block_offload *bo,
>> +			   enum flow_block_command cmd)
>> +{
>> +	int err;
>> +
>> +	switch (cmd) {
>> +	case FLOW_BLOCK_BIND:
>> +		err = nft_flow_offload_bind(bo, basechain);
>> +		break;
>> +	case FLOW_BLOCK_UNBIND:
>> +		err = nft_flow_offload_unbind(bo, basechain);
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		err = -EOPNOTSUPP;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int nft_block_offload_cmd(struct nft_base_chain *chain,
>> +				 struct net_device *dev,
>> +				 enum flow_block_command cmd)
>> +{
>> +	struct netlink_ext_ack extack = {};
>> +	struct flow_block_offload bo = {};
>> +	int err;
>> +
>> +	bo.net = dev_net(dev);
>> +	bo.block = &chain->flow_block;
>> +	bo.command = cmd;
>> +	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
>> +	bo.extack = &extack;
>> +	INIT_LIST_HEAD(&bo.cb_list);
>> +
>> +	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	return nft_block_setup(chain, &bo, cmd);
>> +}
>> +
>> +static void nft_indr_block_ing_cmd(struct net_device *dev,
>> +				   struct flow_block *flow_block,
>> +				   flow_indr_block_bind_cb_t *cb,
>> +				   void *cb_priv,
>> +				   enum flow_block_command cmd)
>> +{
>> +	struct netlink_ext_ack extack = {};
>> +	struct flow_block_offload bo = {};
>> +	struct nft_base_chain *chain;
>> +
>> +	if (flow_block)
>> +		return;
> Maybe "if (!flow_block)" ?


yes it's a mistake. Thx!

>
>> +
>> +	chain = container_of(flow_block, struct nft_base_chain, flow_block);
>> +
>> +	bo.net = dev_net(dev);
>> +	bo.block = flow_block;
>> +	bo.command = cmd;
>> +	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
>> +	bo.extack = &extack;
>> +	INIT_LIST_HEAD(&bo.cb_list);
>> +
>> +	cb(dev, cb_priv, TC_SETUP_BLOCK, &bo);
>> +
>> +	nft_block_setup(chain, &bo, cmd);
>> +}
>> +
>> +static int nft_indr_block_offload_cmd(struct nft_base_chain *chain,
>> +				      struct net_device *dev,
>> +				      enum flow_block_command cmd)
>> +{
>> +	struct flow_block_offload bo = {};
>> +	struct netlink_ext_ack extack = {};
>> +
>> +	bo.net = dev_net(dev);
>> +	bo.block = &chain->flow_block;
>> +	bo.command = cmd;
>> +	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
>> +	bo.extack = &extack;
>> +	INIT_LIST_HEAD(&bo.cb_list);
>> +
>> +	flow_indr_block_call(&chain->flow_block, dev, nft_indr_block_ing_cmd,
>> +			     &bo, cmd);
>> +
>> +	if (list_empty(&bo.cb_list))
>> +		return -EOPNOTSUPP;
>> +
>> +	return nft_block_setup(chain, &bo, cmd);
>> +}
>> +
>>  #define FLOW_SETUP_BLOCK TC_SETUP_BLOCK
>>  
>>  static int nft_flow_offload_chain(struct nft_trans *trans,
>>  				  enum flow_block_command cmd)
>>  {
>>  	struct nft_chain *chain = trans->ctx.chain;
>> -	struct netlink_ext_ack extack = {};
>> -	struct flow_block_offload bo = {};
>>  	struct nft_base_chain *basechain;
>>  	struct net_device *dev;
>> -	int err;
>>  
>>  	if (!nft_is_base_chain(chain))
>>  		return -EOPNOTSUPP;
>>  
>>  	basechain = nft_base_chain(chain);
>>  	dev = basechain->ops.dev;
>> -	if (!dev || !dev->netdev_ops->ndo_setup_tc)
>> +	if (!dev)
>>  		return -EOPNOTSUPP;
>>  
>>  	/* Only default policy to accept is supported for now. */
>> @@ -197,26 +287,10 @@ static int nft_flow_offload_chain(struct nft_trans *trans,
>>  	    nft_trans_chain_policy(trans) != NF_ACCEPT)
>>  		return -EOPNOTSUPP;
>>  
>> -	bo.command = cmd;
>> -	bo.block = &basechain->flow_block;
>> -	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
>> -	bo.extack = &extack;
>> -	INIT_LIST_HEAD(&bo.cb_list);
>> -
>> -	err = dev->netdev_ops->ndo_setup_tc(dev, FLOW_SETUP_BLOCK, &bo);
>> -	if (err < 0)
>> -		return err;
>> -
>> -	switch (cmd) {
>> -	case FLOW_BLOCK_BIND:
>> -		err = nft_flow_offload_bind(&bo, basechain);
>> -		break;
>> -	case FLOW_BLOCK_UNBIND:
>> -		err = nft_flow_offload_unbind(&bo, basechain);
>> -		break;
>> -	}
>> -
>> -	return err;
>> +	if (dev->netdev_ops->ndo_setup_tc)
>> +		return nft_block_offload_cmd(basechain, dev, cmd);
>> +	else
>> +		return nft_indr_block_offload_cmd(basechain, dev, cmd);
>>  }
>>  
>>  int nft_flow_rule_offload_commit(struct net *net)
>> @@ -266,3 +340,37 @@ int nft_flow_rule_offload_commit(struct net *net)
>>  
>>  	return err;
>>  }
>> +
>> +bool nft_indr_get_default_block(struct net_device *dev,
>> +				struct flow_indr_block_info *info)
>> +{
>> +	struct net *net = dev_net(dev);
>> +	const struct nft_table *table;
>> +	const struct nft_chain *chain;
>> +
>> +	rcu_read_lock();
>> +
>> +	list_for_each_entry_rcu(table, &net->nft.tables, list) {
>> +		if (table->family != NFPROTO_NETDEV)
>> +			continue;
>> +
>> +		list_for_each_entry_rcu(chain, &table->chains, list) {
>> +			if (nft_is_base_chain(chain)) {
>> +				struct nft_base_chain *basechain;
>> +
>> +				basechain = nft_base_chain(chain);
>> +				if (!strncmp(basechain->dev_name, dev->name,
>> +					     IFNAMSIZ)) {
>> +					info->flow_block = &basechain->flow_block;
>> +					info->ing_cmd_cb = nft_indr_block_ing_cmd;
>> +					rcu_read_unlock();
>> +					return true;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	rcu_read_unlock();
>> +
>> +	return false;
>> +}
>>
>
