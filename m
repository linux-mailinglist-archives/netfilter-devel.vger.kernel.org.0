Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4869965D0B1
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Jan 2023 11:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjADKc5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Jan 2023 05:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbjADKc4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:32:56 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B99B01EC55
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Jan 2023 02:32:55 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] optimize: payload expression requires inner_desc comparison
Date:   Wed,  4 Jan 2023 11:32:51 +0100
Message-Id: <20230104103251.1565-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since 772892a018b4 ("src: add vxlan matching support"), payload
expressions have a inner_desc field that provides the description for
the outer tunnel header.

When searching for common mergeable selectors, compare the inner
description too.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/optimize.c b/src/optimize.c
index 09013efc548c..32aed866eb49 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -46,6 +46,8 @@ static bool __expr_cmp(const struct expr *expr_a, const struct expr *expr_b)
 			return false;
 		if (expr_a->payload.desc != expr_b->payload.desc)
 			return false;
+		if (expr_a->payload.inner_desc != expr_b->payload.inner_desc)
+			return false;
 		if (expr_a->payload.tmpl != expr_b->payload.tmpl)
 			return false;
 		break;
-- 
2.30.2

