Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC15039316
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfFGRZr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:25:47 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35990 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbfFGRZr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:25:47 -0400
Received: from localhost ([::1]:49080 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIcb-0006yS-N0; Fri, 07 Jun 2019 19:25:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 4/4] tests/shell: Print unified diffs in dump errors
Date:   Fri,  7 Jun 2019 19:25:27 +0200
Message-Id: <20190607172527.22177-5-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607172527.22177-1-phil@nwl.cc>
References: <20190607172527.22177-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Non-unified format is useful only if the expected output is printed as
well, which is not the case.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/shell/run-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index 81ee0cdd62f4a..632cccee0af29 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -106,7 +106,7 @@ do
 		dumpfile="${dumppath}/$(basename ${testfile}).nft"
 		rc_spec=0
 		if [ "$rc_got" -eq 0 ] && [ -f ${dumpfile} ]; then
-			test_output=$(${DIFF} ${dumpfile} <($NFT list ruleset) 2>&1)
+			test_output=$(${DIFF} -u ${dumpfile} <($NFT list ruleset) 2>&1)
 			rc_spec=$?
 		fi
 
-- 
2.21.0

