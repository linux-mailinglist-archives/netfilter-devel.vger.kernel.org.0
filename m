Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AAF7CF8C4
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Oct 2023 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjJSM3G (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Oct 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSM3G (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:29:06 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59FCF
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Oct 2023 05:29:04 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qtS98-00019i-Ao; Thu, 19 Oct 2023 14:29:02 +0200
Date:   Thu, 19 Oct 2023 14:29:02 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH v3 1/3] netfilter: nf_tables: Open-code audit log
 call in nf_tables_getrule()
Message-ID: <ZTEhDhBwd0RDKSjq@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20231019113347.8753-1-phil@nwl.cc>
 <20231019113347.8753-2-phil@nwl.cc>
 <20231019115252.GG12544@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019115252.GG12544@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:52:52PM +0200, Florian Westphal wrote:
> > -	return nfnetlink_unicast(skb2, net, NETLINK_CB(skb).portid);
> > +	tablename = nla_strdup(nla[NFTA_RULE_TABLE], GFP_ATOMIC);
> > +	buf = kasprintf(GFP_ATOMIC, "%s:%u", tablename, nft_net->base_seq);
> 
> You can use %.*s:%u", nla_len(nla[NFTA_RULE_TABLE]), nla_data(nla[NFTA_RULE_TABLE) ...
> here to avoid the extra strdup.

Nice, thanks!
