Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB9360A4A
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Apr 2021 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhDONOB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Apr 2021 09:14:01 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57882 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhDONOA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:14:00 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id BAB1E63E82
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Apr 2021 15:13:09 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 05/10] evaluate: add flowtable to the cache
Date:   Thu, 15 Apr 2021 15:13:25 +0200
Message-Id: <20210415131330.6692-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415131330.6692-1-pablo@netfilter.org>
References: <20210415131330.6692-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the cache does not contain this flowtable that is defined in this
batch, then add it to the cache. This allows for references to this new
flowtable in the same batch.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 3 +++
 src/rule.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index d0dfbabdf538..7b2d01c5dee1 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3925,6 +3925,9 @@ static int flowtable_evaluate(struct eval_ctx *ctx, struct flowtable *ft)
 	if (table == NULL)
 		return table_not_found(ctx);
 
+	if (ft_cache_find(table, ft->handle.flowtable.name) == NULL)
+		ft_cache_add(flowtable_get(ft), table);
+
 	if (ft->hook.name) {
 		ft->hook.num = str2hooknum(NFPROTO_NETDEV, ft->hook.name);
 		if (ft->hook.num == NF_INET_NUMHOOKS)
diff --git a/src/rule.c b/src/rule.c
index 414e53e7d2f6..a6909fc75060 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -2247,7 +2247,7 @@ struct flowtable *flowtable_lookup_fuzzy(const char *ft_name,
 	string_misspell_init(&st);
 
 	list_for_each_entry(table, &cache->list, list) {
-		list_for_each_entry(ft, &table->flowtables, list) {
+		list_for_each_entry(ft, &table->cache_ft, cache_list) {
 			if (!strcmp(ft->handle.flowtable.name, ft_name)) {
 				*t = table;
 				return ft;
-- 
2.20.1

