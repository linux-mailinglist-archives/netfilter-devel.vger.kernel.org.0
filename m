Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D907E06A
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Apr 2019 12:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfD2KTy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Apr 2019 06:19:54 -0400
Received: from mail.us.es ([193.147.175.20]:51510 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfD2KTy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:19:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0DFE3E8626
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Apr 2019 12:19:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F2881DA70A
        for <netfilter-devel@vger.kernel.org>; Mon, 29 Apr 2019 12:19:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E7655DA78D; Mon, 29 Apr 2019 12:19:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F40C0DA705;
        Mon, 29 Apr 2019 12:19:46 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 29 Apr 2019 12:19:46 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C29474265A32;
        Mon, 29 Apr 2019 12:19:46 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, ap420073@gmail.com
Subject: [PATCH nf] netfilter: nft_flow_offload: add entry to flowtable after confirmation
Date:   Mon, 29 Apr 2019 12:19:42 +0200
Message-Id: <20190429101942.7861-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is fixing flow offload for UDP traffic where packets only follow
one single direction.

The nf_ct_tcp_fixup() mechanism works fine in case that the offloaded
entry remains in SYN_RECV state, given sequence tracking is reset and
that conntrack handles syn+ack packets as a retransmission, ie.

	sES + synack => sIG

for reply traffic.

Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_flow_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 6e6b9adf7d38..8968c7f5a72e 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -94,8 +94,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (help)
 		goto out;
 
-	if (ctinfo == IP_CT_NEW ||
-	    ctinfo == IP_CT_RELATED)
+	if (!nf_ct_is_confirmed(ct))
 		goto out;
 
 	if (test_and_set_bit(IPS_OFFLOAD_BIT, &ct->status))
-- 
2.11.0

