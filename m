Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949E3352585
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Apr 2021 04:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhDBChQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 22:37:16 -0400
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:19585 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDBChQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 22:37:16 -0400
Received: from [192.168.188.110] (unknown [106.75.220.2])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id A020CE024A3;
        Fri,  2 Apr 2021 10:37:11 +0800 (CST)
Subject: Re: [PATCH nf-next 1/2] netfilter: flowtable: add vlan match offload
 support
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <1617263411-3244-1-git-send-email-wenxu@ucloud.cn>
 <20210401081808.GA7908@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <1386b6b2-edfe-04cb-0c3d-624dbbb0ada9@ucloud.cn>
Date:   Fri, 2 Apr 2021 10:37:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210401081808.GA7908@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZT0pKTUlPSUhKShgfVkpNSkxISEpLSEpMQ0JVGRETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46NDo*Az06Dw4*E0wLSUww
        EBYKCgpVSlVKTUpMSEhKS0hKQ0NNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpLTVVM
        TlVJSUtVSVlXWQgBWUFKT0JDNwY+
X-HM-Tid: 0a7890710ea020bdkuqya020ce024a3
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On 4/1/2021 4:18 PM, Pablo Neira Ayuso wrote:
> On Thu, Apr 01, 2021 at 03:50:10PM +0800, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> This patch support vlan_id, vlan_priority and vlan_proto match
>> for flowtable offload
> No driver in tree is using this code.
I think mlx5_core driver can support match this code in FT offload
