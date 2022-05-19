Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6802F52DE8A
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 May 2022 22:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiESUlQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 May 2022 16:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244702AbiESUlQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 May 2022 16:41:16 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CC0318B18
        for <netfilter-devel@vger.kernel.org>; Thu, 19 May 2022 13:41:15 -0700 (PDT)
Date:   Thu, 19 May 2022 22:41:12 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        syzbot+4903218f7fba0a2d6226@syzkaller.appspotmail.com,
        syzbot+afd2d80e495f96049571@syzkaller.appspotmail.com
Subject: Re: [PATCH nf-next] netfilter: nfnetlink: fix warn in
 nfnetlink_unbind
Message-ID: <YoaraJtfL87/xy5/@salvia>
References: <20220517192111.2080-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220517192111.2080-1-fw@strlen.de>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 17, 2022 at 09:21:11PM +0200, Florian Westphal wrote:
> syzbot reports following warn:
> WARNING: CPU: 0 PID: 3600 at net/netfilter/nfnetlink.c:703 nfnetlink_unbind+0x357/0x3b0 net/netfilter/nfnetlink.c:694
> 
> The syzbot generated program does this:
> 
> socket(AF_NETLINK, SOCK_RAW, NETLINK_NETFILTER) = 3
> setsockopt(3, SOL_NETLINK, NETLINK_DROP_MEMBERSHIP, [1], 4) = 0
> 
> ... which triggers 'WARN_ON_ONCE(nfnlnet->ctnetlink_listeners == 0)' check.
> 
> Instead of counting, just enable reporting for every bind request
> and check if we still have listeners on unbind.
> 
> While at it, also add the needed bounds check on nfnl_group2type[]
> access.

Also applied
