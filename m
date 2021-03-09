Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE6332AF1
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhCIPqd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 10:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhCIPqP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:46:15 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5BAC06174A
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 07:46:14 -0800 (PST)
Received: from localhost ([::1]:56694 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lJeYn-00017G-Hf; Tue, 09 Mar 2021 16:46:13 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 02/10] obj/ct_expect: Fix snprintf buffer length updates
Date:   Tue,  9 Mar 2021 16:45:08 +0100
Message-Id: <20210309154516.4987-3-phil@nwl.cc>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309154516.4987-1-phil@nwl.cc>
References: <20210309154516.4987-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Have to pass shrinking 'remain' variable to consecutive snprintf calls
instead of the unchanged 'len' parameter.

Fixes: c4b6aa09b85d2 ("src: add ct expectation support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/obj/ct_expect.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/obj/ct_expect.c b/src/obj/ct_expect.c
index c0bb5bad0246b..0b4eb8fe541d9 100644
--- a/src/obj/ct_expect.c
+++ b/src/obj/ct_expect.c
@@ -159,23 +159,27 @@ static int nftnl_obj_ct_expect_snprintf_default(char *buf, size_t len,
 	struct nftnl_obj_ct_expect *exp = nftnl_obj_data(e);
 
 	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_L3PROTO)) {
-		ret = snprintf(buf + offset, len, "family %d ", exp->l3proto);
+		ret = snprintf(buf + offset, remain,
+			       "family %d ", exp->l3proto);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_L4PROTO)) {
-		ret = snprintf(buf + offset, len, "protocol %d ", exp->l4proto);
+		ret = snprintf(buf + offset, remain,
+			       "protocol %d ", exp->l4proto);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_DPORT)) {
-		ret = snprintf(buf + offset, len, "dport %d ", exp->dport);
+		ret = snprintf(buf + offset, remain,
+			       "dport %d ", exp->dport);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_TIMEOUT)) {
-		ret = snprintf(buf + offset, len, "timeout %d ", exp->timeout);
+		ret = snprintf(buf + offset, remain,
+			       "timeout %d ", exp->timeout);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_SIZE)) {
-		ret = snprintf(buf + offset, len, "size %d ", exp->size);
+		ret = snprintf(buf + offset, remain, "size %d ", exp->size);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
-- 
2.30.1

