Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7869EB2B
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 00:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBUXYD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Feb 2023 18:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBUXYD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:24:03 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BEA22005A
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Feb 2023 15:24:02 -0800 (PST)
Date:   Wed, 22 Feb 2023 00:23:59 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] ebtables: fix table blob use-after-free
Message-ID: <Y/VSj9k7d2+vv9Vk@salvia>
References: <20230217222006.169428-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217222006.169428-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 17, 2023 at 11:20:06PM +0100, Florian Westphal wrote:
> We are not allowed to return an error at this point.
> Looking at the code it looks like ret is always 0 at this
> point, but its not.
> 
> t = find_table_lock(net, repl->name, &ret, &ebt_mutex);
> 
> ... this can return a valid table, with ret != 0.
> 
> This bug causes update of table->private with the new
> blob, but then frees the blob right away in the caller.
> 
> Syzbot report:
> 
> BUG: KASAN: vmalloc-out-of-bounds in __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1168
> Read of size 4 at addr ffffc90005425000 by task kworker/u4:4/74
> Workqueue: netns cleanup_net
> Call Trace:
>  kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
>  __ebt_unregister_table+0xc00/0xcd0 net/bridge/netfilter/ebtables.c:1168
>  ebt_unregister_table+0x35/0x40 net/bridge/netfilter/ebtables.c:1372
>  ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
>  cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:613
> ...
> 
> ip(6)tables appears to be ok (ret should be 0 at this point) but make
> this more obvious.

Applied, thanks
