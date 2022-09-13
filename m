Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE75B6CDA
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Sep 2022 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiIMMLD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Sep 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiIMMLC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:11:02 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332757E08
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Sep 2022 05:11:00 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oY4kk-0008VA-4h; Tue, 13 Sep 2022 14:10:58 +0200
Date:   Tue, 13 Sep 2022 14:10:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables-nft 1/2] nft: support ttl/hoplimit dissection
Message-ID: <YyBzUnA4KjVJqbLd@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20220912085846.9116-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912085846.9116-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:58:44AM +0200, Florian Westphal wrote:
> xlate raw "nft ... ttl eq 1" and so on to the ttl/hl matches.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Series:

Reviewed-by: Phil Sutter <phil@nwl.cc>
