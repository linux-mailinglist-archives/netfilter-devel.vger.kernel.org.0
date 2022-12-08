Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47E8646F84
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 13:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLHMYB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 07:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLHMYA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:24:00 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A13FB7617C
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 04:23:59 -0800 (PST)
Date:   Thu, 8 Dec 2022 13:23:56 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 4/7] nft: Fix match generator for '! -i +'
Message-ID: <Y5HXXN4c4NpRDI4+@salvia>
References: <20221201163916.30808-1-phil@nwl.cc>
 <20221201163916.30808-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221201163916.30808-5-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:39:13PM +0100, Phil Sutter wrote:
> It's actually nonsense since it will never match, but iptables accepts
> it and the resulting nftables rule must behave identically. Reuse the
> solution implemented into xtables-translate (by commit e179e87a1179e)
> and turn the above match into 'iifname INVAL/D'.

Maybe starting bailing out in iptables-nft when ! -i + is used at
ruleset load time?

As you mentioned, this rule is really useless / never matching.
