Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2586A0582
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Aug 2019 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH1PCu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Aug 2019 11:02:50 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:26450 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1PCu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:02:50 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 9C0AC411AB;
        Wed, 28 Aug 2019 23:02:37 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_meta_bridge: Fix get NFT_META_BRI_IIFVPROTO in network byteorder
Date:   Wed, 28 Aug 2019 23:02:33 +0800
Message-Id: <1567004553-15231-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVNS0hCQkJDTkhKSE9KTVlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oio6MRw6Czg*AzNLPDk#NzY8
        DD0aCRZVSlVKTk1MS0tPTk5MTEtDVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpIQk03Bg++
X-HM-Tid: 0a6cd8c0014f2086kuqy9c0ac411ab
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Get the vlan_proto of ingress bridge in network byteorder

Fixes: 2a3a93ef0ba5 ("netfilter: nft_meta_bridge: Add NFT_META_BRI_IIFVPROTO support")
Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/bridge/netfilter/nft_meta_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 1804e86..7c9e92b2 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -53,7 +53,7 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 			goto err;
 
 		br_vlan_get_proto(br_dev, &p_proto);
-		nft_reg_store16(dest, p_proto);
+		nft_reg_store16(dest, htons(p_proto));
 		return;
 	}
 	default:
-- 
1.8.3.1

