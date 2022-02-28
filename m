Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4244C7C3A
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Feb 2022 22:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiB1Vkr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Feb 2022 16:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiB1Vkq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:40:46 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01FDB14AC9C
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Feb 2022 13:40:07 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8185460743;
        Mon, 28 Feb 2022 22:38:42 +0100 (CET)
Date:   Mon, 28 Feb 2022 22:40:03 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 00/26] scanner: Some fixes, many new scopes
Message-ID: <Yh1BMz9cW/yb6CR7@salvia>
References: <20220219132814.30823-1-phil@nwl.cc>
 <YhGMiKReUjPCyAai@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhGMiKReUjPCyAai@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Feb 20, 2022 at 01:34:20AM +0100, Pablo Neira Ayuso wrote:
> On Sat, Feb 19, 2022 at 02:27:48PM +0100, Phil Sutter wrote:
> > Patch 1 adds a test for 'ct count' statement, patches 2 and 3 fix some
> > keywords' scope, bulk scope introduction in the remaining ones.
> 
> Could you just push out the fixes in this batch?
> 
> My proposal is to release 1.0.2 with accumulated changes in master,
> then we follow up with more updates after the release.

I think it's fine to merge this to master now that 1.0.2 has been
released.

Thanks.
