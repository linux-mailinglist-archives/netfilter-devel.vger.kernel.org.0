Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14D2D8952
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Dec 2020 19:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407731AbgLLShV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Dec 2020 13:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407729AbgLLShU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Dec 2020 13:37:20 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD479C0613CF
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Dec 2020 10:36:40 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ko9l1-0006pr-9E; Sat, 12 Dec 2020 19:36:39 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] nft: trace: print packet unconditionally
Date:   Sat, 12 Dec 2020 19:36:25 +0100
Message-Id: <20201212183625.71140-1-fw@strlen.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The kernel includes the packet dump once for each base hook.
This means that in case a table contained no matching rule(s),
the packet dump will be included in the base policy dump.

Simply move the packet dump request out of the switch statement
so the debug output shows current packet even with no matched rule.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/netlink.c b/src/netlink.c
index 2ea2d4457664..8098b9746c95 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -1880,12 +1880,12 @@ int netlink_events_trace_cb(const struct nlmsghdr *nlh, int type,
 	if (nftnl_trace_nlmsg_parse(nlh, nlt) < 0)
 		netlink_abi_error();
 
+	if (nftnl_trace_is_set(nlt, NFTNL_TRACE_LL_HEADER) ||
+	    nftnl_trace_is_set(nlt, NFTNL_TRACE_NETWORK_HEADER))
+		trace_print_packet(nlt, &monh->ctx->nft->output);
+
 	switch (nftnl_trace_get_u32(nlt, NFTNL_TRACE_TYPE)) {
 	case NFT_TRACETYPE_RULE:
-		if (nftnl_trace_is_set(nlt, NFTNL_TRACE_LL_HEADER) ||
-		    nftnl_trace_is_set(nlt, NFTNL_TRACE_NETWORK_HEADER))
-			trace_print_packet(nlt, &monh->ctx->nft->output);
-
 		if (nftnl_trace_is_set(nlt, NFTNL_TRACE_RULE_HANDLE))
 			trace_print_rule(nlt, &monh->ctx->nft->output,
 					 &monh->ctx->nft->cache);
-- 
2.28.0

