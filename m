Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546587EBFA4
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 10:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjKOJmm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 04:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjKOJml (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:42:41 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1098411C
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 01:42:38 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, thaller@redhat.com
Subject: [PATCH nft 0/4] more tests/shell updates to run on 5.4 kernels
Date:   Wed, 15 Nov 2023 10:42:27 +0100
Message-Id: <20231115094231.168870-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This patchset contains more updates for tests/shell to support 5.4 kernels:

1) Detect if kernel comes with flowtable counter support.
2) Detect if kernel comes with flowtable can be defined with no devices.
3) Skip pipapo tests if transactions/30s-stress.
4) Restore pipapo and chain binding tests in transactions/30s-stress
   when it is run standalone.

I am still dealing with 3 tests that fail in 5.4, one of them is:

sets/sets_with_ifnames

which needs a bit of work to detach pipapo support from it.

The remaining two failing tests are related to the flowtable, I am still
diagnosing these.

Pablo Neira Ayuso (4):
  tests: shell: skip if kernel does not support flowtable counter
  tests: shell: skip if kernel does not support flowtable with no devices
  tests: shell: skip pipapo set backend in transactions/30s-stress
  tests: shell: restore pipapo and chain binding coverage in standalone 30s-stress

 tests/shell/features/flowtable_counter.sh     | 16 +++++
 tests/shell/features/flowtable_no_devices.nft |  8 +++
 .../flowtable/0012flowtable_variable_0        |  2 +
 tests/shell/testcases/listing/0020flowtable_0 |  2 +
 tests/shell/testcases/transactions/30s-stress | 60 ++++++++++++++++---
 5 files changed, 81 insertions(+), 7 deletions(-)
 create mode 100755 tests/shell/features/flowtable_counter.sh
 create mode 100755 tests/shell/features/flowtable_no_devices.nft

-- 
2.30.2

