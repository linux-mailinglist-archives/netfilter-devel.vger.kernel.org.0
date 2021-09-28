Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8156041B8BE
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Sep 2021 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhI1U5b (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Sep 2021 16:57:31 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58742 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242734AbhI1U5b (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:57:31 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8683763EC7
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Sep 2021 22:54:25 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] evaluate: check for missing transport protocol match in nat map with concatenations
Date:   Tue, 28 Sep 2021 22:55:43 +0200
Message-Id: <20210928205543.368551-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928205543.368551-1-pablo@netfilter.org>
References: <20210928205543.368551-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Restore this error with NAT maps:

 # nft add rule 'ip ipfoo c dnat to ip daddr map @y'
 Error: transport protocol mapping is only valid after transport protocol match
 add rule ip ipfoo c dnat to ip daddr map @y
                     ~~~~    ^^^^^^^^^^^^^^^

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 1737ca0854cd..161372397bcc 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3159,10 +3159,17 @@ static int stmt_evaluate_addr(struct eval_ctx *ctx, struct stmt *stmt,
 
 static int stmt_evaluate_nat_map(struct eval_ctx *ctx, struct stmt *stmt)
 {
+	struct proto_ctx *pctx = &ctx->pctx;
 	struct expr *one, *two, *data, *tmp;
 	const struct datatype *dtype;
 	int addr_type, err;
 
+	if (pctx->protocol[PROTO_BASE_TRANSPORT_HDR].desc == NULL &&
+	    !nat_evaluate_addr_has_th_expr(stmt->nat.addr))
+		return stmt_binary_error(ctx, stmt->nat.addr, stmt,
+					 "transport protocol mapping is only "
+					 "valid after transport protocol match");
+
 	switch (stmt->nat.family) {
 	case NFPROTO_IPV4:
 		addr_type = TYPE_IPADDR;
-- 
2.30.2

