Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E67A868F
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Sep 2023 16:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjITObA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbjITOa7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BBDC6
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Sep 2023 07:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695220215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPt5h4kSEaW2Gz+c1Bl7YnJ7gX/+zKJYMKTX438PDmI=;
        b=Q1fA/mDVX6ImJBne/4lLlRIOJOYlfnHeDiOqvfP6vgWCGDPqXGyrsv8S32VhtV2PSRLSW/
        0YWvHVxFLalNatMphnCtx3V2PikFTJ7xq9x+dKZ33E0fKzvKEIPvEE+bV/YitjVUoq9x6b
        txm22V0/zSI+uUKyJWaBsBgZar1u8zk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-082YQZUdNTSdWVW-0eLONA-1; Wed, 20 Sep 2023 10:30:13 -0400
X-MC-Unique: 082YQZUdNTSdWVW-0eLONA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BD49858F1C
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Sep 2023 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B5C810F1BE7;
        Wed, 20 Sep 2023 14:30:12 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 4/9] datatype: use "enum byteorder" instead of int in set_datatype_alloc()
Date:   Wed, 20 Sep 2023 16:26:05 +0200
Message-ID: <20230920142958.566615-5-thaller@redhat.com>
In-Reply-To: <20230920142958.566615-1-thaller@redhat.com>
References: <20230920142958.566615-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use the enum types as we have them.

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 include/datatype.h | 2 +-
 src/datatype.c     | 2 +-
 src/evaluate.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/datatype.h b/include/datatype.h
index 5b85adc15857..202935bd322f 100644
--- a/include/datatype.h
+++ b/include/datatype.h
@@ -295,7 +295,7 @@ concat_subtype_lookup(uint32_t type, unsigned int n)
 }
 
 extern const struct datatype *
-set_datatype_alloc(const struct datatype *orig_dtype, unsigned int byteorder);
+set_datatype_alloc(const struct datatype *orig_dtype, enum byteorder byteorder);
 
 extern void time_print(uint64_t msec, struct output_ctx *octx);
 extern struct error_record *time_parse(const struct location *loc,
diff --git a/src/datatype.c b/src/datatype.c
index c5d88d9a90b6..6e4bfc4c0de7 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1304,7 +1304,7 @@ const struct datatype *concat_type_alloc(uint32_t type)
 }
 
 const struct datatype *set_datatype_alloc(const struct datatype *orig_dtype,
-					  unsigned int byteorder)
+					  enum byteorder byteorder)
 {
 	struct datatype *dtype;
 
diff --git a/src/evaluate.c b/src/evaluate.c
index 03586922848a..933fddd8996d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1341,7 +1341,7 @@ static int expr_evaluate_bitwise(struct eval_ctx *ctx, struct expr **expr)
 	struct expr *op = *expr, *left = op->left;
 	const struct datatype *dtype;
 	unsigned int max_len;
-	int byteorder;
+	enum byteorder byteorder;
 
 	if (ctx->stmt_len > left->len) {
 		max_len = ctx->stmt_len;
-- 
2.41.0

