Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C014220108
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jul 2020 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGNX1O (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jul 2020 19:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGNX1O (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:27:14 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8BC061755
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2020 16:27:13 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jvUKL-0002O5-Qc; Wed, 15 Jul 2020 01:27:09 +0200
Date:   Wed, 15 Jul 2020 01:27:09 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] iptables: accept lock file name at runtime
Message-ID: <20200714232709.GC23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20200714165206.4078549-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714165206.4078549-1-gscrivan@redhat.com>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, Jul 14, 2020 at 06:52:06PM +0200, Giuseppe Scrivano wrote:
> allow users to override at runtime the lock file to use through the
> XTABLES_LOCKFILE environment variable.
> 
> It allows using iptables from a network namespace owned by an user
> that has no write access to XT_LOCK_NAME (by default under /run), and
> without setting up a new mount namespace.
> 
> $ XTABLES_LOCKFILE=/tmp/xtables unshare -rn iptables ...
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  iptables/xshared.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/iptables/xshared.c b/iptables/xshared.c
> index c1d1371a..291f1c4b 100644
> --- a/iptables/xshared.c
> +++ b/iptables/xshared.c
> @@ -248,13 +248,18 @@ void xs_init_match(struct xtables_match *match)
>  
>  static int xtables_lock(int wait, struct timeval *wait_interval)
>  {
> +	const *lock_file;

This does not look right. Typo?

Cheers, Phil
