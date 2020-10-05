Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A322837B7
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Oct 2020 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgJEO22 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Oct 2020 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEO22 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:28:28 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B0C0613CE
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Oct 2020 07:28:27 -0700 (PDT)
Received: from localhost ([::1]:58604 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kPRTU-0005Ea-Qf; Mon, 05 Oct 2020 16:28:24 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [iptables PATCH 0/3] nft: Fix transaction refreshing
Date:   Mon,  5 Oct 2020 16:48:55 +0200
Message-Id: <20201005144858.11578-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With iptables-nft-restore in --noflush mode, the created batch job list
may need to be adjusted to a changing ruleset in kernel. In particular,
an input line like ':FOO - [0:0]' either means "flush chain FOO" or
"create chain FOO" depending on whether it exists already or not. Patch
3 contains a test case provoking this peculiar situation and fixes the
transaction prepare and refresh logic in that case. Patch 1 is a simple
preparation change, patch 2 a somewhat related fix for error reporting
with refreshed transactions.

Phil Sutter (3):
  nft: Make batch_add_chain() return the added batch object
  nft: Fix error reporting for refreshed transactions
  nft: Fix for concurrent noflush restore calls

 iptables/nft.c                                | 96 ++++++++++---------
 .../ipt-restore/0016-concurrent-restores_0    | 53 ++++++++++
 2 files changed, 102 insertions(+), 47 deletions(-)
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0016-concurrent-restores_0

-- 
2.28.0

