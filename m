Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E2E6F2A7
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 12:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfGUKnM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Jul 2019 06:43:12 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42900 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfGUKnL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:43:11 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hp9J7-0005vO-JV; Sun, 21 Jul 2019 12:43:09 +0200
Date:   Sun, 21 Jul 2019 12:43:09 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nft] src: osf: fix snprintf -Wformat-truncation warning
Message-ID: <20190721104309.GD22661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20190718110145.13361-1-ffmancera@riseup.net>
 <20190720202157.GB22661@orbyte.nwl.cc>
 <00a4ebbb-a571-b00a-83ac-ad198ccbd263@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a4ebbb-a571-b00a-83ac-ad198ccbd263@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sun, Jul 21, 2019 at 11:59:14AM +0200, Fernando Fernandez Mancera wrote:
[...]
> I think your code is more readable than mine. I am going to send a v2
> patch with your code but also adding the following fix.
> 
> -	while (tmp && tmp + 1 && isspace(*(tmp + 1)))
> +	while (tmp && isspace(*(tmp + 1)))
> 
> I am going to send a similar patch for the iptables tree because this
> file was imported from iptables.git/utils/nfnl_osf.c.

Sounds great, thanks a lot!

Cheers, Phil
