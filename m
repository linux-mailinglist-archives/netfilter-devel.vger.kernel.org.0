Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E113FCAC
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Jan 2020 00:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgAPXF1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jan 2020 18:05:27 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:30556 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388411AbgAPXF1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:05:27 -0500
Received: from [192.168.1.4] (unknown [180.157.109.243])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 9722340CCA;
        Fri, 17 Jan 2020 07:05:22 +0800 (CST)
Subject: Re: [PATCH nf-next v4 0/4] netfilter: flowtable: add indr-block
 offload
From:   wenxu <wenxu@ucloud.cn>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
References: <1578996040-6413-1-git-send-email-wenxu@ucloud.cn>
Message-ID: <ff794ea0-11b7-51fa-0f9b-32481ec90e7a@ucloud.cn>
Date:   Fri, 17 Jan 2020 07:04:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578996040-6413-1-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSUhPS0tLSUtOQkJITU5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6DBw6Ojg9GjBREyEjNB4Z
        UTMKCz9VSlVKTkxCSUpOQklJQ0hKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpDS1VK
        TkxVSktCVUlPSFlXWQgBWUFKQk5MNwY+
X-HM-Tid: 0a6fb09aa6592086kuqy9722340cca
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi pablo,


How about this series? Expect for your feedback. Thanks.


BR

wenxu

�� 2020/1/14 18:00, wenxu@ucloud.cn д��:
> From: wenxu <wenxu@ucloud.cn>
>
> This patch provide tunnel offload based on route lwtunnel.
> The first two patches support indr callback setup
> Then add tunnel match and action offload.
>
> This version just rebase to the nf-next.
>
> Pablo, please give me some feedback. If you feel this series is ok, please
> apply it. Thanks.
>
> wenxu (4):
>    netfilter: flowtable: add nf_flow_table_block_offload_init()
>    netfilter: flowtable: add indr block setup support
>    netfilter: flowtable: add tunnel match offload support
>    netfilter: flowtable: add tunnel encap/decap action offload support
>
>   net/netfilter/nf_flow_table_offload.c | 239 +++++++++++++++++++++++++++++++---
>   1 file changed, 222 insertions(+), 17 deletions(-)
>
