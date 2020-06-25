Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623A320A4FC
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2020 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404270AbgFYS2L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jun 2020 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404154AbgFYS2L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:28:11 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAEC08C5C1
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 11:28:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1joWbZ-0000dw-RF; Thu, 25 Jun 2020 20:28:09 +0200
Date:   Thu, 25 Jun 2020 20:28:09 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/5] support for anonymous non-base chains in
 nftables
Message-ID: <20200625182809.GZ26990@breakpoint.cc>
References: <20200625181651.1481-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625181651.1481-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This patchset extends the nftables netlink API to support for anonymous
> non-base chains. Anonymous non-base chains have two properties:
> 
> 1) The kernel dynamically allocates the (internal) chain name.
> 2) If the rule that refers to the anonymous chain is removed, then the
>    anonymous chain and its content is also released.
> 
> This new infrastructure allows for the following syntax from userspace:
> 
>  table inet x {
>         chain y {
>                 type filter hook input priority 0;
>                 tcp dport 22 chain {
>                         ip saddr { 127.0.0.0/8, 172.23.0.0/16, 192.168.13.0/24 } accept
>                         ip6 saddr ::1/128 accept;
>                 }
>         }
>  }

What about goto semantics?

Would it make sense to change this to

tcp dport 22 jump chain {
	 ...

so this could be changed to support 'tcp dport 22 goto chain {' as well?
