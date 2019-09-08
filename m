Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE6ACF46
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Sep 2019 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfIHOW1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Sep 2019 10:22:27 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:4121 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfIHOW1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:22:27 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id E984F5C16D2;
        Sun,  8 Sep 2019 22:22:08 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 1/8] netfilter: nft_tunnel: add nft_tunnel_mode_validate function
Date:   Sun,  8 Sep 2019 22:22:01 +0800
Message-Id: <1567952528-24421-2-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567952528-24421-1-git-send-email-wenxu@ucloud.cn>
References: <1567952528-24421-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSU9CS0tLSkJKTUNDTk9ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6NQw4ODg9SDUXExMsOSIS
        CzEwCw9VSlVKTk1MQk5JTklDQkJIVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlDTUI3Bg++
X-HM-Tid: 0a6d1140e6442087kuqye984f5c16d2
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Move mode validate  common code to nft_tunnel_mode_validate
function.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v6: no change

 net/netfilter/nft_tunnel.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 3d4c2ae..d374466 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -18,6 +18,18 @@ struct nft_tunnel {
 	enum nft_tunnel_mode	mode:8;
 };
 
+bool nft_tunnel_mode_validate(enum nft_tunnel_mode priv_mode, u8 tun_mode)
+{
+	if (priv_mode == NFT_TUNNEL_MODE_NONE ||
+	    (priv_mode == NFT_TUNNEL_MODE_RX &&
+	     !(tun_mode & IP_TUNNEL_INFO_TX)) ||
+	    (priv_mode == NFT_TUNNEL_MODE_TX &&
+	     (tun_mode & IP_TUNNEL_INFO_TX)))
+		return true;
+
+	return false;
+}
+
 static void nft_tunnel_get_eval(const struct nft_expr *expr,
 				struct nft_regs *regs,
 				const struct nft_pktinfo *pkt)
@@ -34,11 +46,7 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 			nft_reg_store8(dest, false);
 			return;
 		}
-		if (priv->mode == NFT_TUNNEL_MODE_NONE ||
-		    (priv->mode == NFT_TUNNEL_MODE_RX &&
-		     !(tun_info->mode & IP_TUNNEL_INFO_TX)) ||
-		    (priv->mode == NFT_TUNNEL_MODE_TX &&
-		     (tun_info->mode & IP_TUNNEL_INFO_TX)))
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
 			nft_reg_store8(dest, true);
 		else
 			nft_reg_store8(dest, false);
@@ -48,11 +56,7 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 			regs->verdict.code = NFT_BREAK;
 			return;
 		}
-		if (priv->mode == NFT_TUNNEL_MODE_NONE ||
-		    (priv->mode == NFT_TUNNEL_MODE_RX &&
-		     !(tun_info->mode & IP_TUNNEL_INFO_TX)) ||
-		    (priv->mode == NFT_TUNNEL_MODE_TX &&
-		     (tun_info->mode & IP_TUNNEL_INFO_TX)))
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
 			*dest = ntohl(tunnel_id_to_key32(tun_info->key.tun_id));
 		else
 			regs->verdict.code = NFT_BREAK;
-- 
1.8.3.1

