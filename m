Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24017CBE25
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Oct 2023 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjJQIwi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Oct 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjJQIwg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF8130
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Oct 2023 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697532706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z43of1+jmRwnwMqTSBAL1vhWxn3YCMD9G8RPyFn18xs=;
        b=HCzpzknuGiqh5KGEVL/fFGOqUplBJr0gTFEevR5+z+qARLUzGJjFTB/mSd6WIUTzYFnYiu
        QfsYo8hzH1a8D+CoFiD7P7XVe8Ac26tslDRCbZThm/16vU6sfICyiF0FVyJHU1JpqKRfv/
        OSkIT0NjYQ8pDphxjJ8n3E9rBTcnYOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494--16PfyobMTC9lT6O4P76UQ-1; Tue, 17 Oct 2023 04:51:44 -0400
X-MC-Unique: -16PfyobMTC9lT6O4P76UQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2045D28EA6EB
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Oct 2023 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 951BA492BEF;
        Tue, 17 Oct 2023 08:51:43 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft v2 0/3] add "eval-exit-code" and skip tests based on kernel version
Date:   Tue, 17 Oct 2023 10:49:05 +0200
Message-ID: <20231017085133.1203402-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a follow-up and replaces the two patches:

  [PATCH nft 1/3] tests/shell: skip "table_onoff" test if kernel patch is missing
  [PATCH nft 2/3] tests/shell: skip "vlan_8021ad_tag" test instead of failing

Instead, add a helper script "eval-exit-code" which makes it easy(?) to
conditionally downgrade a test failure to a SKIP (exit 77) based on the
kernel version.

Thomas Haller (3):
  tests/shell: add "tests/shell/helpers/eval-exit-code"
  tests/shell: skip "table_onoff" test on older kernels
  tests/shell: skip "vlan_8021ad_tag" test on older kernels

 tests/shell/helpers/eval-exit-code            | 116 ++++++++++++++++++
 .../testcases/packetpath/vlan_8021ad_tag      |   8 +-
 .../shell/testcases/transactions/table_onoff  |   4 +-
 3 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100755 tests/shell/helpers/eval-exit-code

-- 
2.41.0

