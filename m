Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60E36F2FD
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Apr 2021 01:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhD2Xn5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 19:43:57 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59546 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhD2Xnx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:43:53 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 517B464148
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Apr 2021 01:42:26 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 10/18] evaluate: add set to the cache
Date:   Fri, 30 Apr 2021 01:42:47 +0200
Message-Id: <20210429234255.16840-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429234255.16840-1-pablo@netfilter.org>
References: <20210429234255.16840-1-pablo@netfilter.org>
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
index 8f35ca5935bc..02115101fec3 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3754,6 +3754,10 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
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

