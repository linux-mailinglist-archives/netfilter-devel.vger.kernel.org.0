Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89815EE8BA
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiI1Vzp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiI1Vzf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:55:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF2C923BD6
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 14:55:30 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/2] netfilter: nft_payload: access ipip payload for inner offset
Date:   Wed, 28 Sep 2022 23:55:23 +0200
Message-Id: <20220928215523.1045-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928215523.1045-1-pablo@netfilter.org>
References: <20220928215523.1045-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ipip is an special case, transport and inner header offset are set to
the same offset to use the upcoming inner expression for matching on
inner tunnel headers.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 81913b74f7c8..47425ccd9fae 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -104,6 +104,9 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 	case IPPROTO_GRE:
 		pkt->inneroff = thoff + sizeof(struct gre_base_hdr);
 		break;
+	case IPPROTO_IPIP:
+		pkt->inneroff = thoff;
+		break;
 	default:
 		return -1;
 	}
-- 
2.30.2

