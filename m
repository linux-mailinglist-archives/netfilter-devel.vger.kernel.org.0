Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380B367C3B
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jul 2019 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfGMWF7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 13 Jul 2019 18:05:59 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45290 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727968AbfGMWF7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 13 Jul 2019 18:05:59 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hmQ9V-0004ic-8x; Sun, 14 Jul 2019 00:05:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_tables: don't fail when updating base chain policy
Date:   Sat, 13 Jul 2019 23:59:21 +0200
Message-Id: <20190713215921.18696-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The following nftables test case fails on nf-next:

tests/shell/run-tests.sh tests/shell/testcases/transactions/0011chain_0

The test case contains:
add chain x y { type filter hook input priority 0; }
add chain x y { policy drop; }"

The new test
if (chain->flags ^ flags)
	return -EOPNOTSUPP;

triggers here, because chain->flags has NFT_BASE_CHAIN set, but flags
is 0 because no flag attribute was present in the policy update.

Just fetch the current flag settings of a pre-existing chain in case
userspace did not provide any.

Fixes: c9626a2cbdb20 ("netfilter: nf_tables: add hardware offload support")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index add64bd227a8..5746a7c948fe 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1914,6 +1914,8 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 
 	if (nla[NFTA_CHAIN_FLAGS])
 		flags = ntohl(nla_get_be32(nla[NFTA_CHAIN_FLAGS]));
+	else if (chain)
+		flags = chain->flags;
 
 	nft_ctx_init(&ctx, net, skb, nlh, family, table, chain, nla);
 
-- 
2.21.0

