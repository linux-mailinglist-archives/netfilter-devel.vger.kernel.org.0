Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF63406C0
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Mar 2021 14:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhCRNUo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Mar 2021 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhCRNU2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:20:28 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA048C06174A
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Mar 2021 06:20:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lMsZe-0008QW-Ke; Thu, 18 Mar 2021 14:20:26 +0100
Date:   Thu, 18 Mar 2021 14:20:26 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 6/6] src: allow arbitary chain name in implicit rule
 add case
Message-ID: <20210318132026.GD22603@breakpoint.cc>
References: <20210316234039.15677-1-fw@strlen.de>
 <20210316234039.15677-7-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316234039.15677-7-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Allow switch of the flex state from bison parser.
> Note that this switch will happen too late to cover all cases:
> 
> nft add ip dup fwd ip saddr ...  # adds a rule to chain fwd in table dup
> nft add dup fwd ... # syntax error  (flex parses dup as expression keyword)
> 
> to solve this, bison must carry a list of keywords that are allowed to
> be used as table names.
> 
> This adds FWD as an example.  When new keywords are added, this can
> then be extended as needed.
> 
> Another alternative is to deprecate implicit rule add altogether
> so users would have to move to 'nft add rule ...'.

... and another alternative is to not allow arbitrary table/chain/set
names after all.

We could just say that all future tokens that could break existing
table/chain/set name need to be added to the 'identifier' in
parser_bison.y.

Provided new expressions with args use start conditionals the list
of tokens would probably stay short.

Given the 'set' complication Phil mentioned that might be the best
way forward.
