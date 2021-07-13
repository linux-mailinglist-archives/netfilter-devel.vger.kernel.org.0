Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3CA3C7539
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Jul 2021 18:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhGMQtd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Jul 2021 12:49:33 -0400
Received: from mail.netfilter.org ([217.70.188.207]:38542 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhGMQtd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:49:33 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 337EE60702;
        Tue, 13 Jul 2021 18:46:24 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     yajun.deng@linux.dev
Subject: [PATCH nf] netfilter: nft_compat: use nfnetlink_unicast()
Date:   Tue, 13 Jul 2021 18:46:40 +0200
Message-Id: <20210713164640.28501-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nfnetlink_unicast() translates EAGAIN to ENOBUFS, since EAGAIN is
reserved to report missing module dependencies to the nfnetlink core.

Reported-by: Yajun Deng <yajun.deng@linux.dev>
Fixes: e0241ae6ac59 ("netfilter: use nfnetlink_unicast()")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_compat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 639c337c885b..60f234df4e1d 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -683,10 +683,7 @@ static int nfnl_compat_get_rcu(struct sk_buff *skb,
 		goto out_put;
 	}
 
-	ret = netlink_unicast(info->sk, skb2, NETLINK_CB(skb).portid,
-			      MSG_DONTWAIT);
-	if (ret > 0)
-		ret = 0;
+	ret = nfnetlink_unicast(skb2, info->net, NETLINK_CB(skb).portid);
 out_put:
 	rcu_read_lock();
 	module_put(THIS_MODULE);
-- 
2.20.1

