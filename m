Return-Path: <netfilter-devel+bounces-5606-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0896A00CC2
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jan 2025 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C32163FF6
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jan 2025 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0FE1FBEAF;
	Fri,  3 Jan 2025 17:35:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1C61F9EDF
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jan 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925740; cv=none; b=LF7eyRqqfYYC9pnSxL2AbVstXTecuxdIVYlKONlg58OyFSKy9dgo85A4zTQ2ZiIZQMlgHuucEVRpcCbtD1Snsy/BJAQ6HfkupisevS8ciEL2XRW3VPL10rPWevB/S8XeeImskP91UfahhGwdfl0rNeVQ43Q4xreTMYOCfi4gz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925740; c=relaxed/simple;
	bh=OWz95vhIpQ3IJfyPk0ShGtKJ//XjitdaOqxEiL/1TpQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtPNC5HZdFNHdxw/LmKQPzVcTtcrlHTuILlav6OFBJbLVqbmTcTJglAVoPU4NbaRyRYwYn9K9KdpZjenCD+EkHnnX27XGAzLd6mCP5KoUTJFvqdvOmsbp9FFnus5n6mwmcptsMQcmOUMOWa0XsSZ2dMqXpfg9TvF8nc17zZ7XCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
X-Spam-Level: 
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 5/7] mnl: rename list of expression in mnl_nft_setelem_batch()
Date: Fri,  3 Jan 2025 18:35:20 +0100
Message-Id: <20250103173522.773063-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250103173522.773063-1-pablo@netfilter.org>
References: <20250103173522.773063-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename set to init to prepare to pass struct set to this function in
the follow up patch. No functional changes are intended.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes.

 src/mnl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 88fac5bd0393..52085d6d960a 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -1731,7 +1731,7 @@ static int mnl_nft_setelem_batch(const struct nftnl_set *nls, struct cmd *cmd,
 				 struct nftnl_batch *batch,
 				 enum nf_tables_msg_types msg_type,
 				 unsigned int flags, uint32_t *seqnum,
-				 const struct expr *set,
+				 const struct expr *init,
 				 struct netlink_ctx *ctx)
 {
 	struct nlattr *nest1, *nest2;
@@ -1743,8 +1743,8 @@ static int mnl_nft_setelem_batch(const struct nftnl_set *nls, struct cmd *cmd,
 	if (msg_type == NFT_MSG_NEWSETELEM)
 		flags |= NLM_F_CREATE;
 
-	if (set)
-		expr = list_first_entry(&set->expressions, struct expr, list);
+	if (init)
+		expr = list_first_entry(&init->expressions, struct expr, list);
 
 next:
 	nlh = nftnl_nlmsg_build_hdr(nftnl_batch_buffer(batch), msg_type,
@@ -1764,13 +1764,13 @@ next:
 				 htonl(nftnl_set_get_u32(nls, NFTNL_SET_ID)));
 	}
 
-	if (!set || list_empty(&set->expressions))
+	if (!init || list_empty(&init->expressions))
 		return 0;
 
 	assert(expr);
 	nest1 = mnl_attr_nest_start(nlh, NFTA_SET_ELEM_LIST_ELEMENTS);
-	list_for_each_entry_from(expr, &set->expressions, list) {
-		nlse = alloc_nftnl_setelem(set, expr);
+	list_for_each_entry_from(expr, &init->expressions, list) {
+		nlse = alloc_nftnl_setelem(init, expr);
 
 		cmd_add_loc(cmd, nlh, &expr->location);
 		nest2 = mnl_attr_nest_start(nlh, ++i);
-- 
2.30.2


