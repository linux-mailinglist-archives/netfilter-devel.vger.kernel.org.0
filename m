Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3007A3BC313
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhGET0c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 15:26:32 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48702 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGET0a (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:26:30 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 950E160693;
        Mon,  5 Jul 2021 21:23:41 +0200 (CEST)
Date:   Mon, 5 Jul 2021 21:23:49 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     aabdallah <aabdallah@suse.de>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: improve RST handling when tuple
 is re-used
Message-ID: <20210705192349.GA16111@salvia>
References: <20210520105311.20745-1-fw@strlen.de>
 <7f02834fae6dde2d351650177375d004@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f02834fae6dde2d351650177375d004@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:27:51AM +0200, aabdallah wrote:
> Hi,
> 
> I see that this commit [1] is still under review, is there is any change
> that it will be reviewed and merged soon? Thanks.
> 
> [1] https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=244902

Ok, I'm assuming that you're fine with Florian's proposal to address
your issue then. I was actually waiting for your ACK.

I'll place this patch:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210520105311.20745-1-fw@strlen.de/

into nf.git.

Thanks
