Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A163DBF5
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Nov 2022 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiK3Raq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Nov 2022 12:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiK3Raq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:30:46 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C466B25E9F
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Nov 2022 09:30:45 -0800 (PST)
Date:   Wed, 30 Nov 2022 18:30:42 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <eric@garver.life>
Subject: Re: [PATCH v2 nf] netfilter: conntrack: set icmpv6 redirects as
 RELATED
Message-ID: <Y4eTQg9Fk+9KDizU@salvia>
References: <20221123121639.27624-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221123121639.27624-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 23, 2022 at 01:16:39PM +0100, Florian Westphal wrote:
> icmp conntrack will set icmp redirects as RELATED, but icmpv6 will not
> do this.
> 
> For icmpv6, only icmp errors (code <= 128) are examined for RELATED state.
> ICMPV6 Redirects are part of neighbour discovery mechanism, those are
> handled by marking a selected subset (e.g.  neighbour solicitations) as
> UNTRACKED, but not REDIRECT -- they will thus be flagged as INVALID.
> 
> Add minimal support for REDIRECTs.  No parsing of neighbour options is
> added for simplicity, so this will only check that we have the embeeded
> original header (ND_OPT_REDIRECT_HDR), and then attempt to do a flow
> lookup for this tuple.
> 
> Also extend the existing test case to cover redirects.

Applied to nf-next, thanks.
