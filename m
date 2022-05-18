Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC652C1D4
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 20:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiERSFH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiERSFE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 14:05:04 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58A7A2218C7
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 11:05:03 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: nf_tables: set element extended ACK reporting support
Date:   Wed, 18 May 2022 20:04:59 +0200
Message-Id: <20220518180459.298532-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Report the element that causes problems via netlink extended ACK for set
element commands.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a096b9fbbbdf..ceb5b5258930 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5344,8 +5344,10 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 
 	return err;
@@ -6125,8 +6127,10 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_add_set_elem(&ctx, set, attr, info->nlh->nlmsg_flags);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return err;
+		}
 	}
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
@@ -6396,8 +6400,10 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_del_setelem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 	return err;
 }
-- 
2.30.2

