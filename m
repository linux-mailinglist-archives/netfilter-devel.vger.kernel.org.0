Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21126F1AC3
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Apr 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjD1OsI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Apr 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjD1OsH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:48:07 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01951731
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Apr 2023 07:48:04 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1psPOE-0002xx-Qy
        for netfilter-devel@vger.kernel.org; Fri, 28 Apr 2023 16:48:02 +0200
Date:   Fri, 28 Apr 2023 16:48:02 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/3] arptables: Fix parsing of inverted 'arp
 operation' match
Message-ID: <ZEvcorAMwGyol13o@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230428130531.14195-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428130531.14195-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 28, 2023 at 03:05:29PM +0200, Phil Sutter wrote:
> The wrong bit was set in 'invflags', probably due to copy'n'paste from
> the previous case.
> 
> Fixes: 84909d171585d ("xtables: bootstrap ARP compatibility layer for nftables")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.
