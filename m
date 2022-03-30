Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF594EC8F6
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Mar 2022 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbiC3QAn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Mar 2022 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiC3QAn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:00:43 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FBC64EC
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Mar 2022 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3PTIGWP4ZesZFo9NoYJD/DKPXye0EMxEEG+QkNN/zJQ=; b=gkCDn2lo9u20YfzxASKP7Fs5KF
        qJDgMZ2e2fBN+f4fdp2JNFz25TwmWwfOBNhCxDq3/tfyL6chCJ3if8+hkXOIrFcwt1nAJrtAus0wc
        pGhX9hZgDAAPUSDd0i5nx9FBDuUzyWkJHMwtH8hk+++EjIDh+TyDkFCyogCLv9Agh1KukUta4cfGs
        OSCg22Q1XwqBQTyKk7E0lIKmwJKMy39K4bjm8qD3/ucYbtBFOeso2KXDkstPWrqY7QiOXDHJ5hk6Q
        RDnZQAi9s3wjeSBr3I9lQ6J37g5n8Nt5uJxB9d2M3GDr3BMknC6n/mb5D9nVR2Q7xArADmwp+QLlJ
        5JnQcd8w==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1nZaij-0004Wy-JU; Wed, 30 Mar 2022 17:58:53 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 2/9] Revert "libipt_[SD]NAT: avoid false error about multiple destinations specified"
Date:   Wed, 30 Mar 2022 17:58:44 +0200
Message-Id: <20220330155851.13249-3-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330155851.13249-1-phil@nwl.cc>
References: <20220330155851.13249-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts commit f25b2355e889290879c8cecad3dd24ec0c384fb8.

The workaround is not needed anymore since commit 30b178b9bf11e
("extensions: *NAT: Kill multiple IPv4 range support").

While being at it, drop the same hidden flag logic from
libip6t_[SD]NAT extensions as well and just don't set XTOPT_MULTI so
guided option parser will reject multiple parameters automatically.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libip6t_DNAT.c | 9 +--------
 extensions/libip6t_SNAT.c | 9 +--------
 extensions/libipt_DNAT.c  | 8 ++------
 extensions/libipt_SNAT.c  | 3 ---
 4 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/extensions/libip6t_DNAT.c b/extensions/libip6t_DNAT.c
index f1ad81436316b..d51994c09e7f2 100644
--- a/extensions/libip6t_DNAT.c
+++ b/extensions/libip6t_DNAT.c
@@ -19,10 +19,8 @@ enum {
 	O_TO_DEST = 0,
 	O_RANDOM,
 	O_PERSISTENT,
-	O_X_TO_DEST,
 	F_TO_DEST   = 1 << O_TO_DEST,
 	F_RANDOM   = 1 << O_RANDOM,
-	F_X_TO_DEST = 1 << O_X_TO_DEST,
 };
 
 static void DNAT_help(void)
@@ -45,7 +43,7 @@ static void DNAT_help_v2(void)
 
 static const struct xt_option_entry DNAT_opts[] = {
 	{.name = "to-destination", .id = O_TO_DEST, .type = XTTYPE_STRING,
-	 .flags = XTOPT_MAND | XTOPT_MULTI},
+	 .flags = XTOPT_MAND},
 	{.name = "random", .id = O_RANDOM, .type = XTTYPE_NONE},
 	{.name = "persistent", .id = O_PERSISTENT, .type = XTTYPE_NONE},
 	XTOPT_TABLEEND,
@@ -183,12 +181,7 @@ static void _DNAT_parse(struct xt_option_call *cb,
 	xtables_option_parse(cb);
 	switch (cb->entry->id) {
 	case O_TO_DEST:
-		if (cb->xflags & F_X_TO_DEST) {
-			xtables_error(PARAMETER_PROBLEM,
-				      "DNAT: Multiple --to-destination not supported");
-		}
 		parse_to(cb->arg, portok, range, rev);
-		cb->xflags |= F_X_TO_DEST;
 		break;
 	case O_PERSISTENT:
 		range->flags |= NF_NAT_RANGE_PERSISTENT;
diff --git a/extensions/libip6t_SNAT.c b/extensions/libip6t_SNAT.c
index 6d19614c7c708..4fe272b262a3d 100644
--- a/extensions/libip6t_SNAT.c
+++ b/extensions/libip6t_SNAT.c
@@ -20,11 +20,9 @@ enum {
 	O_RANDOM,
 	O_RANDOM_FULLY,
 	O_PERSISTENT,
-	O_X_TO_SRC,
 	F_TO_SRC       = 1 << O_TO_SRC,
 	F_RANDOM       = 1 << O_RANDOM,
 	F_RANDOM_FULLY = 1 << O_RANDOM_FULLY,
-	F_X_TO_SRC     = 1 << O_X_TO_SRC,
 };
 
 static void SNAT_help(void)
@@ -38,7 +36,7 @@ static void SNAT_help(void)
 
 static const struct xt_option_entry SNAT_opts[] = {
 	{.name = "to-source", .id = O_TO_SRC, .type = XTTYPE_STRING,
-	 .flags = XTOPT_MAND | XTOPT_MULTI},
+	 .flags = XTOPT_MAND},
 	{.name = "random", .id = O_RANDOM, .type = XTTYPE_NONE},
 	{.name = "random-fully", .id = O_RANDOM_FULLY, .type = XTTYPE_NONE},
 	{.name = "persistent", .id = O_PERSISTENT, .type = XTTYPE_NONE},
@@ -163,12 +161,7 @@ static void SNAT_parse(struct xt_option_call *cb)
 	xtables_option_parse(cb);
 	switch (cb->entry->id) {
 	case O_TO_SRC:
-		if (cb->xflags & F_X_TO_SRC) {
-			xtables_error(PARAMETER_PROBLEM,
-				      "SNAT: Multiple --to-source not supported");
-		}
 		parse_to(cb->arg, portok, range);
-		cb->xflags |= F_X_TO_SRC;
 		break;
 	case O_PERSISTENT:
 		range->flags |= NF_NAT_RANGE_PERSISTENT;
diff --git a/extensions/libipt_DNAT.c b/extensions/libipt_DNAT.c
index eefa95eb73630..e93ab6958969b 100644
--- a/extensions/libipt_DNAT.c
+++ b/extensions/libipt_DNAT.c
@@ -12,10 +12,8 @@ enum {
 	O_TO_DEST = 0,
 	O_RANDOM,
 	O_PERSISTENT,
-	O_X_TO_DEST, /* hidden flag */
-	F_TO_DEST   = 1 << O_TO_DEST,
-	F_RANDOM    = 1 << O_RANDOM,
-	F_X_TO_DEST = 1 << O_X_TO_DEST,
+	F_TO_DEST = 1 << O_TO_DEST,
+	F_RANDOM  = 1 << O_RANDOM,
 };
 
 static void DNAT_help(void)
@@ -145,7 +143,6 @@ static void DNAT_parse(struct xt_option_call *cb)
 	switch (cb->entry->id) {
 	case O_TO_DEST:
 		parse_to(cb->arg, portok, mr->range);
-		cb->xflags |= F_X_TO_DEST;
 		break;
 	case O_PERSISTENT:
 		mr->range->flags |= NF_NAT_RANGE_PERSISTENT;
@@ -367,7 +364,6 @@ static void DNAT_parse_v2(struct xt_option_call *cb)
 	switch (cb->entry->id) {
 	case O_TO_DEST:
 		parse_to_v2(cb->arg, portok, range);
-		cb->xflags |= F_X_TO_DEST;
 		break;
 	case O_PERSISTENT:
 		range->flags |= NF_NAT_RANGE_PERSISTENT;
diff --git a/extensions/libipt_SNAT.c b/extensions/libipt_SNAT.c
index bd36830ae91ce..211a20bc45bfe 100644
--- a/extensions/libipt_SNAT.c
+++ b/extensions/libipt_SNAT.c
@@ -13,11 +13,9 @@ enum {
 	O_RANDOM,
 	O_RANDOM_FULLY,
 	O_PERSISTENT,
-	O_X_TO_SRC,
 	F_TO_SRC       = 1 << O_TO_SRC,
 	F_RANDOM       = 1 << O_RANDOM,
 	F_RANDOM_FULLY = 1 << O_RANDOM_FULLY,
-	F_X_TO_SRC     = 1 << O_X_TO_SRC,
 };
 
 static void SNAT_help(void)
@@ -139,7 +137,6 @@ static void SNAT_parse(struct xt_option_call *cb)
 	switch (cb->entry->id) {
 	case O_TO_SRC:
 		parse_to(cb->arg, portok, mr->range);
-		cb->xflags |= F_X_TO_SRC;
 		break;
 	case O_PERSISTENT:
 		mr->range->flags |= NF_NAT_RANGE_PERSISTENT;
-- 
2.34.1

