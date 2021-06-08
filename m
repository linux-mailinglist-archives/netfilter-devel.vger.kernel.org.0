Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6986B39F163
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 10:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFHIwt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFHIwt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:52:49 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E86C061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 01:50:56 -0700 (PDT)
Received: from localhost ([::1]:59728 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lqXRl-0006RU-Cf; Tue, 08 Jun 2021 10:50:53 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH] netfilter: nft_exthdr: Fix for unsafe packet data read
Date:   Tue,  8 Jun 2021 10:51:04 +0200
Message-Id: <20210608085104.6249-1-phil@nwl.cc>
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
 net/netfilter/nft_exthdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 1b0579cb62d08..2b976687510d8 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -327,7 +327,8 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 				break;
 
 			dest[priv->len / NFT_REG32_SIZE] = 0;
-			memcpy(dest, (char *)sch + priv->offset, priv->len);
+			skb_copy_bits(pkt->skb, offset + priv->offset,
+				      dest, priv->len);
 			return;
 		}
 		offset += SCTP_PAD4(ntohs(sch->length));
-- 
2.31.1

