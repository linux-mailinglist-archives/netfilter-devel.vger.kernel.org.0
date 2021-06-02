Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB45C39965A
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Jun 2021 01:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFBX3e (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 19:29:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43160 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBX3d (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 19:29:33 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2DD56641FF
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Jun 2021 01:26:42 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] statement: connlimit: remove extra whitespace in print function
Date:   Thu,  3 Jun 2021 01:27:46 +0200
Message-Id: <20210602232746.15791-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of:

 ct count 2  accept
           ^^

simply print:

 ct count 2 accept

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/statement.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/statement.c b/src/statement.c
index f7f1c0c4d553..7537c07f495c 100644
--- a/src/statement.c
+++ b/src/statement.c
@@ -201,7 +201,7 @@ struct stmt *meter_stmt_alloc(const struct location *loc)
 
 static void connlimit_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
 {
-	nft_print(octx, "ct count %s%u ",
+	nft_print(octx, "ct count %s%u",
 		  stmt->connlimit.flags ? "over " : "", stmt->connlimit.count);
 }
 
-- 
2.20.1

