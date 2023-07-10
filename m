Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994A474D096
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jul 2023 10:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGJIu2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jul 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGJIu1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA104C3
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 01:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688978982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ss4LqPV90koYkPPYmMN3WCvm/6+fZB+hrqiDFrdjejQ=;
        b=BosVxd9OKy7vH1sSMXdsrECpAE2rKzbU2tIV7SDiCIQuRnmgdMSS9YkJODpbD2TtY/GGB/
        cIDCCRP2yZ2qTnvHSricj4B+HMXMLhUNfcjAYViamOdGOtYB9kNeHIkQqtEDRVfg/R2fFq
        CRtO5fQWmgFulvnYt2isXF9K+dY+4kQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-oBQ07DEKP6SHcmaS6_C7uA-1; Mon, 10 Jul 2023 04:49:40 -0400
X-MC-Unique: oBQ07DEKP6SHcmaS6_C7uA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3246F2999B20
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jul 2023 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB6B0111DCE1;
        Mon, 10 Jul 2023 08:49:39 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [nft PATCH 0/4] libnftables: minor cleanups initalizing nf_sock instance of nft_ctx
Date:   Mon, 10 Jul 2023 10:45:15 +0200
Message-ID: <20230710084926.172198-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There is some unnecessary or redundant code in "src/libnftables.c".
Clean up.

This was motivated by an attempt to add a new flag for nft_ctx_new(),
beside NFT_CTX_DEFAULT. The current "if (flags == NFT_CTX_DEFAULT)"
check is an odd usage for flags (because we would want that behavior for
all flags).

Thomas Haller (4):
  libnftables: always initialize netlink socket in nft_ctx_new()
  libnftables: drop unused argument nf_sock from nft_netlink()
  libnftables: inline creation of nf_sock in nft_ctx_new()
  libnftables: drop check for nf_sock in nft_ctx_free()

 src/libnftables.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

-- 
2.41.0

