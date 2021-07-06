Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65393BD46A
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Jul 2021 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhGFMJC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Jul 2021 08:09:02 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51382 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbhGFLzn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:55:43 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 81EBF6165C;
        Tue,  6 Jul 2021 13:52:52 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:53:01 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     aabdallah <aabdallah@suse.de>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: improve RST handling when tuple
 is re-used
Message-ID: <20210706115301.GA3835@salvia>
References: <20210520105311.20745-1-fw@strlen.de>
 <7f02834fae6dde2d351650177375d004@suse.de>
 <20210705192349.GA16111@salvia>
 <20210706100410.kxsjk23zpnwbynpw@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210706100410.kxsjk23zpnwbynpw@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 06, 2021 at 12:04:10PM +0200, Ali Abdallah wrote:
> On 05.07.2021 21:23, Pablo Neira Ayuso wrote:
> > Ok, I'm assuming that you're fine with Florian's proposal to address
> > your issue then. I was actually waiting for your ACK.
> > 
> > I'll place this patch:
> > 
> > https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210520105311.20745-1-fw@strlen.de/
> 
> Thanks a lot!
> 
> Please also take into account the following patch:
> 
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210527071906.s7z72s7wsene5lib@Fryzen495/
> 
> which was already acked by Florian.

Patches applied to nf.git, thanks.
