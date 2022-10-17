Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB7600D5B
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Oct 2022 13:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJQLEF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Oct 2022 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJQLDn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:03:43 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC89810C8
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Oct 2022 04:03:41 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v5 1/7] netfilter: nft_payload: access GRE payload via inner offset
Date:   Mon, 17 Oct 2022 13:03:29 +0200
Message-Id: <20221017110335.742076-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221017110335.742076-1-pablo@netfilter.org>
References: <20221017110335.742076-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Parse GRE v0 packets to properly set up inner offset, this allow for
matching on inner headers.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v5: skip if GRE_ROUTING flag is set.

 net/netfilter/nft_payload.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 99d971fc54ad..c2ab64e12f79 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -19,6 +19,7 @@
 /* For layer 4 checksum field offset. */
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <net/gre.h>
 #include <linux/icmpv6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -100,6 +101,37 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 		pkt->inneroff = thoff + __tcp_hdrlen(th);
 		}
 		break;
+	case IPPROTO_GRE: {
+		u32 offset = sizeof(struct gre_base_hdr), version;
+		struct gre_base_hdr *gre, _gre;
+
+		gre = skb_header_pointer(pkt->skb, thoff, sizeof(_gre), &_gre);
+		if (!gre)
+			return -1;
+
+		version = gre->flags & GRE_VERSION;
+		switch (version) {
+		case GRE_VERSION_0:
+			if (gre->flags & GRE_ROUTING)
+				return -1;
+
+			if (gre->flags & GRE_CSUM) {
+				offset += sizeof_field(struct gre_full_hdr, csum) +
+					  sizeof_field(struct gre_full_hdr, reserved1);
+			}
+			if (gre->flags & GRE_KEY)
+				offset += sizeof_field(struct gre_full_hdr, key);
+
+			if (gre->flags & GRE_SEQ)
+				offset += sizeof_field(struct gre_full_hdr, seq);
+			break;
+		default:
+			return -1;
+		}
+
+		pkt->inneroff = thoff + offset;
+		}
+		break;
 	default:
 		return -1;
 	}
-- 
2.30.2

