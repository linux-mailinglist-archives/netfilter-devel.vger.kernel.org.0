Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766A317619E
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCBRyI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 12:54:08 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:53318 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBRyI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:54:08 -0500
Received: from localhost ([::1]:38176 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1j8pGZ-0007II-6s; Mon, 02 Mar 2020 18:54:07 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/4] Fix for iptables-nft-restore under pressure
Date:   Mon,  2 Mar 2020 18:53:54 +0100
Message-Id: <20200302175358.27796-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Using a rather simple test-case, it is possible to provoke NULL-pointer
derefs in iptables-nft-restore.

Said test-case involves a rule set with a thousand custom chains in each
table, a thousand rules in each builtin chain and one rule in each
custom chain - details are not important though, it is enough to have
reasonably large tables to cause delays.

The test script simply starts ten instances of iptables-nft-restore in
background and ten instances in a loop in foreground, all reading above
rule set.

Critical detail is iptables-nft-restore pushing to kernel at each COMMIT
line, so nft_rebuild_cache() may run multiple times during a single
restore.

The actual fix is contained in patch one. Patch two is actually a
performance optimization, the behaviour it changes is not wrong per se.
Patches three and four are fall-out from the first one.

Phil Sutter (4):
  nft: cache: Fix nft_release_cache() under stress
  nft: cache: Make nft_rebuild_cache() respect fake cache
  nft: cache: Simplify chain list allocation
  nft: cache: Review flush_cache()

 iptables/nft-cache.c | 87 +++++++++++++++++++++++---------------------
 iptables/nft.h       |  3 +-
 2 files changed, 48 insertions(+), 42 deletions(-)

-- 
2.25.1

