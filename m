Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF53A46A8
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFKQnU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQnT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:19 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F7C061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:41:21 -0700 (PDT)
Received: from localhost ([::1]:41336 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkDg-0005de-2L; Fri, 11 Jun 2021 18:41:20 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 02/10] parser_json: Fix for memleak in tcp option error path
Date:   Fri, 11 Jun 2021 18:40:56 +0200
Message-Id: <20210611164104.8121-3-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If 'kind' value is invalid, the function returned without freeing 'expr'
first. Fix this by performing the check before allocation.

Fixes: cb21869649208 ("json: tcp: add raw tcp option match support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/parser_json.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/parser_json.c b/src/parser_json.c
index e6a0233ab6ce3..bb0e4169b477d 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -603,12 +603,12 @@ static struct expr *json_parse_tcp_option_expr(struct json_ctx *ctx,
 			"base", &kind, "offset", &offset, "len", &len)) {
 		uint32_t flag = 0;
 
-		expr = tcpopt_expr_alloc(int_loc, kind,
-					 TCPOPT_COMMON_KIND);
-
 		if (kind < 0 || kind > 255)
 			return NULL;
 
+		expr = tcpopt_expr_alloc(int_loc, kind,
+					 TCPOPT_COMMON_KIND);
+
 		if (offset == TCPOPT_COMMON_KIND && len == 8)
 			flag = NFT_EXTHDR_F_PRESENT;
 
-- 
2.31.1

