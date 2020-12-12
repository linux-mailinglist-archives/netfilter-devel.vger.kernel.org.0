Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66C2D8733
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Dec 2020 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439227AbgLLPQ1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Dec 2020 10:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLLPQ1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Dec 2020 10:16:27 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A2C0613CF
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Dec 2020 07:15:46 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ko6ca-0005zW-8W; Sat, 12 Dec 2020 16:15:44 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH xtables-nft 0/3] xt-monitor fixes
Date:   Sat, 12 Dec 2020 16:15:31 +0100
Message-Id: <20201212151534.54336-1-fw@strlen.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

rule tracing via xt-monitor has various bugs:
 1. It prints unrelated rules because the function supposed
    to print the traced rule does a dump instead of a handle
    lookup.  This prints all rules in the chain instead of just one.
 2. Print the table family, not whatever family user provided on command line.
 3. The packet shoud be printed first, instead of after the first
    trace event.
 4. also make sure to flush stdout after each event so stdout redirect
    to files/pipes etc. works.

After this the output is much more similar to nft monitor, just in
xt rule format.

Florian Westphal (3):
  xtables-monitor: fix rule printing
  xtables-monitor: fix packet family protocol
  xtables-monitor: print packet first

 iptables/xtables-monitor.c | 70 ++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 30 deletions(-)

-- 
2.28.0

