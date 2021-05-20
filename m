Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86F338B93F
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 May 2021 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhETV5J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 May 2021 17:57:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49486 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhETV5J (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 May 2021 17:57:09 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 89E9664195;
        Thu, 20 May 2021 23:54:49 +0200 (CEST)
Date:   Thu, 20 May 2021 23:55:43 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?utf-8?B?U3TDqXBoYW5l?= Veyret <sveyret@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: warning splat in nftables ct expect
Message-ID: <20210520215543.GA29522@salvia>
References: <20210518152426.GA23687@salvia>
 <CAFs+hh5+8EmjQn6ahFnujOVwEHJv48Lj+=yum+dL_rG9gY9xbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFs+hh5+8EmjQn6ahFnujOVwEHJv48Lj+=yum+dL_rG9gY9xbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 20, 2021 at 08:00:53PM +0200, Stéphane Veyret wrote:
> HI,
> 
> > I can fix this by adding the nf_ct_is_confirmed() check, but then you
> > can only create an expectation from the first packet. I guess this is
> > fine for your usecase, right?
> 
> Well, I must say that I actually never used the expectations, and
> probably will not use it before long. So, of course, you can add the
> check.

No problem. The limitation (only allowing to create the expectation
from the first packet) should be relatively easy to remove by adding
an action to attach a "dummy" helper.

Thanks.
