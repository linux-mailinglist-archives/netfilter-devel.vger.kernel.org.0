Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31435218D
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Apr 2021 23:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDAVVe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 17:21:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53796 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhDAVVc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:21:32 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 31E5363E34
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Apr 2021 23:21:16 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] cache: check for NULL chain in cache_init()
Date:   Thu,  1 Apr 2021 23:21:28 +0200
Message-Id: <20210401212128.31768-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Another process might race to add chains after chain_cache_init().
The generation check does not help since it comes after cache_init().
NLM_F_DUMP_INTR only guarantees consistency within one single netlink
dump operation, so it does not help either (cache population requires
several netlink dump commands).

Let's be safe and do not assume the chain exists in the cache when
populating the rule cache.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/cache.c b/src/cache.c
index f7187ee7237f..5c21b8958a28 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -338,6 +338,9 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags)
 				if (!chain)
 					chain = chain_binding_lookup(table,
 							rule->handle.chain.name);
+				if (!chain)
+					goto cache_fails;
+
 				list_move_tail(&rule->list, &chain->rules);
 			}
 			if (ret < 0) {
-- 
2.20.1

