Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DA246E7E
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Aug 2020 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbgHQRci (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Aug 2020 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389549AbgHQRbw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:31:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F828C061342
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Aug 2020 10:31:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1k7iz8-0000yr-V4; Mon, 17 Aug 2020 19:31:51 +0200
Date:   Mon, 17 Aug 2020 19:31:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Amiq Nahas <m992493@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables] Use ipset with conntrack module
Message-ID: <20200817173150.GC15804@breakpoint.cc>
References: <CAPicJaHrKqxJUV18pU+tvojjJvcV1EbvBo8VpNrgjoh0BYwz6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPicJaHrKqxJUV18pU+tvojjJvcV1EbvBo8VpNrgjoh0BYwz6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Amiq Nahas <m992493@gmail.com> wrote:
> Hi Guys,
> 
> Currently only a single ip-address can be specified with these options
> in conntrack module:
> --ctorigsrc address[/mask]
> --ctorigdst address[/mask]
> --ctreplsrc address[/mask]
> --ctrepldst address[/mask]
> 
> I would like to add a new feature into iptables so that multiple
> ip-addresses can be specified at once. I am thinking this can be done
> using ipset.
> 
> Please share your thoughts on how this can be implemented.

This can be done with nftables.  I don't think its worth it to spend
time on this in iptables world.

You would also need to copy-paste reimplement the match  again if you want to
combine it with e.g. network interface.
