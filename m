Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6A153C65
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Feb 2020 01:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBFA7N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Feb 2020 19:59:13 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:47710 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBFA7N (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:59:13 -0500
Received: from localhost ([::1]:60800 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1izVVg-0000me-G4; Thu, 06 Feb 2020 01:59:12 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 3/4] tests: monitor: Support testing host's nft binary
Date:   Thu,  6 Feb 2020 01:58:50 +0100
Message-Id: <20200206005851.28962-4-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206005851.28962-1-phil@nwl.cc>
References: <20200206005851.28962-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add support for -H/--host flag to use 'nft' tool from $PATH instead of
the local one.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/monitor/run-tests.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/monitor/run-tests.sh b/tests/monitor/run-tests.sh
index efacdaaab952b..ffb833a7f86f0 100755
--- a/tests/monitor/run-tests.sh
+++ b/tests/monitor/run-tests.sh
@@ -119,6 +119,10 @@ while [ -n "$1" ]; do
 		test_json=true
 		shift
 		;;
+	-H|--host)
+		nft=nft
+		shift
+		;;
 	testcases/*.t)
 		testcases+=" $1"
 		shift
-- 
2.24.1

