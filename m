Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E11B25EA
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgDUMZq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 08:25:46 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43996 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbgDUMZq (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:25:46 -0400
Received: from localhost ([::1]:47310 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jQry9-0000JX-LG; Tue, 21 Apr 2020 14:25:41 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/3] tests: shell: Improve ipt-restore/0001load-specific-table_0 a bit
Date:   Tue, 21 Apr 2020 14:25:31 +0200
Message-Id: <20200421122533.29169-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of reading from stdin, pass dump file as regular parameter. This
way dump file name occurs in 'bash -x' output which helps finding out
where things fail.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../tests/shell/testcases/ipt-restore/0001load-specific-table_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/tests/shell/testcases/ipt-restore/0001load-specific-table_0 b/iptables/tests/shell/testcases/ipt-restore/0001load-specific-table_0
index ce3bef3a88355..3f443a980ab3a 100755
--- a/iptables/tests/shell/testcases/ipt-restore/0001load-specific-table_0
+++ b/iptables/tests/shell/testcases/ipt-restore/0001load-specific-table_0
@@ -22,7 +22,7 @@ do_simple()
 	table="${2}"
 	dumpfile="$(dirname "${0}")/dumps/${iptables}.dump"
 
-	"$XT_MULTI" "${iptables}-restore" --table="${table}" <"${dumpfile}"; rv=$?
+	"$XT_MULTI" "${iptables}-restore" --table="${table}" "${dumpfile}"; rv=$?
 
 	if [ "${rv}" -ne 0 ]; then
 		RET=1
-- 
2.25.1

