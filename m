Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890397E01DA
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 12:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKCLMJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKCLMH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801821A8
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699009875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R/htTHNKbPe4E+x/FqT14eQVCBsdC3XifjhyE87t3E=;
        b=SUnvluen5+PAtmYQD4qYoTzAz/xzvysWKcy6l3osQfWEOxPExCBj0pR+Dl05vOHZDggo6R
        oJC40uPchNLd4MtoFkfUGf+qUBwz8wX+0iqlxbQKoMiUzuN0xZLKV+FIoFAtGuH8bXcuCn
        xFuSI7U/oz4femrkHTLfCCpoKl3apJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-D9mzKKj9OoqCpm-ouWSIrQ-1; Fri, 03 Nov 2023 07:11:14 -0400
X-MC-Unique: D9mzKKj9OoqCpm-ouWSIrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38AD6101A529
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD40B1C060BE;
        Fri,  3 Nov 2023 11:11:13 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 1/6] gitignore: ignore build artifacts from top level file
Date:   Fri,  3 Nov 2023 12:05:43 +0100
Message-ID: <20231103111102.2801624-2-thaller@redhat.com>
In-Reply-To: <20231103111102.2801624-1-thaller@redhat.com>
References: <20231103111102.2801624-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I don't think that having multiple .gitignore files for a small project
like nftables is best. Anyway. The build artifacts like "*.o" will not
only be found under "src/". Move those patterns.

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 .gitignore     | 7 ++++++-
 src/.gitignore | 5 -----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index a62e31f31c6b..51429020ceb6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,11 @@
-# Generated by autoconf/configure/automake
+# Generated by autoconf/configure/automake/make
 *.m4
+*.la
+*.lo
+*.o
+.deps/
 .dirstamp
+.libs/
 Makefile
 Makefile.in
 stamp-h1
diff --git a/src/.gitignore b/src/.gitignore
index 2d907425cbb0..f34105c6cda4 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,8 +1,3 @@
-*.la
-*.lo
-*.o
-.deps/
-.libs/
 nft
 parser_bison.c
 parser_bison.h
-- 
2.41.0

