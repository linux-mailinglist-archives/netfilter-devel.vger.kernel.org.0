Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2079F360A49
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Apr 2021 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhDONOA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Apr 2021 09:14:00 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57880 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhDONOA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:14:00 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6C4B963E81
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Apr 2021 15:13:09 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 04/10] evaluate: add set to the cache
Date:   Thu, 15 Apr 2021 15:13:24 +0200
Message-Id: <20210415131330.6692-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415131330.6692-1-pablo@netfilter.org>
References: <20210415131330.6692-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the cache does not contain the set that is defined in this batch, add
it to the cache. This allows for references to this new set in the same
batch.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index a516a01ffc30..d0dfbabdf538 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3718,6 +3718,10 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 	if (table == NULL)
 		return table_not_found(ctx);
 
+	if (!(set->flags & NFT_SET_ANONYMOUS) &&
+	    !set_cache_find(table, set->handle.set.name))
+		set_cache_add(set_get(set), table);
+
 	if (!(set->flags & NFT_SET_INTERVAL) && set->automerge)
 		return set_error(ctx, set, "auto-merge only works with interval sets");
 
-- 
2.20.1

