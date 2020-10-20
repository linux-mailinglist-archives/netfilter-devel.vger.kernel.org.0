Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72E12849A7
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Oct 2020 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJFJux (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Oct 2020 05:50:53 -0400
Received: from correo.us.es ([193.147.175.20]:45090 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJFJuw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:50:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 40702114819
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 11:50:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 30ADCDA792
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 11:50:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2F85EDA7B6; Tue,  6 Oct 2020 11:50:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6B0DDA792;
        Tue,  6 Oct 2020 11:50:47 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 06 Oct 2020 11:50:47 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CAB5F41E4802;
        Tue,  6 Oct 2020 11:50:47 +0200 (CEST)
Date:   Tue, 6 Oct 2020 11:50:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Serhey Popovych <serhe.popovych@gmail.com>
Subject: Re: [iptables PATCH 1/3] libxtables: Make sure extensions register
 in revision order
Message-ID: <20201006095047.GA17114@salvia>
References: <20200922225341.8976-1-phil@nwl.cc>
 <20200922225341.8976-2-phil@nwl.cc>
 <20201003111741.GA3035@salvia>
 <20201004145339.GE29050@orbyte.nwl.cc>
 <20201005224255.GA13440@salvia>
 <20201006092723.GJ29050@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006092723.GJ29050@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 06, 2020 at 11:27:23AM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> On Tue, Oct 06, 2020 at 12:42:55AM +0200, Pablo Neira Ayuso wrote:
> > On Sun, Oct 04, 2020 at 04:53:39PM +0200, Phil Sutter wrote:
> > > On Sat, Oct 03, 2020 at 01:17:41PM +0200, Pablo Neira Ayuso wrote:
> > > > On Wed, Sep 23, 2020 at 12:53:39AM +0200, Phil Sutter wrote:
> > > > > Insert extensions into pending lists in ordered fashion: Group by
> > > > > extension name (and, for matches, family) and order groups by descending
> > > > > revision number.
> > > > >
> > > > > This allows to simplify the later full registration considerably. Since
> > > > > that involves kernel compatibility checks, the extra cycles here pay off
> > > > > eventually.
> > > > > 
> > > > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > > > > ---
> > > > >  libxtables/xtables.c | 64 +++++++++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 58 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/libxtables/xtables.c b/libxtables/xtables.c
> > > > > index 8907ba2069be7..63d0ea5def2d5 100644
> > > > > --- a/libxtables/xtables.c
> > > > > +++ b/libxtables/xtables.c
> > > > > @@ -948,8 +948,14 @@ static void xtables_check_options(const char *name, const struct option *opt)
> > > > >  		}
> > > > >  }
> > > > >  
> > > > > +static int xtables_match_prefer(const struct xtables_match *a,
> > > > > +				const struct xtables_match *b);
> > > > > +
> > > > >  void xtables_register_match(struct xtables_match *me)
> > > > >  {
> > > > > +	struct xtables_match **pos;
> > > > > +	bool seen_myself = false;
> > > > > +
> > > > >  	if (me->next) {
> > > > >  		fprintf(stderr, "%s: match \"%s\" already registered\n",
> > > > >  			xt_params->program_name, me->name);
> > > > > @@ -1001,10 +1007,32 @@ void xtables_register_match(struct xtables_match *me)
> > > > >  	if (me->extra_opts != NULL)
> > > > >  		xtables_check_options(me->name, me->extra_opts);
> > > > >  
> > > > > +	/* order into linked list of matches pending full registration */
> > > > > +	for (pos = &xtables_pending_matches; *pos; pos = &(*pos)->next) {
> > > > > +		/* NOTE: No extension_cmp() here as we accept all families */
> > > > > +		if (strcmp(me->name, (*pos)->name) ||
> > > > > +		    me->family != (*pos)->family) {
> > > > > +			if (seen_myself)
> > > > > +				break;
> > > > > +			continue;
> > > > > +		}
> > > > > +		seen_myself = true;
> > > > > +		if (xtables_match_prefer(me, *pos) >= 0)
> > > > 
> > > > xtables_match_prefer() evaluates >= 0 if 'me' has higher revision
> > > > number than *pos. So list order is: higher revision first.
> > > 
> > > Correct.
> > > 
> > > > > +			break;
> > > > > +	}
> > > > > +	if (!*pos)
> > > > > +		pos = &xtables_pending_matches;
> > > > >  
> > > > > -	/* place on linked list of matches pending full registration */
> > > > > -	me->next = xtables_pending_matches;
> > > > > -	xtables_pending_matches = me;
> > > > > +	me->next = *pos;
> > > > 
> > > > This line above is placing 'me' right before the existing match in the list.
> > > 
> > > Also correct. As stated in the description, xtables_pending_matches
> > > should be grouped by name and family and within those groups ordered by
> > > descending revision.
> > > 
> > > > > +	*pos = me;
> > > > 
> > > > This line above only works if *pos is &xtables_pending_matches?
> > > 
> > > This piece of code confused me at first, too. I even wrote a quick test
> > > to make sure the pointer stuff works as intended. :D
> > > 
> > > In fact, *pos can't be &xtables_pending_matches: pos is type 'struct
> > > xtables_match **' (note the double pointer). pos is either
> > > &xtables_pending_matches or the address of the right position's previous
> > > element's 'next' pointer. Still confusing, but the for-loop is clear:
> > > 
> > > | for (pos = &xtables_pending_matches; *pos; pos = &(*pos)->next) {
> > > 
> > > So by doing '*pos = me', the 'next' pointer value is changed (or the
> > > value of xtables_pending_matches.
> > 
> > pos is always &xtables_pending_matches:
> > 
> > - The first element in the array finds no matching, then:
> > 
> >         if (!*pos)
> >                pos = &xtables_pending_matches;
> > 
> >   kicks in and and pos is set to &xtables_pending_matches, so this is
> >   inserted in the first position of the xtables_pending_matches.
> > 
> > - The follow up element in the array (higher revision) finds itself at
> >   the very beginning of the iteration, so pos here is
> >   &xtables_pending_matches too.
> > 
> > So *pos = me; is always updating the next pointer in the
> > xtables_pending_matches.
> 
> This is true only if you assume the ordering of arrays passed to the
> function. But you can't since it's an exported library function. Also,
> there are already cases where the above does not hold due to the
> grouping by name *and* family value. Apply the patch, build with
> -DDEBUG, add a rule with connlimit match and you'll see.

If you can insert entries in the middle of the list, before an
existing node, assuming

        pos = &(*pos)->next

then

        *pos = me;

is updating the ->next pointer of the existing entry in the list to
'me' (appending).

But the existing entry is actually placed after the new one (inserting).

        me->next = *pos;

do I need more coffee here?

> I found a bug, though: When inserting same name and family extensions in
> descending revision order, for all consecutive extensions the for-loop
> never breaks and the 'if (!*pos)' clause inserts the new (lowest)
> revision into the beginning. The fix is trivial though.

Just to clarify: You assume that input array does _not_ need to be
sorted from lower to higher, correct? This was not obvious to me.
