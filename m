Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F5398E80
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Jun 2021 17:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFBP0C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFBP0C (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:26:02 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F6C061574
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Jun 2021 08:24:19 -0700 (PDT)
Received: from localhost ([::1]:43094 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1loSjB-0007OZ-E7; Wed, 02 Jun 2021 17:24:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 4/9] nft: Avoid memleak in error path of nft_cmd_new()
Date:   Wed,  2 Jun 2021 17:23:58 +0200
Message-Id: <20210602152403.5689-5-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602152403.5689-1-phil@nwl.cc>
References: <20210602152403.5689-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If rule allocation fails, free the allocated 'cmd' before returning to
caller.

Fixes: a7f1e208cdf9c ("nft: split parsing from netlink commands")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/iptables/nft-cmd.c b/iptables/nft-cmd.c
index f2b935c57dab4..c3f6c14e0b99e 100644
--- a/iptables/nft-cmd.c
+++ b/iptables/nft-cmd.c
@@ -35,8 +35,10 @@ struct nft_cmd *nft_cmd_new(struct nft_handle *h, int command,
 
 	if (state) {
 		rule = nft_rule_new(h, chain, table, state);
-		if (!rule)
+		if (!rule) {
+			nft_cmd_free(cmd);
 			return NULL;
+		}
 
 		cmd->obj.rule = rule;
 
-- 
2.31.1

