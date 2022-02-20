Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8594BCB66
	for <lists+netfilter-devel@lfdr.de>; Sun, 20 Feb 2022 01:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiBTApG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Feb 2022 19:45:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbiBTApG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:45:06 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4170856220
        for <netfilter-devel@vger.kernel.org>; Sat, 19 Feb 2022 16:44:46 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nLaLE-0000Ry-EM; Sun, 20 Feb 2022 01:44:44 +0100
Date:   Sun, 20 Feb 2022 01:44:44 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 03/26] scanner: Some time units are only used in
 limit scope
Message-ID: <YhGO/AeDbhEV6hgM@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220219132814.30823-1-phil@nwl.cc>
 <20220219132814.30823-4-phil@nwl.cc>
 <YhGNe9XT8rgZReKf@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhGNe9XT8rgZReKf@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Feb 20, 2022 at 01:38:19AM +0100, Pablo Neira Ayuso wrote:
> On Sat, Feb 19, 2022 at 02:27:51PM +0100, Phil Sutter wrote:
> > 'hour' and 'day' are allowed as unqualified meta expressions, so leave
> > them alone.
> 
> Are you use? I can see time_type is by 'ct expiration'.

It's not about time_type, but the keywords. We support 'meta day' and
'meta hour' expressions, and they are allowed as unqualified. So
effectively:

| nft add rule t c day "Saturday" hour "13:37"

must succeed. Therefore "day" and "hour" keywords must stay in global
scope.

Cheers, Phil
