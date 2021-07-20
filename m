Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA43CFFDC
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jul 2021 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGTQTY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Jul 2021 12:19:24 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51500 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhGTQTN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:19:13 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 37472608E0
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jul 2021 18:59:22 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: fix inet nat with no layer 3 info
Date:   Tue, 20 Jul 2021 18:59:44 +0200
Message-Id: <20210720165944.42987-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft currently reports:

 Error: Could not process rule: Protocol error
 add rule inet x y meta l4proto tcp dnat to :80
                                    ^^^^

default to NFPROTO_INET family, otherwise kernel bails out EPROTO when
trying to load the conntrack helper.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1428
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 0ea57b0cd8fb..98309ea83ac0 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2997,9 +2997,10 @@ static int nat_evaluate_family(struct eval_ctx *ctx, struct stmt *stmt)
 			stmt->nat.family = ctx->pctx.family;
 		return 0;
 	case NFPROTO_INET:
-		if (!stmt->nat.addr)
+		if (!stmt->nat.addr) {
+			stmt->nat.family = NFPROTO_INET;
 			return 0;
-
+		}
 		if (stmt->nat.family != NFPROTO_UNSPEC)
 			return 0;
 
-- 
2.30.2

