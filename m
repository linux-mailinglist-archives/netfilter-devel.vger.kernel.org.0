Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00D13A477C
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFKRKK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 13:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhFKRKJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:10:09 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9522C061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 10:08:11 -0700 (PDT)
Received: from localhost ([::1]:41424 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkde-0005qG-3d; Fri, 11 Jun 2021 19:08:10 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nf-next PATCH] netfilter: nft_extdhr: Drop pointless check of tprot_set
Date:   Fri, 11 Jun 2021 19:08:26 +0200
Message-Id: <20210611170826.11412-1-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo says, tprot_set is only there to detect if tprot was set to
IPPROTO_IP as that evaluates to zero. Therefore, code asserting a
different value in tprot does not need to check tprot_set.

Fixes: 935b7f6430188 ("netfilter: nft_exthdr: add TCP option matching")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nft_exthdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 9cf86be2cff4b..4f583d2e220e4 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -164,7 +164,7 @@ nft_tcp_header_pointer(const struct nft_pktinfo *pkt,
 {
 	struct tcphdr *tcph;
 
-	if (!pkt->tprot_set || pkt->tprot != IPPROTO_TCP)
+	if (pkt->tprot != IPPROTO_TCP)
 		return NULL;
 
 	tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt), sizeof(*tcph), buffer);
-- 
2.31.1

