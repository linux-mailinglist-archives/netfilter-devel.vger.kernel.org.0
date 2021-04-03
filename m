Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE8353427
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Apr 2021 15:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhDCNdp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Apr 2021 09:33:45 -0400
Received: from m97179.mail.qiye.163.com ([220.181.97.179]:8446 "EHLO
        m97179.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDCNdo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Apr 2021 09:33:44 -0400
Received: from [192.168.1.8] (unknown [180.157.172.243])
        by m97179.mail.qiye.163.com (Hmail) with ESMTPA id 12037E0284A;
        Sat,  3 Apr 2021 21:33:34 +0800 (CST)
Subject: Re: [PATCH nf] netfilter: nft_payload: fix vlan_tpid get from
 h_vlan_proto
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <1617347632-19283-1-git-send-email-wenxu@ucloud.cn>
 <20210402195403.GA22049@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <6ce0f16c-69ae-265a-bea8-bc2c4705dd5b@ucloud.cn>
Date:   Sat, 3 Apr 2021 21:33:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20210402195403.GA22049@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSUI3V1ktWUFJV1kPCR
        oVCBIfWUFZQh4dTU4ZHh5CGB5KVkpNSkxPTk1DSk9JSk1VGRETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OS46Tww*IT02EwwQIjgNCjEO
        EBwaCxJVSlVKTUpMT05NQ0pPSEhKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpDS1VK
        TkxVSkxJVUlPSFlXWQgBWUFKTUJMNwY+
X-HM-Tid: 0a7897f0584120bdkuqy12037e0284a
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


在 2021/4/3 3:54, Pablo Neira Ayuso 写道:
> On Fri, Apr 02, 2021 at 03:13:52PM +0800, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> vlan_tpid of flow_dissector_key_vlan should be set as h_vlan_proto
>> but not h_vlan_encapsulated_proto.
> Probably this patch instead?

I don't think so.  The vlan_tpid in flow_dissector_key_vlan should be the

vlan proto (such as ETH_P_8021Q or ETH_P_8021AD) but not h_vlan_encapsulated_proto (for next header proto).

But this is a problem that the vlan_h_proto is the same as offsetof(struct ethhdr, h_proto)

