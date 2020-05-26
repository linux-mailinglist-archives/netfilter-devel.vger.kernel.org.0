Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221991BFFDB
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgD3POe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726787AbgD3POe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:14:34 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720CFC035494
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 08:14:34 -0700 (PDT)
Received: from localhost ([::1]:43944 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jUAtV-0008BM-95; Thu, 30 Apr 2020 17:14:33 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/4] segtree: Use expr_clone in get_set_interval_*()
Date:   Thu, 30 Apr 2020 17:14:06 +0200
Message-Id: <20200430151408.32283-3-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200430151408.32283-1-phil@nwl.cc>
References: <20200430151408.32283-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Both functions perform interval set lookups with either start and end or
only start values as input. Interestingly, in practice they either see
values which are not contained or which match an existing range exactly.

Make use of the above and just return a clone of the matching entry
instead of creating a new one based on input data.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/segtree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/segtree.c b/src/segtree.c
index 002ee41a16db0..f81a66e185990 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -708,9 +708,7 @@ static struct expr *get_set_interval_find(const struct table *table,
 			range_expr_value_high(high, i);
 			if (mpz_cmp(left->key->value, low) >= 0 &&
 			    mpz_cmp(right->key->value, high) <= 0) {
-				range = range_expr_alloc(&internal_location,
-							 expr_clone(left->key),
-							 expr_clone(right->key));
+				range = expr_clone(i->key);
 				goto out;
 			}
 			break;
@@ -742,9 +740,7 @@ static struct expr *get_set_interval_end(const struct table *table,
 		case EXPR_RANGE:
 			range_expr_value_low(low, i);
 			if (mpz_cmp(low, left->key->value) == 0) {
-				range = range_expr_alloc(&internal_location,
-							 expr_clone(left->key),
-							 expr_clone(i->key->right));
+				range = expr_clone(i->key);
 				goto out;
 			}
 			break;
-- 
2.25.1

