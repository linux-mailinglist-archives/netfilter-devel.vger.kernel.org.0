Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61533DCAEF
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Aug 2021 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhHAJqr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Aug 2021 05:46:47 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47682 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhHAJqr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Aug 2021 05:46:47 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3E4A460033;
        Sun,  1 Aug 2021 11:46:04 +0200 (CEST)
Date:   Sun, 1 Aug 2021 11:46:31 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: clusterip: don't register hook in
 all netns
Message-ID: <20210801094631.GA15328@salvia>
References: <20210722084834.27027-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210722084834.27027-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:48:31AM +0200, Florian Westphal wrote:
> This series stops ipt_CLUSTERIP from registering arp mangling hook
> unconditionally.
> 
> Hook gets installed/removed from checkentry/destroy callbacks.
> 
> Before this, modprobe ipt_CLUSTERIP would add a hook in each netns.
> While at it, also get rid of x_tables.h/xt storage space in struct net,
> there is no need for this.

Series applied, thanks.

I made a small update to 2/3 here:

@@ -517,6 +531,19 @@ static int clusterip_tg_check(const struct xt_tgchk_param *par)
                return ret;
        }

+       if (cn->hook_users == 0) {
+               ret = nf_register_net_hook(par->net, &cip_arp_ops);
+
+               if (ret < 0) {
+                       clusterip_config_entry_put(config); <--
+                       clusterip_config_put(config); <--

to use config instead cipinfo->config which is set on later.
