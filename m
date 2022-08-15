Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E10959336C
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Aug 2022 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiHOQqJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Aug 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHOQqI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:46:08 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10F95640F
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Aug 2022 09:46:08 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2] netfilter: nf_tables: check NFT_SET_CONCAT flag if field_count is specified
Date:   Mon, 15 Aug 2022 18:46:02 +0200
Message-Id: <20220815164602.305258-1-pablo@netfilter.org>
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

Since f3a2181e16f1 ("netfilter: nf_tables: Support for sets with
multiple ranged fields"), it possible to combine intervals and
concatenations. Later on, ef516e8625dd ("netfilter: nf_tables:
reintroduce the NFT_SET_CONCAT flag") provides the NFT_SET_CONCAT flag
for userspace to report that the set stores a concatenation.

Make sure NFT_SET_CONCAT is set on if field_count is specified for
consistency. Otherwise, if NFT_SET_CONCAT is specified with no
field_count, bail out with EINVAL.

Fixes: ef516e8625dd ("netfilter: nf_tables: reintroduce the NFT_SET_CONCAT flag")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: missing check for NFT_SET_CONCAT flag and unset field_count.

 net/netfilter/nf_tables_api.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b1b12e083abb..62cfb0e31c40 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4451,6 +4451,11 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		err = nf_tables_set_desc_parse(&desc, nla[NFTA_SET_DESC]);
 		if (err < 0)
 			return err;
+
+		if (desc.field_count > 1 && !(flags & NFT_SET_CONCAT))
+			return -EINVAL;
+	} else if (flags & NFT_SET_CONCAT) {
+		return -EINVAL;
 	}
 
 	if (nla[NFTA_SET_EXPR] || nla[NFTA_SET_EXPRESSIONS])
-- 
2.30.2

