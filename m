Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4F7DF09E
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 11:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346987AbjKBKyj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 06:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346112AbjKBKyi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:54:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C8DE
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 03:54:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qyVLO-0006zS-Tn; Thu, 02 Nov 2023 11:54:34 +0100
Date:   Thu, 2 Nov 2023 11:54:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC] netfilter: nf_tables: add flowtable map for xdp
 offload
Message-ID: <20231102105434.GF6174@breakpoint.cc>
References: <20231019202507.16439-1-fw@strlen.de>
 <87il6k1lbz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il6k1lbz.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Toke H�iland-J�rgensen <toke@kernel.org> wrote:
> > It might make more sense to intentionally have packets
> > flow through the normal path periodically so neigh entries are up to
> > date.
> 
> Hmm, I see what you mean, but I worry that this would lead to some nasty
> latency blips when a flow transitions back and forth between kernel and
> XDP paths. Also, there's a reordering problem as the state is changed:
> the first goes through the stack, sets the flow state to active, then
> gets transmitted. But while that sits in the qdisc waiting to go out on
> the wire, the next packet arrives, gets handled by the XDP fastpath and
> ends up overtaking the first packet on the TX side. Not sure we have a
> good solution for this in general :(

From nft based flowtable offload we already had a feature request to
bounce flows back to normal path periodially, this was because people
wanted to make sure that long-living flows get revalidated vs. current
netfilter ruleset and not the one that was active at flow offload time.

There was a patch for it, using a new sysctl, and author never came
back with an updated patch to handle this via the ruleset instead.
