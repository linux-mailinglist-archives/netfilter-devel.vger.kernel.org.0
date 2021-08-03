Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258CD3DE92A
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Aug 2021 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhHCJEQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Aug 2021 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhHCJEP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:04:15 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77F1C06175F
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Aug 2021 02:04:04 -0700 (PDT)
Received: from localhost ([::1]:57954 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mAqLC-0003VN-JX; Tue, 03 Aug 2021 11:04:02 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] nft: Fix for non-verbose check command
Date:   Tue,  3 Aug 2021 11:03:54 +0200
Message-Id: <20210803090354.21202-1-phil@nwl.cc>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Check command was unconditionally verbose since v1.8.5. Make it respect
--verbose option again.

Fixes: a7f1e208cdf9c ("nft: split parsing from netlink commands")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 4e80e5b7e7972..8880d12f31c7a 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -3122,7 +3122,7 @@ static int nft_prepare(struct nft_handle *h)
 		case NFT_COMPAT_RULE_CHECK:
 			assert_chain_exists(h, cmd->table, cmd->jumpto);
 			ret = nft_rule_check(h, cmd->chain, cmd->table,
-					     cmd->obj.rule, cmd->rulenum);
+					     cmd->obj.rule, cmd->verbose);
 			break;
 		case NFT_COMPAT_RULE_ZERO:
 			ret = nft_rule_zero_counters(h, cmd->chain, cmd->table,
-- 
2.32.0

