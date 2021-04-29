Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5136F2FE
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Apr 2021 01:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhD2Xn5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 19:43:57 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59552 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhD2Xnx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:43:53 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9A7FC64133
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Apr 2021 01:42:26 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 11/18] evaluate: add flowtable to the cache
Date:   Fri, 30 Apr 2021 01:42:48 +0200
Message-Id: <20210429234255.16840-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429234255.16840-1-pablo@netfilter.org>
References: <20210429234255.16840-1-pablo@netfilter.org>
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
 1 file changed, 3 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 02115101fec3..f4c1acef0b16 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3961,6 +3961,9 @@ static int flowtable_evaluate(struct eval_ctx *ctx, struct flowtable *ft)
 	if (table == NULL)
 		return table_not_found(ctx);
 
+	if (!ft_cache_find(table, ft->handle.flowtable.name))
+		ft_cache_add(flowtable_get(ft), table);
+
 	if (ft->hook.name) {
 		ft->hook.num = str2hooknum(NFPROTO_NETDEV, ft->hook.name);
 		if (ft->hook.num == NF_INET_NUMHOOKS)
-- 
2.20.1

