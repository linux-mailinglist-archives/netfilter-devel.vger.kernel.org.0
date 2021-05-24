Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E825238F416
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 May 2021 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEXUKU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 May 2021 16:10:20 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58910 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhEXUKU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 May 2021 16:10:20 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 418A4641E0
        for <netfilter-devel@vger.kernel.org>; Mon, 24 May 2021 22:07:51 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables] expression: display an error on unknown datatype
Date:   Mon, 24 May 2021 22:08:45 +0200
Message-Id: <20210524200845.27732-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524200845.27732-1-pablo@netfilter.org>
References: <20210524200845.27732-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 # nft describe foo
 datatype foo is invalid

Fixes: 21cbab5b6ffe ("expression: extend 'nft describe' to allow listing data types")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/expression.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/expression.c b/src/expression.c
index 7ae075d23ee3..c91333631ad0 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -135,9 +135,12 @@ void expr_describe(const struct expr *expr, struct output_ctx *octx)
 		nft_print(octx, "datatype %s (%s)",
 			  dtype->name, dtype->desc);
 		len = dtype->size;
-	} else {
+	} else if (dtype != &invalid_type) {
 		nft_print(octx, "%s expression, datatype %s (%s)",
 			  expr_name(expr), dtype->name, dtype->desc);
+	} else {
+		nft_print(octx, "datatype %s is invalid\n", expr->identifier);
+		return;
 	}
 
 	if (dtype->basetype != NULL) {
-- 
2.20.1

