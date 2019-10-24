Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D9E2F2E
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 12:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438816AbfJXKfj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 06:35:39 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:44956 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407882AbfJXKfj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:35:39 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 529BF41B1C;
        Thu, 24 Oct 2019 18:35:36 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/5] netfilter: nft_tunnel: support NFT_TUNNEL_IPV4_SRC/DST match
Date:   Thu, 24 Oct 2019 18:35:33 +0800
Message-Id: <1571913336-13431-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571913336-13431-1-git-send-email-wenxu@ucloud.cn>
References: <1571913336-13431-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSk9PS0tLS05IT0tOTE1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6Eww6UTg2Hx5LOUMCPwgN
        FigwCT1VSlVKTkxKQkpISEhNSENOVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlMT0g3Bg++
X-HM-Tid: 0a6dfd56061f2086kuqy529bf41b1c
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add new two NFT_TUNNEL_IPV4_SRC/DST match in nft_tunnel

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nft_tunnel.c               | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 81fed16..7f65019 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1775,6 +1775,8 @@ enum nft_tunnel_key_attributes {
 enum nft_tunnel_keys {
 	NFT_TUNNEL_PATH,
 	NFT_TUNNEL_ID,
+	NFT_TUNNEL_IPV4_SRC,
+	NFT_TUNNEL_IPV4_DST,
 	__NFT_TUNNEL_MAX
 };
 #define NFT_TUNNEL_MAX	(__NFT_TUNNEL_MAX - 1)
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 78b6e8f..b60e855 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -62,6 +62,26 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 		else
 			regs->verdict.code = NFT_BREAK;
 		break;
+	case NFT_TUNNEL_IPV4_SRC:
+		if (!tun_info) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
+			*dest = tun_info->key.u.ipv4.src;
+		else
+			regs->verdict.code = NFT_BREAK;
+		break;
+	case NFT_TUNNEL_IPV4_DST:
+		if (!tun_info) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode))
+			*dest = tun_info->key.u.ipv4.dst;
+		else
+			regs->verdict.code = NFT_BREAK;
+		break;
 	default:
 		WARN_ON(1);
 		regs->verdict.code = NFT_BREAK;
@@ -91,6 +111,8 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 		len = sizeof(u8);
 		break;
 	case NFT_TUNNEL_ID:
+	case NFT_TUNNEL_IPV4_SRC:
+	case NFT_TUNNEL_IPV4_DST:
 		len = sizeof(u32);
 		break;
 	default:
-- 
1.8.3.1

