Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95D86B3294
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Mar 2023 01:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCJAN2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Mar 2023 19:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCJAN0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:13:26 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0522164212
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Mar 2023 16:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OWIVI9DiPJoE7zAKpUDVjl15RlM03+oGoqrsWfAZBRA=; b=aiLC1cfvfYQzjuP5amaKOdupP9
        WANeU5PvJVrpPM/ujXnoTIGx1SjE0nUgZc+WOm0VQ+NrVIYnfxkAjJnUR3BW7cB8n5eI3algcT5XK
        Gl1q/m/YfoMLPLWxPi+WC3sRYDTv+m8UTjc6JDpKG/qgHaJ+vJAKoGZ5up+ffE/RCzX+rZx7+sHZl
        HtkC1f6i9xaQ6zrvlTsV1/ea0X0E+1mgUhRL1JRxR/EkpKGztSG3zBOviIfwAzA4bS0K4bdwAcsZb
        V5LRYif2xMMFDkgkX6FBMw82h3B3V+aA6spbHQ7AoUL1b/uGWshdi5mooU7R8HXSIVsx+0/2yJCmJ
        oauEB03A==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1paQNv-0003YI-0T; Fri, 10 Mar 2023 01:13:23 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] Reject invalid chain priority values in user space
Date:   Fri, 10 Mar 2023 01:13:14 +0100
Message-Id: <20230310001314.16957-1-phil@nwl.cc>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The kernel doesn't accept nat type chains with a priority of -200 or
below. Catch this and provide a better error message than the kernel's
EOPNOTSUPP.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/evaluate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index d24f8b66b0de8..af4844c1ef6cc 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4842,6 +4842,8 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 	}
 
 	if (chain->flags & CHAIN_F_BASECHAIN) {
+		int priority;
+
 		chain->hook.num = str2hooknum(chain->handle.family,
 					      chain->hook.name);
 		if (chain->hook.num == NF_INET_NUMHOOKS)
@@ -4854,6 +4856,14 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 			return __stmt_binary_error(ctx, &chain->priority.loc, NULL,
 						   "invalid priority expression %s in this context.",
 						   expr_name(chain->priority.expr));
+
+		if (!strcmp(chain->type.str, "nat") &&
+		    (mpz_export_data(&priority, chain->priority.expr->value,
+				    BYTEORDER_HOST_ENDIAN, sizeof(int))) &&
+		    priority <= -200)
+			return __stmt_binary_error(ctx, &chain->priority.loc, NULL,
+						   "Nat type chains must have a priority value above -200.");
+
 		if (chain->policy) {
 			expr_set_context(&ctx->ectx, &policy_type,
 					 NFT_NAME_MAXLEN * BITS_PER_BYTE);
-- 
2.38.0

