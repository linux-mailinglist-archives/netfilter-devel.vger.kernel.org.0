Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C354C793
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jun 2022 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiFOLgi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jun 2022 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiFOLgh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:36:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DF653C60
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jun 2022 04:36:35 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g15so7072005qke.4
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jun 2022 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fzl7H51L9v0Tceq0XMmex1LZvUh9z6GqhqMd9Id+Jwk=;
        b=ZGO2wBQ7+kP8Wgkx9JflA1tSVb8Cw68NmgO6DjCfiQgcjrY2F/MMCFa3IGHJKPgY91
         iTTh+d/6Y3Y9rMujtjJZcw9k92/DhnWMjk3+E645gdLZSqFL7ERoop0vGIt/oO6vlbQS
         wBKxpntjyUDRJHzimmFSgkEhBKix6VXpZSO581Z7zgOkQ++KSkakYmMTA2vWNSFu1b5V
         yqCBWpgROJkqV6FN0nqtg+063dt5alvAH1uH8wvC1bssNdmrjaCQ9LrXT8WbdW4n2bBs
         5GSbtA/qcbnQqbm5hDiXKPeR7gy2ijg3DJLdvOvzO4Fo1XN8wfWWyp9zfXSfBP9ztktk
         qIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fzl7H51L9v0Tceq0XMmex1LZvUh9z6GqhqMd9Id+Jwk=;
        b=wHdhzOhZimN592zCOfgvU1JY7rvsL1teGfLL7JcF0XCg+5FweEbzzSAFMIidA+aumS
         q47tkzRatUNfhU7bxvuZnIqNpGyPYl2199fGGFze/akbarotZfwTtl35ywmotSqfr+Vw
         dJxfvTlBF75pOOeT1C62fxyFpJoEcUDa9FyW5nLxl9uj+3wqGxLyghDhrTD+OLp0jafe
         CN/cNvbztNoeAJKa+GE+qCCHhoU0Fa4rL2CuVHPFhNK7xKfrsyirKmiv3CeB50Uzwj4m
         A1IjRGAcVprZHA2walClMs/J1mzHuy4o8Cxs46XuJiPeuYb1m5nrP5YENUkaB6+FEr+9
         MoYA==
X-Gm-Message-State: AOAM531/WOAXpLQ2Zcbn3FNi6/sJF/hLd4wx7iOnK9GbBQWfwCwj6iy1
        xYrlOvDy6fPwPukKICQgtbp2KnqeF/0=
X-Google-Smtp-Source: ABdhPJzFWKwfx7rAN9y6dZaWYZHV42JvFyzCSbY5bbfywi5oUyzevoCYIDjei+BKAfDaxjBV1rOjrg==
X-Received: by 2002:a37:a6ca:0:b0:6a6:a244:4dba with SMTP id p193-20020a37a6ca000000b006a6a2444dbamr7843666qke.492.1655292994353;
        Wed, 15 Jun 2022 04:36:34 -0700 (PDT)
Received: from localhost.localdomain ([2602:ae:1883:e000:e23f:49ff:fe19:abd0])
        by smtp.googlemail.com with ESMTPSA id t37-20020a05622a182500b003051ce7812asm9758586qtc.5.2022.06.15.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:36:33 -0700 (PDT)
From:   Nicholas Vinson <nvinson234@gmail.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Nicholas Vinson <nvinson234@gmail.com>
Subject: [PATCH v2] build: fix clang+glibc snprintf substitution error
Date:   Wed, 15 Jun 2022 07:35:28 -0400
Message-Id: <3ee0b1d20d315ea8bbd865a1779fbf5342d01763.1655292884.git.nvinson234@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When building with clang and glibc and -D_FORTIFY_SOURCE=2 is passed to
clang, the snprintf member of the expr_ops and obj_ops structures will
be incorrectly replaced with __builtin_snprintf_chk() which results in
"error: no member named '__builtin___snprintf_chk'" errors at build
time.

This patch changes the member name from 'snprintf' to 'output' to
prevent the replacement.

This bug can be emulated using GCC by undefining the __va_arg_pack macro
before stdio.h is included.

This patch is based on the notes provided in
https://bugs.gentoo.org/807766.

Signed-off-by: Nicholas Vinson <nvinson234@gmail.com>
---
 include/expr_ops.h      | 2 +-
 include/obj.h           | 2 +-
 src/expr.c              | 4 ++--
 src/expr/bitwise.c      | 2 +-
 src/expr/byteorder.c    | 2 +-
 src/expr/cmp.c          | 2 +-
 src/expr/connlimit.c    | 2 +-
 src/expr/counter.c      | 2 +-
 src/expr/ct.c           | 2 +-
 src/expr/dup.c          | 2 +-
 src/expr/dynset.c       | 2 +-
 src/expr/exthdr.c       | 2 +-
 src/expr/fib.c          | 2 +-
 src/expr/flow_offload.c | 2 +-
 src/expr/fwd.c          | 2 +-
 src/expr/hash.c         | 2 +-
 src/expr/immediate.c    | 2 +-
 src/expr/last.c         | 2 +-
 src/expr/limit.c        | 2 +-
 src/expr/log.c          | 2 +-
 src/expr/lookup.c       | 2 +-
 src/expr/masq.c         | 2 +-
 src/expr/match.c        | 2 +-
 src/expr/meta.c         | 2 +-
 src/expr/nat.c          | 2 +-
 src/expr/numgen.c       | 2 +-
 src/expr/objref.c       | 2 +-
 src/expr/osf.c          | 2 +-
 src/expr/payload.c      | 2 +-
 src/expr/queue.c        | 2 +-
 src/expr/quota.c        | 2 +-
 src/expr/range.c        | 2 +-
 src/expr/redir.c        | 2 +-
 src/expr/reject.c       | 2 +-
 src/expr/rt.c           | 2 +-
 src/expr/socket.c       | 2 +-
 src/expr/synproxy.c     | 2 +-
 src/expr/target.c       | 2 +-
 src/expr/tproxy.c       | 2 +-
 src/expr/tunnel.c       | 2 +-
 src/expr/xfrm.c         | 2 +-
 src/obj/counter.c       | 2 +-
 src/obj/ct_expect.c     | 2 +-
 src/obj/ct_helper.c     | 2 +-
 src/obj/ct_timeout.c    | 2 +-
 src/obj/limit.c         | 2 +-
 src/obj/quota.c         | 2 +-
 src/obj/secmark.c       | 2 +-
 src/obj/synproxy.c      | 2 +-
 src/obj/tunnel.c        | 2 +-
 src/object.c            | 2 +-
 51 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/include/expr_ops.h b/include/expr_ops.h
index 7a6aa23..a7d747a 100644
--- a/include/expr_ops.h
+++ b/include/expr_ops.h
@@ -18,7 +18,7 @@ struct expr_ops {
 	const void *(*get)(const struct nftnl_expr *e, uint16_t type, uint32_t *data_len);
 	int 	(*parse)(struct nftnl_expr *e, struct nlattr *attr);
 	void	(*build)(struct nlmsghdr *nlh, const struct nftnl_expr *e);
-	int	(*snprintf)(char *buf, size_t len, uint32_t flags, const struct nftnl_expr *e);
+	int	(*output)(char *buf, size_t len, uint32_t flags, const struct nftnl_expr *e);
 };
 
 struct expr_ops *nftnl_expr_ops_lookup(const char *name);
diff --git a/include/obj.h b/include/obj.h
index 60dc853..d848ac9 100644
--- a/include/obj.h
+++ b/include/obj.h
@@ -109,7 +109,7 @@ struct obj_ops {
 	const void *(*get)(const struct nftnl_obj *e, uint16_t type, uint32_t *data_len);
 	int	(*parse)(struct nftnl_obj *e, struct nlattr *attr);
 	void	(*build)(struct nlmsghdr *nlh, const struct nftnl_obj *e);
-	int	(*snprintf)(char *buf, size_t len, uint32_t flags, const struct nftnl_obj *e);
+	int	(*output)(char *buf, size_t len, uint32_t flags, const struct nftnl_obj *e);
 };
 
 extern struct obj_ops obj_ops_counter;
diff --git a/src/expr.c b/src/expr.c
index 277bbde..b4581f1 100644
--- a/src/expr.c
+++ b/src/expr.c
@@ -279,10 +279,10 @@ int nftnl_expr_snprintf(char *buf, size_t remain, const struct nftnl_expr *expr,
 	if (remain)
 		buf[0] = '\0';
 
-	if (!expr->ops->snprintf || type != NFTNL_OUTPUT_DEFAULT)
+	if (!expr->ops->output || type != NFTNL_OUTPUT_DEFAULT)
 		return 0;
 
-	ret = expr->ops->snprintf(buf + offset, remain, flags, expr);
+	ret = expr->ops->output(buf + offset, remain, flags, expr);
 	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 
 	return offset;
diff --git a/src/expr/bitwise.c b/src/expr/bitwise.c
index d0c7827..2d27233 100644
--- a/src/expr/bitwise.c
+++ b/src/expr/bitwise.c
@@ -282,5 +282,5 @@ struct expr_ops expr_ops_bitwise = {
 	.get		= nftnl_expr_bitwise_get,
 	.parse		= nftnl_expr_bitwise_parse,
 	.build		= nftnl_expr_bitwise_build,
-	.snprintf	= nftnl_expr_bitwise_snprintf,
+	.output		= nftnl_expr_bitwise_snprintf,
 };
diff --git a/src/expr/byteorder.c b/src/expr/byteorder.c
index d299745..89ed0a8 100644
--- a/src/expr/byteorder.c
+++ b/src/expr/byteorder.c
@@ -220,5 +220,5 @@ struct expr_ops expr_ops_byteorder = {
 	.get		= nftnl_expr_byteorder_get,
 	.parse		= nftnl_expr_byteorder_parse,
 	.build		= nftnl_expr_byteorder_build,
-	.snprintf	= nftnl_expr_byteorder_snprintf,
+	.output		= nftnl_expr_byteorder_snprintf,
 };
diff --git a/src/expr/cmp.c b/src/expr/cmp.c
index 6030693..f9d15bb 100644
--- a/src/expr/cmp.c
+++ b/src/expr/cmp.c
@@ -202,5 +202,5 @@ struct expr_ops expr_ops_cmp = {
 	.get		= nftnl_expr_cmp_get,
 	.parse		= nftnl_expr_cmp_parse,
 	.build		= nftnl_expr_cmp_build,
-	.snprintf	= nftnl_expr_cmp_snprintf,
+	.output		= nftnl_expr_cmp_snprintf,
 };
diff --git a/src/expr/connlimit.c b/src/expr/connlimit.c
index 3b37587..549417b 100644
--- a/src/expr/connlimit.c
+++ b/src/expr/connlimit.c
@@ -135,5 +135,5 @@ struct expr_ops expr_ops_connlimit = {
 	.get		= nftnl_expr_connlimit_get,
 	.parse		= nftnl_expr_connlimit_parse,
 	.build		= nftnl_expr_connlimit_build,
-	.snprintf	= nftnl_expr_connlimit_snprintf,
+	.output		= nftnl_expr_connlimit_snprintf,
 };
diff --git a/src/expr/counter.c b/src/expr/counter.c
index 1676d70..d139a5f 100644
--- a/src/expr/counter.c
+++ b/src/expr/counter.c
@@ -133,5 +133,5 @@ struct expr_ops expr_ops_counter = {
 	.get		= nftnl_expr_counter_get,
 	.parse		= nftnl_expr_counter_parse,
 	.build		= nftnl_expr_counter_build,
-	.snprintf	= nftnl_expr_counter_snprintf,
+	.output		= nftnl_expr_counter_snprintf,
 };
diff --git a/src/expr/ct.c b/src/expr/ct.c
index d5dfc81..f4a2aea 100644
--- a/src/expr/ct.c
+++ b/src/expr/ct.c
@@ -258,5 +258,5 @@ struct expr_ops expr_ops_ct = {
 	.get		= nftnl_expr_ct_get,
 	.parse		= nftnl_expr_ct_parse,
 	.build		= nftnl_expr_ct_build,
-	.snprintf	= nftnl_expr_ct_snprintf,
+	.output		= nftnl_expr_ct_snprintf,
 };
diff --git a/src/expr/dup.c b/src/expr/dup.c
index f041b55..a239ff3 100644
--- a/src/expr/dup.c
+++ b/src/expr/dup.c
@@ -138,5 +138,5 @@ struct expr_ops expr_ops_dup = {
 	.get		= nftnl_expr_dup_get,
 	.parse		= nftnl_expr_dup_parse,
 	.build		= nftnl_expr_dup_build,
-	.snprintf	= nftnl_expr_dup_snprintf,
+	.output		= nftnl_expr_dup_snprintf,
 };
diff --git a/src/expr/dynset.c b/src/expr/dynset.c
index 85d64bb..5bcf1c6 100644
--- a/src/expr/dynset.c
+++ b/src/expr/dynset.c
@@ -373,5 +373,5 @@ struct expr_ops expr_ops_dynset = {
 	.get		= nftnl_expr_dynset_get,
 	.parse		= nftnl_expr_dynset_parse,
 	.build		= nftnl_expr_dynset_build,
-	.snprintf	= nftnl_expr_dynset_snprintf,
+	.output		= nftnl_expr_dynset_snprintf,
 };
diff --git a/src/expr/exthdr.c b/src/expr/exthdr.c
index 625dd5d..739c7ff 100644
--- a/src/expr/exthdr.c
+++ b/src/expr/exthdr.c
@@ -267,5 +267,5 @@ struct expr_ops expr_ops_exthdr = {
 	.get		= nftnl_expr_exthdr_get,
 	.parse		= nftnl_expr_exthdr_parse,
 	.build		= nftnl_expr_exthdr_build,
-	.snprintf	= nftnl_expr_exthdr_snprintf,
+	.output		= nftnl_expr_exthdr_snprintf,
 };
diff --git a/src/expr/fib.c b/src/expr/fib.c
index aaff52a..957f929 100644
--- a/src/expr/fib.c
+++ b/src/expr/fib.c
@@ -198,5 +198,5 @@ struct expr_ops expr_ops_fib = {
 	.get		= nftnl_expr_fib_get,
 	.parse		= nftnl_expr_fib_parse,
 	.build		= nftnl_expr_fib_build,
-	.snprintf	= nftnl_expr_fib_snprintf,
+	.output		= nftnl_expr_fib_snprintf,
 };
diff --git a/src/expr/flow_offload.c b/src/expr/flow_offload.c
index a826202..4fc0563 100644
--- a/src/expr/flow_offload.c
+++ b/src/expr/flow_offload.c
@@ -120,5 +120,5 @@ struct expr_ops expr_ops_flow = {
 	.get		= nftnl_expr_flow_get,
 	.parse		= nftnl_expr_flow_parse,
 	.build		= nftnl_expr_flow_build,
-	.snprintf	= nftnl_expr_flow_snprintf,
+	.output		= nftnl_expr_flow_snprintf,
 };
diff --git a/src/expr/fwd.c b/src/expr/fwd.c
index 82e5a41..51f6612 100644
--- a/src/expr/fwd.c
+++ b/src/expr/fwd.c
@@ -158,5 +158,5 @@ struct expr_ops expr_ops_fwd = {
 	.get		= nftnl_expr_fwd_get,
 	.parse		= nftnl_expr_fwd_parse,
 	.build		= nftnl_expr_fwd_build,
-	.snprintf	= nftnl_expr_fwd_snprintf,
+	.output		= nftnl_expr_fwd_snprintf,
 };
diff --git a/src/expr/hash.c b/src/expr/hash.c
index 10b4a72..6e2dd19 100644
--- a/src/expr/hash.c
+++ b/src/expr/hash.c
@@ -226,5 +226,5 @@ struct expr_ops expr_ops_hash = {
 	.get		= nftnl_expr_hash_get,
 	.parse		= nftnl_expr_hash_parse,
 	.build		= nftnl_expr_hash_build,
-	.snprintf	= nftnl_expr_hash_snprintf,
+	.output		= nftnl_expr_hash_snprintf,
 };
diff --git a/src/expr/immediate.c b/src/expr/immediate.c
index 94b043c..5d477a8 100644
--- a/src/expr/immediate.c
+++ b/src/expr/immediate.c
@@ -229,5 +229,5 @@ struct expr_ops expr_ops_immediate = {
 	.get		= nftnl_expr_immediate_get,
 	.parse		= nftnl_expr_immediate_parse,
 	.build		= nftnl_expr_immediate_build,
-	.snprintf	= nftnl_expr_immediate_snprintf,
+	.output		= nftnl_expr_immediate_snprintf,
 };
diff --git a/src/expr/last.c b/src/expr/last.c
index e2a60c4..641b713 100644
--- a/src/expr/last.c
+++ b/src/expr/last.c
@@ -134,5 +134,5 @@ struct expr_ops expr_ops_last = {
 	.get		= nftnl_expr_last_get,
 	.parse		= nftnl_expr_last_parse,
 	.build		= nftnl_expr_last_build,
-	.snprintf	= nftnl_expr_last_snprintf,
+	.output		= nftnl_expr_last_snprintf,
 };
diff --git a/src/expr/limit.c b/src/expr/limit.c
index 3dfd54a..1870e0e 100644
--- a/src/expr/limit.c
+++ b/src/expr/limit.c
@@ -202,5 +202,5 @@ struct expr_ops expr_ops_limit = {
 	.get		= nftnl_expr_limit_get,
 	.parse		= nftnl_expr_limit_parse,
 	.build		= nftnl_expr_limit_build,
-	.snprintf	= nftnl_expr_limit_snprintf,
+	.output		= nftnl_expr_limit_snprintf,
 };
diff --git a/src/expr/log.c b/src/expr/log.c
index 86db548..180d839 100644
--- a/src/expr/log.c
+++ b/src/expr/log.c
@@ -253,5 +253,5 @@ struct expr_ops expr_ops_log = {
 	.get		= nftnl_expr_log_get,
 	.parse		= nftnl_expr_log_parse,
 	.build		= nftnl_expr_log_build,
-	.snprintf	= nftnl_expr_log_snprintf,
+	.output		= nftnl_expr_log_snprintf,
 };
diff --git a/src/expr/lookup.c b/src/expr/lookup.c
index 83adce9..a06c338 100644
--- a/src/expr/lookup.c
+++ b/src/expr/lookup.c
@@ -206,5 +206,5 @@ struct expr_ops expr_ops_lookup = {
 	.get		= nftnl_expr_lookup_get,
 	.parse		= nftnl_expr_lookup_parse,
 	.build		= nftnl_expr_lookup_build,
-	.snprintf	= nftnl_expr_lookup_snprintf,
+	.output		= nftnl_expr_lookup_snprintf,
 };
diff --git a/src/expr/masq.c b/src/expr/masq.c
index 684708c..e6e528d 100644
--- a/src/expr/masq.c
+++ b/src/expr/masq.c
@@ -163,5 +163,5 @@ struct expr_ops expr_ops_masq = {
 	.get		= nftnl_expr_masq_get,
 	.parse		= nftnl_expr_masq_parse,
 	.build		= nftnl_expr_masq_build,
-	.snprintf	= nftnl_expr_masq_snprintf,
+	.output		= nftnl_expr_masq_snprintf,
 };
diff --git a/src/expr/match.c b/src/expr/match.c
index 533fdf5..f472add 100644
--- a/src/expr/match.c
+++ b/src/expr/match.c
@@ -189,5 +189,5 @@ struct expr_ops expr_ops_match = {
 	.get		= nftnl_expr_match_get,
 	.parse		= nftnl_expr_match_parse,
 	.build		= nftnl_expr_match_build,
-	.snprintf	= nftnl_expr_match_snprintf,
+	.output		= nftnl_expr_match_snprintf,
 };
diff --git a/src/expr/meta.c b/src/expr/meta.c
index 34fbb9b..96544a4 100644
--- a/src/expr/meta.c
+++ b/src/expr/meta.c
@@ -216,5 +216,5 @@ struct expr_ops expr_ops_meta = {
 	.get		= nftnl_expr_meta_get,
 	.parse		= nftnl_expr_meta_parse,
 	.build		= nftnl_expr_meta_build,
-	.snprintf	= nftnl_expr_meta_snprintf,
+	.output		= nftnl_expr_meta_snprintf,
 };
diff --git a/src/expr/nat.c b/src/expr/nat.c
index 0a9cdd7..ca727be 100644
--- a/src/expr/nat.c
+++ b/src/expr/nat.c
@@ -274,5 +274,5 @@ struct expr_ops expr_ops_nat = {
 	.get		= nftnl_expr_nat_get,
 	.parse		= nftnl_expr_nat_parse,
 	.build		= nftnl_expr_nat_build,
-	.snprintf	= nftnl_expr_nat_snprintf,
+	.output		= nftnl_expr_nat_snprintf,
 };
diff --git a/src/expr/numgen.c b/src/expr/numgen.c
index 159dfec..d4020a6 100644
--- a/src/expr/numgen.c
+++ b/src/expr/numgen.c
@@ -180,5 +180,5 @@ struct expr_ops expr_ops_ng = {
 	.get		= nftnl_expr_ng_get,
 	.parse		= nftnl_expr_ng_parse,
 	.build		= nftnl_expr_ng_build,
-	.snprintf	= nftnl_expr_ng_snprintf,
+	.output		= nftnl_expr_ng_snprintf,
 };
diff --git a/src/expr/objref.c b/src/expr/objref.c
index a4b6470..ad0688f 100644
--- a/src/expr/objref.c
+++ b/src/expr/objref.c
@@ -205,5 +205,5 @@ struct expr_ops expr_ops_objref = {
 	.get		= nftnl_expr_objref_get,
 	.parse		= nftnl_expr_objref_parse,
 	.build		= nftnl_expr_objref_build,
-	.snprintf	= nftnl_expr_objref_snprintf,
+	.output		= nftnl_expr_objref_snprintf,
 };
diff --git a/src/expr/osf.c b/src/expr/osf.c
index 215a681..f15a722 100644
--- a/src/expr/osf.c
+++ b/src/expr/osf.c
@@ -147,5 +147,5 @@ struct expr_ops expr_ops_osf = {
 	.get		= nftnl_expr_osf_get,
 	.parse		= nftnl_expr_osf_parse,
 	.build		= nftnl_expr_osf_build,
-	.snprintf	= nftnl_expr_osf_snprintf,
+	.output		= nftnl_expr_osf_snprintf,
 };
diff --git a/src/expr/payload.c b/src/expr/payload.c
index 82747ec..a0402c8 100644
--- a/src/expr/payload.c
+++ b/src/expr/payload.c
@@ -259,5 +259,5 @@ struct expr_ops expr_ops_payload = {
 	.get		= nftnl_expr_payload_get,
 	.parse		= nftnl_expr_payload_parse,
 	.build		= nftnl_expr_payload_build,
-	.snprintf	= nftnl_expr_payload_snprintf,
+	.output		= nftnl_expr_payload_snprintf,
 };
diff --git a/src/expr/queue.c b/src/expr/queue.c
index 8f70977..de287f2 100644
--- a/src/expr/queue.c
+++ b/src/expr/queue.c
@@ -193,5 +193,5 @@ struct expr_ops expr_ops_queue = {
 	.get		= nftnl_expr_queue_get,
 	.parse		= nftnl_expr_queue_parse,
 	.build		= nftnl_expr_queue_build,
-	.snprintf	= nftnl_expr_queue_snprintf,
+	.output		= nftnl_expr_queue_snprintf,
 };
diff --git a/src/expr/quota.c b/src/expr/quota.c
index 8c841d8..835729c 100644
--- a/src/expr/quota.c
+++ b/src/expr/quota.c
@@ -147,5 +147,5 @@ struct expr_ops expr_ops_quota = {
 	.get		= nftnl_expr_quota_get,
 	.parse		= nftnl_expr_quota_parse,
 	.build		= nftnl_expr_quota_build,
-	.snprintf	= nftnl_expr_quota_snprintf,
+	.output		= nftnl_expr_quota_snprintf,
 };
diff --git a/src/expr/range.c b/src/expr/range.c
index f76843a..473add8 100644
--- a/src/expr/range.c
+++ b/src/expr/range.c
@@ -213,5 +213,5 @@ struct expr_ops expr_ops_range = {
 	.get		= nftnl_expr_range_get,
 	.parse		= nftnl_expr_range_parse,
 	.build		= nftnl_expr_range_build,
-	.snprintf	= nftnl_expr_range_snprintf,
+	.output		= nftnl_expr_range_snprintf,
 };
diff --git a/src/expr/redir.c b/src/expr/redir.c
index 4f56cb4..87c2acc 100644
--- a/src/expr/redir.c
+++ b/src/expr/redir.c
@@ -167,5 +167,5 @@ struct expr_ops expr_ops_redir = {
 	.get		= nftnl_expr_redir_get,
 	.parse		= nftnl_expr_redir_parse,
 	.build		= nftnl_expr_redir_build,
-	.snprintf	= nftnl_expr_redir_snprintf,
+	.output		= nftnl_expr_redir_snprintf,
 };
diff --git a/src/expr/reject.c b/src/expr/reject.c
index 716d25c..c7c9441 100644
--- a/src/expr/reject.c
+++ b/src/expr/reject.c
@@ -134,5 +134,5 @@ struct expr_ops expr_ops_reject = {
 	.get		= nftnl_expr_reject_get,
 	.parse		= nftnl_expr_reject_parse,
 	.build		= nftnl_expr_reject_build,
-	.snprintf	= nftnl_expr_reject_snprintf,
+	.output		= nftnl_expr_reject_snprintf,
 };
diff --git a/src/expr/rt.c b/src/expr/rt.c
index 1ad9b2a..695a658 100644
--- a/src/expr/rt.c
+++ b/src/expr/rt.c
@@ -162,5 +162,5 @@ struct expr_ops expr_ops_rt = {
 	.get		= nftnl_expr_rt_get,
 	.parse		= nftnl_expr_rt_parse,
 	.build		= nftnl_expr_rt_build,
-	.snprintf	= nftnl_expr_rt_snprintf,
+	.output		= nftnl_expr_rt_snprintf,
 };
diff --git a/src/expr/socket.c b/src/expr/socket.c
index 02d86f8..83045c0 100644
--- a/src/expr/socket.c
+++ b/src/expr/socket.c
@@ -165,5 +165,5 @@ struct expr_ops expr_ops_socket = {
 	.get		= nftnl_expr_socket_get,
 	.parse		= nftnl_expr_socket_parse,
 	.build		= nftnl_expr_socket_build,
-	.snprintf	= nftnl_expr_socket_snprintf,
+	.output		= nftnl_expr_socket_snprintf,
 };
diff --git a/src/expr/synproxy.c b/src/expr/synproxy.c
index 630f3f4..47fcaef 100644
--- a/src/expr/synproxy.c
+++ b/src/expr/synproxy.c
@@ -152,5 +152,5 @@ struct expr_ops expr_ops_synproxy = {
 	.get		= nftnl_expr_synproxy_get,
 	.parse		= nftnl_expr_synproxy_parse,
 	.build		= nftnl_expr_synproxy_build,
-	.snprintf	= nftnl_expr_synproxy_snprintf,
+	.output		= nftnl_expr_synproxy_snprintf,
 };
diff --git a/src/expr/target.c b/src/expr/target.c
index b7c595a..2a3fe8a 100644
--- a/src/expr/target.c
+++ b/src/expr/target.c
@@ -189,5 +189,5 @@ struct expr_ops expr_ops_target = {
 	.get		= nftnl_expr_target_get,
 	.parse		= nftnl_expr_target_parse,
 	.build		= nftnl_expr_target_build,
-	.snprintf	= nftnl_expr_target_snprintf,
+	.output		= nftnl_expr_target_snprintf,
 };
diff --git a/src/expr/tproxy.c b/src/expr/tproxy.c
index d3ee8f8..bd5ffbf 100644
--- a/src/expr/tproxy.c
+++ b/src/expr/tproxy.c
@@ -170,5 +170,5 @@ struct expr_ops expr_ops_tproxy = {
 	.get		= nftnl_expr_tproxy_get,
 	.parse		= nftnl_expr_tproxy_parse,
 	.build		= nftnl_expr_tproxy_build,
-	.snprintf	= nftnl_expr_tproxy_snprintf,
+	.output		= nftnl_expr_tproxy_snprintf,
 };
diff --git a/src/expr/tunnel.c b/src/expr/tunnel.c
index 1460fd2..a00f620 100644
--- a/src/expr/tunnel.c
+++ b/src/expr/tunnel.c
@@ -145,5 +145,5 @@ struct expr_ops expr_ops_tunnel = {
 	.get		= nftnl_expr_tunnel_get,
 	.parse		= nftnl_expr_tunnel_parse,
 	.build		= nftnl_expr_tunnel_build,
-	.snprintf	= nftnl_expr_tunnel_snprintf,
+	.output		= nftnl_expr_tunnel_snprintf,
 };
diff --git a/src/expr/xfrm.c b/src/expr/xfrm.c
index c81d14d..2db00d5 100644
--- a/src/expr/xfrm.c
+++ b/src/expr/xfrm.c
@@ -196,5 +196,5 @@ struct expr_ops expr_ops_xfrm = {
 	.get		= nftnl_expr_xfrm_get,
 	.parse		= nftnl_expr_xfrm_parse,
 	.build		= nftnl_expr_xfrm_build,
-	.snprintf	= nftnl_expr_xfrm_snprintf,
+	.output		= nftnl_expr_xfrm_snprintf,
 };
diff --git a/src/obj/counter.c b/src/obj/counter.c
index ef0cd20..ebf3e74 100644
--- a/src/obj/counter.c
+++ b/src/obj/counter.c
@@ -127,5 +127,5 @@ struct obj_ops obj_ops_counter = {
 	.get		= nftnl_obj_counter_get,
 	.parse		= nftnl_obj_counter_parse,
 	.build		= nftnl_obj_counter_build,
-	.snprintf	= nftnl_obj_counter_snprintf,
+	.output		= nftnl_obj_counter_snprintf,
 };
diff --git a/src/obj/ct_expect.c b/src/obj/ct_expect.c
index 8136ad9..810ba9a 100644
--- a/src/obj/ct_expect.c
+++ b/src/obj/ct_expect.c
@@ -196,5 +196,5 @@ struct obj_ops obj_ops_ct_expect = {
 	.get		= nftnl_obj_ct_expect_get,
 	.parse		= nftnl_obj_ct_expect_parse,
 	.build		= nftnl_obj_ct_expect_build,
-	.snprintf	= nftnl_obj_ct_expect_snprintf,
+	.output		= nftnl_obj_ct_expect_snprintf,
 };
diff --git a/src/obj/ct_helper.c b/src/obj/ct_helper.c
index c52032a..a31bd6f 100644
--- a/src/obj/ct_helper.c
+++ b/src/obj/ct_helper.c
@@ -150,5 +150,5 @@ struct obj_ops obj_ops_ct_helper = {
 	.get		= nftnl_obj_ct_helper_get,
 	.parse		= nftnl_obj_ct_helper_parse,
 	.build		= nftnl_obj_ct_helper_build,
-	.snprintf	= nftnl_obj_ct_helper_snprintf,
+	.output		= nftnl_obj_ct_helper_snprintf,
 };
diff --git a/src/obj/ct_timeout.c b/src/obj/ct_timeout.c
index 1d4f8fb..65b48bd 100644
--- a/src/obj/ct_timeout.c
+++ b/src/obj/ct_timeout.c
@@ -316,5 +316,5 @@ struct obj_ops obj_ops_ct_timeout = {
 	.get		= nftnl_obj_ct_timeout_get,
 	.parse		= nftnl_obj_ct_timeout_parse,
 	.build		= nftnl_obj_ct_timeout_build,
-	.snprintf	= nftnl_obj_ct_timeout_snprintf,
+	.output		= nftnl_obj_ct_timeout_snprintf,
 };
diff --git a/src/obj/limit.c b/src/obj/limit.c
index 8b40f9d..d7b1aed 100644
--- a/src/obj/limit.c
+++ b/src/obj/limit.c
@@ -168,5 +168,5 @@ struct obj_ops obj_ops_limit = {
 	.get		= nftnl_obj_limit_get,
 	.parse		= nftnl_obj_limit_parse,
 	.build		= nftnl_obj_limit_build,
-	.snprintf	= nftnl_obj_limit_snprintf,
+	.output		= nftnl_obj_limit_snprintf,
 };
diff --git a/src/obj/quota.c b/src/obj/quota.c
index 8ab3300..6c7559a 100644
--- a/src/obj/quota.c
+++ b/src/obj/quota.c
@@ -144,5 +144,5 @@ struct obj_ops obj_ops_quota = {
 	.get		= nftnl_obj_quota_get,
 	.parse		= nftnl_obj_quota_parse,
 	.build		= nftnl_obj_quota_build,
-	.snprintf	= nftnl_obj_quota_snprintf,
+	.output		= nftnl_obj_quota_snprintf,
 };
diff --git a/src/obj/secmark.c b/src/obj/secmark.c
index 2ccc803..e5c24b3 100644
--- a/src/obj/secmark.c
+++ b/src/obj/secmark.c
@@ -116,5 +116,5 @@ struct obj_ops obj_ops_secmark = {
 	.get		= nftnl_obj_secmark_get,
 	.parse		= nftnl_obj_secmark_parse,
 	.build		= nftnl_obj_secmark_build,
-	.snprintf	= nftnl_obj_secmark_snprintf,
+	.output		= nftnl_obj_secmark_snprintf,
 };
diff --git a/src/obj/synproxy.c b/src/obj/synproxy.c
index d689fee..baef5c2 100644
--- a/src/obj/synproxy.c
+++ b/src/obj/synproxy.c
@@ -143,5 +143,5 @@ struct obj_ops obj_ops_synproxy = {
 	.get		= nftnl_obj_synproxy_get,
 	.parse		= nftnl_obj_synproxy_parse,
 	.build		= nftnl_obj_synproxy_build,
-	.snprintf	= nftnl_obj_synproxy_snprintf,
+	.output		= nftnl_obj_synproxy_snprintf,
 };
diff --git a/src/obj/tunnel.c b/src/obj/tunnel.c
index 5ede6bd..d2503dc 100644
--- a/src/obj/tunnel.c
+++ b/src/obj/tunnel.c
@@ -547,5 +547,5 @@ struct obj_ops obj_ops_tunnel = {
 	.get		= nftnl_obj_tunnel_get,
 	.parse		= nftnl_obj_tunnel_parse,
 	.build		= nftnl_obj_tunnel_build,
-	.snprintf	= nftnl_obj_tunnel_snprintf,
+	.output		= nftnl_obj_tunnel_snprintf,
 };
diff --git a/src/object.c b/src/object.c
index 46e208b..232b97a 100644
--- a/src/object.c
+++ b/src/object.c
@@ -396,7 +396,7 @@ static int nftnl_obj_snprintf_dflt(char *buf, size_t remain,
 	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 
 	if (obj->ops) {
-		ret = obj->ops->snprintf(buf + offset, remain, flags, obj);
+		ret = obj->ops->output(buf + offset, remain, flags, obj);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 	ret = snprintf(buf + offset, remain, "]");
-- 
2.35.1

