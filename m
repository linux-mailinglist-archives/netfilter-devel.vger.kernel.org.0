Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC05874C20
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 12:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfGYKs5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 06:48:57 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:54163 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGYKs5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:48:57 -0400
Received: from [192.168.188.14] (unknown [120.132.1.226])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 0956041AA7;
        Thu, 25 Jul 2019 18:48:54 +0800 (CST)
Subject: Re: vrf and flowtable problems
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20190725101044.kkoyziz57iynjmzc@salvia>
From:   wenxu <wenxu@ucloud.cn>
Message-ID: <b700826a-589b-dcf8-bc4a-0ca65520351a@ucloud.cn>
Date:   Thu, 25 Jul 2019 18:48:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725101044.kkoyziz57iynjmzc@salvia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVQkJLS0tLSU9MQk5OSElZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6IRw*EDg9IlYtQhwoOg0T
        Cz5PC0JVSlVKTk1PS05KTEhPT0JNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJS1VK
        SElVSlVJSU1ZV1kIAVlBSklNQzcG
X-HM-Tid: 0a6c28bf7e5b2086kuqy0956041aa7
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I will check it.

On 7/25/2019 6:10 PM, Pablo Neira Ayuso wrote:
> Hi,
>
> There are reports
>
> https://github.com/openwrt/openwrt/pull/2266#issuecomment-514681715
>
> This report might not be your fault, but you can probably help fixing
> bugs before we move on anywhere else.
>
