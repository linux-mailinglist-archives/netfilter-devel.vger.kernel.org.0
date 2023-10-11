Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDE7C560E
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Oct 2023 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjJKOAN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Oct 2023 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjJKOAM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:00:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6C4A4
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Oct 2023 07:00:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qqZkt-00010I-NT; Wed, 11 Oct 2023 16:00:07 +0200
Date:   Wed, 11 Oct 2023 16:00:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack] conntrack: label update requires a previous
 label in place
Message-ID: <20231011140007.GF1407@breakpoint.cc>
References: <20231011095503.131168-1-pablo@netfilter.org>
 <ZSZ39VSJWfPjeizQ@calendula>
 <20231011111029.GE1407@breakpoint.cc>
 <ZSakk9nuZZXAb+qE@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSakk9nuZZXAb+qE@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Rationale was that if you have no rules that check on labels then
> > there is never a need to allocate the space.
> > 
> > I'm working on a patchset that will also set/enable the label
> > extension if its enabled on the template. The idea is to convert
> > ovs and act_ct to it, currently they point-blank increment
> > net->ct.labels_used which means that all conntrack objects get the
> > label area allocated.
> > 
> > But thats not what the counter was (originally) meant to convey, it
> > was really 'number of connlabel rules'.
> 
> > As soon as act_ct or ovs modules are loaded, then all the namespaces
> > see 'I need conntrack labels', which completely voids all attempts to
> > avoid ct->ext allocation.
> 
> OK, so instead a of per-netns sysctl toggle, you propose to use the
> conntrack template to selectively enable this.

I think for iptables/nftables current approach is fine.

Otherwise someone has to explain to me what the use case is for
setting connlabels from netlink but no rules in place that make
any decision based on that.
