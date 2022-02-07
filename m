Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2504AC2DA
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Feb 2022 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiBGPTY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Feb 2022 10:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347334AbiBGOxQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:53:16 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6255C0401C1
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Feb 2022 06:53:15 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nH5OD-0007bD-RG; Mon, 07 Feb 2022 15:53:13 +0100
Date:   Mon, 7 Feb 2022 15:53:13 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/3] json: add flow statement json export + parser
Message-ID: <20220207145313.GD25000@breakpoint.cc>
References: <20220207132816.21129-1-fw@strlen.de>
 <20220207132816.21129-2-fw@strlen.de>
 <20220207132915.GB25000@breakpoint.cc>
 <YgEm4OBHhQ0L+0bD@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgEm4OBHhQ0L+0bD@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Feb 07, 2022 at 02:29:15PM +0100, Florian Westphal wrote:
> > Florian Westphal <fw@strlen.de> wrote:
> > > flow statement has no export, its shown as:
> > > ".. }, "flow add @ft" ] } }"
> > > 
> > > With this patch:
> > > 
> > > ".. }, {"flow": {"op": "add", "flowtable": "@ft"}}]}}"
> > 
> > This is based on the 'set' statement.  If you prefer the @ to
> > be removed let me know.
> 
> Then, it is consistent with the existing syntax. So either we consider
> deprecating the @ on the 'set' statement (while retaining backward
> compatibility) or flowtable also includes it as in your patch.

Ok, then lets keep it as-is; the @ might help humans to find a
set/flowtable name more quickly this way.
