Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6810EE3B
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 18:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfLBRdP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 12:33:15 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:54118 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfLBRdP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:33:15 -0500
Received: from localhost ([::1]:38976 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1ibpZR-0005fE-J7; Mon, 02 Dec 2019 18:33:13 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH] tests: flowtable: Don't check NFTNL_FLOWTABLE_SIZE
Date:   Mon,  2 Dec 2019 18:33:05 +0100
Message-Id: <20191202173305.29737-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Marshalling code around that attribute has been dropped by commit
d1c4b98c733a5 ("flowtable: remove NFTA_FLOWTABLE_SIZE") so it's value is
lost during the test.

Assuming that NFTNL_FLOWTABLE_SIZE will receive kernel support at a
later point, leave the test code in place but just comment it out.

Fixes: d1c4b98c733a5 ("flowtable: remove NFTA_FLOWTABLE_SIZE")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/nft-flowtable-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nft-flowtable-test.c b/tests/nft-flowtable-test.c
index 3edb00ddf3196..8ab8d4c5347a4 100644
--- a/tests/nft-flowtable-test.c
+++ b/tests/nft-flowtable-test.c
@@ -33,9 +33,11 @@ static void cmp_nftnl_flowtable(struct nftnl_flowtable *a, struct nftnl_flowtabl
 	if (nftnl_flowtable_get_u32(a, NFTNL_FLOWTABLE_USE) !=
 	    nftnl_flowtable_get_u32(b, NFTNL_FLOWTABLE_USE))
 		print_err("Flowtable use mismatches");
+#if 0
 	if (nftnl_flowtable_get_u32(a, NFTNL_FLOWTABLE_SIZE) !=
 	    nftnl_flowtable_get_u32(b, NFTNL_FLOWTABLE_SIZE))
 		print_err("Flowtable size mismatches");
+#endif
 	if (nftnl_flowtable_get_u32(a, NFTNL_FLOWTABLE_FLAGS) !=
 	    nftnl_flowtable_get_u32(b, NFTNL_FLOWTABLE_FLAGS))
 		print_err("Flowtable flags mismatches");
-- 
2.24.0

