Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5740331090
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Mar 2021 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhCHOOd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCHOOH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:14:07 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97757C06174A
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Mar 2021 06:14:07 -0800 (PST)
Received: from localhost ([::1]:53506 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lJGe6-0003UE-6r; Mon, 08 Mar 2021 15:14:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH] expr/{masq,nat}: Don't print unused regs
Date:   Mon,  8 Mar 2021 15:13:57 +0100
Message-Id: <20210308141357.19155-1-phil@nwl.cc>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

No point in printing the unset register value (which is zero then).

Fixes: af0c182670837 ("expr: masq: Add support for port selection")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/expr/masq.c | 10 +++++++---
 src/expr/nat.c  | 18 ++++++++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/expr/masq.c b/src/expr/masq.c
index 622ba282ff160..ea66fecdf2a72 100644
--- a/src/expr/masq.c
+++ b/src/expr/masq.c
@@ -138,9 +138,13 @@ static int nftnl_expr_masq_snprintf_default(char *buf, size_t len,
 	int remain = len, offset = 0, ret = 0;
 
 	if (e->flags & (1 << NFTNL_EXPR_MASQ_REG_PROTO_MIN)) {
-		ret = snprintf(buf, remain,
-			       "proto_min reg %u proto_max reg %u ",
-			       masq->sreg_proto_min, masq->sreg_proto_max);
+		ret = snprintf(buf + offset, remain, "proto_min reg %u ",
+			       masq->sreg_proto_min);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+	if (e->flags & (1 << NFTNL_EXPR_MASQ_REG_PROTO_MAX)) {
+		ret = snprintf(buf + offset, remain, "proto_max reg %u ",
+			       masq->sreg_proto_max);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 	if (e->flags & (1 << NFTNL_EXPR_MASQ_FLAGS)) {
diff --git a/src/expr/nat.c b/src/expr/nat.c
index 408521626d892..91a1ae6c99a43 100644
--- a/src/expr/nat.c
+++ b/src/expr/nat.c
@@ -236,15 +236,25 @@ nftnl_expr_nat_snprintf_default(char *buf, size_t size,
 
 	if (e->flags & (1 << NFTNL_EXPR_NAT_REG_ADDR_MIN)) {
 		ret = snprintf(buf + offset, remain,
-			       "addr_min reg %u addr_max reg %u ",
-			       nat->sreg_addr_min, nat->sreg_addr_max);
+			       "addr_min reg %u ", nat->sreg_addr_min);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+
+	if (e->flags & (1 << NFTNL_EXPR_NAT_REG_ADDR_MAX)) {
+		ret = snprintf(buf + offset, remain,
+			       "addr_max reg %u ", nat->sreg_addr_max);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
 	if (e->flags & (1 << NFTNL_EXPR_NAT_REG_PROTO_MIN)) {
 		ret = snprintf(buf + offset, remain,
-			       "proto_min reg %u proto_max reg %u ",
-			       nat->sreg_proto_min, nat->sreg_proto_max);
+			       "proto_min reg %u ", nat->sreg_proto_min);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+
+	if (e->flags & (1 << NFTNL_EXPR_NAT_REG_PROTO_MAX)) {
+		ret = snprintf(buf + offset, remain,
+			       "proto_max reg %u ", nat->sreg_proto_max);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
-- 
2.30.1

