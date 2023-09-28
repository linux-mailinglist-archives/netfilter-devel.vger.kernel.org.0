Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225207B1F69
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjI1O0r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjI1O0q (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:26:46 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2523136
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Sep 2023 07:26:43 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qlryT-0002rA-BO; Thu, 28 Sep 2023 16:26:41 +0200
Date:   Thu, 28 Sep 2023 16:26:41 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 3/3,v2] netlink_linearize: skip set element
 expression in map statement key
Message-ID: <ZRWNIXfj02u0v8na@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230926160216.152549-1-pablo@netfilter.org>
 <ZRMNB+3/4rzYb08p@orbyte.nwl.cc>
 <ZRPq/JMoVffTEDM4@calendula>
 <ZRQNkSG/dnesQ6Wv@orbyte.nwl.cc>
 <ZRQPw+jMI+i9qSyE@calendula>
 <ZRQpodNr/9aiVI7H@orbyte.nwl.cc>
 <ZRQ/DhU558tSxQ/D@orbyte.nwl.cc>
 <ZRRd0gxC81eoYNSP@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRRd0gxC81eoYNSP@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 27, 2023 at 06:52:34PM +0200, Pablo Neira Ayuso wrote:
> On Wed, Sep 27, 2023 at 04:41:18PM +0200, Phil Sutter wrote:
> > On Wed, Sep 27, 2023 at 03:09:53PM +0200, Phil Sutter wrote:
> > > On Wed, Sep 27, 2023 at 01:19:31PM +0200, Pablo Neira Ayuso wrote:
> > > > Hi Phil,
> > > > 
> > > > On Wed, Sep 27, 2023 at 01:10:09PM +0200, Phil Sutter wrote:
> [...]
> > > > > I actually considered forking the project. Or we just ship a copy of the
> > > > > lib with nftables sources?
> > > > 
> > > > I would try to get back to them to refresh and retry.
> > > 
> > > Oh well. I'll try an approach which eliminates the pointer if not
> > > enabled. The terse feedback and pessimistic replies right from the start
> > > convinced me though they just don't want it.
> > 
> > OK, so I had a close look at the code and played a bit with pahole. My
> > approach to avoiding the extra pointer is to add another set of types
> > which json_t embed. So taking json_array_t as an example:
> > 
> > | typedef struct {
> > |     json_t json;
> > |     size_t size;
> > |     size_t entries;
> > |     json_t **table;
> > | } json_array_t;
> > 
> > I could introduce json_location_array_t:
> > 
> > | typedef struct {
> > |     json_array_t array;
> > |     json_location_t *location;
> > | } json_location_array_t;
> >
> > The above structs are opaque to users, they only know about json_t.
> 
> OK, so this new object type is hiding behind the json_t opaque type.
> 
> > So I introduced a getter for the location data:
> > 
> > | int json_get_location(json_t *json, int *line, int *column,
> > |                       int *position, int *length);
> > 
> > In there, I have to map from json_t to the type in question. The problem
> > is to know whether I have a json_location_array_t or just a
> > json_array_t. The json_t may have been allocated by the input parser
> > with either JSON_STORE_LOCATION set or not or by json_array().
> >
> > In order to make the decision, I need at least a bit in well-known
> > memory. Pahole tells there's a 4byte hole in json_t, but it may be
> > gone in 32bit builds (and enlarging json_t is a no-go, they consider
> > it ABI). The json_*_t structures don't show any holes, and extending
> > them means adding a mandatory word due to buffering, so I may just
> > as well store the location pointer itself in them.
> >
> > The only feasible alternative is to store location data separate from
> > the objects themselves, ideally in a hash table. This reduces the
> > overhead if not used by a failing hash table lookup in json_delete().
> 
> If I understood correctly, then this means you are ditching the
> json_location_array_t approach that you are detailing above.
> 
> The hashtable approach might be sensible to follow, and such approach
> does not require any update to libjansson?
> 

It does! We can't access the parser state from outside and during the
parsing of input data. The whole thing has to reside within libjansson.
Here's my reimplementation:

https://github.com/akheron/jansson/pull/662

Any review and/or supportive comment highly appreciated. (:

Cheers, Phil
