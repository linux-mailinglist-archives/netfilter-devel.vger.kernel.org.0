Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409901157DB
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 20:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLFTjn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 14:39:43 -0500
Received: from correo.us.es ([193.147.175.20]:40194 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfLFTjn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:39:43 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 24DB7EB462
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 20:39:40 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 15D21DA709
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 20:39:40 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0B6C9DA702; Fri,  6 Dec 2019 20:39:40 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 829A7DA701;
        Fri,  6 Dec 2019 20:39:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Dec 2019 20:39:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5E7AB41E4800;
        Fri,  6 Dec 2019 20:39:37 +0100 (CET)
Date:   Fri, 6 Dec 2019 20:39:38 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_set_rbtree: bogus lookup/get on
 consecutive elements in named sets
Message-ID: <20191206193938.7jceb5dvi2zwkm2g@salvia>
References: <20191205180706.134232-1-pablo@netfilter.org>
 <20191205220408.GG14469@orbyte.nwl.cc>
 <20191206192647.h3htnpq3b4qmlphs@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206192647.h3htnpq3b4qmlphs@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 06, 2019 at 08:26:47PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Dec 05, 2019 at 11:04:08PM +0100, Phil Sutter wrote:
> > Hi Pablo,
> > 
> > On Thu, Dec 05, 2019 at 07:07:06PM +0100, Pablo Neira Ayuso wrote:
> > > The existing rbtree implementation might store consecutive elements
> > > where the closing element and the opening element might overlap, eg.
> > > 
> > > 	[ a, a+1) [ a+1, a+2)
> > > 
> > > This patch removes the optimization for non-anonymous sets in the exact
> > > matching case, where it is assumed to stop searching in case that the
> > > closing element is found. Instead, invalidate candidate interval and
> > > keep looking further in the tree.
> > > 
> > > This patch fixes the lookup and get operations.
> > 
> > I didn't get what the actual problem is?
> 
> The lookup/get results false, while there is an element in the rbtree.
> Moreover, the get operation returns true as if a+2 would be in the
> tree. This happens with named sets after several set updates, I could
> reproduce the issue with several elements mixed with insertion and
> deletions in one batch.

To extend the problem description: The issue is that the existing
lookup optimization (that only works for the anonymous sets) might not
reach the opening [ a+1, ... element if the closing ... , a+1) is
found in first place when walking over the rbtree. Hence, walking the
full tree in that case is needed.

> I managed to trigger the problem using the test file coming in this
> patch: https://patchwork.ozlabs.org/patch/1204779/
> 
> I can extend the patch description if you like.
> 
> > [...]
> > > diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> > > index 57123259452f..510169e28065 100644
> > > --- a/net/netfilter/nft_set_rbtree.c
> > > +++ b/net/netfilter/nft_set_rbtree.c
> > [...]
> > > @@ -141,6 +146,8 @@ static bool __nft_rbtree_get(const struct net *net, const struct nft_set *set,
> > >  		} else {
> > >  			if (!nft_set_elem_active(&rbe->ext, genmask))
> > >  				parent = rcu_dereference_raw(parent->rb_left);
> > > +				continue;
> > > +			}
> > >  
> > >  			if (!nft_set_ext_exists(&rbe->ext, NFT_SET_EXT_FLAGS) ||
> > >  			    (*nft_set_ext_flags(&rbe->ext) & NFT_SET_ELEM_INTERVAL_END) ==
> > 
> > Are you sure about that chunk? It adds a closing brace without a
> > matching opening one. Either this patch ignores whitespace change or
> > there's something fishy. :)
> 
> Yes, I botched it when squashing my patches before submission. I just
> sent a v2.
> 
> Thanks.
> 
> 
