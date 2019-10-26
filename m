Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2155E58B2
	for <lists+netfilter-devel@lfdr.de>; Sat, 26 Oct 2019 07:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfJZFT4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 26 Oct 2019 01:19:56 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:41872 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfJZFTz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 26 Oct 2019 01:19:55 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 007593A0467
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Oct 2019 16:19:37 +1100 (AEDT)
Received: (qmail 17431 invoked by uid 501); 26 Oct 2019 05:19:37 -0000
Date:   Sat, 26 Oct 2019 16:19:37 +1100
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnfnetlink 1/1] src: Minimally resurrect doxygen
 documentation
Message-ID: <20191026051937.GA17407@dimstar.local.net>
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
References: <20191014020223.21757-1-duncan_roe@optusnet.com.au>
 <20191014020223.21757-2-duncan_roe@optusnet.com.au>
 <20191023111346.4xoujsy6h2j7cv6y@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023111346.4xoujsy6h2j7cv6y@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=EvbN31qY6XiuFAOFoYsA:9 a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 23, 2019 at 01:13:46PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Oct 14, 2019 at 01:02:23PM +1100, Duncan Roe wrote:
> > The documentation was written in the days before doxygen required groups or even
> > doxygen.cfg, so create doxygen.cfg.in and introduce one \defgroup per source
> > file, encompassing pretty-much the whole file.
> >
> > Also add a tiny \mainpage.
> >
[...]
>
> I'm ambivalent about this, it's been up on the table for a while.
>
> This library is rather old, and new applications should probably
> be based instead used libmnl, which is a better choice.

I'm sending a v2 which makes this abundantly clear
>
> Did you already queue patches to make documentation for libnfnetlink
> locally there? I would like not to discourage you in your efforts to
> help us improve documentation, which is always extremely useful for
> everyone.

No, I'm concentrating on libnetfilter_queue from now on.

Cheers ... Duncan.
