Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8766E2C7
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Jan 2023 16:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjAQPwX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Jan 2023 10:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjAQPwD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:52:03 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86412C654
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Jan 2023 07:51:03 -0800 (PST)
Date:   Tue, 17 Jan 2023 16:51:00 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] Implement 'reset rule' and 'reset rules' commands
Message-ID: <Y8bD5EJCWPSsNcTp@salvia>
References: <20230112162342.2986-1-phil@nwl.cc>
 <Y8VDcq8UXg+5GD+F@salvia>
 <Y8a3fB86ccXiv3A9@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8a3fB86ccXiv3A9@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:58:04PM +0100, Phil Sutter wrote:
> On Mon, Jan 16, 2023 at 01:30:42PM +0100, Pablo Neira Ayuso wrote:
> > On Thu, Jan 12, 2023 at 05:23:42PM +0100, Phil Sutter wrote:
> > > Reset rule counters and quotas in kernel, i.e. without having to reload
> > > them. Requires respective kernel patch to support NFT_MSG_GETRULE_RESET
> > > message type.
> > 
> > Only thing to mention: This adds a new rule_cache_dump() call, this
> > was consolidated on top of the cache infrastructure, to have a single
> > spot in the code to fetch kernel objects via netlink. This triggers to
> > netlink dumps, one to populate the cache and another for the reset,
> > right?
> 
> Well, rule_cache_dump() becomes dual-use, because the rule reset call is
> so similar to the regular rule dump one.
> 
> I also changed it to allow turning the actual dump off (by sending
> NLM_F_ACK instead of NLM_F_DUMP to kernel). This is used for resetting a
> single rule (identified by rule-handle). Same functionality as with
> resetting (a single) quota instead of "quotas".

Makes sense.

> If dump is active, the kernel returns the rules that have been reset to
> user space, so users see the last state data. To correctly print this,
> nft needs a table and chain cache. My v2 has this wrong, it needlessly
> requests a rule cache also. Thanks for making me validate this aspect of
> the implementation! :)

Ok.

> The only caveat I just noticed with reduced cache is that "whole ruleset
> reset" does not print the rules because list_rule_cb() expects h->family
> to be set. Making it accept NFPROTO_UNSPEC is trivial, though.

I guess you refer to this chunk.

@@ -591,8 +615,8 @@  static int list_rule_cb(struct nftnl_rule *nlr, void *data)
 	table  = nftnl_rule_get_str(nlr, NFTNL_RULE_TABLE);
 	chain  = nftnl_rule_get_str(nlr, NFTNL_RULE_CHAIN);
 
-	if (h->family != family ||
-	    strcmp(table, h->table.name) != 0 ||
+	if ((h->family != NFPROTO_UNSPEC && h->family != family) ||
+	    (h->table.name && strcmp(table, h->table.name) != 0) ||
 	    (h->chain.name && strcmp(chain, h->chain.name) != 0))
 		return 0;

There is one more thing that will need a re-visit sooner or later.

NLM_F_DUMP might hit EINTR, meaning that while dumping-and-reset,
there was a ruleset update from the transaction path.

In this case, the listing would not be consistent. This would require
to trigger a bit more complicated path, that is: 1) keep previous list
of rules, 2) re-start dump with empty list, 3) look up via handle to
check if the rule in the previous list, to fetch the counter into the
new rule.

I think this problem already exists for the counter/quota/... reset.

I still have to extend the cache infrastructure to support for rules.
It is on my TODO list for monitor infrastructure. Then probably this
reset command can be reworked on top of the cache.

Anyway, your patch is a good starter. Better cache integration and
this corner case can possibly wait.
