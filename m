Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC174C1F
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 12:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbfGYKsc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 06:48:32 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:53557 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGYKsc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:48:32 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 7255E41B51;
        Thu, 25 Jul 2019 18:48:24 +0800 (CST)
Subject: Re: [PATCH nf-next 3/5] netfilter: nft_tunnel: add
 NFTA_TUNNEL_KEY_RELEASE action
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
References: <1564027781-24882-1-git-send-email-wenxu@ucloud.cn>
 <1564027781-24882-4-git-send-email-wenxu@ucloud.cn>
 <20190725101502.lsfg2rlxdpuyb6je@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <054788af-ce7b-14f4-5a82-e2e7a092df58@ucloud.cn>
Date:   Thu, 25 Jul 2019 18:48:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725101502.lsfg2rlxdpuyb6je@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVQ0lOS0tLSk1NQ0JIS0pZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pio6Tzo4DDgyPlYuKxEjOhkJ
        DTMwCSFVSlVKTk1PS05KTEtPTUhNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSkxPSjcG
X-HM-Tid: 0a6c28bf0b062086kuqy7255e41b51
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 7/25/2019 6:15 PM, Pablo Neira Ayuso wrote:
> On Thu, Jul 25, 2019 at 12:09:39PM +0800, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> Add new NFTA_TUNNEL_KEY_RELEASE action for future offload
>> feature
> How is hardware using this?

It will add a action with id  FLOW_ACTION_TUNNEL_DECAP,  which tell hardware to

decap the tunnel.  It is the same as TCA_TUNNEL_KEY_ACT_RELEASE in tc

