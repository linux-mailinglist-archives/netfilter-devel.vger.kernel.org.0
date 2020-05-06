Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910D01C6D77
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgEFJqs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 May 2020 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726935AbgEFJqs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 May 2020 05:46:48 -0400
Received: from smail.fem.tu-ilmenau.de (smail.fem.tu-ilmenau.de [IPv6:2001:638:904:ffbf::41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58FDC061A0F
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 02:46:47 -0700 (PDT)
Received: from mail.fem.tu-ilmenau.de (mail-zuse.net.fem.tu-ilmenau.de [172.21.220.54])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smail.fem.tu-ilmenau.de (Postfix) with ESMTPS id DB25620033;
        Wed,  6 May 2020 11:46:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.fem.tu-ilmenau.de (Postfix) with ESMTP id B3EC96226;
        Wed,  6 May 2020 11:46:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at fem.tu-ilmenau.de
Received: from mail.fem.tu-ilmenau.de ([127.0.0.1])
        by localhost (mail.fem.tu-ilmenau.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kfobGYzAmS9N; Wed,  6 May 2020 11:46:42 +0200 (CEST)
Received: from mail-backup.fem.tu-ilmenau.de (mail-backup.net.fem.tu-ilmenau.de [10.42.40.22])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.fem.tu-ilmenau.de (Postfix) with ESMTPS;
        Wed,  6 May 2020 11:46:42 +0200 (CEST)
Received: from a234.fem.tu-ilmenau.de (ray-controller.net.fem.tu-ilmenau.de [10.42.51.234])
        by mail-backup.fem.tu-ilmenau.de (Postfix) with ESMTP id C4FD056053;
        Wed,  6 May 2020 11:46:42 +0200 (CEST)
Received: by a234.fem.tu-ilmenau.de (Postfix, from userid 1000)
        id BF146306A950; Wed,  6 May 2020 11:46:42 +0200 (CEST)
From:   Michael Braun <michael-dev@fami-braun.de>
To:     netfilter-devel@vger.kernel.org
Cc:     Michael Braun <michael-dev@fami-braun.de>
Subject: [PATCH 2/3] nftables: enable reject with 802.1q
Date:   Wed,  6 May 2020 11:46:24 +0200
Message-Id: <ab66a06ae60d84577e0802ab989658d7b651d7a2.1588758255.git.michael-dev@fami-braun.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588758255.git.michael-dev@fami-braun.de>
References: <cover.1588758255.git.michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This enables the use nft bridge reject with bridge vlan filtering.

It depends on a kernel patch to make the kernel preserve the
vlan id in nft bridge reject generation.

Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index ec96dd58..20849ef3 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2635,7 +2635,7 @@ static int stmt_evaluate_reject_bridge(struct eval_ctx *ctx, struct stmt *stmt,
 	const struct proto_desc *desc;
 
 	desc = ctx->pctx.protocol[PROTO_BASE_LL_HDR].desc;
-	if (desc != &proto_eth)
+	if (desc != &proto_eth && desc != &proto_vlan)
 		return stmt_binary_error(ctx,
 					 &ctx->pctx.protocol[PROTO_BASE_LL_HDR],
 					 stmt, "unsupported link layer protocol");
-- 
2.20.1

