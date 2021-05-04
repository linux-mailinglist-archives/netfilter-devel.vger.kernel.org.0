Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F5372E60
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 May 2021 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhEDRC7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 May 2021 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhEDRC7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 May 2021 13:02:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626BC061574
        for <netfilter-devel@vger.kernel.org>; Tue,  4 May 2021 10:02:04 -0700 (PDT)
Received: from localhost ([::1]:42766 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1ldyQs-0008Cv-QL; Tue, 04 May 2021 19:02:02 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/3] json: Simplify non-tcpopt exthdr printing a bit
Date:   Tue,  4 May 2021 19:01:47 +0200
Message-Id: <20210504170148.25226-2-phil@nwl.cc>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210504170148.25226-1-phil@nwl.cc>
References: <20210504170148.25226-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This was just duplicate code apart from the object's name.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/json.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/src/json.c b/src/json.c
index 52603a57de508..93decfe6a279e 100644
--- a/src/json.c
+++ b/src/json.c
@@ -697,21 +697,17 @@ json_t *exthdr_expr_json(const struct expr *expr, struct output_ctx *octx)
 
 		return json_pack("{s:o}", "tcp option", root);
 	}
-	if (expr->exthdr.op == NFT_EXTHDR_OP_IPV4) {
-		root = json_pack("{s:s}", "name", desc);
 
-		if (!is_exists)
-			json_object_set_new(root, "field", json_string(field));
-
-		return json_pack("{s:o}", "ip option", root);
-	}
-
-	root = json_pack("{s:s}",
-			 "name", desc);
+	root = json_pack("{s:s}", "name", desc);
 	if (!is_exists)
 		json_object_set_new(root, "field", json_string(field));
 
-	return json_pack("{s:o}", "exthdr", root);
+	switch (expr->exthdr.op) {
+	case NFT_EXTHDR_OP_IPV4:
+		return json_pack("{s:o}", "ip option", root);
+	default:
+		return json_pack("{s:o}", "exthdr", root);
+	}
 }
 
 json_t *verdict_expr_json(const struct expr *expr, struct output_ctx *octx)
-- 
2.31.0

