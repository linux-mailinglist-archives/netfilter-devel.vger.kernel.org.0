Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E6169AA3
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 00:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWXPe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 18:15:34 -0500
Received: from correo.us.es ([193.147.175.20]:41626 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgBWXPe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:15:34 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EBBFEEF432
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Feb 2020 00:15:26 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DF09FDA72F
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Feb 2020 00:15:26 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C89FCDA3B0; Mon, 24 Feb 2020 00:15:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DFB62DA3A1;
        Mon, 24 Feb 2020 00:15:24 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 24 Feb 2020 00:15:24 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BEF5942EF4E0;
        Mon, 24 Feb 2020 00:15:24 +0100 (CET)
Date:   Mon, 24 Feb 2020 00:15:29 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Duncan Roe <duncan_roe@optusnet.com.au>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] build: doc: "make" builds & installs
 a full set of man pages
Message-ID: <20200223231529.jd7dfhebp7lfvbgs@salvia>
References: <20200208012844.30481-1-duncan_roe@optusnet.com.au>
 <20200223222733.rc4mhtvxgxiihlij@salvia>
 <20200223223514.GA19559@breakpoint.cc>
 <20200223223706.543ya6xumtuk3l7b@salvia>
 <20200223225419.GB19559@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223225419.GB19559@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Sun, Feb 23, 2020 at 11:54:19PM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Sun, Feb 23, 2020 at 11:35:14PM +0100, Florian Westphal wrote:
> > > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > On Sat, Feb 08, 2020 at 12:28:44PM +1100, Duncan Roe wrote:
> > > > > This enables one to enter "man <any nfq function>" and get the appropriate
> > > > > group man page created by doxygen.
> > > > > 
> > > > >  - New makefile in doxygen directory. Rebuilds documentation if any sources
> > > > >    change that contain doxygen comments, or if fixmanpages.sh changes
> > > > >  - New shell script fixmanpages.sh which
> > > > >    - Renames each group man page to the first function listed therein
> > > > >    - Creates symlinks for subsequently listed functions (if any)
> > > > >    - Deletes _* temp files
> > > > >  - Update top-level makefile to visit new subdir doxygen
> > > > >  - Update top-level configure to only build documentation if doxygen installed
> > > > 
> > > > I'd prefer people to keep this infrastructure out of tree. Thanks.
> > > 
> > > Hmm, why?
> > 
> > Would you like to allow to generate manpage per function in the
> > library? We never had this so far.
> > 
> > Probably a single manpage in the style of libnftables(3)?
> 
> I like it.  I mean, its up to distros to package this, I guess
> most of them will place this into some extra doc sub-package.
> 
> $ man 3 ssl-<tab>
> zsh: do you wish to see all 416 possibilities (70 lines)?
> 
> ... so there are libraries that do this.
> Also, from what I understand, there is not a single man-page per
> function, the extra ones are just aliases.

I was not familiar with this fine-grain manpage approach, thanks for
explaining.

Please, go ahead and apply this patch.

Thanks.
