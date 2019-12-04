Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B288A1137CA
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 23:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfLDWnK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 17:43:10 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:59418 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfLDWnK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:43:10 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1icdMS-0004sg-Sg; Wed, 04 Dec 2019 23:43:08 +0100
Date:   Wed, 4 Dec 2019 23:43:08 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/2] Fix DEBUG build
Message-ID: <20191204224308.GZ14469@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191204090606.2088-1-phil@nwl.cc>
 <20191204174927.5eylewkivztqwmzh@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204174927.5eylewkivztqwmzh@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Dec 04, 2019 at 06:49:27PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Dec 04, 2019 at 10:06:05AM +0100, Phil Sutter wrote:
> > Fixed commit missed to update this conditional call to
> > nft_rule_print_save().
> > 
> > Fixes: 1e8ef6a584754 ("nft: family_ops: Pass nft_handle to 'rule_to_cs' callback")
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> If you still find all this debugging useful.
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Otherwise, remove the nft DEBUG is another option. IIRC those were
> added at very early stage to fix a few issues with -D and -C commands.
> 
> Pick the one you prefer. Thanks!

While it's definitely not as convenient as calling 'nft --debug=<foo>',
it's better than nothing. So I'm rather tempted to try and implement a
permanent debug output option although all the added jumps will probably
kill kubernetes. ;)

Cheers, Phil
