Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1711291F
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 11:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLDKSW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 05:18:22 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:58156 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfLDKSW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:18:22 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1icRjf-00064O-2v; Wed, 04 Dec 2019 11:18:19 +0100
Date:   Wed, 4 Dec 2019 11:18:19 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Numen with reference to vmap
Message-ID: <20191204101819.GN8016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
References: <EC8889A1-27E2-4DC9-B752-514689982085@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC8889A1-27E2-4DC9-B752-514689982085@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Serguei,

On Wed, Dec 04, 2019 at 12:54:05AM +0000, Serguei Bezverkhi (sbezverk) wrote:
> Nftables wiki gives this example for numgen:
> 
> nft add rule nat prerouting numgen random mod 2 vmap { 0 : jump mychain1, 1 : jump mychain2 }
> 
> I would like to use it but with map reference, like this:
> 
> nft add rule nat prerouting numgen random mod 2 vmap @service1-endpoints
> 
> Could you please confirm if it is supported? If it is what would be the type of the key in such map? I thought it would be integer, but command fails.
> 
> sudo nft --debug all add map ipv4table k8s-57XVOCFNTLTR3Q27-endpoints   { type  integer : verdict \; }
> Error: unqualified key type integer specified in map definition
> add map ipv4table k8s-57XVOCFNTLTR3Q27-endpoints { type integer : verdict ; }
>                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^

Yes, this is sadly not possible right now. numgen type is 32bit integer,
but we don't have a type definition matching that. Type 'integer' is
unqualified regarding size, therefore unsuitable for use in map/set
definitions.

This all works when using anonymous set/map because key type is
deduced from map LHS.

We plan to support a 'typeof' keyword at some point to allow for the
same deduction from within named map/set declarations, but it needs
further work as the type info is lost on return path (when listing) so
it would create a ruleset that can't be fed back.

> The ultimate  goal is to update dynamically just the  map  with available endpoints and loadbalance between them without  touching the rule.

I don't quite understand why you need to dynamically change the
load-balancing rule: numgen modulus is fixed anyway, so the number of
elements in vmap are fixed. Maybe just jump to chains and dynamically
update those instead?

Cheers, Phil
