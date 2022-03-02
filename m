Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765034CB364
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 01:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiCCADI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Mar 2022 19:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCCADH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:03:07 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 596BCC30
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Mar 2022 16:02:22 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 19B68625FE;
        Thu,  3 Mar 2022 00:24:49 +0100 (CET)
Date:   Thu, 3 Mar 2022 00:26:17 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH v3] netfilter: nf_tables: Reject tables of
 unsupported family
Message-ID: <Yh/9GfhyZ346OMBk@salvia>
References: <20220216145538.19070-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220216145538.19070-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 16, 2022 at 03:55:38PM +0100, Phil Sutter wrote:
> An nftables family is merely a hollow container, its family just a
> number and such not reliant on compile-time options other than nftables
> support itself. Add an artificial check so attempts at using a family
> the kernel can't support fail as early as possible. This helps user
> space detect kernels which lack e.g. NFPROTO_INET.

Applied, thanks
