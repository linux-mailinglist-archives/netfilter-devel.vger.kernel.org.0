Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA9B770C77
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Aug 2023 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHDXmz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Aug 2023 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDXmw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:42:52 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1073AAF
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Aug 2023 16:42:51 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qS4RV-0000Dp-Eh; Sat, 05 Aug 2023 01:42:49 +0200
Date:   Sat, 5 Aug 2023 01:42:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Jan Palus <atler@pld-linux.org>
Subject: Re: [iptables PATCH] nft: move processing logic out of asserts
Message-ID: <ZM2M+Vh9Qspls3jj@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org, Jan Palus <atler@pld-linux.org>
References: <20230803144753.27070-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803144753.27070-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:47:53PM +0200, Phil Sutter wrote:
> From: Jan Palus <atler@pld-linux.org>
> 
> [Phil: Introduce assert_nft_restart() to keep things clean, also add
>        fallback returns to nft_action() and nft_prepare(), sanitizing
>        things at least a bit.]
> 
> Signed-off-by: Jan Palus <atler@pld-linux.org>
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied after adding a link to the Bugzilla ticket.
