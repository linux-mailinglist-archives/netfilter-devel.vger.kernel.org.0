Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9133A667C
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Jun 2021 14:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhFNM1B (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Jun 2021 08:27:01 -0400
Received: from mail.netfilter.org ([217.70.188.207]:41284 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhFNM1B (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:27:01 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 92ACF6420F;
        Mon, 14 Jun 2021 14:23:40 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nftables] evaluate: add set to cache once
Date:   Mon, 14 Jun 2021 14:24:54 +0200
Message-Id: <20210614122454.27902-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

67d3969a7244 ("evaluate: add set to the cache") re-adds the set into the
cache again.

This bug was hidden behind 5ec5c706d993 ("cache: add hashtable cache for
table") which broken set_evaluate() for anonymous sets.

Phil reported a gcc compilation warning which uncovered this problem.

Reported-by: Phil Sutter <phil@nwl.cc>
Fixes: 67d3969a7244 ("evaluate: add set to the cache")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 5311963a20c5..92cc8994c809 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3867,9 +3867,6 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 	}
 	ctx->set = NULL;
 
-	if (set_cache_find(table, set->handle.set.name) == NULL)
-		set_cache_add(set_get(set), table);
-
 	return 0;
 }
 
-- 
2.20.1

