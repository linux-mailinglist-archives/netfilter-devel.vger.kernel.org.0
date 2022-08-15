Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC0F5932D7
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Aug 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiHOQRo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Aug 2022 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiHOQRn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:17:43 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AA40167C1
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Aug 2022 09:17:42 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v4 2/2] netfilter: nf_tables: NFTA_SET_ELEM_KEY_END requires concat and interval flags
Date:   Mon, 15 Aug 2022 18:17:35 +0200
Message-Id: <20220815161735.199502-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the NFT_SET_CONCAT|NFT_SET_INTERVAL flags are set on, then the
netlink attribute NFTA_SET_ELEM_KEY_END must be specified. Otherwise,
NFTA_SET_ELEM_KEY_END should not be present.

For catch-all element, NFTA_SET_ELEM_KEY_END should not be present.
The NFT_SET_ELEM_INTERVAL_END is never used with this set flags
combination.

Fixes: 7b225d0b5c6d ("netfilter: nf_tables: add NFTA_SET_ELEM_KEY_END attribute")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v4: check delete set element path too.

 net/netfilter/nf_tables_api.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bcfe8120e014..1d14d694f654 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5844,6 +5844,24 @@ static void nft_setelem_remove(const struct net *net,
 		set->ops->remove(net, set, elem);
 }
 
+static bool nft_setelem_valid_key_end(const struct nft_set *set,
+				      struct nlattr **nla, u32 flags)
+{
+	if ((set->flags & (NFT_SET_CONCAT | NFT_SET_INTERVAL)) ==
+			  (NFT_SET_CONCAT | NFT_SET_INTERVAL)) {
+		if (flags & NFT_SET_ELEM_INTERVAL_END)
+			return false;
+		if (!nla[NFTA_SET_ELEM_KEY_END] &&
+		    !(flags & NFT_SET_ELEM_CATCHALL))
+			return false;
+	} else {
+		if (nla[NFTA_SET_ELEM_KEY_END])
+			return false;
+	}
+
+	return true;
+}
+
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
 {
@@ -5903,6 +5921,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			return -EINVAL;
 	}
 
+	if (!nft_setelem_valid_key_end(set, nla, flags))
+		return -EINVAL;
+
 	if ((flags & NFT_SET_ELEM_INTERVAL_END) &&
 	     (nla[NFTA_SET_ELEM_DATA] ||
 	      nla[NFTA_SET_ELEM_OBJREF] ||
@@ -6333,6 +6354,9 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 	if (!nla[NFTA_SET_ELEM_KEY] && !(flags & NFT_SET_ELEM_CATCHALL))
 		return -EINVAL;
 
+	if (!nft_setelem_valid_key_end(set, nla, flags))
+		return -EINVAL;
+
 	nft_set_ext_prepare(&tmpl);
 
 	if (flags != 0) {
-- 
2.30.2

