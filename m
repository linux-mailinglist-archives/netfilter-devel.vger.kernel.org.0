Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88E876F337
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Aug 2023 21:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjHCTGP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Aug 2023 15:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHCTGA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:06:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014903588
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Aug 2023 12:05:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qRddg-0007Vm-Os; Thu, 03 Aug 2023 21:05:36 +0200
Date:   Thu, 3 Aug 2023 21:05:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Robert <robert.smith51@protonmail.com>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Solution Bugzilla Issue 1659 - iptables-nft v1.8.9 Error: meta
 sreg key not supported
Message-ID: <20230803190536.GI30550@breakpoint.cc>
References: <0TcEByvmmvSrVOL2oYdyKhBojClLwt3xHHGYkphjAaaBm2jOxRmlvXJqEykAbCkuyOKHORKJ8epnPMSPocplpWrWpczuyjoOcrOurG9jJ2k=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0TcEByvmmvSrVOL2oYdyKhBojClLwt3xHHGYkphjAaaBm2jOxRmlvXJqEykAbCkuyOKHORKJ8epnPMSPocplpWrWpczuyjoOcrOurG9jJ2k=@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Robert <robert.smith51@protonmail.com> wrote:
> I have recently encountered the issue described in the aforementioned Bugzilla issue (#1659)  as, among others, Debian 12 ships the affected iptables v1.8.9. This can trip up a number of other applications that rely on the iptables command, including the Docker daemon, preventing it from creating correct FW rules if any nftables "meta" rules are present during startup.
> 
> After some bisecting, I was able to determine that this issue was introduced by commit 66806feef085c0504966c484f687bdf7b09510e3 ("nft: Fix meta statement parsing"). Reverting the commit in question resolves the issue, and no further errors are produced by builds of the 1.8.9 version.

No, the old version doesn't work either, it will ignore/suppress the nft
mark rule.

You cannot mix nftables and iptables-nft one the same table.
