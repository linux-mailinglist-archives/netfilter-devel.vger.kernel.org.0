Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC347EAFD6
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Nov 2023 13:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjKNM3C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Nov 2023 07:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNM3C (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:29:02 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6AD1
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Nov 2023 04:28:59 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r2sX5-0008Kh-1D; Tue, 14 Nov 2023 13:28:43 +0100
Date:   Tue, 14 Nov 2023 13:28:43 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Linkui Xiao <xiaolinkui@kylinos.cn>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH 1/1] netfilter: ipset: fix race condition between
 swap/destroy and kernel side add/del/test, v3
Message-ID: <20231114122843.GB11683@breakpoint.cc>
References: <20231113201323.1747378-1-kadlec@netfilter.org>
 <20231113201323.1747378-2-kadlec@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113201323.1747378-2-kadlec@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> Linkui Xiao reported that there's a race condition when ipset swap and destroy is
> called, which can lead to crash in add/del/test element operations. Swap then
> destroy are usual operations to replace a set with another one in a production
> system. The issue can in some cases be reproduced with the script:
> 
> ipset create hash_ip1 hash:net family inet hashsize 1024 maxelem 1048576
> ipset add hash_ip1 172.20.0.0/16
> ipset add hash_ip1 192.168.0.0/16
> iptables -A INPUT -m set --match-set hash_ip1 src -j ACCEPT
> while [ 1 ]
> do
> 	# ... Ongoing traffic...
>         ipset create hash_ip2 hash:net family inet hashsize 1024 maxelem 1048576
>         ipset add hash_ip2 172.20.0.0/16
>         ipset swap hash_ip1 hash_ip2
>         ipset destroy hash_ip2
>         sleep 0.05
> done
> 
> In the race case the possible order of the operations are
> 
> 	CPU0			CPU1
> 	ip_set_test
> 				ipset swap hash_ip1 hash_ip2
> 				ipset destroy hash_ip2
> 	hash_net_kadt
> 
> Swap replaces hash_ip1 with hash_ip2 and then destroy removes hash_ip2 which
> is the original hash_ip1. ip_set_test was called on hash_ip1 and because destroy
> removed it, hash_net_kadt crashes.
> 
> The fix is to force ip_set_swap() to wait for all readers to finish accessing the
> old set pointers by calling synchronize_rcu().

Patch LGTM, thanks Jozsef!
