Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E2E39F29D
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFHJml (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFHJmk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:42:40 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6548DC061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 02:40:47 -0700 (PDT)
Received: from localhost ([::1]:59844 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lqYE1-00073o-Qu; Tue, 08 Jun 2021 11:40:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH v2] netfilter: nft_exthdr: Fix for unsafe packet data read
Date:   Tue,  8 Jun 2021 11:40:57 +0200
Message-Id: <20210608094057.24598-1-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

While iterating through an SCTP packet's chunks, skb_header_pointer() is
called for the minimum expected chunk header size. If (that part of) the
skbuff is non-linear, the following memcpy() may read data past
temporary buffer '_sch'. Use skb_copy_bits() instead which does the
right thing in this situation.

Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- skb_copy_bits() call error handling added
---
 net/netfilter/nft_exthdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 1b0579cb62d08..7f705b5c09de8 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -327,7 +327,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 				break;
 
 			dest[priv->len / NFT_REG32_SIZE] = 0;
-			memcpy(dest, (char *)sch + priv->offset, priv->len);
+			if (skb_copy_bits(pkt->skb, offset + priv->offset,
+					  dest, priv->len) < 0)
+				break;
 			return;
 		}
 		offset += SCTP_PAD4(ntohs(sch->length));
-- 
2.31.1

