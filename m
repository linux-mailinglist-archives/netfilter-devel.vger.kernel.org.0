Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2884629510
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Nov 2022 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiKOJ7e (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Nov 2022 04:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiKOJ70 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:59:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DF85FC9;
        Tue, 15 Nov 2022 01:59:25 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net-next 1/6] netfilter: nft_payload: use __be16 to store gre version
Date:   Tue, 15 Nov 2022 10:59:17 +0100
Message-Id: <20221115095922.139954-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221115095922.139954-1-pablo@netfilter.org>
References: <20221115095922.139954-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

GRE_VERSION and GRE_VERSION0 are expressed in network byte order,
use __be16. Uncovered by sparse:

net/netfilter/nft_payload.c:112:25: warning: incorrect type in assignment (different base types)
net/netfilter/nft_payload.c:112:25:    expected unsigned int [usertype] version
net/netfilter/nft_payload.c:112:25:    got restricted __be16
net/netfilter/nft_payload.c:114:22: warning: restricted __be16 degrades to integer

Fixes: c247897d7c19 ("netfilter: nft_payload: access GRE payload via inner offset")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 9d2ac764a14c..53e64d8aa01f 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -102,8 +102,9 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 		}
 		break;
 	case IPPROTO_GRE: {
-		u32 offset = sizeof(struct gre_base_hdr), version;
+		u32 offset = sizeof(struct gre_base_hdr);
 		struct gre_base_hdr *gre, _gre;
+		__be16 version;
 
 		gre = skb_header_pointer(pkt->skb, thoff, sizeof(_gre), &_gre);
 		if (!gre)
-- 
2.30.2

