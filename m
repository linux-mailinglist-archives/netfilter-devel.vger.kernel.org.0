Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C321D563DB3
	for <lists+netfilter-devel@lfdr.de>; Sat,  2 Jul 2022 04:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGBCQn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 Jul 2022 22:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBCQn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 Jul 2022 22:16:43 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C27C438183
        for <netfilter-devel@vger.kernel.org>; Fri,  1 Jul 2022 19:16:41 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] netfilter: nf_tables: stricter validation of element data
Date:   Sat,  2 Jul 2022 04:16:30 +0200
Message-Id: <20220702021631.796822-1-pablo@netfilter.org>
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

Make sure element data type and length do not mismatch the one specified
by the set declaration.

Reported-by: Hugues ANGUELKOV <hanguelkov@randorisec.fr>
Fixes: 7d7402642eaf ("netfilter: nf_tables: variable sized set element keys / data")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 51144fc66889..d6b59beab3a9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5213,13 +5213,20 @@ static int nft_setelem_parse_data(struct nft_ctx *ctx, struct nft_set *set,
 				  struct nft_data *data,
 				  struct nlattr *attr)
 {
+	u32 dtype;
 	int err;
 
 	err = nft_data_init(ctx, data, NFT_DATA_VALUE_MAXLEN, desc, attr);
 	if (err < 0)
 		return err;
 
-	if (desc->type != NFT_DATA_VERDICT && desc->len != set->dlen) {
+	if (set->dtype == NFT_DATA_VERDICT)
+		dtype = NFT_DATA_VERDICT;
+	else
+		dtype = NFT_DATA_VALUE;
+
+	if (dtype != desc->type ||
+	    set->dlen != desc->len) {
 		nft_data_release(data, desc->type);
 		return -EINVAL;
 	}
-- 
2.30.2

