Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D28D07B
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHNKQy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 06:16:54 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:55540 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfHNKQx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:16:53 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id E146141BA8;
        Wed, 14 Aug 2019 18:16:49 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 05/12] netfilter: nft_tunnel: add nft_tunnel_mode_validate function
Date:   Wed, 14 Aug 2019 18:16:41 +0800
Message-Id: <1565777808-28735-6-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
References: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSUNPS0tLS0hCSktLTU5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhg6Ngw*CzgyHzk6ODIdCDIf
        VglPChpVSlVKTk1OTExMQ0pLS0lJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlCS0k3Bg++
X-HM-Tid: 0a6c8fa1520e2086kuqye146141ba8
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Move mode validate common code to nft_tunnel_mode_validate
function.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: new patch

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

