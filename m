Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C647591AEC
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Aug 2022 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiHMOZp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 13 Aug 2022 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbiHMOZm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:25:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A03E763AB
        for <netfilter-devel@vger.kernel.org>; Sat, 13 Aug 2022 07:25:41 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: disallow NFT_SET_ELEM_CATCHALL and NFT_SET_ELEM_INTERVAL_END
Date:   Sat, 13 Aug 2022 16:25:35 +0200
Message-Id: <20220813142535.503521-1-pablo@netfilter.org>
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

These flags are mutually exclusive, report EINVAL in this case.

Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 29fe6fd41799..d044ef556e68 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5198,6 +5198,9 @@ static int nft_setelem_parse_flags(const struct nft_set *set,
 	if (!(set->flags & NFT_SET_INTERVAL) &&
 	    *flags & NFT_SET_ELEM_INTERVAL_END)
 		return -EINVAL;
+	if ((*flags & (NFT_SET_ELEM_INTERVAL_END | NFT_SET_ELEM_CATCHALL)) ==
+	    (NFT_SET_ELEM_INTERVAL_END | NFT_SET_ELEM_CATCHALL))
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.30.2

