Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4056478A28
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Dec 2021 12:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhLQLiw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Dec 2021 06:38:52 -0500
Received: from mail.netfilter.org ([217.70.188.207]:60830 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhLQLiu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:38:50 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 40388607C1;
        Fri, 17 Dec 2021 12:36:18 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH nf-next,v2 3/5] netfilter: nf_tables: consolidate rule verdict trace call
Date:   Fri, 17 Dec 2021 12:38:35 +0100
Message-Id: <20211217113837.1253-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217113837.1253-1-pablo@netfilter.org>
References: <20211217113837.1253-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add function to consolidate verdict tracing.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 net/netfilter/nf_tables_core.c | 39 ++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 41c7509955e6..d026890a9842 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -67,6 +67,36 @@ static void nft_cmp_fast_eval(const struct nft_expr *expr,
 	regs->verdict.code = NFT_BREAK;
 }
 
+static noinline void __nft_trace_verdict(struct nft_traceinfo *info,
+					 const struct nft_chain *chain,
+					 const struct nft_regs *regs)
+{
+	enum nft_trace_types type;
+
+	switch (regs->verdict.code) {
+	case NFT_CONTINUE:
+	case NFT_RETURN:
+		type = NFT_TRACETYPE_RETURN;
+		break;
+	default:
+		type = NFT_TRACETYPE_RULE;
+		break;
+	}
+
+	__nft_trace_packet(info, chain, type);
+}
+
+static inline void nft_trace_verdict(struct nft_traceinfo *info,
+				     const struct nft_chain *chain,
+				     const struct nft_rule *rule,
+				     const struct nft_regs *regs)
+{
+	if (static_branch_unlikely(&nft_trace_enabled)) {
+		info->rule = rule;
+		__nft_trace_verdict(info, chain, regs);
+	}
+}
+
 static bool nft_payload_fast_eval(const struct nft_expr *expr,
 				  struct nft_regs *regs,
 				  const struct nft_pktinfo *pkt)
@@ -205,13 +235,13 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 		break;
 	}
 
+	nft_trace_verdict(&info, chain, rule, &regs);
+
 	switch (regs.verdict.code & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
 	case NF_DROP:
 	case NF_QUEUE:
 	case NF_STOLEN:
-		nft_trace_packet(&info, chain, rule,
-				 NFT_TRACETYPE_RULE);
 		return regs.verdict.code;
 	}
 
@@ -224,15 +254,10 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 		stackptr++;
 		fallthrough;
 	case NFT_GOTO:
-		nft_trace_packet(&info, chain, rule,
-				 NFT_TRACETYPE_RULE);
-
 		chain = regs.verdict.chain;
 		goto do_chain;
 	case NFT_CONTINUE:
 	case NFT_RETURN:
-		nft_trace_packet(&info, chain, rule,
-				 NFT_TRACETYPE_RETURN);
 		break;
 	default:
 		WARN_ON(1);
-- 
2.30.2

