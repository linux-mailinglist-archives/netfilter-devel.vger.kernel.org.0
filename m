Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45887EB7D1
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 20:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfJaTMV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 15:12:21 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43078 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729312AbfJaTMV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:12:21 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iQFrn-0002Nq-Ol; Thu, 31 Oct 2019 20:12:19 +0100
Date:   Thu, 31 Oct 2019 20:12:19 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Huhardeaux <tech@tootai.net>
Cc:     Netfilter list <netfilter-devel@vger.kernel.org>
Subject: Re: Nat redirect using map
Message-ID: <20191031191219.GL876@breakpoint.cc>
References: <6ea6ecb5-99c5-5519-b689-8e1291df69cc@tootai.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea6ecb5-99c5-5519-b689-8e1291df69cc@tootai.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Daniel Huhardeaux <tech@tootai.net> wrote:
> Hi,
> 
> I have a map like this
> 
> map redirect_tcp {
>                 type inet_service : inet_service
>                 flags interval
>                 elements = { 12345 : 12345, 36025 : smtp }
>         }
> 
> and want to use nat redirect but it fail with unexpecting to, expecting EOF
> or semicolon. Here is the rule
> 
> nft add rule ip nat prerouting iif eth0 tcp dport map @redirect_tcp redirect
> to @redirect_tcp

This should work:
nft add rule ip nat prerouting iif eth0 ip protocol tcp redirect to : tcp dport map @redirect_tcp

> Other: when using dnat for forwarding, should I take care of forward rules ?
> 
> Example for this kind of rule from wiki:
> 
> nft add rule nat prerouting iif eth0 tcp dport { 80, 443 } dnat
> 192.168.1.120

You mean auto-accept dnatted connections? Try "ct status dnat accept"
