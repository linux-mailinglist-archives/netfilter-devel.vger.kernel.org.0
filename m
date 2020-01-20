Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D194142F88
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jan 2020 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgATQZz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jan 2020 11:25:55 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60802 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgATQZz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:25:55 -0500
Received: from localhost ([::1]:45660 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1itZs9-000633-RM; Mon, 20 Jan 2020 17:25:53 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 4/4] netlink: Avoid potential NULL-pointer deref in netlink_gen_payload_stmt()
Date:   Mon, 20 Jan 2020 17:25:40 +0100
Message-Id: <20200120162540.9699-5-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120162540.9699-1-phil@nwl.cc>
References: <20200120162540.9699-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With payload_needs_l4csum_update_pseudohdr() unconditionally
dereferencing passed 'desc' parameter and a previous check for it to be
non-NULL, make sure to call the function only if input is sane.

Fixes: 68de70f2b3fc6 ("netlink_linearize: fix IPv6 layer 4 checksum mangling")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netlink_linearize.c b/src/netlink_linearize.c
index 498326d0087a1..cb1b7fe1748b2 100644
--- a/src/netlink_linearize.c
+++ b/src/netlink_linearize.c
@@ -941,7 +941,7 @@ static void netlink_gen_payload_stmt(struct netlink_linearize_ctx *ctx,
 		nftnl_expr_set_u32(nle, NFTNL_EXPR_PAYLOAD_CSUM_OFFSET,
 				   csum_off / BITS_PER_BYTE);
 	}
-	if (expr->payload.base == PROTO_BASE_NETWORK_HDR &&
+	if (expr->payload.base == PROTO_BASE_NETWORK_HDR && desc &&
 	    payload_needs_l4csum_update_pseudohdr(expr, desc))
 		nftnl_expr_set_u32(nle, NFTNL_EXPR_PAYLOAD_FLAGS,
 				   NFT_PAYLOAD_L4CSUM_PSEUDOHDR);
-- 
2.24.1

