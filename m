Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CC68D4D8
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Feb 2023 11:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjBGKvd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Feb 2023 05:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjBGKva (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:51:30 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8071117CEF
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Feb 2023 02:51:29 -0800 (PST)
Date:   Tue, 7 Feb 2023 11:51:26 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Russel King <linux@armlinux.org.uk>
Subject: Re: [PATCH nf-next] netfilter: let reset rules clean out conntrack
 entries
Message-ID: <Y+ItLunDRJ9OyRFW@salvia>
References: <20230201134522.13188-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230201134522.13188-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:45:22PM +0100, Florian Westphal wrote:
> iptables/nftables support responding to tcp packets with tcp resets.
> 
> The generated tcp reset packet passes through both output and postrouting
> netfilter hooks, but conntrack will never see them because the generated
> skb has its ->nfct pointer copied over from the packet that triggered the
> reset rule.
> 
> If the reset rule is used for established connections, this
> may result in the conntrack entry to be around for a very long
> time (default timeout is 5 days).
> 
> One way to avoid this would be to not copy the nf_conn pointer
> so that the rest packet passes through conntrack too.
> 
> Problem is that output rules might not have the same conntrack
> zone setup as the prerouting ones, so its possible that the
> reset skb won't find the correct entry.  Generating a template
> entry for the skb seems error prone as well.
> 
> Add an explicit "closing" function that switches a confirmed
> conntrack entry to closed state and wire this up for tcp.
> 
> If the entry isn't confirmed, no action is needed because
> the conntrack entry will never be committed to the table.

Applied to nf-next, thanks
