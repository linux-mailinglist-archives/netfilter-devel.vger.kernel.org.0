Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14325568C4
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFZM1U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 08:27:20 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:56082 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZM1U (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:27:20 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hg71B-0005hn-PC; Wed, 26 Jun 2019 14:27:17 +0200
Date:   Wed, 26 Jun 2019 14:27:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: Use of oifname in input chains
Message-ID: <20190626122717.GF9218@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20190625122954.GC9218@orbyte.nwl.cc>
 <20190625194321.e2siqh7jfhldwzgw@salvia>
 <20190626103230.b7eqh2i3ibpkfv52@breakpoint.cc>
 <20190626103746.ag26jczoq7ggkh5b@salvia>
 <20190626104254.cfhkfpagequp6kuv@breakpoint.cc>
 <20190626104740.vw7xzrkoqd2lwzqh@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626104740.vw7xzrkoqd2lwzqh@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Jun 26, 2019 at 12:47:40PM +0200, Pablo Neira Ayuso wrote:
[...]
> OK, you think there may be people using oifname from the C chain, but
> how so? To skip rules that are specific to the output path?

My idea for how to use it was this:

| table ip t {
|     chain in {
|         type filter hook input priority 0; policy accept;
|         jump common
|     }
|
|     chain out {
|         type filter hook output priority 0; policy accept;
|         jump common
|     }
|
|     chain common {
|         iifname "eth0" tcp dport ssh counter packets 101 bytes 10149 accept
|         oifname "eth0" tcp sport ssh counter packets 65 bytes 8233 accept
|         counter packets 0 bytes 0 drop
|     }
| }

> Anyway, I'm fine with leaving things as is, I don't need this. Just in
> case you pass by here in the future, the tracking infrastructure
> should allow for this.

OK, cool. Thanks for clarifying upstream PoV. :)

Cheers, Phil
