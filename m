Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2647E2B1BC
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 May 2019 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfE0KCn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 May 2019 06:02:43 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:33516 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0KCn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 May 2019 06:02:43 -0400
Received: from 129.166.216.87.static.jazztel.es ([87.216.166.129] helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <pablo@gnumonks.org>)
        id 1hVCSl-000078-7Y; Mon, 27 May 2019 12:02:41 +0200
Date:   Mon, 27 May 2019 12:02:38 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Eric Garver <e@erig.me>,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: Re: [nft PATCH v3 0/2] JSON schema for nftables.py
Message-ID: <20190527100238.astrqtktw25qowoj@salvia>
References: <20190522161453.23096-1-phil@nwl.cc>
 <20190524204514.4tf77x2ugqay5e5c@salvia>
 <20190527095720.GT31548@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527095720.GT31548@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.6 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 27, 2019 at 11:57:20AM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> On Fri, May 24, 2019 at 10:45:14PM +0200, Pablo Neira Ayuso wrote:
> > On Wed, May 22, 2019 at 06:14:51PM +0200, Phil Sutter wrote:
> > > Round three of JSON validation enhancement.
> > > 
> > > Changes since v2:
> > > - Make enhancement to nftables module Python3 compliant.
> > > - Complain in nft-test.py if --schema was given without --json.
> > > 
> > > Changes since v1:
> > > - Fix patch 2 commit message, thanks to Jones Desougi who reported the
> > >   inconsistency.
> > > 
> > > Changes since RFC:
> > > - Import builtin traceback module unconditionally.
> > > 
> > > Phil Sutter (2):
> > >   py: Implement JSON validation in nftables module
> > >   tests/py: Support JSON validation
> > > 
> > >  py/Makefile.am       |  2 +-
> > >  py/nftables.py       | 29 +++++++++++++++++++++++++++++
> > >  py/schema.json       | 17 +++++++++++++++++
> > >  py/setup.py          |  1 +
> > >  tests/py/nft-test.py | 25 ++++++++++++++++++++++++-
> > 
> > Where is ruleset-schema.json?
> > 
> > +       "id": "http://netfilter.org/nftables/ruleset-schema.json",
> > +       "description": "libnftables JSON API schema",
> 
> Oh, I forgot about that. There are actually two problems with it: On one
> hand, current draft version suggests to use "$id" instead of "id" for
> the property name. On the other, the URL should point to an online
> location of the document itself, which is obviously not correct.

We can upload it to exactly the location you specify above, that won't
be a problem.

> Given that it is optional according to the draft, I would just drop it
> for now. What do you think?

Drop for now is fine with fine.

Thanks.
