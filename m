Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596E97AEF92
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Sep 2023 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjIZPZR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Sep 2023 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjIZPZP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:25:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2264E10E
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Sep 2023 08:25:08 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/3] json: expose dynamic flag
Date:   Tue, 26 Sep 2023 17:24:59 +0200
Message-Id: <20230926152500.30571-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926152500.30571-1-pablo@netfilter.org>
References: <20230926152500.30571-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The dynamic flag is not exported via JSON, this triggers spurious
ENOTSUPP errors when restoring rulesets in JSON with dynamic flags
set on.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/json.c        | 2 ++
 src/parser_json.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/src/json.c b/src/json.c
index 446575c2afc0..220ce0f79f2f 100644
--- a/src/json.c
+++ b/src/json.c
@@ -176,6 +176,8 @@ static json_t *set_print_json(struct output_ctx *octx, const struct set *set)
 		json_array_append_new(tmp, json_pack("s", "interval"));
 	if (set->flags & NFT_SET_TIMEOUT)
 		json_array_append_new(tmp, json_pack("s", "timeout"));
+	if (set->flags & NFT_SET_EVAL)
+		json_array_append_new(tmp, json_pack("s", "dynamic"));
 
 	if (json_array_size(tmp) > 0) {
 		json_object_set_new(root, "flags", tmp);
diff --git a/src/parser_json.c b/src/parser_json.c
index df327e9558e0..16961d6013af 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -3136,6 +3136,7 @@ static int string_to_set_flag(const char *str)
 		{ NFT_SET_CONSTANT, "constant" },
 		{ NFT_SET_INTERVAL, "interval" },
 		{ NFT_SET_TIMEOUT, "timeout" },
+		{ NFT_SET_EVAL,	"dynamic" },
 	};
 	unsigned int i;
 
-- 
2.30.2

