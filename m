Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CB664696
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Jan 2023 17:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjAJQxt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Jan 2023 11:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjAJQxn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:53:43 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C026B175B3
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Jan 2023 08:53:41 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pFHsa-0003eQ-5l; Tue, 10 Jan 2023 17:53:40 +0100
Date:   Tue, 10 Jan 2023 17:53:40 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [iptables PATCH] Makefile: Replace brace expansion
Message-ID: <Y72YFKdMLUYf30lx@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20230110163502.11238-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110163502.11238-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 10, 2023 at 05:35:02PM +0100, Phil Sutter wrote:
> According to bash(1), it is not supported by "historical versions of
> sh". Dash seems to be such a historical version.
> 
> Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Fixes: 3822a992bc277 ("Makefile: Fix for 'make distcheck'")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
