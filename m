Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188165437CA
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jun 2022 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiFHPoH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Jun 2022 11:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbiFHPoG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:44:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810B8369FC
        for <netfilter-devel@vger.kernel.org>; Wed,  8 Jun 2022 08:44:03 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nyxqj-00032p-HE; Wed, 08 Jun 2022 17:44:01 +0200
Date:   Wed, 8 Jun 2022 17:44:01 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Nick <vincent@systemli.org>
Cc:     Netfilter Development Mailing List 
        <netfilter-devel@vger.kernel.org>
Subject: Re: Add action to "finally" accept packets?
Message-ID: <20220608154401.GB6114@breakpoint.cc>
References: <36adbaad-20aa-2909-6ec1-caf61b0364ad@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36adbaad-20aa-2909-6ec1-caf61b0364ad@systemli.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Nick <vincent@systemli.org> wrote:
> OpenWrt switched to nftables in its firewall4 implementation [0]. Now people
> start porting their custom iptables rules to nft. However, there is a lack
> of "finally" accepting a packet without traversing the other chains with the
> same hook type and later priority in the same table [1,2]. Jumping/GoTo
> statements do not help [3]. Is it possible to add an action/policy allowing
> us to stop traversing the table?
> 
> [0] - https://git.openwrt.org/project/firewall4.git
> [1] - https://github.com/openwrt/openwrt/issues/9981

This statement is incorrect, nft behaves like iptables.
ACCEPT in raw table moves packet to mangle table, and so on.

The confusion arises because users that to add their own tables,
and then are surprised that their 'accept' "does not work" the
way they expect.

Its not possible to implement a 'full accept' because it would
also make the packet skip the internal hooks  that are used e.g.
by conntrack.

Why does jump/goto not help? It works just like in iptables.
