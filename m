Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4239D6C88A8
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Mar 2023 23:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjCXW7J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Mar 2023 18:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXW7I (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:59:08 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A621C7FD
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Mar 2023 15:59:05 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pfqNE-0004eC-An; Fri, 24 Mar 2023 23:59:04 +0100
Date:   Fri, 24 Mar 2023 23:59:04 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nftables 8/8] test: py: add tests for shifted nat
 port-ranges
Message-ID: <20230324225904.GB17250@breakpoint.cc>
References: <20230305101418.2233910-1-jeremy@azazel.net>
 <20230305101418.2233910-9-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305101418.2233910-9-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> +ip daddr 10.0.0.1 tcp dport 55900-55910 dnat ip to 192.168.127.1:5900-5910/55900;ok
> +ip6 daddr 10::1 tcp dport 55900-55910 dnat ip6 to [::c0:a8:7f:1]:5900-5910/55900;ok

This syntax is horrible (yes, I know, xtables fault).

Do you think this series could be changed to grab the offset register from the
left edge of the range rather than requiring the user to specify it a
second time?  Something like:

ip daddr 10.0.0.1 tcp dport 55900-55910 dnat ip to 192.168.127.1:5900-5910

I'm open to other suggestions of course.
