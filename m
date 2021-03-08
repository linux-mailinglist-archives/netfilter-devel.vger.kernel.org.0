Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A3331077
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 15:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCHOLw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 09:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhCHOLp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:45 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F21C06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 06:11:45 -0800 (PST)
Received: from localhost ([::1]:53494 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lJGbo-0003Rs-7l; Mon, 08 Mar 2021 15:11:44 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 3/5] expr/xfrm: Kill dead code
Date:   Mon,  8 Mar 2021 15:11:17 +0100
Message-Id: <20210308141119.17809-4-phil@nwl.cc>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308141119.17809-1-phil@nwl.cc>
References: <20210308141119.17809-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These functions were used by removed JSON parser only.

Fixes: 80077787f8f21 ("src: remove json support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/expr/xfrm.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/src/expr/xfrm.c b/src/expr/xfrm.c
index 8fe5438bd792a..0502b53bb7edc 100644
--- a/src/expr/xfrm.c
+++ b/src/expr/xfrm.c
@@ -171,34 +171,6 @@ static const char *xfrmdir2str(uint8_t dir)
 	return xfrmdir2str_array[dir];
 }
 
-#ifdef JSON_PARSING
-static uint32_t str2xfrmkey(const char *s)
-{
-	int i;
-
-	for (i = 0;
-	     i < sizeof(xfrmkey2str_array) / sizeof(xfrmkey2str_array[0]);
-	     i++) {
-		if (strcmp(xfrmkey2str_array[i], s) == 0)
-			return i;
-	}
-	return -1;
-}
-
-static int str2xfmrdir(const char *s)
-{
-	int i;
-
-	for (i = 0;
-	     i <  sizeof(xfrmdir2str_array) / sizeof(xfrmdir2str_array[0]);
-	     i++) {
-		if (strcmp(xfrmkey2str_array[i], s) == 0)
-			return i;
-	}
-	return -1;
-}
-#endif
-
 static int
 nftnl_expr_xfrm_snprintf_default(char *buf, size_t size,
 			       const struct nftnl_expr *e)
-- 
2.30.1

