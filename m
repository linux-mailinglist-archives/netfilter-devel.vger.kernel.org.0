Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F36A49F
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfGPJLQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 05:11:16 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55262 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbfGPJLQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:11:16 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hnJUN-0003YP-F8; Tue, 16 Jul 2019 11:11:11 +0200
Date:   Tue, 16 Jul 2019 11:11:11 +0200
From:   Florian Westphal <fw@strlen.de>
To:     wenxu@ucloud.cn
Cc:     pablo@netfilter.org, fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v5 0/8] netfilter: nf_flow_offload: support
 bridge family offload for both
Message-ID: <20190716091111.bqjnoqcfd4aykbqc@breakpoint.cc>
References: <1563238066-3105-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563238066-3105-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

wenxu@ucloud.cn <wenxu@ucloud.cn> wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> wenxu (8):
>   netfilter:nf_flow_table: Refactor flow_offload_tuple to destination
>   netfilter:nf_flow_table_core: Separate inet operation to single
>     function
>   netfilter:nf_flow_table_ip: Separate inet operation to single function
>   bridge: add br_vlan_get_info_rcu()
>   netfilter:nf_flow_table_core: Support bridge family flow offload
>   netfilter:nf_flow_table_ip: Support bridge family flow offload
>   netfilter:nft_flow_offload: Support bridge family flow offload
>   netfilter: Support the bridge family in flow table

Note that net-next is closed, and therefore nf-next, so it may
take longer than usual for this series to get feedback.
