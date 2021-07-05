Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B655B3BC2A9
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 20:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGESdU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 14:33:20 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48492 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGESdT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:33:19 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2CD6161657
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Jul 2021 20:30:31 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/2] netfilter: nft_last: incorrect arithmetics when restoring last used
Date:   Mon,  5 Jul 2021 20:30:37 +0200
Message-Id: <20210705183037.10815-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210705183037.10815-1-pablo@netfilter.org>
References: <20210705183037.10815-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Subtract the jiffies that have passed by to current jiffies to fix last
used restoration.

Fixes: 836382dc2471 ("netfilter: nf_tables: add last expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index bbb352b64c73..8088b99f2ee3 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -37,7 +37,7 @@ static int nft_last_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		if (err < 0)
 			return err;
 
-		priv->last_jiffies = jiffies + (unsigned long)last_jiffies;
+		priv->last_jiffies = jiffies - (unsigned long)last_jiffies;
 	}
 
 	return 0;
-- 
2.20.1

