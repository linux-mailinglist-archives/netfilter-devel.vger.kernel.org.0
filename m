Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7162F158B5B
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Feb 2020 09:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBKIi5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Feb 2020 03:38:57 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:45280 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgBKIi5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:38:57 -0500
Received: from [192.168.43.231] (unknown [182.97.48.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 0EC6641129;
        Tue, 11 Feb 2020 16:38:49 +0800 (CST)
Subject: Re: [PATCH nf-next v2 0/4] netfilter: nft_tunnel: support tunnel
 match expr offload
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <1573890564-16500-1-git-send-email-wenxu@ucloud.cn>
 <20191118220310.bp24erhewr2uetbp@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <6f59f380-8d3e-92f8-83e4-b413286a9c20@ucloud.cn>
Date:   Tue, 11 Feb 2020 16:38:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20191118220310.bp24erhewr2uetbp@salvia>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVS0pNS0tLSUxLQ09ITkpZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6GDo*Sjg6KCgSDR0cMk88
        GgEaCUJVSlVKTkNKT0pLSEhLT0pDVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpDSVVC
        TFVPQ1VJSU1ZV1kIAVlBSUpNQjcG
X-HM-Tid: 0a703366a6732086kuqy0ec6641129
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


�� 2019/11/19 6:03, Pablo Neira Ayuso д��:
> On Sat, Nov 16, 2019 at 03:49:20PM +0800, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> This series add NFT_TUNNEL_IPV4/6_SRC/DST match and tunnel expr offload.
> Thanks. Please, let me revamp a new patch series for the
> encapsulation/decapsulation support to make sure those are mixing well
> with your tunnel matching support.
Pablo, any update for this series?
>
>> wenxu (4):
>>   netfilter: nft_tunnel: add nft_tunnel_mode_match function
>>   netfilter: nft_tunnel: support NFT_TUNNEL_IPV4_SRC/DST match
>>   netfilter: nft_tunnel: support NFT_TUNNEL_IPV6_SRC/DST match
>>   netfilter: nft_tunnel: add nft_tunnel_get_offload support
>>
>>  include/net/netfilter/nf_tables_offload.h |   5 ++
>>  include/uapi/linux/netfilter/nf_tables.h  |   4 +
>>  net/netfilter/nft_tunnel.c                | 138 +++++++++++++++++++++++++++---
>>  3 files changed, 134 insertions(+), 13 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
