Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E07E1313
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Nov 2023 11:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKEKka (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Nov 2023 05:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKk3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Nov 2023 05:40:29 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011BA2
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Nov 2023 02:40:25 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qzaYI-0002db-Te; Sun, 05 Nov 2023 11:40:22 +0100
Date:   Sun, 5 Nov 2023 11:40:22 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 1/2] json: drop handling missing json() hook in
 expr_print_json()
Message-ID: <ZUdxFhzlm42rDpC3@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20231103162937.3352069-1-thaller@redhat.com>
 <20231103162937.3352069-2-thaller@redhat.com>
 <ZUVoLKrYbqHu6Hby@orbyte.nwl.cc>
 <ff945f754eb5a12409563d0aca79a0d2e10fb157.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff945f754eb5a12409563d0aca79a0d2e10fb157.camel@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 04, 2023 at 06:28:30AM +0100, Thomas Haller wrote:
> On Fri, 2023-11-03 at 22:37 +0100, Phil Sutter wrote:
> > On Fri, Nov 03, 2023 at 05:25:13PM +0100, Thomas Haller wrote:
> > [...]
> > > +	/* The json() hooks of "symbol_expr_ops" and
> > > "variable_expr_ops" are
> > > +	 * known to be NULL, but for such expressions we never
> > > expect to call
> > > +	 * expr_print_json().
> > > +	 *
> > > +	 * All other expr_ops must have a json() hook.
> > > +	 *
> > > +	 * Unconditionally access the hook (and segfault in case
> > > of a bug).  */
> > > +	return expr_ops(expr)->json(expr, octx);
> > 
> > This does not make sense to me. You're deliberately dropping any
> > error
> > handling
> 
> Error handling for what is clearly a bug. Don't try to handle bugs.
> Avoid bugs and fix them.

Yeah, indeed. Let's go ahead and drop all BUG() statements as well.
Seriously, I doubt nftables users agree the software should segfault
instead of aborting with an error message.

> > and accept a segfault because "it should never happen"? All it
> > takes is someone to add a new expression type and forget about the
> > JSON
> > API.
> 
> There will be a unit test guarding against that, once the unit test
> basics are done.
> 
> Also, if you "forget" to implement the JSON hook and test it (manually)
> only a single time, then you'll notice right away.

Actually, all it takes to notice things don't add up is running the py
testsuite with '-j' arg after adding the obligatory "unit" tests there.
Feel free to search the git history for late additions of .json
callbacks. I think the message is pretty clear.

> > If you absolutely have to remove that fallback code, at least add a
> > BUG() explaining the situation. The sysadmin looking at the segfault
> > report in syslog won't see your comment above.
> 
> I am in favor of adding assertions all over the place. The project
> doesn't use enough asserions for my taste.
> 
> In this case, it seems hard to mess up the condition, and you get a
> very clear signal when you do (segfault). That makes the assert()/BUG()
> kinda unecessary.

The clear signal being "oops, my program crashed" when it could be a
dubious "oops, there is no JSON callback for this expression type".

Cheers, Phil
