Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14231788617
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Aug 2023 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjHYLjx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Aug 2023 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjHYLjL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC192102
        for <netfilter-devel@vger.kernel.org>; Fri, 25 Aug 2023 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692963507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rLzQRPw9SE6CsQq6WkqPkytmRozeA4D677igsdh7yhc=;
        b=bzT24DipJa5wJMjmCZeTXNdol738che40SNWGLh9ZSgauCaI6fAOumYNiSqSHwt3eNsP5v
        ObgV3tM7KHJ5pqjt58zPACIJtL4igPKPNnHxjOODhRoA5H1yGULWAi54xTrsFaEA2ceg/S
        Np8piJ4dPkg58/YqLYB3N/cbBEZ3IvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-JTYHoy6OOGGwPukRJvtjmw-1; Fri, 25 Aug 2023 07:38:25 -0400
X-MC-Unique: JTYHoy6OOGGwPukRJvtjmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05E608D40A1
        for <netfilter-devel@vger.kernel.org>; Fri, 25 Aug 2023 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 795D61121319;
        Fri, 25 Aug 2023 11:38:24 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft v2 4/6] configure: use AC_USE_SYSTEM_EXTENSIONS to get _GNU_SOURCE
Date:   Fri, 25 Aug 2023 13:36:32 +0200
Message-ID: <20230825113810.2620133-5-thaller@redhat.com>
In-Reply-To: <20230825113810.2620133-1-thaller@redhat.com>
References: <20230825113810.2620133-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Let "configure" detect which features are available. Also, nftables is a
Linux project, so portability beyond gcc/clang and glibc/musl is less
relevant. And even if it were, then feature detection by "configure"
would still be preferable.

Use AC_USE_SYSTEM_EXTENSIONS ([1]).

Available since autoconf 2.60, from 2006 ([2]).

[1] https://www.gnu.org/software/autoconf/manual/autoconf-2.67/html_node/Posix-Variants.html#index-AC_005fUSE_005fSYSTEM_005fEXTENSIONS-1046
[2] https://lists.gnu.org/archive/html/autoconf/2006-06/msg00111.html

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 configure.ac  | 3 +++
 include/nft.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 42f0dc4cf392..baec66978847 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,6 +23,9 @@ AM_CONDITIONAL([BUILD_MAN], [test "x$enable_man_doc" = "xyes" ])
 
 # Checks for programs.
 AC_PROG_CC
+
+AC_USE_SYSTEM_EXTENSIONS
+
 AC_PROG_MKDIR_P
 AC_PROG_INSTALL
 AC_PROG_SED
diff --git a/include/nft.h b/include/nft.h
index 4e66f8e6470d..0fd481c6ef04 100644
--- a/include/nft.h
+++ b/include/nft.h
@@ -2,8 +2,6 @@
 #ifndef NFTABLES_NFT_H
 #define NFTABLES_NFT_H
 
-#define _GNU_SOURCE
-
 #include <config.h>
 
 #endif /* NFTABLES_NFT_H */
-- 
2.41.0

