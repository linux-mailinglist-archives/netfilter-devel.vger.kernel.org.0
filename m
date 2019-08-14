Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260368D07F
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfHNKQ4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 06:16:56 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:55574 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfHNKQ4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:16:56 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 603F941BBF;
        Wed, 14 Aug 2019 18:16:50 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 08/12] netfilter: nft_tunnel: support NFT_TUNNEL_IP6_SRC/DST match
Date:   Wed, 14 Aug 2019 18:16:44 +0800
Message-Id: <1565777808-28735-9-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
References: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSUNPS0tLS0hCSktLTU5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6Oio4HDg*Hzk5EjcyCDk5
        TThPCzBVSlVKTk1OTExMQ0pLT0xOVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlDTE03Bg++
X-HM-Tid: 0a6c8fa153e62086kuqy603f941bbf
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add new two NFT_TUNNEL_IP6_SRC/DST match in nft_tunnel

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: new patch

 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nft_tunnel.c               | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 4f1e5ef..bfb051f 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1767,6 +1767,8 @@ enum nft_tunnel_keys {
 	NFT_TUNNEL_ID,
 	NFT_TUNNEL_IP_SRC,
 	NFT_TUNNEL_IP_DST,
+	NFT_TUNNEL_IP6_SRC,
+	NFT_TUNNEL_IP6_DST,
 	__NFT_TUNNEL_MAX
 };
 #define NFT_TUNNEL_MAX	(__NFT_TUNNEL_MAX - 1)
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 64bda3d..58b6083 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -85,6 +85,26 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 		else
 			regs->verdict.code = NFT_BREAK;
 		break;
+	case NFT_TUNNEL_IP6_SRC:
+		if (!tun_info) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode, true))
+			memcpy(dest, &tun_info->key.u.ipv6.src, sizeof(struct in6_addr));
+		else
+			regs->verdict.code = NFT_BREAK;
+		break;
+	case NFT_TUNNEL_IP6_DST:
+		if (!tun_info) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode, true))
+			memcpy(dest, &tun_info->key.u.ipv6.dst, sizeof(struct in6_addr));
+		else
+			regs->verdict.code = NFT_BREAK;
+		break;
 	default:
 		WARN_ON(1);
 		regs->verdict.code = NFT_BREAK;
@@ -118,6 +138,10 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 	case NFT_TUNNEL_IP_DST:
 		len = sizeof(u32);
 		break;
+	case NFT_TUNNEL_IP6_SRC:
+	case NFT_TUNNEL_IP6_DST:
+		len = sizeof(struct in6_addr);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
1.8.3.1

