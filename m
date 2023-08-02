Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0376D6DF
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Aug 2023 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbjHBSam (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Aug 2023 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjHBSal (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BA1724
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Aug 2023 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691000993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VqtO8FZ5iwxtBIoSkBaSVd3Pc1zbl4dDWYpEWJ2qFrE=;
        b=bdaT7NJGSoOLsD4/5af+/Ldv8UUO/msMXgRhN+X3+M0Rg+akUo3epq17wp5iHDuc18yRWX
        rlgLz426W6kyvFxG6aQCivz/1HAvznnN0Tz2oskjUxucnXiGlYxXL7twUE2T66QCZt8tPd
        GXIQdWx/xY9jXUJ3Y8xhCfz743MtK7A=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-972GISf9PJajyV-Iw8DWpQ-1; Wed, 02 Aug 2023 14:29:50 -0400
X-MC-Unique: 972GISf9PJajyV-Iw8DWpQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E018D2800E86;
        Wed,  2 Aug 2023 18:29:49 +0000 (UTC)
Received: from bpaciore-thinkpadt14sgen2i.remote.csb (unknown [10.22.17.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9063C492C13;
        Wed,  2 Aug 2023 18:29:49 +0000 (UTC)
From:   Brennan Paciorek <bpaciore@redhat.com>
To:     netfilter-devel@vger.kernel.org
Cc:     Brennan Paciorek <bpaciore@redhat.com>, Phil Sutter <phil@nwl.cc>
Subject: [nft PATCH] doc: document add chain device parameter
Date:   Wed,  2 Aug 2023 14:29:47 -0400
Message-ID: <20230802182947.24789-1-bpaciore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft add chain lacked documentation of its optional device parameter,
specifically what values the parameter accepted, what it did and
when to use it.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1093
Suggested-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Brennan Paciorek <bpaciore@redhat.com>
---
 doc/nft.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/nft.txt b/doc/nft.txt
index fe123d04..7e47ca39 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -434,6 +434,11 @@ further quirks worth noticing:
   *prerouting*, *input*, *forward*, *output*, *postrouting* and this *ingress*
   hook.
 
+The *device* parameter accepts a network interface name as a string, and is
+required when adding a base chain that filters traffic on the ingress or
+egress hooks. Any ingress or egress chains will only filter traffic from the
+interface specified in the *device* parameter.
+
 The *priority* parameter accepts a signed integer value or a standard priority
 name which specifies the order in which chains with the same *hook* value are
 traversed. The ordering is ascending, i.e. lower priority values have precedence
-- 
2.41.0

