Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813F4E9D6C
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2019 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJ3O0F (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Oct 2019 10:26:05 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44802 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfJ3O0F (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:26:05 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iPovD-0005dH-Lg; Wed, 30 Oct 2019 15:26:03 +0100
Date:   Wed, 30 Oct 2019 15:26:03 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] mnl: Replace use of untyped nftnl data setters
Message-ID: <20191030142603.GV26123@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191029125420.26178-1-phil@nwl.cc>
 <20191030124520.hu7humqhvs6zb2co@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030124520.hu7humqhvs6zb2co@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 30, 2019 at 01:45:20PM +0100, Pablo Neira Ayuso wrote:
> On Tue, Oct 29, 2019 at 01:54:20PM +0100, Phil Sutter wrote:
> > Setting strings won't make a difference, but passing data length to
> > *_set_data() functions allows for catching accidental changes on either
> > side.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Applied after resolving merge conflict with previous commits. Apart from
a context change, data_len argument passed to *_data() functions needed
an update as well since data is no longer an array on stack but
dynamically allocated.

I made sure code compiles without warnings and both shell and py
testsuites pass (apart from unrelated warnings the latter yields).

Thanks, Phil
