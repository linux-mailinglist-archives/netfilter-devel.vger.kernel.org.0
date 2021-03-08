Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4F33107F
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCHOMY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 09:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhCHOLv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:51 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3966C06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 06:11:50 -0800 (PST)
Received: from localhost ([::1]:53498 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lJGbt-0003Rx-Gv; Mon, 08 Mar 2021 15:11:49 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 2/5] expr/tunnel: Kill dead code
Date:   Mon,  8 Mar 2021 15:11:16 +0100
Message-Id: <20210308141119.17809-3-phil@nwl.cc>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308141119.17809-1-phil@nwl.cc>
References: <20210308141119.17809-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Function str2tunnel_key() was never used.

Fixes: 42468fb6df61a ("expr: add support for matching tunnel metadata")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/expr/tunnel.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/src/expr/tunnel.c b/src/expr/tunnel.c
index b2b8d7243a26c..62e164805fee6 100644
--- a/src/expr/tunnel.c
+++ b/src/expr/tunnel.c
@@ -124,19 +124,6 @@ static const char *tunnel_key2str(uint8_t key)
 	return "unknown";
 }
 
-static inline int str2tunnel_key(const char *str)
-{
-	int i;
-
-	for (i = 0; i <= NFT_TUNNEL_MAX; i++) {
-		if (strcmp(str, tunnel_key2str_array[i]) == 0)
-			return i;
-	}
-
-	errno = EINVAL;
-	return -1;
-}
-
 static int
 nftnl_expr_tunnel_snprintf_default(char *buf, size_t len,
 				 const struct nftnl_expr *e)
-- 
2.30.1

