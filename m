Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E766D4FA699
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Apr 2022 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiDIJyB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 Apr 2022 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiDIJyB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:54:01 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC973E0C9
        for <netfilter-devel@vger.kernel.org>; Sat,  9 Apr 2022 02:51:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nd7l2-0007O8-51; Sat, 09 Apr 2022 11:51:52 +0200
Date:   Sat, 9 Apr 2022 11:51:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] doc: Document that kernel may accept unimplemented
 expressions
Message-ID: <20220409095152.GA19371@breakpoint.cc>
References: <20220409094402.22567-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409094402.22567-1-toiwoton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> wrote:
> Kernel silently accepts input chain filters using meta skuid, meta
> skgid, meta cgroup or socket cgroupv2 expressions but they don't work
> yet. Warn the users of this possibility.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  doc/nft.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/doc/nft.txt b/doc/nft.txt
> index f7a53ac9..4820b4ae 100644
> --- a/doc/nft.txt
> +++ b/doc/nft.txt
> @@ -932,6 +932,11 @@ filter output oif wlan0
>  ^^^^^^^^^^^^^^^^^^^^^^^
>  ---------------------------------
>  
> +Note that the kernel may accept expressions without errors even if it
> +doesn't implement the feature. For example, input chain filters using
> +*meta skuid*, *meta skgid*, *meta cgroup* or *socket cgroupv2*
> +expressions are silently accepted but they don't work yet.

Thats not correct.

Those expressions load values from skb->sk, i.e. the socket associated
with the packet.

In input, such socket may exist, either because of tproxy rules, early
demux, or bpf programs.
