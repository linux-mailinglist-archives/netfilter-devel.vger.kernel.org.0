Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE0146B56
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jan 2020 15:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAWOai (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jan 2020 09:30:38 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:39876 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWOai (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:30:38 -0500
Received: from localhost ([::1]:52964 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iudVE-0000mi-Sa; Thu, 23 Jan 2020 15:30:36 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [nft PATCH 3/4] segtree: Simplify overlap case in ei_insert()
Date:   Thu, 23 Jan 2020 15:30:48 +0100
Message-Id: <20200123143049.13888-4-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123143049.13888-1-phil@nwl.cc>
References: <20200123143049.13888-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since upper boundary overlaps can't happen, lower boundary overlaps may
simply be resolved by adjusting the existing range's upper boundary to
that of the new one instead of adding elements which are later dropped
again.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/segtree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/segtree.c b/src/segtree.c
index 47e326533ac39..3c0989e76093a 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -214,19 +214,16 @@ static int ei_insert(struct list_head *msgs, struct seg_tree *tree,
 			/*
 			 * Left endpoint is within lei, adjust it so we have:
 			 *
-			 * [lei_left, new_left)[new_left, new_right]
+			 * [lei_left, new_right]
 			 */
 			if (segtree_debug(tree->debug_mask)) {
 				pr_gmp_debug("adjust left [%Zx %Zx]\n",
 					     lei->left, lei->right);
 			}
 
-			mpz_sub_ui(lei->right, new->left, 1);
-			mpz_sub(lei->size, lei->right, lei->left);
-			if (mpz_sgn(lei->size) < 0) {
-				ei_remove(tree, lei);
-				ei_destroy(lei);
-			}
+			mpz_set(lei->right, new->right);
+			ei_destroy(new);
+			return 0;
 		}
 	}
 
-- 
2.24.1

