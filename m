Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D95F5CC7
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 00:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJEWhq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Oct 2022 18:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJEWhp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:37:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D582D63F31
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Oct 2022 15:37:44 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 1/6] netfilter: nft_payload: access GRE payload via inner offset
Date:   Thu,  6 Oct 2022 00:37:35 +0200
Message-Id: <20221005223740.22991-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005223740.22991-1-pablo@netfilter.org>
References: <20221005223740.22991-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Parse GRE packets to properly set up inner offset, this allow for
matching on inner headers.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: interpret GRE flags to handle variable GRE header size.

 net/netfilter/nft_payload.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 99d971fc54ad..78a393d6a7c8 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -19,6 +19,8 @@
 /* For layer 4 checksum field offset. */
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <net/gre.h>
+#include <net/pptp.h>
 #include <linux/icmpv6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -100,6 +102,26 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 		pkt->inneroff = thoff + __tcp_hdrlen(th);
 		}
 		break;
+	case IPPROTO_GRE: {
+		struct gre_base_hdr *gre, _gre;
+		u32 offset = 0;
+
+		gre = skb_header_pointer(pkt->skb, thoff, sizeof(_gre), &_gre);
+		if (!gre)
+			return -1;
+
+		if (gre->flags & GRE_CSUM) {
+			offset += sizeof_field(struct gre_full_hdr, csum) +
+				  sizeof_field(struct gre_full_hdr, reserved1);
+		}
+		if (gre->flags & GRE_KEY)
+			offset += sizeof_field(struct gre_full_hdr, key);
+		if (gre->flags & GRE_SEQ)
+			offset += sizeof_field(struct pptp_gre_header, seq);
+
+		pkt->inneroff = thoff + sizeof(struct gre_base_hdr) + offset;
+		}
+		break;
 	default:
 		return -1;
 	}
-- 
2.30.2

