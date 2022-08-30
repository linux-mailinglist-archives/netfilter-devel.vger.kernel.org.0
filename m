Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412685A6248
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Aug 2022 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiH3Lmm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Aug 2022 07:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiH3LmK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:42:10 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9AA1D59
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Aug 2022 04:40:31 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oSzbY-0003VM-Cf; Tue, 30 Aug 2022 13:40:28 +0200
Date:   Tue, 30 Aug 2022 13:40:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: nft.8: Extend limit statement's burst value info
Message-ID: <Yw33LIfkSd4rEQHI@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220826131431.19696-1-phil@nwl.cc>
 <Yw32VzsENzRJ0kpn@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw32VzsENzRJ0kpn@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:36:55PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Aug 26, 2022 at 03:14:31PM +0200, Phil Sutter wrote:
> > Describe how the burst value influences the kernel module's token
> > bucket in each of the two modes.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> > Looking at the code, maybe one should make byte-based limit burst
> > default to either zero or four times the rate value instead of the
> > seemingly arbitrary 5 bytes.
> 
> This is a bug, let me have a look and then you follow up to update the
> manpage, OK?

ACK, thanks!

Cheers, Phil
