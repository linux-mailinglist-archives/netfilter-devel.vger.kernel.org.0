Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47762770C76
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Aug 2023 01:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjHDXl0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Aug 2023 19:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDXl0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:41:26 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B164EDD
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Aug 2023 16:41:24 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qS4Q7-0000Cs-9d
        for netfilter-devel@vger.kernel.org; Sat, 05 Aug 2023 01:41:23 +0200
Date:   Sat, 5 Aug 2023 01:41:23 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 00/15] Man pages review
Message-ID: <ZM2Mo+Y0ddgBmcDi@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230802160923.17949-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802160923.17949-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 02, 2023 at 06:09:08PM +0200, Phil Sutter wrote:
> Thanks to the manpage-l10n project, we received several tickets listing
> a number of corrections and improvements to the different iptables man
> pages. This series implements what I considered valid and worth keeping.
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1682
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1683
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1684

Series applied.
