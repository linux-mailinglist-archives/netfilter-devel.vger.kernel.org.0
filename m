Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4932C35F
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Mar 2021 01:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhCDAEd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Mar 2021 19:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384832AbhCCQ2g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:28:36 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F338DC06175F
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Mar 2021 08:27:53 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lHULm-0002iI-Kg; Wed, 03 Mar 2021 17:27:50 +0100
Date:   Wed, 3 Mar 2021 17:27:50 +0100
From:   Florian Westphal <fw@strlen.de>
To:     linuxludo@free.fr
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] netfilter: Fix GRE over IPv6 with conntrack module
Message-ID: <20210303162750.GD17911@breakpoint.cc>
References: <1524997693.135804496.1614764827412.JavaMail.root@zimbra63-e11.priv.proxad.net>
 <471218486.135924319.1614766871068.JavaMail.root@zimbra63-e11.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471218486.135924319.1614766871068.JavaMail.root@zimbra63-e11.priv.proxad.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

linuxludo@free.fr <linuxludo@free.fr> wrote:
> I would provide you a small patch in order to fix a BUG when GRE over IPv6 is used with netfilter/conntrack module.
> 
> This is my first contribution, not knowing the procedure well, thank you for being aware of this request.

See
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

In short, the patch should pass 'scripts/checkpatch.pl' and should apply
cleanly with 'git am'.

> Regarding the proposed patch, here is a description of the encountered bug.
> Indeed, when an ip6tables rule dropping traffic due to an invalid packet (aka w/ conntrack module) is placed before a GRE protocol permit rule, the latter is never reached ; the packet is discarded via the previous rule. 
> 
> The proposed patch takes into account both IPv4 and IPv6 in conntrack module for GRE protocol.
> You will find this one at the end of this email.
> 
> I personally tested this, successfully.

If the GRE tracker works fine with ipv6 its best to just remove
the if-clause entirely, we only support ipv4 and ipv6 anyway.
