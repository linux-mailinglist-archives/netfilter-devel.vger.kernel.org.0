Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2054C978A
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Mar 2022 22:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiCAVIY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Mar 2022 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiCAVIX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:08:23 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B40F6460
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Mar 2022 13:07:40 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6D3D36019D;
        Tue,  1 Mar 2022 22:06:12 +0100 (CET)
Date:   Tue, 1 Mar 2022 22:07:37 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 00/26] scanner: Some fixes, many new scopes
Message-ID: <Yh6LGYMboF8/b65Q@salvia>
References: <20220219132814.30823-1-phil@nwl.cc>
 <YhGMiKReUjPCyAai@salvia>
 <Yh1BMz9cW/yb6CR7@salvia>
 <Yh5W42dNE1YxTi2s@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh5W42dNE1YxTi2s@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Tue, Mar 01, 2022 at 06:24:51PM +0100, Phil Sutter wrote:
> On Mon, Feb 28, 2022 at 10:40:03PM +0100, Pablo Neira Ayuso wrote:
> > On Sun, Feb 20, 2022 at 01:34:20AM +0100, Pablo Neira Ayuso wrote:
> > > On Sat, Feb 19, 2022 at 02:27:48PM +0100, Phil Sutter wrote:
> > > > Patch 1 adds a test for 'ct count' statement, patches 2 and 3 fix some
> > > > keywords' scope, bulk scope introduction in the remaining ones.
> > > 
> > > Could you just push out the fixes in this batch?
> > > 
> > > My proposal is to release 1.0.2 with accumulated changes in master,
> > > then we follow up with more updates after the release.
> > 
> > I think it's fine to merge this to master now that 1.0.2 has been
> > released.
> 
> Pushed the series after a rebase and successful py testsuite run for
> sanity. Thanks for the heads-up!

shell testsuite reports problems:

results: [OK] 298 [FAILED] 3 [TOTAL] 301

These test breaks with syntax errors.

Please, also run monitor and json_echo tests.

Thanks.
