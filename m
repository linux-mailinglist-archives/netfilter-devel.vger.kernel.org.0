Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A143931B
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfFGRZ6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:25:58 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:36002 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfFGRZ5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:25:57 -0400
Received: from localhost ([::1]:49092 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIcm-0006zD-Aq; Fri, 07 Jun 2019 19:25:56 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/4] Some fixes and minor improvements in tests/
Date:   Fri,  7 Jun 2019 19:25:23 +0200
Message-Id: <20190607172527.22177-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series mostly adds missing bits and changes to JSON equivalents in
tests/py to avoid errors when running the suite with -j flag.

In addition to that, patch 3 fixes awk syntax in 0028delete_handle_0
test of tests/shell suite. Patch 4 improves the diff output upon dump
errors in same suite by printing unified diffs instead of normal ones.

Phil Sutter (4):
  tests/py: Fix JSON equivalents
  tests/py: Add missing arp.t JSON equivalents
  tests/shell: Fix warning from awk call
  tests/shell: Print unified diffs in dump errors

 tests/py/any/ct.t.json                        |  35 ++++--
 tests/py/any/ct.t.json.output                 |  21 +++-
 tests/py/any/meta.t.json                      | 110 +++++++-----------
 tests/py/arp/arp.t.json                       |  64 ++++++++++
 tests/py/arp/arp.t.json.output                |  14 +--
 tests/shell/run-tests.sh                      |   2 +-
 .../shell/testcases/sets/0028delete_handle_0  |   2 +-
 7 files changed, 158 insertions(+), 90 deletions(-)

-- 
2.21.0

