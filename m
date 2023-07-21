Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7075CA43
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jul 2023 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGUOmA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jul 2023 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjGUOlp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:41:45 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756F30C2
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jul 2023 07:41:43 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qMrK8-0002OK-GL; Fri, 21 Jul 2023 16:41:40 +0200
Date:   Fri, 21 Jul 2023 16:41:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        igor@gooddata.com
Subject: Re: [iptables PATCH 1/3] extensions: libebt_among: Fix for false
 positive match comparison
Message-ID: <ZLqZJPrn9+M+eloE@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        igor@gooddata.com
References: <20230715125928.18395-1-phil@nwl.cc>
 <20230715125928.18395-2-phil@nwl.cc>
 <ZLUg97WtqnWR6aqT@calendula>
 <ZLpXG2GzqH3QLveA@orbyte.nwl.cc>
 <ZLqOfeIBpOFGNX/l@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLqOfeIBpOFGNX/l@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 21, 2023 at 03:56:13PM +0200, Pablo Neira Ayuso wrote:
> Hi Phil,
> 
> On Fri, Jul 21, 2023 at 11:59:55AM +0200, Phil Sutter wrote:
> > Pablo,
> > 
> > On Mon, Jul 17, 2023 at 01:07:35PM +0200, Pablo Neira Ayuso wrote:
> > > On Sat, Jul 15, 2023 at 02:59:26PM +0200, Phil Sutter wrote:
> > > > When comparing matches for equality, trailing data in among match is not
> > > > considered. Therefore two matches with identical pairs count may be
> > > > treated as identical when the pairs actually differ.
> > > 
> > > By "trailing data", you mean the right-hand side of this?
> > > 
> > >         fe:ed:ba:be:00:01=10.0.0.1
> > > 
> > > > Matches' parsing callbacks have no access to the xtables_match itself,
> > > > so can't update userspacesize field as needed.
> > > > 
> > > > To fix this, extend struct nft_among_data by a hash field to contain a
> > > > DJB hash of the trailing data.
> > > 
> > > Is this DJB hash use subject to collisions?
> > 
> > Thanks for the heads-up. I suspected DJB hash algo might not be perfect
> > when it comes to collisions, but "good enough" for the task. In fact,
> > collisions are pretty common, so this approach is not a proper solution
> > to the problem.
> >
> > Searching for other ways to fix the issue, I noticed that
> > compare_matches() was deliberately changed to compare only the first
> > 'userspacesize' bytes of extensions to avoid false-negatives caused by
> > kernel-internals in extension data.
> 
> Indeed, that was a deliberate decision.

Yes, you did it! :)

> > I see two different solutions and would like to hear your opinion. First
> > one is a hack, special treatment for among match in compare_matches():
> > 
> > | @@ -381,6 +381,7 @@ bool compare_matches(struct xtables_rule_match *mt1,
> > |         for (mp1 = mt1, mp2 = mt2; mp1 && mp2; mp1 = mp1->next, mp2 = mp2->next) {
> > |                 struct xt_entry_match *m1 = mp1->match->m;
> > |                 struct xt_entry_match *m2 = mp2->match->m;
> > | +               size_t cmplen = mp1->match->userspacesize;
> > |  
> > |                 if (strcmp(m1->u.user.name, m2->u.user.name) != 0) {
> > |                         DEBUGP("mismatching match name\n");
> > | @@ -392,8 +393,10 @@ bool compare_matches(struct xtables_rule_match *mt1,
> > |                         return false;
> > |                 }
> > |  
> > | -               if (memcmp(m1->data, m2->data,
> > | -                          mp1->match->userspacesize) != 0) {
> > | +               if (!strcmp(m1->u.user.name, "among"))
> > | +                       cmplen = m1->u.match_size - sizeof(*m1);
> > | +
> > | +               if (memcmp(m1->data, m2->data, cmplen) != 0) {
> > |                         DEBUGP("mismatch match data\n");
> > |                         return false;
> > |                 }
> 
> This incremental update is relatively simple and it is only 'among'
> that requires this special handling. Maybe you start with this, also
> placing a comment to describe the intention for this particular case.
> I don't remember if among allows to delete a rule with set elements
> that are placed in different order.
> 
> Then, if you have to follow up because this is not enough...

Luckily, I had that in mind already and implemented element sorting in
the among parser, it should match how the kernel returns the elements.

> > The second one is more generic, reusing extensions' 'udata' pointer. One
> > could make xtables_option_{m,t}fcall() functions zero the scratch area
> > if present (so locally created extensions match ones fetched from
> > kernel) and compare that scratch area in compare_matches(). For among
> > match, using the scratch area to store pairs is fine.
> 
> then pursue this second approach?

ACK, I'll keep that around somewhere. For now that special casing above
is probably fine.

Thanks, Phil
