Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569A96E5D2
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfGSMjh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 08:39:37 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:37934 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfGSMjh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:39:37 -0400
Received: from localhost ([::1]:51024 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hoSAh-0007Kd-K0; Fri, 19 Jul 2019 14:39:35 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fwestpha@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 2/2] net: netfilter: nft_meta_bridge: Eliminate 'out' label
Date:   Fri, 19 Jul 2019 14:39:21 +0200
Message-Id: <20190719123921.1249-2-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719123921.1249-1-phil@nwl.cc>
References: <20190719123921.1249-1-phil@nwl.cc>
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

