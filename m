Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 462712D0D3
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 May 2019 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfE1VD6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 May 2019 17:03:58 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:38486 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbfE1VD6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 May 2019 17:03:58 -0400
Received: from localhost ([::1]:51574 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hVjGH-0002LB-8U; Tue, 28 May 2019 23:03:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: [nft PATCH v4 3/7] src: Make {table,chain}_not_found() public
Date:   Tue, 28 May 2019 23:03:19 +0200
Message-Id: <20190528210323.14605-4-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528210323.14605-1-phil@nwl.cc>
References: <20190528210323.14605-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/rule.h | 3 +++
 src/evaluate.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/rule.h b/include/rule.h
index 8e70c129fcce0..61aa040a2e891 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -646,4 +646,7 @@ struct timeout_protocol {
 extern struct timeout_protocol timeout_protocol[IPPROTO_MAX];
 extern int timeout_str2num(uint16_t l4proto, struct timeout_state *ts);
 
+int table_not_found(struct eval_ctx *ctx);
+int chain_not_found(struct eval_ctx *ctx);
+
 #endif /* NFTABLES_RULE_H */
diff --git a/src/evaluate.c b/src/evaluate.c
index 55fb3b6131e04..09bb1fd37a301 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -166,7 +166,7 @@ static struct table *table_lookup_global(struct eval_ctx *ctx)
 	return table;
 }
 
-static int table_not_found(struct eval_ctx *ctx)
+int table_not_found(struct eval_ctx *ctx)
 {
 	struct table *table;
 
@@ -181,7 +181,7 @@ static int table_not_found(struct eval_ctx *ctx)
 			 family2str(table->handle.family));
 }
 
-static int chain_not_found(struct eval_ctx *ctx)
+int chain_not_found(struct eval_ctx *ctx)
 {
 	const struct table *table;
 	struct chain *chain;
-- 
2.21.0

