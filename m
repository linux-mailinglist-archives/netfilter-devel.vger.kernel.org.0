Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B1E15D7D4
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Feb 2020 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBNM5U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Feb 2020 07:57:20 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:40314 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNM5U (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Feb 2020 07:57:20 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j2aX0-0000xW-Ev; Fri, 14 Feb 2020 13:57:18 +0100
Date:   Fri, 14 Feb 2020 13:57:18 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-translate: Fix for iface++
Message-ID: <20200214125718.GP20005@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200213130436.26755-1-phil@nwl.cc>
 <20200214090024.tqfubfkvnczq5bcy@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214090024.tqfubfkvnczq5bcy@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Fri, Feb 14, 2020 at 10:00:24AM +0100, Pablo Neira Ayuso wrote:
> On Thu, Feb 13, 2020 at 02:04:36PM +0100, Phil Sutter wrote:
> > In legacy iptables, only the last plus sign remains special, any
> > previous ones are taken literally. Therefore xtables-translate must not
> > replace all of them with asterisk but just the last one.
> 
> Interesting corner case.

I'm merely fixing the bugs I introduced earlier - old code (prior to my
initial fix for translating '+' as interface name) did it right,
considering only the last character for wildcard substitution and
leaving any earlier '+' chars in place. :)

Cheers, Phil
