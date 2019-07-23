Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD47192D
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jul 2019 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfGWN2J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 09:28:09 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48456 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbfGWN2J (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:28:09 -0400
Received: from localhost ([::1]:33314 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hpupr-00088V-O7; Tue, 23 Jul 2019 15:28:07 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [PATCH v3 2/2] net: netfilter: nft_meta_bridge: Eliminate 'out' label
Date:   Tue, 23 Jul 2019 15:27:53 +0200
Message-Id: <20190723132753.13781-2-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723132753.13781-1-phil@nwl.cc>
References: <20190723132753.13781-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The label is used just once and the code it points at is not reused, no
point in keeping it.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/bridge/netfilter/nft_meta_bridge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index a98dec2cf0cfd..1804e867f7151 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -57,13 +57,11 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		return;
 	}
 	default:
-		goto out;
+		return nft_meta_get_eval(expr, regs, pkt);
 	}
 
 	strncpy((char *)dest, br_dev ? br_dev->name : "", IFNAMSIZ);
 	return;
-out:
-	return nft_meta_get_eval(expr, regs, pkt);
 err:
 	regs->verdict.code = NFT_BREAK;
 }
-- 
2.22.0

