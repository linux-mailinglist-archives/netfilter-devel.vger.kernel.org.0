Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE1B57EF24
	for <lists+netfilter-devel@lfdr.de>; Sat, 23 Jul 2022 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiGWMfw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 23 Jul 2022 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGWMfw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 23 Jul 2022 08:35:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FA2DDF
        for <netfilter-devel@vger.kernel.org>; Sat, 23 Jul 2022 05:35:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oFEME-0006Cd-0h; Sat, 23 Jul 2022 14:35:46 +0200
Date:   Sat, 23 Jul 2022 14:35:45 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Jan Engelhardt <jengelh@inai.de>,
        Erik Skultety <eskultet@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] iptables: xshared: Ouptut '--' in the opt field
 in ipv6's fake mode
Message-ID: <20220723123545.GA20457@breakpoint.cc>
References: <bb391c763171f0c5511f73e383e1b2e6a53e2014.1658322396.git.eskultet@redhat.com>
 <20220720142002.GA22790@breakpoint.cc>
 <YtgpJ9FNZmmuniLV@nautilus.home.lan>
 <YtvDzOxd1/eEMaFo@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtvDzOxd1/eEMaFo@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Another bug I found while playing around is this:
> 
> | # iptables -A FORWARD -p icmpv6
> | # iptables -vnL FORWARD
> | Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
> |  pkts bytes target     prot opt in     out     source               destination
> |     0     0            ipv6-icmp--  *      *       0.0.0.0/0            0.0.0.0/0
> 
> print_rule_details() does not append a space after the protocol name if it is
> longer or equal to five characters.
> 
> Both bugs seem to exist since day 1, I'm still tempted to fix them, i.e.:
> 
> - Print protocol numbers with --numeric
> - Adjust the protocol format string from "%-5s" to "%-4s " for protocol
>   names and from "%-5hu" to "%-4hu " for protocol numbers to force a
>   single white space
> 
> Objections anyone?

No, go ahead.  Also, I think that the proposed "--" change is the least
intrusive option so I'm inclined to apply the patch as-is.
