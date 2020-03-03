Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254C41775B6
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2020 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgCCMOB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Mar 2020 07:14:01 -0500
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:14963 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgCCMOB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:14:01 -0500
Received: from [192.168.1.6] (unknown [101.86.128.44])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 47EA95C1013;
        Tue,  3 Mar 2020 20:13:53 +0800 (CST)
Subject: Re: [PATCH nf-next v5 0/4] netfilter: flowtable: add indr-block
 offload
From:   wenxu <wenxu@ucloud.cn>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
References: <1582521775-25176-1-git-send-email-wenxu@ucloud.cn>
Message-ID: <d6dd697b-d0dc-d6c6-2cfc-f836f1ac9d02@ucloud.cn>
Date:   Tue, 3 Mar 2020 20:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1582521775-25176-1-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSEhJS0tLSkhNSExOT0hZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6Dxw5ITg6AiEIKQJCQwkt
        IxQwCxhVSlVKTkNISUhMTUhIT0tIVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpLSlVD
        TVVKSUNVT09ZV1kIAVlBSkJISDcG
X-HM-Tid: 0a70a05115482087kuqy47ea95c1013
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi pablo,


How about this series?


BR

wenxu

�� 2020/2/24 13:22, wenxu@ucloud.cn д��:
> From: wenxu <wenxu@ucloud.cn>
>
> This patch provide tunnel offload based on route lwtunnel. 
> The first two patches support indr callback setup
> Then add tunnel match and action offload.
>
> This version modify the second patch: make the dev can bind with different 
> flowtable and check the NF_FLOWTABLE_HW_OFFLOAD flags in 
> nf_flow_table_indr_block_cb_cmd. 
>
> wenxu (4):
>   netfilter: flowtable: add nf_flow_table_block_offload_init()
>   netfilter: flowtable: add indr block setup support
>   netfilter: flowtable: add tunnel match offload support
>   netfilter: flowtable: add tunnel encap/decap action offload support
>
>  net/netfilter/nf_flow_table_offload.c | 233 ++++++++++++++++++++++++++++++++--
>  1 file changed, 219 insertions(+), 14 deletions(-)
>
