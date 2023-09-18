Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059657A5251
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Sep 2023 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRSrl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Sep 2023 14:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjIRSrk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541310E
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Sep 2023 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695062811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wXUUNVCIJmg6udVhLQ75B6vie7NiQVJti2R15BxCmWk=;
        b=Qr0iMkrcTg0EegOQVKXkG1DsYTAag2dUIRoGXSeES+OX11CmgxySUZJCJYArJBFZ79GjIt
        mw9yKZVOUXX5L8A7j6Ph+OryC886URAkyFsd5elBML82n04bOFh5LVmgRS3g8df0ztrd9h
        /3zLjJSokdIBZ1Nb4PBFbxIiu2JC+0k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-KfwlTyXBOkOi6Mr6swRMpw-1; Mon, 18 Sep 2023 14:46:50 -0400
X-MC-Unique: KfwlTyXBOkOi6Mr6swRMpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DB0F1C01727
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Sep 2023 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AEC34011E4;
        Mon, 18 Sep 2023 18:46:44 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft 0/3] tests/shell: minor improvements to "run-tests.sh"
Date:   Mon, 18 Sep 2023 20:45:18 +0200
Message-ID: <20230918184634.3471832-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These patches out from another branch. Three minor improvements.

Thomas Haller (3):
  tests/shell: set C locale in "run-tests.sh"
  tests/shell: don't show the exit status for failed tests
  tests/shell: colorize NFT_TEST_HAS_SOCKET_LIMITS

 tests/shell/run-tests.sh | 46 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

-- 
2.41.0

