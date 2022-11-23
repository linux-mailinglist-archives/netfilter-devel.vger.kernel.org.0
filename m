Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2D63602E
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Nov 2022 14:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiKWNk4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Nov 2022 08:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiKWNka (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:40:30 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85264D0
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Nov 2022 05:27:51 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oxpn3-0001ID-AB; Wed, 23 Nov 2022 14:27:49 +0100
Date:   Wed, 23 Nov 2022 14:27:49 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables-nft RFC 1/5] nft-shared: dump errors on stdout to
 garble output
Message-ID: <20221123132749.GB2753@breakpoint.cc>
References: <20221121111932.18222-1-fw@strlen.de>
 <20221121111932.18222-2-fw@strlen.de>
 <Y30NJTaQx8Wn7RLE@orbyte.nwl.cc>
 <20221123125032.GA2753@breakpoint.cc>
 <Y34cjdOo11JO8J7/@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y34cjdOo11JO8J7/@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > Huh?
> > iptables-restore < bla
> > iptables-restore v1.8.8 (nf_tables): unknown option "--bla"
> > Error occurred at line: 7 Try `iptables-restore -h' or 'iptables-restore --help' for more information.
> > 
> > ... exits with 2.
> > 
> > Can you give an example?
> 
> # nft add table ip filter '{ chain FORWARD { \
> 	type filter hook forward priority filter; \
> 	ip saddr 10.1.2.3 meta cpu 3 counter accept; }; }'
> 
> # nft list ruleset 
> table ip filter {
> 	chain FORWARD {
> 		type filter hook forward priority filter; policy accept;
> 		ip saddr 10.1.2.3 meta cpu 3 counter packets 0 bytes 0 accept
> 	}
> }
> 
> # iptables-nft -S FORWARD
> -P FORWARD ACCEPT
> -A FORWARD -s 10.1.2.3/32 -j ACCEPT
> # echo $?
> 0

Ah.  I thought you were talking about iptables-restore/rule parsing.
