Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A89534175
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 May 2022 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiEYQYU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 May 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiEYQYT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 May 2022 12:24:19 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43CBD8148B
        for <netfilter-devel@vger.kernel.org>; Wed, 25 May 2022 09:24:18 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:53104.440129044
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-101.229.165.125 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 68EA42800B5;
        Thu, 26 May 2022 00:24:09 +0800 (CST)
X-189-SAVE-TO-SEND: +wenxu@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id 02c64cf405fa4328bb3a7333a0eadaf8 for pablo@netfilter.org;
        Thu, 26 May 2022 00:24:10 CST
X-Transaction-ID: 02c64cf405fa4328bb3a7333a0eadaf8
X-Real-From: wenxu@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: wenxu@chinatelecom.cn
From:   wenxu@chinatelecom.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, wenxu@chinatelecom.cn
Subject: [PATCH nf-next] netfilter: flowtable: fix nft_flow_route use saddr for reverse route
Date:   Wed, 25 May 2022 12:23:57 -0400
Message-Id: <1653495837-75877-1-git-send-email-wenxu@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@chinatelecom.cn>

The nf_flow_tabel get route through ip_route_output_key which
the saddr should be local ones. For the forward case it always
can't get the other_dst and can't offload any flows

Fixes: 3412e1641828 (netfilter: flowtable: nft_flow_route use more data for reverse route)
Signed-off-by: wenxu <wenxu@chinatelecom.cn>
---
 net/netfilter/nft_flow_offload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 40d18aa..742a494 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -230,7 +230,6 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 	switch (nft_pf(pkt)) {
 	case NFPROTO_IPV4:
 		fl.u.ip4.daddr = ct->tuplehash[dir].tuple.src.u3.ip;
-		fl.u.ip4.saddr = ct->tuplehash[dir].tuple.dst.u3.ip;
 		fl.u.ip4.flowi4_oif = nft_in(pkt)->ifindex;
 		fl.u.ip4.flowi4_iif = this_dst->dev->ifindex;
 		fl.u.ip4.flowi4_tos = RT_TOS(ip_hdr(pkt->skb)->tos);
@@ -238,7 +237,6 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		break;
 	case NFPROTO_IPV6:
 		fl.u.ip6.daddr = ct->tuplehash[dir].tuple.src.u3.in6;
-		fl.u.ip6.saddr = ct->tuplehash[dir].tuple.dst.u3.in6;
 		fl.u.ip6.flowi6_oif = nft_in(pkt)->ifindex;
 		fl.u.ip6.flowi6_iif = this_dst->dev->ifindex;
 		fl.u.ip6.flowlabel = ip6_flowinfo(ipv6_hdr(pkt->skb));
-- 
1.8.3.1

