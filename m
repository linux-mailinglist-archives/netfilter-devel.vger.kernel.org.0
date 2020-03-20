Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3811318CF8F
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2020 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCTN4o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Mar 2020 09:56:44 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:34331 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgCTN4o (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:56:44 -0400
Received: from [192.168.1.6] (unknown [101.81.70.14])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 9E5135C15FF;
        Fri, 20 Mar 2020 21:56:35 +0800 (CST)
Subject: Re: [PATCH nf-next v2] netfilter: nf_flow_table_offload: set
 hw_stats_type of flow_action_entry to FLOW_ACTION_HW_STATS_ANY
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <1584709029-20268-1-git-send-email-wenxu@ucloud.cn>
 <20200320130459.fxpsaebyoq4c6em2@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <6644e52d-27d6-ec38-0435-def39ce6caf0@ucloud.cn>
Date:   Fri, 20 Mar 2020 21:55:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320130459.fxpsaebyoq4c6em2@salvia>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVQ01IS0tLSk5PT0JOSU9ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6FDo6Tzg0LBw3DTIaFA8p
        CksaChBVSlVKTkNPTEpJTkJNS05DVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpLSlVD
        SlVMS1VKT1lXWQgBWUFKQ0tPNwY+
X-HM-Tid: 0a70f83b392a2087kuqy9e5135c15ff
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


ÔÚ 2020/3/20 21:04, Pablo Neira Ayuso Ð´µÀ:
> On Fri, Mar 20, 2020 at 08:57:09PM +0800, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> Set hw_stats_type of flow_action_entry to FLOW_ACTION_HW_STATS_ANY to
>> follow the driver behavior.
> Now you have to explain me how you are going to use this.
>
> There is no support for packet/bytes stats right now.
>
> Thank you.

The FLOW_ACTION_HW_STATS_ANY flags is the default behavior and

can avoid the failure of flow inserting. We don't nedd to use this.

>
