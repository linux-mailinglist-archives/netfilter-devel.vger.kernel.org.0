Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99E1100FD3
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Nov 2019 01:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKSAUh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Nov 2019 19:20:37 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:35036 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfKSAUh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:20:37 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iWrFz-0007Mh-02; Tue, 19 Nov 2019 01:20:35 +0100
Date:   Tue, 19 Nov 2019 01:20:34 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests/py: Set a fixed timezone in nft-test.py
Message-ID: <20191119002034.GB8016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191116213218.14698-1-phil@nwl.cc>
 <20191118183459.qkqztuc5pn4fezzn@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118183459.qkqztuc5pn4fezzn@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Nov 18, 2019 at 07:34:59PM +0100, Pablo Neira Ayuso wrote:
> On Sat, Nov 16, 2019 at 10:32:18PM +0100, Phil Sutter wrote:
> > Payload generated for 'meta time' matches depends on host's timezone and
> > DST setting. To produce constant output, set a fixed timezone in
> > nft-test.py. Choose UTC-2 since most payloads are correct then, adjust
> > the remaining two tests.
> 
> This means that the ruleset listing for the user changes when daylight
> saving occurs, right? Just like it happened to our tests.

I think UTC-2 is a fixed offset to a time that doesn't change. During
DST in Europe, our timezone changes from CET to CEST, or from UTC+1 to
UTC+2. So by specifying the same TZ no matter if DST applies or not, the
offset added to the current time should always remain the same.

Cheers, Phil

