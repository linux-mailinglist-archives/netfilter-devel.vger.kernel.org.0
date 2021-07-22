Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E383D2A84
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jul 2021 19:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhGVQMm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Jul 2021 12:12:42 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55420 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhGVQLj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:11:39 -0400
Received: from localhost.localdomain (unknown [78.30.10.20])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6497F642A0
        for <netfilter-devel@vger.kernel.org>; Thu, 22 Jul 2021 18:51:47 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] parser_json: inconditionally initialize ct timeout list
Date:   Thu, 22 Jul 2021 18:52:14 +0200
Message-Id: <20210722165214.1982-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722165214.1982-1-pablo@netfilter.org>
References: <20210722165214.1982-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The policy is optional, make sure this timeout list is initialized.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/parser_json.c b/src/parser_json.c
index e03b51697cb7..666aa2fcc9ec 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -3204,7 +3204,6 @@ static int json_parse_ct_timeout_policy(struct json_ctx *ctx,
 		return 1;
 	}
 
-	init_list_head(&obj->ct_timeout.timeout_list);
 	json_object_foreach(tmp, key, val) {
 		struct timeout_state *ts;
 
@@ -3351,6 +3350,7 @@ static struct cmd *json_parse_cmd_add_object(struct json_ctx *ctx,
 		}
 		obj->ct_helper.l3proto = l3proto;
 
+		init_list_head(&obj->ct_timeout.timeout_list);
 		if (json_parse_ct_timeout_policy(ctx, root, obj)) {
 			obj_free(obj);
 			return NULL;
-- 
2.20.1

