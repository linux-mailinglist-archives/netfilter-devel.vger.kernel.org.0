Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D5EDA1E4
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 01:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389833AbfJPXDn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 19:03:43 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40202 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbfJPXDn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:03:43 -0400
Received: from localhost ([::1]:53292 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKsKU-0005er-E3; Thu, 17 Oct 2019 01:03:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/4] A bunch of fixes for --echo option
Date:   Thu, 17 Oct 2019 01:03:18 +0200
Message-Id: <20191016230322.24432-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Echo/monitor testsuite failed for multiple reasons. With this series
applied and a libnftnl with the recently submiited NFTA_CT_TIMEOUT_DATA
parser fix in place, testsuite finally passes again.

Phil Sutter (4):
  monitor: Add missing newline to error message
  Revert "monitor: fix double cache update with --echo"
  tests/monitor: Fix for changed ct timeout format
  rule: Fix for single line ct timeout printing

 src/monitor.c                    | 3 ++-
 src/rule.c                       | 2 +-
 tests/monitor/testcases/object.t | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.23.0

