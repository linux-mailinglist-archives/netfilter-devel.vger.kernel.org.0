Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9D6B952
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfGQJcl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 05:32:41 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:58670 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGQJck (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:32:40 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 0A34841BFB;
        Wed, 17 Jul 2019 17:32:34 +0800 (CST)
Subject: Pre-patch of nftables for nft_tunnel
To:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
References: <1563238066-3105-1-git-send-email-wenxu@ucloud.cn>
 <20190716091111.bqjnoqcfd4aykbqc@breakpoint.cc>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <0e4cb0f1-fb5e-1fda-584e-914b63940a68@ucloud.cn>
Date:   Wed, 17 Jul 2019 17:32:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716091111.bqjnoqcfd4aykbqc@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVT0pJS0tLS01LS0NKT0NZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORw6SAw5DzgwMgJPSgEUOSIK
        Ey0wCh9VSlVKTk1ISE5OQk5OSUhLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSk9LTzcG
X-HM-Tid: 0a6bff46bfd62086kuqy0a34841bfb
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian& pablo,


Kernel already support nft_tunnel for sometime, There are some pre patch for nftables. I want to do some test but not so familiar with nftables(Add new expr nft_tunnel_type and  new obj type nft_tunnel_obj_type)



BR

wenxu

