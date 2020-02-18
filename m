Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24F1636AD
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Feb 2020 00:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBRXCl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Feb 2020 18:02:41 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:50618 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgBRXCl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:02:41 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j4Bt1-0003X8-NN; Wed, 19 Feb 2020 00:02:39 +0100
Date:   Wed, 19 Feb 2020 00:02:39 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH] src: Fix nftnl_assert() on data_len
Message-ID: <20200218230239.GE20005@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200214172417.11217-1-phil@nwl.cc>
 <20200214173247.2wbrvcqilqfmcqq5@salvia>
 <20200214173450.GR20005@orbyte.nwl.cc>
 <20200214174200.4xrvnlb72qebtvnb@salvia>
 <20200215004311.GS20005@orbyte.nwl.cc>
 <20200215131713.5gwn4ayk2udjff33@salvia>
 <20200215225855.GU20005@orbyte.nwl.cc>
 <20200218134227.yndixbtxjzq3jznk@salvia>
 <20200218181851.GC20005@orbyte.nwl.cc>
 <20200218210611.4woiwhndyc35rzoz@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218210611.4woiwhndyc35rzoz@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Tue, Feb 18, 2020 at 10:06:11PM +0100, Pablo Neira Ayuso wrote:
[...]
> If I apply the patch that I'm attaching, then I use the wrong datatype
> helper:
> 
>         nftnl_flowtable_get_u32(nlo, NFTNL_FLOWTABLE_DEVICES);
> 
> And I can see:
> 
> libnftnl: attribute 6 assertion failed in flowtable.c:274

Yes, that was what I meant with alternative (simpler) approach. Should I
submit this change formally or do you want to do it?

Thanks, Phil
