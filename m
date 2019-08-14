Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C518D07E
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 12:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHNKQz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 06:16:55 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:55576 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNKQz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:16:55 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 4D25B41BBE;
        Wed, 14 Aug 2019 18:16:50 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 07/12] netfilter: nft_tunnel: add ipv6 check in nft_tunnel_mode_validate
Date:   Wed, 14 Aug 2019 18:16:43 +0800
Message-Id: <1565777808-28735-8-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
References: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSUNPS0tLS0hCSktLTU5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgw6ERw5STgzDzk1AjcNCDkp
        TwgKFD1VSlVKTk1OTExMQ0pLSExLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhKTU83Bg++
X-HM-Tid: 0a6c8fa153992086kuqy4d25b41bbe
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add ipv6 tunnel check in nft_tunnel_mode_validate.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: new patch

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

