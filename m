Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC727773B
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Sep 2020 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgIXQyB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Sep 2020 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIXQyA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:54:00 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABC8C0613CE
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Sep 2020 09:54:00 -0700 (PDT)
Received: from localhost ([::1]:56662 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kLUVJ-0002hn-8s; Thu, 24 Sep 2020 18:53:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] evaluate: Reject quoted strings containing only wildcard
Date:   Thu, 24 Sep 2020 19:06:39 +0200
Message-Id: <20200924170639.15842-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix for an assertion fail when trying to match against an all-wildcard
interface name:

| % nft add rule t c iifname '"*"'
| nft: expression.c:402: constant_expr_alloc: Assertion `(((len) + (8) - 1) / (8)) > 0' failed.
| zsh: abort      nft add rule t c iifname '"*"'

Fix this by detecting the string in expr_evaluate_string() and returning
an error message:

| % nft add rule t c iifname '"*"'
| Error: All-wildcard strings are not supported
| add rule t c iifname "*"
|                      ^^^

While being at it, drop the 'datalen >= 1' clause from the following
conditional as together with the added check for 'datalen == 0', all
possible other values have been caught already.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/evaluate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index c8045e5ded729..5f17d7501ac0e 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -324,8 +324,11 @@ static int expr_evaluate_string(struct eval_ctx *ctx, struct expr **exprp)
 		return 0;
 	}
 
-	if (datalen >= 1 &&
-	    data[datalen - 1] == '\\') {
+	if (datalen == 0)
+		return expr_error(ctx->msgs, expr,
+				  "All-wildcard strings are not supported");
+
+	if (data[datalen - 1] == '\\') {
 		char unescaped_str[data_len];
 
 		memset(unescaped_str, 0, sizeof(unescaped_str));
-- 
2.28.0

