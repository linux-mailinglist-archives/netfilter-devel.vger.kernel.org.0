Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87FB4115AA3
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Dec 2019 02:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLGB3A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 20:29:00 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40105 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfLGB3A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 20:29:00 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 61D077EA9FF
        for <netfilter-devel@vger.kernel.org>; Sat,  7 Dec 2019 12:28:44 +1100 (AEDT)
Received: (qmail 24750 invoked by uid 501); 7 Dec 2019 01:28:43 -0000
Date:   Sat, 7 Dec 2019 12:28:43 +1100
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question (verdicts)
Message-ID: <20191207012843.GA22674@dimstar.local.net>
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
References: <20191202102623.GA775@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202102623.GA775@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=RSmzAf-M6YYA:10 a=uRtfhzloAAAA:20 a=pFCvvqlZHehEolZJ9tMA:9
        a=CjuIK1q_8ugA:10 a=ubDO4clxTgye4MFiUn6k:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Dec 02, 2019 at 09:26:23PM +1100, Duncan Roe wrote:
> Hi Pablo,
>
> Queue handling [DEPRECATED] in libnetfilter_queue.c documents these 3:
>
> > 278  *   - NF_ACCEPT the packet passes, continue iterations
> > 281  *   - NF_REPEAT iterate the same cycle once more
> > 282  *   - NF_STOP accept, but don't continue iterations
>
> In my tests, NF_REPEAT works as documented - the input hook presents the packet
> a second time. But, contrary to the above, the packet does not show again
> after NF_ACCEPT.
>
> Is that expected behaviour nowadays?
>
> And if so, does that make NF_STOP redundant?
>
> BTW if you'd like to try it, my test program nfq6 is a subdirectory at
> https://github.com/duncan-roe/nfq (nfq itself is an ad blocker).
>
> Cheers ... Duncan.

Specifically I need to know whether to document NF_STOP as obsolete (same as
NF_ACCEPT).

Cheers ... Duncan.
