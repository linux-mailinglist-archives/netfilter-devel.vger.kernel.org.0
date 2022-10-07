Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD4F5F75F9
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Oct 2022 11:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJGJQi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Oct 2022 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJGJQW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:16:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 595E9AE874
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Oct 2022 02:16:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 6/6] netfilter: nft_inner: add geneve support
Date:   Fri,  7 Oct 2022 11:16:14 +0200
Message-Id: <20221007091614.339582-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221007091614.339582-1-pablo@netfilter.org>
References: <20221007091614.339582-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Geneve tunnel header may contain options, parse geneve header and update
offset to point to the link layer header according to the opt_len field.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes.

 include/uapi/linux/netfilter/nf_tables.h |  1 +
 net/netfilter/nft_inner.c                | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 05a15dce8271..e4b739d57480 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -783,6 +783,7 @@ enum nft_payload_csum_flags {
 enum nft_inner_type {
 	NFT_INNER_UNSPEC	= 0,
 	NFT_INNER_VXLAN,
+	NFT_INNER_GENEVE,
 };
 
 enum nft_inner_flags {
diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index f5f205ed34f7..f72e8a8bb7d4 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -17,6 +17,7 @@
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <net/gre.h>
+#include <net/geneve.h>
 #include <net/ip.h>
 #include <linux/icmpv6.h>
 #include <linux/ip.h>
@@ -170,6 +171,22 @@ static int nft_inner_parse_tunhdr(const struct nft_inner *priv,
 	ctx->flags |= NFT_PAYLOAD_CTX_INNER_TUN;
 	*off += priv->hdrsize;
 
+	switch (priv->type) {
+	case NFT_INNER_GENEVE: {
+		struct genevehdr *gnvh, _gnvh;
+
+		gnvh = skb_header_pointer(pkt->skb, pkt->inneroff,
+					  sizeof(_gnvh), &_gnvh);
+		if (!gnvh)
+			return -1;
+
+		*off += gnvh->opt_len * 4;
+		}
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

