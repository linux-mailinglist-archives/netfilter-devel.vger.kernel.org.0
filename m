Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924C7392F7
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfFGRVl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:21:41 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35938 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbfFGRVl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:21:41 -0400
Received: from localhost ([::1]:49028 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIYe-0006ts-Ad; Fri, 07 Jun 2019 19:21:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH v6 0/5] Support intra-transaction rule references
Date:   Fri,  7 Jun 2019 19:21:16 +0200
Message-Id: <20190607172121.21752-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

After Pablo's evaluation sequence rework, this series (formerly fixing
cache updates as well) has shrunken considerably:

Patch 1 contains a proper fix for that workaround in
evaluate_cache_add().

Patch 2 removes the cache-related workaround in tests/json_echo.

Patches 3 and 4 contain prerequisites for the last one, which actually
implements the support for referencing rules of the same transation with
'index' keyword.

Phil Sutter (5):
  cache: Fix evaluation for rules with index reference
  tests/json_echo: Drop needless workaround
  rule: Introduce rule_lookup_by_index()
  src: Make cache_is_complete() public
  src: Support intra-transaction rule references

 include/rule.h                                |  5 +
 src/cache.c                                   |  8 +-
 src/evaluate.c                                | 94 +++++++++++++++----
 src/mnl.c                                     |  4 +
 src/rule.c                                    | 13 ++-
 tests/json_echo/run-test.py                   |  6 +-
 .../shell/testcases/cache/0003_cache_update_0 |  7 ++
 tests/shell/testcases/transactions/0024rule_0 | 17 ++++
 tests/shell/testcases/transactions/0025rule_0 | 21 +++++
 .../transactions/dumps/0024rule_0.nft         |  8 ++
 .../transactions/dumps/0025rule_0.nft         |  6 ++
 11 files changed, 157 insertions(+), 32 deletions(-)
 create mode 100755 tests/shell/testcases/transactions/0024rule_0
 create mode 100755 tests/shell/testcases/transactions/0025rule_0
 create mode 100644 tests/shell/testcases/transactions/dumps/0024rule_0.nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0025rule_0.nft

-- 
2.21.0

