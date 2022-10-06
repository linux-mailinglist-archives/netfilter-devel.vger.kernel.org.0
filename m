Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33685F6867
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJFNnq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Oct 2022 09:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJFNnp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:43:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8A498CAF;
        Thu,  6 Oct 2022 06:43:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ogRA4-0008Fj-Uu; Thu, 06 Oct 2022 15:43:40 +0200
Date:   Thu, 6 Oct 2022 15:43:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        Paolo Abeni <pabeni@redhat.com>,
        netfilter-devel@vger.kernel.org,
        netfilter <netfilter@vger.kernel.org>
Subject: Re: Kernel 6.0.0 bug pptp not work
Message-ID: <20221006134340.GA31481@breakpoint.cc>
References: <3D70BC1B-A19E-45E3-B6BC-6B2719BA9B46@gmail.com>
 <20221006111811.GA3034@breakpoint.cc>
 <0DF040F3-ACC8-447E-99DA-BB77FEE03C7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0DF040F3-ACC8-447E-99DA-BB77FEE03C7E@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Martin Zaharinov <micron10@gmail.com> wrote:
> Huh
> Very strange in kernel 6.0.0 i not found : net.netfilter.nf_conntrack_helper
> 
> 
> in old kernel 5.19.14 in sysctl -a | grep net.netfilter.nf_conntrack_helper 
> 
> net.netfilter.nf_conntrack_helper = 1

Yes, so this is expected -- 6.0.0 should behave like 5.19.14 with
net.netfilter.nf_conntrack_helper=0.

You need something like:

table inet foo {
        ct helper pptp {
                type "pptp" protocol tcp
                l3proto ip
        }

        chain prerouting {
                type filter hook prerouting priority filter; policy accept;
                tcp dport 1723 ct helper set "pptp"
        }
}

... so that the helper will start processing traffic on the pptp control port.
You might want to refine the rule a big, e.g.
'iifname ppp*' or similar, to restrict/limit the helper to those clients that need
it.
