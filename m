Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFC59127F
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Aug 2022 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbiHLOtE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Aug 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHLOtD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:49:03 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D040AB4CF
        for <netfilter-devel@vger.kernel.org>; Fri, 12 Aug 2022 07:49:02 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/2] netfilter: nf_tables: validate NFTA_SET_ELEM_KEY_END based on NFT_SET_CONCAT flag
Date:   Fri, 12 Aug 2022 16:48:52 +0200
Message-Id: <20220812144852.316952-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812144852.316952-1-pablo@netfilter.org>
References: <20220812144852.316952-1-pablo@netfilter.org>
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

If the NFT_SET_CONCAT flag is set on, then the netlink attribute
NFTA_SET_ELEM_KEY_END must be specified. Otherwise, NFTA_SET_ELEM_KEY_END
should not be present.

There are two special cases where NFTA_SET_ELEM_KEY_END is optional,
either if this is a closing interval element or this is a catch-all
element.

Fixes: 7b225d0b5c6d ("netfilter: nf_tables: add NFTA_SET_ELEM_KEY_END attribute")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bcfe8120e014..6e7eb47e14e9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5903,6 +5903,15 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			return -EINVAL;
 	}
 
+	if (set->flags & NFT_SET_CONCAT) {
+		if (!nla[NFTA_SET_ELEM_KEY_END] &&
+		    !(flags & (NFT_SET_ELEM_INTERVAL_END | NFT_SET_ELEM_CATCHALL)))
+			return -EINVAL;
+	} else {
+		if (nla[NFTA_SET_ELEM_KEY_END])
+			return -EINVAL;
+	}
+
 	if ((flags & NFT_SET_ELEM_INTERVAL_END) &&
 	     (nla[NFTA_SET_ELEM_DATA] ||
 	      nla[NFTA_SET_ELEM_OBJREF] ||
-- 
2.30.2

