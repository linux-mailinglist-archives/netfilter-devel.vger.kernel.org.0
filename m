Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3B24DE9
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 May 2019 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfEULbV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 May 2019 07:31:21 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35500 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbfEULbV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 May 2019 07:31:21 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hT2zH-0008Tx-9k; Tue, 21 May 2019 13:31:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     marcmicalizzi@gmail.com, Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 3/5] netfilter: nft_flow_offload: don't offload when sequence numbers need adjustment
Date:   Tue, 21 May 2019 13:24:32 +0200
Message-Id: <20190521112434.11767-4-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521112434.11767-1-fw@strlen.de>
References: <20190521112434.11767-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We can't deal with tcp sequence number rewrite in flow_offload.
While at it, simplify helper check, we only need to know if the extension
is present, we don't need the helper data.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_flow_offload.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index bde63d9c3c4e..c97c03c3939a 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -12,7 +12,6 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <net/netfilter/nf_flow_table.h>
-#include <net/netfilter/nf_conntrack_helper.h>
 
 struct nft_flow_offload {
 	struct nft_flowtable	*flowtable;
@@ -67,7 +66,6 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
-	const struct nf_conn_help *help;
 	enum ip_conntrack_info ctinfo;
 	struct nf_flow_route route;
 	struct flow_offload *flow;
@@ -93,8 +91,8 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		goto out;
 	}
 
-	help = nfct_help(ct);
-	if (help)
+	if (nf_ct_ext_exist(ct, NF_CT_EXT_HELPER) ||
+	    ct->status & IPS_SEQ_ADJUST)
 		goto out;
 
 	if (!nf_ct_is_confirmed(ct))
-- 
2.21.0

