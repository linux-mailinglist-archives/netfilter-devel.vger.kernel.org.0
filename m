Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5F533F9E4
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Mar 2021 21:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhCQUUY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Mar 2021 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCQUUE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:20:04 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E224C06174A
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 13:20:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id F3C0D62BA5
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 21:19:59 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/2] netfilter: nftables: missing transaction object on flowtable deletion
Date:   Wed, 17 Mar 2021 21:19:56 +0100
Message-Id: <20210317201957.13165-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The delete flowtable command does not create a transaction if the
NFTA_FLOWTABLE_HOOK attribute is specified, hence, the flowtable
is never deleted.

Fixes: abadb2f865d7 ("netfilter: nf_tables: delete devices from flowtable")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 224c8e537cb3..6b97a0c7b6d3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7090,6 +7090,7 @@ static int nf_tables_delflowtable(struct net *net, struct sock *nlsk,
 	const struct nlattr *attr;
 	struct nft_table *table;
 	struct nft_ctx ctx;
+	int err;
 
 	if (!nla[NFTA_FLOWTABLE_TABLE] ||
 	    (!nla[NFTA_FLOWTABLE_NAME] &&
@@ -7118,8 +7119,11 @@ static int nf_tables_delflowtable(struct net *net, struct sock *nlsk,
 
 	nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
 
-	if (nla[NFTA_FLOWTABLE_HOOK])
-		return nft_delflowtable_hook(&ctx, flowtable);
+	if (nla[NFTA_FLOWTABLE_HOOK]) {
+		err = nft_delflowtable_hook(&ctx, flowtable);
+		if (err < 0)
+			return err;
+	}
 
 	if (flowtable->use > 0) {
 		NL_SET_BAD_ATTR(extack, attr);
-- 
2.20.1

