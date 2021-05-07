Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3E3769A8
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 May 2021 19:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhEGRs4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 May 2021 13:48:56 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49136 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhEGRsv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 May 2021 13:48:51 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 46F9E6414C;
        Fri,  7 May 2021 19:47:03 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 6/8] netfilter: nftables: Fix a memleak from userdata error path in new objects
Date:   Fri,  7 May 2021 19:47:37 +0200
Message-Id: <20210507174739.1850-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210507174739.1850-1-pablo@netfilter.org>
References: <20210507174739.1850-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Release object name if userdata allocation fails.

Fixes: b131c96496b3 ("netfilter: nf_tables: add userdata support for nft_object")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0b7fe0a902ff..926da6ed8d51 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6615,9 +6615,9 @@ static int nf_tables_newobj(struct sk_buff *skb, const struct nfnl_info *info,
 	INIT_LIST_HEAD(&obj->list);
 	return err;
 err_trans:
-	kfree(obj->key.name);
-err_userdata:
 	kfree(obj->udata);
+err_userdata:
+	kfree(obj->key.name);
 err_strdup:
 	if (obj->ops->destroy)
 		obj->ops->destroy(&ctx, obj);
-- 
2.30.2

