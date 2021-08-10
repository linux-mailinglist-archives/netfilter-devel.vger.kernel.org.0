Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE13DE257
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Aug 2021 00:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHBWQR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Aug 2021 18:16:17 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51168 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWQR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Aug 2021 18:16:17 -0400
Received: from salvia.lan (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 213FA6003E;
        Tue,  3 Aug 2021 00:15:32 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf 2/2] netfilter: nfnetlink_hook: missing chain family
Date:   Tue,  3 Aug 2021 00:15:54 +0200
Message-Id: <20210802221554.4474-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802221554.4474-1-pablo@netfilter.org>
References: <20210802221554.4474-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The family is relevant for pseudo-families like NFPROTO_INET
otherwise the user needs to rely on the hook function name to
differentiate it from NFPROTO_IPV4 and NFPROTO_IPV6 names.

Add nfnl_hook_chain_desc_attributes instead of using the existing
NFTA_CHAIN_* attributes, since these do not provide a family number.

Fixes: e2cf17d3774c ("netfilter: add new hook nfnl subsystem")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nfnetlink_hook.h | 9 +++++++++
 net/netfilter/nfnetlink_hook.c                | 8 ++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/netfilter/nfnetlink_hook.h b/include/uapi/linux/netfilter/nfnetlink_hook.h
index 912ec60b26b0..bbcd285b22e1 100644
--- a/include/uapi/linux/netfilter/nfnetlink_hook.h
+++ b/include/uapi/linux/netfilter/nfnetlink_hook.h
@@ -43,6 +43,15 @@ enum nfnl_hook_chain_info_attributes {
 };
 #define NFNLA_HOOK_INFO_MAX (__NFNLA_HOOK_INFO_MAX - 1)
 
+enum nfnl_hook_chain_desc_attributes {
+	NFNLA_CHAIN_UNSPEC,
+	NFNLA_CHAIN_TABLE,
+	NFNLA_CHAIN_FAMILY,
+	NFNLA_CHAIN_NAME,
+	__NFNLA_CHAIN_MAX,
+};
+#define NFNLA_CHAIN_MAX (__NFNLA_CHAIN_MAX - 1)
+
 /**
  * enum nfnl_hook_chaintype - chain type
  *
diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index 5b1922f96c9e..30fe94477f8d 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -89,11 +89,15 @@ static int nfnl_hook_put_nft_chain_info(struct sk_buff *nlskb,
 	if (!nest2)
 		goto cancel_nest;
 
-	ret = nla_put_string(nlskb, NFTA_CHAIN_TABLE, chain->table->name);
+	ret = nla_put_string(nlskb, NFNLA_CHAIN_TABLE, chain->table->name);
 	if (ret)
 		goto cancel_nest;
 
-	ret = nla_put_string(nlskb, NFTA_CHAIN_NAME, chain->name);
+	ret = nla_put_string(nlskb, NFNLA_CHAIN_NAME, chain->name);
+	if (ret)
+		goto cancel_nest;
+
+	ret = nla_put_u8(nlskb, NFNLA_CHAIN_FAMILY, chain->table->family);
 	if (ret)
 		goto cancel_nest;
 
-- 
2.20.1

