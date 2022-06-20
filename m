Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A635B5512CE
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiFTIcf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiFTIc3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BEB812A9B
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:26 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 07/18] optimize: add osf expression support
Date:   Mon, 20 Jun 2022 10:32:04 +0200
Message-Id: <20220620083215.1021238-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620083215.1021238-1-pablo@netfilter.org>
References: <20220620083215.1021238-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Extend expr_cmp() to compare osf expressions used in relational.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/optimize.c b/src/optimize.c
index 747282b4d7f4..04c92575c4b0 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -81,6 +81,12 @@ static bool __expr_cmp(const struct expr *expr_a, const struct expr *expr_b)
 		if (expr_a->socket.level != expr_b->socket.level)
 			return false;
 		break;
+	case EXPR_OSF:
+		if (expr_a->osf.ttl != expr_b->osf.ttl)
+			return false;
+		if (expr_a->osf.flags != expr_b->osf.flags)
+			return false;
+		break;
 	default:
 		return false;
 	}
-- 
2.30.2

