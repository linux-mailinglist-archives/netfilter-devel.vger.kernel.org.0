Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3089E96FC8
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 04:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfHUCxA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Aug 2019 22:53:00 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:64788 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfHUCxA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:53:00 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 495A641750;
        Wed, 21 Aug 2019 10:52:53 +0800 (CST)
Subject: Re: [PATCH nf-next v4 00/12] netfilter: nf_tables_offload: support
 more expr and obj offload
From:   wenxu <wenxu@ucloud.cn>
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
References: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
Message-ID: <dd78c477-8dd9-d034-73ed-73f88676e539@ucloud.cn>
Date:   Wed, 21 Aug 2019 10:52:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSEtMS0tLS09KS0tDWVdZKFlBSU
        I3V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6FRw6UTgrHz8MTDYQFRY3
        SD8aCxhVSlVKTk1NSE5OQkxITUpPVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBTktDSDcG
X-HM-Tid: 0a6cb217653d2086kuqy495a641750
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Please drop this series first, I will send patches for each offload function individually

On 8/14/2019 6:16 PM, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
>
> This series patch support more expr and obj offload: 
> fw_nedev, set payload, tunnel encap/decap action,
> Add tunnel match on TUNNEL_IP(6)_SRC/DST.
> Tunnel meta match, objref offload.
>
> The follwing is the test sample:
>
> # nft add table netdev firewall
> # nft add tunnel netdev firewall encap tunid 1000 tundst 0xf198a8ac tunsrc 0x4b98a8ac tunrelease 0
> # nft add tunnel netdev firewall decap tunid 0 tundst 0 tunsrc 0  tunrelease 1
> # nft add chain netdev firewall aclout { type filter hook ingress device mlx_pf0vf0 priority - 300 \; }
> # nft --debug=netlink add rule netdev firewall aclout ip daddr 10.0.1.7  @ll,0,48 set 0x00002e9ca06e2596 @ll,48,48 set 0xfaffffffffff tunnel name encap fwd to gretap
>   [ meta load protocol => reg 1 ] 
>   [ cmp eq reg 1 0x00000008 ]
>   [ payload load 4b @ network header + 16 => reg 1 ] 
>   [ cmp eq reg 1 0x0701000a ]
>   [ immediate reg 1 0x6ea09c2e 0x00009625 ]
>   [ payload write reg 1 => 6b @ link header + 0 csum_type 0 csum_off 0 csum_flags 0x0 ]
>   [ immediate reg 1 0xfffffffa 0x0000ffff ]
>   [ payload write reg 1 => 6b @ link header + 6 csum_type 0 csum_off 0 csum_flags 0x0 ]
>   [ objref type 6 name encap ]
>   [ immediate reg 1 0x00000019 ]
>   [ fwd sreg_dev 1 ] 
>
> # nft add chain netdev firewall aclin { type filter hook ingress device gretap priority - 300 \; }
> # nft --debug=netlink add rule netdev firewall aclin ip daddr 10.0.0.7 tunnel tunid 1000 tunnel tundst 172.168.152.75 tunnel tunsrc 172.168.152.241 tunnel name decap @ll,0,48 set 0x0000525400001275 @ll,48,48 set 0xfaffffffffff fwd to mlx_pf0vf0
>   [ meta load protocol => reg 1 ]
>   [ cmp eq reg 1 0x00000008 ]
>   [ payload load 4b @ network header + 16 => reg 1 ]
>   [ cmp eq reg 1 0x0700000a ]
>   [ tunnel load id => reg 1 ]
>   [ cmp eq reg 1 0x000003e8 ]
>   [ tunnel load tun_dst => reg 1 ]
>   [ cmp eq reg 1 0xaca8984b ]
>   [ tunnel load tun_src => reg 1 ]
>   [ cmp eq reg 1 0xaca898f1 ]
>   [ objref type 6 name decap ]
>   [ immediate reg 1 0x00005452 0x00007512 ]
>   [ payload write reg 1 => 6b @ link header + 0 csum_type 0 csum_off 0 csum_flags 0x0 ]
>   [ immediate reg 1 0xfffffffa 0x0000ffff ]
>   [ payload write reg 1 => 6b @ link header + 6 csum_type 0 csum_off 0 csum_flags 0x0 ]
>   [ immediate reg 1 0x0000000f ]
>   [ fwd sreg_dev 1 ]
>
> wenxu (12):
>   netfilter: nf_flow_offload: add net in offload_ctx
>   netfilter: nf_tables_offload: add offload_actions callback
>   netfilter: nft_fwd_netdev: add fw_netdev action support
>   netfilter: nft_payload: add nft_set_payload offload support
>   netfilter: nft_tunnel: add nft_tunnel_mode_validate function
>   netfilter: nft_tunnel: support NFT_TUNNEL_IP_SRC/DST match
>   netfilter: nft_tunnel: add ipv6 check in nft_tunnel_mode_validate
>   netfilter: nft_tunnel: support NFT_TUNNEL_IP6_SRC/DST match
>   netfilter: nft_tunnel: support tunnel meta match offload
>   netfilter: nft_tunnel: add NFTA_TUNNEL_KEY_RELEASE action
>   netfilter: nft_objref: add nft_objref_type offload
>   netfilter: nft_tunnel: support nft_tunnel_obj offload
>
>  include/net/netfilter/nf_tables.h         |  10 +-
>  include/net/netfilter/nf_tables_offload.h |  10 +-
>  include/uapi/linux/netfilter/nf_tables.h  |   5 +
>  net/netfilter/nf_tables_api.c             |   2 +-
>  net/netfilter/nf_tables_offload.c         |   7 +-
>  net/netfilter/nft_fwd_netdev.c            |  27 +++++
>  net/netfilter/nft_immediate.c             |   2 +-
>  net/netfilter/nft_objref.c                |  15 +++
>  net/netfilter/nft_payload.c               |  56 +++++++++++
>  net/netfilter/nft_tunnel.c                | 159 +++++++++++++++++++++++++++---
>  10 files changed, 271 insertions(+), 22 deletions(-)
>
