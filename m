Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43936222E35
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jul 2020 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgGPVzm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jul 2020 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgGPVzl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:55:41 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364B2C061755
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jul 2020 14:55:41 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jwBqp-0001J1-Py; Thu, 16 Jul 2020 23:55:35 +0200
Date:   Thu, 16 Jul 2020 23:55:35 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH v2] iptables: accept lock file name at runtime
Message-ID: <20200716215535.GD23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20200715065152.4172896-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715065152.4172896-1-gscrivan@redhat.com>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Jul 15, 2020 at 08:51:52AM +0200, Giuseppe Scrivano wrote:
> allow users to override at runtime the lock file to use through the
> XTABLES_LOCKFILE environment variable.
> 
> It allows using iptables from a network namespace owned by an user
> that has no write access to XT_LOCK_NAME (by default under /run), and
> without setting up a new mount namespace.

This sentence appears overly complicated to me. Isn't the problem just
that XT_LOCK_NAME may not be writeable? That "user that has no write
access" is typically root anyway as iptables doesn't support being
called by non-privileged UIDs.

> $ XTABLES_LOCKFILE=/tmp/xtables unshare -rn iptables ...
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  iptables/xshared.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Could you please update the man page as well? Unless you clarify why
this should be a hidden feature, of course. :)

Cheers, Phil
