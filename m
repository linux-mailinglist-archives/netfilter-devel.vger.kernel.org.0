Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72493A46A4
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhFKQnB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFKQm7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:42:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B1C0617AF
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:41:00 -0700 (PDT)
Received: from localhost ([::1]:41312 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkDK-0005bu-TU; Fri, 11 Jun 2021 18:40:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 04/10] json: Drop pointless assignment in exthdr_expr_json()
Date:   Fri, 11 Jun 2021 18:40:58 +0200
Message-Id: <20210611164104.8121-5-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The updated value of 'is_exists' is no longer read at this point.

Fixes: cb21869649208 ("json: tcp: add raw tcp option match support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/json.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/json.c b/src/json.c
index f648ea1b8c178..f111ad678f8a0 100644
--- a/src/json.c
+++ b/src/json.c
@@ -708,7 +708,6 @@ json_t *exthdr_expr_json(const struct expr *expr, struct output_ctx *octx)
 					 "base", expr->exthdr.raw_type,
 					 "offset", expr->exthdr.offset,
 					 "len", expr->len);
-			is_exists = false;
 		}
 
 		return json_pack("{s:o}", "tcp option", root);
-- 
2.31.1

