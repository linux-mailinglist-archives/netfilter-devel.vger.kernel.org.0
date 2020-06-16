Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F51B1FAEE2
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2020 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgFPLF7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jun 2020 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPLF7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:05:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F1C08C5C2
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jun 2020 04:05:58 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jl9Pc-0003eT-Ng; Tue, 16 Jun 2020 13:05:52 +0200
Date:   Tue, 16 Jun 2020 13:05:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-translate: don't fail if help was
 requested
Message-ID: <20200616110552.GP23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <159230001954.62609.10203108901931558446.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159230001954.62609.10203108901931558446.stgit@endurance>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Arturo,

On Tue, Jun 16, 2020 at 11:33:39AM +0200, Arturo Borrero Gonzalez wrote:
> If the user called `iptables-translate -h` then we have CMD_NONE and we should gracefully handle
> this case in do_command_xlate().
> 
> Before this patch, you would see:
> 
>  user@debian:~$ sudo iptables-translate -h
>  [..]
>  nft Unsupported command?
>  user@debian:~$ echo $?
>  1
> 
> After this patch:
> 
>  user@debian:~$ sudo iptables-translate -h
>  [..]
>  user@debian:~$ echo $?
>  0

Apparently I forgot to test xtables-restore after changing help
functions, thanks for fixing this up.

> Fixes: d4409d449c10fa ("nft: Don't exit early after printing help texts")
> Signed-off-by: Arturo Borrero Gonzalez <arturo@netfilter.org>

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks, Phil
