Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D678889D
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Aug 2023 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbjHYNbR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Aug 2023 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245127AbjHYNaq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE81FDF
        for <netfilter-devel@vger.kernel.org>; Fri, 25 Aug 2023 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692970194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XxB36AJWWYJLCmQqpSWKQMmOS5IrMHS9BAehe+oZD4M=;
        b=UgqnFYq+Y3eA2GgeQTuKc9ry7jxD/ETKn184k2i5Vr2+41UbNbpH6POEGzue32dGxroDuw
        bMN1hM/G2D9mCr/Co09ioHUN8q2FjCwLBqq0fRpXIzxZ4La5P7uMuEgIZbGG93w+fstjZo
        Mm1rJ6DURzybFmBIzowMtqQBhEBMvCI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-myggNGOvOjGH65353ev5wQ-1; Fri, 25 Aug 2023 09:29:52 -0400
X-MC-Unique: myggNGOvOjGH65353ev5wQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 986A61C07260
        for <netfilter-devel@vger.kernel.org>; Fri, 25 Aug 2023 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16FD22166B26;
        Fri, 25 Aug 2023 13:29:51 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 0/4] add operation cache for timestamp
Date:   Fri, 25 Aug 2023 15:24:16 +0200
Message-ID: <20230825132942.2733840-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a cache for "time(NULL)" and tm_gmtoff from localtime_r(time(NULL), &tm).
The point is to ensure that one parse/output operation fetches the current time
and GMT offset at most once.

Follow up to ([1])

  Subject:  Re: [nft PATCH 2/2] meta: use reentrant localtime_r()/gmtime_r() functions
  Date:     Tue, 22 Aug 2023 17:15:14 +0200

[1] https://marc.info/?l=netfilter-devel&m=169271724629901&w=4

Thomas Haller (4):
  evaluate: add and use parse_ctx_init() helper method
  src: add ops_cache struct for caching information during parsing
  src: cache result of time() during parsing/output
  src: cache GMT offset for current time during parsing/output

 include/datatype.h | 22 ++++++++++++++++++++
 include/nftables.h |  3 +++
 src/datatype.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 src/evaluate.c     | 29 +++++++++++++++++++-------
 src/libnftables.c  | 17 +++++++++++++++
 src/meta.c         | 43 +++++++++++++++++++-------------------
 6 files changed, 136 insertions(+), 30 deletions(-)

-- 
2.41.0

