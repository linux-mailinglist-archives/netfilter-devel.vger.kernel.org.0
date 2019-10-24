Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7350DE2D18
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 11:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbfJXJUy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 05:20:54 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:58164 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733125AbfJXJUy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:20:54 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iNZIa-0000LU-Tr; Thu, 24 Oct 2019 11:20:52 +0200
Date:   Thu, 24 Oct 2019 11:20:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/4] py: add missing output flags.
Message-ID: <20191024092052.GP26123@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
References: <20191022205855.22507-1-jeremy@azazel.net>
 <20191022205855.22507-3-jeremy@azazel.net>
 <20191023203833.aidczbpuxokywu6i@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023203833.aidczbpuxokywu6i@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Oct 23, 2019 at 10:38:33PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Oct 22, 2019 at 09:58:53PM +0100, Jeremy Sowden wrote:
> > `terse` and `numeric_time` are missing from the `output_flags` dict.
> > Add them and getters and setters for them.
> 
> LGTM.
> 
> @Phil, is this fine with you? I let you decide on this.

I just pushed it. Could you please update Patchwork? I'm not allowed to.

> BTW, would it make sense at some point to remove all the getter/setter
> per option and use the setter/getter flags approach as in libnftables?

Well, from a compat standpoint we can't remove them. The benefit of
those setter/getter methods is the clean interface (user's don't have to
memorize flag names) and the semantics of returning the old value. The
latter comes in handy when changing flags temporarily.

One could change the private __{g,s}et_output_flag() methods though and
make them similar to {g,s}et_debug() methods which probably resemble the
syntax you're looking for.

Cheers, Phil
