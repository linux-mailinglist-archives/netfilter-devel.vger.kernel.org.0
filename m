Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2816B3E50
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Mar 2023 12:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCJLq6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Mar 2023 06:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCJLqw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:46:52 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3E112595
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Mar 2023 03:46:46 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pabCv-0001al-Bq; Fri, 10 Mar 2023 12:46:45 +0100
Date:   Fri, 10 Mar 2023 12:46:45 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] xt: Fix fallback printing for extensions matching
 keywords
Message-ID: <ZAsYpctpm13XEBx4@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230309134350.9803-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309134350.9803-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:43:50PM +0100, Phil Sutter wrote:
> Yet another Bison workaround: Instead of the fancy error message, an
> incomprehensible syntax error is emitted:
> 
> | # iptables-nft -A FORWARD -p tcp -m osf --genre linux
> | # nft list ruleset | nft -f -
> | # Warning: table ip filter is managed by iptables-nft, do not touch!
> | /dev/stdin:4:29-31: Error: syntax error, unexpected osf, expecting string
> | 		meta l4proto tcp xt match osf counter packets 0 bytes 0
> | 		                          ^^^
> 
> Avoid this by quoting the extension name when printing:
> 
> | # nft list ruleset | sudo ./src/nft -f -
> | # Warning: table ip filter is managed by iptables-nft, do not touch!
> | /dev/stdin:4:20-33: Error: unsupported xtables compat expression, use iptables-nft with this ruleset
> | 		meta l4proto tcp xt match "osf" counter packets 0 bytes 0
> | 		                 ^^^^^^^^^^^^^^
> 
> Fixes: 79195a8cc9e9d ("xt: Rewrite unsupported compat expression dumping")
> Fixes: e41c53ca5b043 ("xt: Fall back to generic printing from translation")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
