Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC5798B82
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Sep 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbjIHRdc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Sep 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjIHRdc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC11FCA
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Sep 2023 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694194362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gl2l8KioG+ipa0Dn1GcO9Af90NuXJsLL8lRfa+gBKv8=;
        b=NC1h0h+2lsK2G0xgXgUlgaLKiBa5SnWuyv/cMIoSY3LNkHN33lj3Fscz8EN2oE7KOsJFju
        DjGtNeMJ8yyVLMe3osQY/0cIOa8MK/dFE+l/8KufqLkNevJ6KjkUiZEbsFf5rNr2ABGvoc
        sP96vAnH0QaRyuPU6eahDZcnLTDIVCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-EjdwbpQDNw2r-BvDN61tUA-1; Fri, 08 Sep 2023 13:32:38 -0400
X-MC-Unique: EjdwbpQDNw2r-BvDN61tUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2A9D94EA41
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Sep 2023 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D22A40ED414;
        Fri,  8 Sep 2023 17:32:37 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 1/2] parser_bison: include <nft.h> for base C environment to "parser_bison.y"
Date:   Fri,  8 Sep 2023 19:32:19 +0200
Message-ID: <20230908173226.1182353-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

All our C sources should include <nft.h> as first. This prepares an
environment of things that we expect to have available in all our C
sources (and indirectly in our internal header files, because internal
header files are always indirectly from a C source).

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 src/parser_bison.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 4a0c09a2912a..bfd53ab3b63a 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -9,6 +9,7 @@
  */
 
 %{
+#include <nft.h>
 
 #include <ctype.h>
 #include <stddef.h>
-- 
2.41.0

