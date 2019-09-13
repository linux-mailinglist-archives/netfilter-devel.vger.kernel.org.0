Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9423B22D5
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbfIMPDV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 11:03:21 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:47471 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390487AbfIMPDU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:03:20 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id CC27441630;
        Fri, 13 Sep 2019 23:03:11 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 4/8] netfilter: nft_tunnel: support NFT_TUNNEL_IP6_SRC/DST match
Date:   Fri, 13 Sep 2019 23:03:06 +0800
Message-Id: <1568386990-29660-5-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568386990-29660-1-git-send-email-wenxu@ucloud.cn>
References: <1568386990-29660-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSk5KS0tLSU1KSEtNTE1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6OSo5Ezg6Ays3PzFRDx8T
        Dh5PCTVVSlVKTk1DSENNQkJKQ0xNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlCS0g3Bg++
X-HM-Tid: 0a6d2b2646e52086kuqycc27441630
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add new two NFT_TUNNEL_IP6_SRC/DST match in nft_tunnel

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nft_tunnel.c               | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index d459f49..da9b1d1 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1775,6 +1775,8 @@ enum nft_tunnel_keys {
 	NFT_TUNNEL_ID,
 	NFT_TUNNEL_IP_SRC,
 	NFT_TUNNEL_IP_DST,
+	NFT_TUNNEL_IP6_SRC,
+	NFT_TUNNEL_IP6_DST,
 	__NFT_TUNNEL_MAX
 };
 #define NFT_TUNNEL_MAX	(__NFT_TUNNEL_MAX - 1)
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 3ca7d80..f128b28 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -96,6 +96,30 @@ static void nft_tunnel_get_eval(const struct nft_expr *expr,
 		else
 			regs->verdict.code = NFT_BREAK;
 		break;
+	case NFT_TUNNEL_IP6_SRC:
+		if (!tun_info) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode,
+					     NFT_INET_IP6_TYPE))
+			memcpy(dest, &tun_info->key.u.ipv6.src,
+			       sizeof(struct in6_addr));
+		else
+			regs->verdict.code = NFT_BREAK;
+		break;
+	case NFT_TUNNEL_IP6_DST:
+		if (!tun_info) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		if (nft_tunnel_mode_validate(priv->mode, tun_info->mode,
+					     NFT_INET_IP6_TYPE))
+			memcpy(dest, &tun_info->key.u.ipv6.dst,
+			       sizeof(struct in6_addr));
+		else
+			regs->verdict.code = NFT_BREAK;
+		break;
 	default:
 		WARN_ON(1);
 		regs->verdict.code = NFT_BREAK;
@@ -129,6 +153,10 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
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

