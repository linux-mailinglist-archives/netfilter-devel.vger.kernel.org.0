Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA513A46AE
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFKQnc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFKQnb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:31 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C656C061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:41:32 -0700 (PDT)
Received: from localhost ([::1]:41348 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkDq-0005eF-M8; Fri, 11 Jun 2021 18:41:30 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 09/10] netlink_delinearize: Fix suspicious calloc() call
Date:   Fri, 11 Jun 2021 18:41:03 +0200
Message-Id: <20210611164104.8121-10-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Parameter passed to sizeof() was wrong. While being at it, replace the
whole call with xmalloc_array() which takes care of error checking.

Fixes: 913979f882d13 ("src: add expression handler hashtable")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_delinearize.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index a71d06d7fe12f..9a1cf3c4f7d90 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -1733,9 +1733,8 @@ void expr_handler_init(void)
 	unsigned int i;
 	uint32_t hash;
 
-	expr_handle_ht = calloc(NFT_EXPR_HSIZE, sizeof(expr_handle_ht));
-	if (!expr_handle_ht)
-		memory_allocation_error();
+	expr_handle_ht = xmalloc_array(NFT_EXPR_HSIZE,
+				       sizeof(expr_handle_ht[0]));
 
 	for (i = 0; i < array_size(netlink_parsers); i++) {
 		hash = djb_hash(netlink_parsers[i].name) % NFT_EXPR_HSIZE;
-- 
2.31.1

