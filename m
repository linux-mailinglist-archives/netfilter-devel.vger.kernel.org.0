Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95FACF43
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Sep 2019 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfIHOWX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Sep 2019 10:22:23 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:4145 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfIHOWW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:22:22 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 11B0B5C16D8;
        Sun,  8 Sep 2019 22:22:09 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 3/8] netfilter: nft_tunnel: add ipv6 check in nft_tunnel_mode_validate
Date:   Sun,  8 Sep 2019 22:22:03 +0800
Message-Id: <1567952528-24421-4-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567952528-24421-1-git-send-email-wenxu@ucloud.cn>
References: <1567952528-24421-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSU9CS0tLSkJKTUNDTk9ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6USo4NzgwAzUYKRwhOS0O
        CU1PCwtVSlVKTk1MQk5JTklCSkpJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhKSEs3Bg++
X-HM-Tid: 0a6d1140e6b92087kuqy11b0b5c16d8
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add ipv6 tunnel check in nft_tunnel_mode_validate.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v6: no change

 net/netfilter/nft_tunnel.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index fe544bf..64bda3d 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -18,8 +18,12 @@ struct nft_tunnel {
 	enum nft_tunnel_mode	mode:8;
 };
 
-bool nft_tunnel_mode_validate(enum nft_tunnel_mode priv_mode, u8 tun_mode)
+bool nft_tunnel_mode_validate(enum nft_tunnel_mode priv_mode,
+			      u8 tun_mode, bool ipv6)
 {
+	if (ipv6 && !(tun_mode & IP_TUNNEL_INFO_IPV6))
+		return false;
+
 	if (priv_mode == NFT_TUNNEL_MODE_NONE ||
 	    (priv_mode == NFT_TUNNEL_MODE_RX &&
 	     !(tun_mode & IP_TUNNEL_INFO_TX)) ||
@@ -46,7 +50,7 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 			nft_reg_store8(dest, false);
 			return;
 		}
-		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode, false))
 			nft_reg_store8(dest, true);
 		else
 			nft_reg_store8(dest, false);
@@ -56,7 +60,7 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 			regs->verdict.code = NFT_BREAK;
 			return;
 		}
-		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode, false))
 			*dest = ntohl(tunnel_id_to_key32(tun_info->key.tun_id));
 		else
 			regs->verdict.code = NFT_BREAK;
@@ -66,7 +70,7 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 			regs->verdict.code = NFT_BREAK;
 			return;
 		}
-		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode, false))
 			*dest = tun_info->key.u.ipv4.src;
 		else
 			regs->verdict.code = NFT_BREAK;
@@ -76,7 +80,7 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 			regs->verdict.code = NFT_BREAK;
 			return;
 		}
-		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode, false))
 			*dest = tun_info->key.u.ipv4.dst;
 		else
 			regs->verdict.code = NFT_BREAK;
-- 
1.8.3.1

