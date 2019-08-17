Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0C91046
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfHQLc5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 07:32:57 -0400
Received: from vxsys-smtpclusterma-05.srv.cat ([46.16.61.54]:47067 "EHLO
        vxsys-smtpclusterma-05.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbfHQLc5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 07:32:57 -0400
Received: from localhost.localdomain (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-05.srv.cat (Postfix) with ESMTPA id DF62124209
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Aug 2019 13:32:54 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl v2 2/2] expr: meta: Make NFT_DYNSET_OP_DELETE known
Date:   Sat, 17 Aug 2019 13:32:48 +0200
Message-Id: <20190817113248.9832-2-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190817113248.9832-1-a@juaristi.eus>
References: <20190817113248.9832-1-a@juaristi.eus>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 include/linux/netfilter/nf_tables.h | 1 +
 src/expr/dynset.c                   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index 0222d08..75e083e 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -636,6 +636,7 @@ enum nft_lookup_attributes {
 enum nft_dynset_ops {
 	NFT_DYNSET_OP_ADD,
 	NFT_DYNSET_OP_UPDATE,
+	NFT_DYNSET_OP_DELETE,
 };
 
 enum nft_dynset_flags {
diff --git a/src/expr/dynset.c b/src/expr/dynset.c
index 68115ba..4870923 100644
--- a/src/expr/dynset.c
+++ b/src/expr/dynset.c
@@ -208,11 +208,12 @@ nftnl_expr_dynset_parse(struct nftnl_expr *e, struct nlattr *attr)
 static const char *op2str_array[] = {
 	[NFT_DYNSET_OP_ADD]		= "add",
 	[NFT_DYNSET_OP_UPDATE] 		= "update",
+	[NFT_DYNSET_OP_DELETE]		= "delete",
 };
 
 static const char *op2str(enum nft_dynset_ops op)
 {
-	if (op > NFT_DYNSET_OP_UPDATE)
+	if (op > NFT_DYNSET_OP_DELETE)
 		return "unknown";
 	return op2str_array[op];
 }
-- 
2.17.1

