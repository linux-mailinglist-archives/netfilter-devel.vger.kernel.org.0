Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535945B2287
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Sep 2022 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIHPho (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Sep 2022 11:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiIHPhP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:37:15 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653A8E6B8E
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Sep 2022 08:37:13 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oWJaZ-0006XQ-2h; Thu, 08 Sep 2022 17:37:11 +0200
Date:   Thu, 8 Sep 2022 17:37:11 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables-nft 0/3] nft: prefer meta pkttype to
 libxt_pkttype
Message-ID: <YxoMJxDrzmh0nQRM@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20220908151242.26838-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908151242.26838-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 08, 2022 at 05:12:39PM +0200, Florian Westphal wrote:
> low hanging fruit: use native meta+cmp instead of libxt_pkttype.
> First patch adds dissection, second patch switches to native expression.
> 
> Last patch adds support for 'otherhost' mnemonic, useless for iptables
> but useful for ebtables.

Reviewed-by: Phil Sutter <phil@nwl.cc>
