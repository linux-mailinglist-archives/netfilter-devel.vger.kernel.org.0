Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 298C1FDB64
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKOK3Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 05:29:24 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36560 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfKOK3Y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:29:24 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iVYqw-0003Vs-OE; Fri, 15 Nov 2019 11:29:22 +0100
Date:   Fri, 15 Nov 2019 11:29:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 2/2] nft: Fix -Z for rules with NFTA_RULE_COMPAT
Message-ID: <20191115102922.GK19558@breakpoint.cc>
References: <20191115094725.19756-1-phil@nwl.cc>
 <20191115094725.19756-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115094725.19756-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> The special nested attribute NFTA_RULE_COMPAT holds information about
> any present l4proto match (given via '-p' parameter) in input. The match
> is contained as meta expression as well, but some xtables extensions
> explicitly check it's value (see e.g. xt_TPROXY).
> 
> This nested attribute is input only, the information is lost after
> parsing (and initialization of compat extensions). So in order to feed a
> rule back to kernel with zeroed counters, the attribute has to be
> reconstructed based on the rule's expressions.
> 
> Other code paths are not affected since rule_to_cs() callback will
> populate respective fields in struct iptables_command_state and 'add'
> callback (which is the inverse to rule_to_cs()) calls add_compat() in
> any case.

Reviewed-by: Florian Westphal <fw@strlen.de>
