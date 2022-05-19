Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9952DE84
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 May 2022 22:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiESUkP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 May 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiESUkP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 May 2022 16:40:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C83B98597
        for <netfilter-devel@vger.kernel.org>; Thu, 19 May 2022 13:40:11 -0700 (PDT)
Date:   Thu, 19 May 2022 22:40:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        syzbot+92968395eedbdbd3617d@syzkaller.appspotmail.com
Subject: Re: [PATCH nf-next] netfilter: cttimeout: fix slab-out-of-bounds
 read in cttimeout_net_exit
Message-ID: <YoarJyKPuoiP9F/K@salvia>
References: <0000000000002ecf9805df3af808@google.com>
 <20220517205036.25883-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517205036.25883-1-fw@strlen.de>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 17, 2022 at 10:50:36PM +0200, Florian Westphal wrote:
> syzbot reports:
> BUG: KASAN: slab-out-of-bounds in __list_del_entry_valid+0xcc/0xf0 lib/list_debug.c:42
> [..]
>  list_del include/linux/list.h:148 [inline]
>  cttimeout_net_exit+0x211/0x540 net/netfilter/nfnetlink_cttimeout.c:617
> 
> No reproducer so far. Looking at recent changes in this area
> its clear that the free_head must not be at the end of the
> structure because nf_ct_timeout structure has variable size.

Applied, thanks
