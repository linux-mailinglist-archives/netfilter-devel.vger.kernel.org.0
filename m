Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67731388D23
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 May 2021 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351824AbhESLnj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 May 2021 07:43:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45494 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbhESLnj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 May 2021 07:43:39 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7084B64132
        for <netfilter-devel@vger.kernel.org>; Wed, 19 May 2021 13:41:23 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: missing error reporting for not selected expressions
Date:   Wed, 19 May 2021 13:42:15 +0200
Message-Id: <20210519114215.126098-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sometimes users forget to turn on nftables extensions from Kconfig that
they need. In such case, the error reporting from userspace is
misleading:

 $ sudo nft add rule x y counter
 Error: Could not process rule: No such file or directory
 add rule x y counter
 ^^^^^^^^^^^^^^^^^^^^

Add missing NL_SET_BAD_ATTR() to provide a hint:

 $ nft add rule x y counter
 Error: Could not process rule: No such file or directory
 add rule x y counter
              ^^^^^^^

Fixes: 83d9dcba06c5 ("netfilter: nf_tables: extended netlink error reporting for expressions")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 104b9a47be5f..11e7edc1e9e4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3277,8 +3277,10 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			if (n == NFT_RULE_MAXEXPRS)
 				goto err1;
 			err = nf_tables_expr_parse(&ctx, tmp, &expr_info[n]);
-			if (err < 0)
+			if (err < 0) {
+				NL_SET_BAD_ATTR(extack, tmp);
 				goto err1;
+			}
 			size += expr_info[n].ops->size;
 			n++;
 		}
-- 
2.30.2

