Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAF392F8
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfFGRVr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:21:47 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35946 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbfFGRVr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:21:47 -0400
Received: from localhost ([::1]:49036 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIYj-0006uE-Lk; Fri, 07 Jun 2019 19:21:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH v6 3/5] rule: Introduce rule_lookup_by_index()
Date:   Fri,  7 Jun 2019 19:21:19 +0200
Message-Id: <20190607172121.21752-4-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607172121.21752-1-phil@nwl.cc>
References: <20190607172121.21752-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In contrast to rule_lookup(), this function returns a chain's rule at a
given index instead of by handle.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/rule.h |  2 ++
 src/rule.c     | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/rule.h b/include/rule.h
index bf3f39636efb5..87b440b63ba5c 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -260,6 +260,8 @@ extern struct rule *rule_get(struct rule *rule);
 extern void rule_free(struct rule *rule);
 extern void rule_print(const struct rule *rule, struct output_ctx *octx);
 extern struct rule *rule_lookup(const struct chain *chain, uint64_t handle);
+extern struct rule *rule_lookup_by_index(const struct chain *chain,
+					 uint64_t index);
 
 /**
  * struct set - nftables set
diff --git a/src/rule.c b/src/rule.c
index e570238a40f5b..20fe6f3758cbc 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -641,6 +641,17 @@ struct rule *rule_lookup(const struct chain *chain, uint64_t handle)
 	return NULL;
 }
 
+struct rule *rule_lookup_by_index(const struct chain *chain, uint64_t index)
+{
+	struct rule *rule;
+
+	list_for_each_entry(rule, &chain->rules, list) {
+		if (!--index)
+			return rule;
+	}
+	return NULL;
+}
+
 struct scope *scope_init(struct scope *scope, const struct scope *parent)
 {
 	scope->parent = parent;
-- 
2.21.0

