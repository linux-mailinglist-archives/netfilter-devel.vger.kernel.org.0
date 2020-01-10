Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180B9136BBD
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgAJLLa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 06:11:30 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34992 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgAJLL3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:11:29 -0500
Received: from localhost ([::1]:48082 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1ipsCO-0002l0-PL; Fri, 10 Jan 2020 12:11:28 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/3] Fixes for monitor/echo mode with maps
Date:   Fri, 10 Jan 2020 12:11:11 +0100
Message-Id: <20200110111114.23952-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Patch 1 fixes a segfault when trying to add a rule referring to a map
and adds a relevant test case. Patch 2 fixes for wrong format of map
values, this is already covered by existing tests. Patch 3 merely
improves versatility of tests/monitor/run-tests.sh a bit.

Phil Sutter (3):
  monitor: Do not decompose non-anonymous sets
  monitor: Fix for use after free when printing map elements
  tests: monitor: Support running individual test cases

 src/monitor.c                          |  5 +++--
 tests/monitor/run-tests.sh             |  9 +++++++--
 tests/monitor/testcases/set-interval.t | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)
 create mode 100644 tests/monitor/testcases/set-interval.t

-- 
2.24.1

