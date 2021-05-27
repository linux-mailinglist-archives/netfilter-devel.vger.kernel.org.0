Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B913E3932A0
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 May 2021 17:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhE0Pp2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 May 2021 11:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhE0PpQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 May 2021 11:45:16 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDFDC061761
        for <netfilter-devel@vger.kernel.org>; Thu, 27 May 2021 08:43:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lmIAe-0003OY-Bp; Thu, 27 May 2021 17:43:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 3/6] main: add -O help to dump list of supported optimzation flags
Date:   Thu, 27 May 2021 17:43:20 +0200
Message-Id: <20210527154323.4003-4-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210527154323.4003-1-fw@strlen.de>
References: <20210527154323.4003-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Print list of supported options.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/main.c b/src/main.c
index 6e14a7f26b0f..cf00f27f06de 100644
--- a/src/main.c
+++ b/src/main.c
@@ -86,6 +86,7 @@ enum opt_vals {
 
 enum optimization_feature {
 	OPTIMIZE_UNDEFINED,
+	OPTIMIZE_HELP,
 	OPTIMIZE_REMOVE_DEPENDENCIES,
 };
 
@@ -315,11 +316,18 @@ static const struct {
 
 static const struct {
 	const char		*name;
+	const char		*help;
 	enum optimization_feature level;
 	enum nft_optimization_flags flag;
 } optimization_param[] = {
+	{
+		.name	= "help",
+		.help	= "",
+		.level	= OPTIMIZE_HELP,
+	},
 	{
 		.name	= "remove-dependencies",
+		.help	= "ruleset listing with redundant expressions removed",
 		.level	= OPTIMIZE_REMOVE_DEPENDENCIES,
 		.flag	= NFT_OPTIMIZATION_F_REMOVE_DEPS,
 	},
@@ -372,6 +380,7 @@ static bool nft_options_check(int argc, char * const argv[])
 
 static void optimize_settings_set_custom(struct nft_ctx *ctx, char *options)
 {
+	unsigned int default_flags = ctx->optimization_flags;
 	unsigned int i;
 	char *end;
 
@@ -401,7 +410,21 @@ static void optimize_settings_set_custom(struct nft_ctx *ctx, char *options)
 		switch (level) {
 		case OPTIMIZE_UNDEFINED:
 			fprintf(stderr, "invalid optimization option `%s'\n", options);
+			fprintf(stderr, "Try \"-O help\" for list of options.\n");
 			exit(EXIT_FAILURE);
+		case OPTIMIZE_HELP:
+			for (i = 0; i < array_size(optimization_param); i++) {
+				if (level == optimization_param[i].level)
+					continue;
+
+				flag = optimization_param[i].flag;
+				printf("%s: %s (default %s)\n",
+					optimization_param[i].name, optimization_param[i].help,
+					default_flags & flag ? "on" : "off");
+			}
+
+			printf("\nPrepend \"no-\" to disable options that are enabled by default.\n");
+			exit(EXIT_SUCCESS);
 		case OPTIMIZE_REMOVE_DEPENDENCIES:
 			break;
 		}
-- 
2.26.3

