Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A429634050C
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Mar 2021 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCRMAd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Mar 2021 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCRMAW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:00:22 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4735C06174A
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Mar 2021 05:00:21 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lMrK7-0008Hz-7G; Thu, 18 Mar 2021 13:00:19 +0100
Date:   Thu, 18 Mar 2021 13:00:19 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 6/6] src: allow arbitary chain name in implicit rule
 add case
Message-ID: <20210318120019.GH6306@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20210316234039.15677-1-fw@strlen.de>
 <20210316234039.15677-7-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316234039.15677-7-fw@strlen.de>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Mar 17, 2021 at 12:40:39AM +0100, Florian Westphal wrote:
[...]
> Another alternative is to deprecate implicit rule add altogether
> so users would have to move to 'nft add rule ...'.

Isn't this required for nested syntax? I didn't check, but does your
arbitrary table/chain name support work also when restoring a ruleset in
that nested syntax? Another interesting aspect might be arbitrary set
names - 'set' is also a valid keyword used in rules, this fact killed my
approach with start conditions. ;)

Cheers, Phil
