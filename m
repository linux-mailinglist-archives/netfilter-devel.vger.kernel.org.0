Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E07B52E00B
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 May 2022 00:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiESWej (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 May 2022 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiESWej (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 May 2022 18:34:39 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BED5BDA17
        for <netfilter-devel@vger.kernel.org>; Thu, 19 May 2022 15:34:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] netlink_delinearize: memleak when parsing concatenation data
Date:   Fri, 20 May 2022 00:34:33 +0200
Message-Id: <20220519223433.783136-1-pablo@netfilter.org>
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

netlink_get_register() clones the expression in the register,
release after using it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink_delinearize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 068c3bba1159..3bdd98d47eb0 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -200,6 +200,7 @@ static struct expr *netlink_parse_concat_data(struct netlink_parse_ctx *ctx,
 
 		len -= netlink_padded_len(expr->len);
 		reg += netlink_register_space(expr->len);
+		expr_free(expr);
 	}
 	return concat;
 
-- 
2.30.2

