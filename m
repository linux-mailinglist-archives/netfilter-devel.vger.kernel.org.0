Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE404886AD
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Jan 2022 23:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiAHW0v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Jan 2022 17:26:51 -0500
Received: from mail.netfilter.org ([217.70.188.207]:40118 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiAHW0t (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:26:49 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1CCBA64292
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Jan 2022 23:23:59 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 08/14] netfilter: nf_tables: add NFT_REG32_NUM
Date:   Sat,  8 Jan 2022 23:26:32 +0100
Message-Id: <20220108222638.36037-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108222638.36037-1-pablo@netfilter.org>
References: <20220108222638.36037-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a definition including the maximum number of 32-bits registers that
are used a scratchpad memory area to store data.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 5a046b01bdab..515e5db97e01 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -105,6 +105,8 @@ struct nft_data {
 	};
 } __attribute__((aligned(__alignof__(u64))));
 
+#define NFT_REG32_NUM		20
+
 /**
  *	struct nft_regs - nf_tables register set
  *
@@ -115,7 +117,7 @@ struct nft_data {
  */
 struct nft_regs {
 	union {
-		u32			data[20];
+		u32			data[NFT_REG32_NUM];
 		struct nft_verdict	verdict;
 	};
 };
-- 
2.30.2

