Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9551AB5D
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2019 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfELI40 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 May 2019 04:56:26 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:56614 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbfELI40 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 May 2019 04:56:26 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hPkHQ-0002ln-C2; Sun, 12 May 2019 10:56:24 +0200
Date:   Sun, 12 May 2019 10:56:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     =?iso-8859-15?Q?St=E9phane?= Veyret <sveyret@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Undefined reference?
Message-ID: <20190512085624.gdzbjeb4htdp7z45@breakpoint.cc>
References: <CAFs+hh4ghFJqE=b+CXiVL9AguKr1MjZntuDvzYyqmDy5aGJPLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFs+hh4ghFJqE=b+CXiVL9AguKr1MjZntuDvzYyqmDy5aGJPLw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stéphane Veyret <sveyret@gmail.com> wrote:
> I am currently trying to add a new feature to nftables. I made
> modifications on the kernel and updated a VM with this modified
> kernel. I then made modifications on libnftnl, make && make install it
> on this VM. I even made some tests which I managed to execute.
> 
> Now, I am trying to modify the nftables userspace tool. I had to set variables:
> LIBNFTNL_CFLAGS="-g -O2"
> LIBNFTNL_LIBS=$HOME/libnftnl/src/.libs/libnftnl.so ./configure
> in order for configure to work, but it worked. But at linking time, I
> get the following error for each nftnl_* function:
> ld: ./.libs/libnftables.so: undefined reference to `nftnl_trace_free'
> 
> I tried to set the LD_LIBRARY_PATH to /usr/local/lib but it did not
> change anything. Do you have an idea of what the problem is?

Try

LIBNFTNL_LIBS="-L$HOME/libnftnl/src/.libs -lnftnl" ./configure
