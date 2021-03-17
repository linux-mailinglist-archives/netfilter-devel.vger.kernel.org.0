Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6054633E274
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Mar 2021 00:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCPX4P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Mar 2021 19:56:15 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45516 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCPXzs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:55:48 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id B54C46353B
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 00:55:45 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] segtree: release single element already contained in an interval
Date:   Wed, 17 Mar 2021 00:55:35 +0100
Message-Id: <20210316235535.3329-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Before this patch:

 table ip x {
        chain y {
                ip saddr { 1.1.1.1-1.1.1.2, 1.1.1.1 }
        }
 }

results in:

 table ip x {
        chain y {
                ip saddr { 1.1.1.1 }
        }
 }

due to incorrect interval merge logic.

If the element 1.1.1.1 is already contained in an existing interval
1.1.1.1-1.1.1.2, release it.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1512
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/segtree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/segtree.c b/src/segtree.c
index 9aa39e52d8a0..ad199355532e 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -210,6 +210,12 @@ static int ei_insert(struct list_head *msgs, struct seg_tree *tree,
 			ei = lei;
 			goto err;
 		}
+		/* single element contained in an existing interval */
+		if (mpz_cmp(new->left, new->right) == 0) {
+			ei_destroy(new);
+			goto out;
+		}
+
 		/*
 		 * The new interval is entirely contained in the same interval,
 		 * split it into two parts:
@@ -277,7 +283,7 @@ static int ei_insert(struct list_head *msgs, struct seg_tree *tree,
 	}
 
 	__ei_insert(tree, new);
-
+out:
 	mpz_clear(p);
 
 	return 0;
-- 
2.20.1

