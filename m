Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18E33FD0
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Jun 2019 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFDHR6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Jun 2019 03:17:58 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:55330 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfFDHR6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:17:58 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hY3hi-0008Mc-V2; Tue, 04 Jun 2019 09:17:54 +0200
Date:   Tue, 4 Jun 2019 09:17:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <eric@garver.life>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v4 7/7] src: Support intra-transaction rule references
Message-ID: <20190604071754.GO31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Eric Garver <eric@garver.life>, netfilter-devel@vger.kernel.org
References: <20190528210323.14605-1-phil@nwl.cc>
 <20190528210323.14605-8-phil@nwl.cc>
 <20190531165625.nxtgnokrxzgol2nk@egarver.localdomain>
 <20190603165917.pnub5grz3eaixdwt@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603165917.pnub5grz3eaixdwt@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Mon, Jun 03, 2019 at 06:59:17PM +0200, Pablo Neira Ayuso wrote:
> On Fri, May 31, 2019 at 12:56:25PM -0400, Eric Garver wrote:
[...]
> > I'm seeing a NULL pointer dereferenced here. It occurs when we delete a rule
> > and add a new rule using the "index" keyword in the same transaction/batch.

Yes, cache population for rule delete command was completely broken. I
missed that cmd->rule is NULL in that case, sorry for the mess.

> I think we need two new things here:
> 
> #1 We need a new initial step, before evalution, to calculate the cache
>    completeness level. This means, we interate over the batch to see what
>    kind of completeness is needed. Then, cache is fetched only once, at
>    the beginning of the batch processing. Ensure that cache is
>    consistent from that step.
> 
> #2 Update the cache incrementally: Add new objects from the evaluation
>    phase. If RESTART is hit, then release the cache, and restart the
>    evaluation. Probably we don't need to restart the evaluation, just
>    a function to refresh the batch, ie. check if several objects are
>    there.

I don't understand this but please wait a day or two before jumping in.
I'm currently working on fixing the problem above and some more I found
along the way.

Cheers, Phil
