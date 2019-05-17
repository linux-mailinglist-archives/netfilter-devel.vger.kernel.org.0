Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2ED2209E
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 May 2019 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfEQXAp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 May 2019 19:00:45 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:57044 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfEQXAo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 May 2019 19:00:44 -0400
Received: from localhost ([::1]:41900 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hRlqF-0007G2-BS; Sat, 18 May 2019 01:00:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: [nft PATCH 1/3] src: Improve cache_needs_more() algorithm
Date:   Sat, 18 May 2019 01:00:31 +0200
Message-Id: <20190517230033.25417-2-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517230033.25417-1-phil@nwl.cc>
References: <20190517230033.25417-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The old logic wasn't optimal: If e.g. current command was CMD_RESET and
old command was CMD_LIST, cache was already fully populated but still
refreshed.

Introduce a simple scoring system which reflects how
cache_init_objects() looks at the current command to decide if it is
finished already or not. Then use that in cache_needs_more(): If current
commands score is higher than old command's, cache needs an update.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/rule.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/rule.c b/src/rule.c
index afe37cd90b1da..17bf5bbbe680c 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -220,13 +220,21 @@ static int cache_init(struct netlink_ctx *ctx, enum cmd_ops cmd)
 	return 0;
 }
 
-static int cache_needs_more(enum cmd_ops old_cmd, enum cmd_ops cmd)
+/* Return a "score" of how complete local cache will be if
+ * cache_init_objects() ran for given cmd. Higher value
+ * means more complete. */
+static int cache_completeness(enum cmd_ops cmd)
 {
-	if (cmd == CMD_LIST && old_cmd != CMD_LIST)
-		return 1;
-	if (cmd == CMD_RESET && old_cmd != CMD_RESET)
-		return 1;
-	return 0;
+	if (cmd == CMD_LIST)
+		return 3;
+	if (cmd != CMD_RESET)
+		return 2;
+	return 1;
+}
+
+static bool cache_needs_more(enum cmd_ops old_cmd, enum cmd_ops cmd)
+{
+	return cache_completeness(old_cmd) < cache_completeness(cmd);
 }
 
 int cache_update(struct nft_ctx *nft, enum cmd_ops cmd, struct list_head *msgs)
-- 
2.21.0

