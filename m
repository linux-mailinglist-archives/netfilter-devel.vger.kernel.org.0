Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2403A2E04
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Jun 2021 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhFJOZA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Jun 2021 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFJOZA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:25:00 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4F1C061574
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Jun 2021 07:23:04 -0700 (PDT)
Received: from localhost ([::1]:38098 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrLaH-00006I-CP; Thu, 10 Jun 2021 16:23:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH] netfilter: nft_exthdr: Search chunks in SCTP packets only
Date:   Thu, 10 Jun 2021 16:23:16 +0200
Message-Id: <20210610142316.24354-1-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since user space does not generate a payload dependency, plain sctp
chunk matches cause searching in non-SCTP packets, too. Avoid this
potential mis-interpretation of packet data by checking pkt->tprot.

Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nft_exthdr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 7f705b5c09de8..1093bb83f8aeb 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -312,6 +312,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 	const struct sctp_chunkhdr *sch;
 	struct sctp_chunkhdr _sch;
 
+	if (!pkt->tprot_set || pkt->tprot != IPPROTO_SCTP)
+		goto err;
+
 	do {
 		sch = skb_header_pointer(pkt->skb, offset, sizeof(_sch), &_sch);
 		if (!sch || !sch->length)
@@ -334,7 +337,7 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 		}
 		offset += SCTP_PAD4(ntohs(sch->length));
 	} while (offset < pkt->skb->len);
-
+err:
 	if (priv->flags & NFT_EXTHDR_F_PRESENT)
 		nft_reg_store8(dest, false);
 	else
-- 
2.31.1

