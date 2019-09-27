Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944F8C072A
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2019 16:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfI0OU3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Sep 2019 10:20:29 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50262 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726926AbfI0OU3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:20:29 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iDr6h-0002Xv-QA; Fri, 27 Sep 2019 16:20:27 +0200
Date:   Fri, 27 Sep 2019 16:20:27 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 04/24] nft: Fix for add and delete of same
 rule in single batch
Message-ID: <20190927142027.GE9938@breakpoint.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925212605.1005-5-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Another corner-case found when extending restore ordering test: If a
> delete command in a dump referenced a rule added earlier within the same
> dump, kernel would reject the resulting NFT_MSG_DELRULE command.
> 
> Catch this by assigning the rule to delete a RULE_ID value if it doesn't
> have a handle yet. Since __nft_rule_del() does not duplicate the
> nftnl_rule object when creating the NFT_COMPAT_RULE_DELETE command, this
> RULE_ID value is added to both NEWRULE and DELRULE commands - exactly
> what is needed to establish the reference.

Acked-by: Florian Westphal <fw@strlen.de>
