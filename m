Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4325E2D0D1
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 May 2019 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE1VDs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 May 2019 17:03:48 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:38470 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfE1VDr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 May 2019 17:03:47 -0400
Received: from localhost ([::1]:51558 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hVjG6-0002KL-CE; Tue, 28 May 2019 23:03:46 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: [nft PATCH v4 5/7] rule: Introduce rule_lookup_by_index()
Date:   Tue, 28 May 2019 23:03:21 +0200
Message-Id: <20190528210323.14605-6-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528210323.14605-1-phil@nwl.cc>
References: <20190528210323.14605-1-phil@nwl.cc>
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
index 61aa040a2e891..a7dd042d60e3f 100644
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
index 78e0388e41e93..dc2dd3628b17f 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -716,6 +716,17 @@ struct rule *rule_lookup(const struct chain *chain, uint64_t handle)
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

