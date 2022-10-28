Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635256113D5
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Oct 2022 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJ1OAc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Oct 2022 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiJ1OA3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:00:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FA5E53033
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Oct 2022 07:00:27 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     kuba@kernel.org
Subject: [PATCH nf-next] netfilter: nft_payload: use __b16 to store gre version
Date:   Fri, 28 Oct 2022 16:00:21 +0200
Message-Id: <20221028140021.3727-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

