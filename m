Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16A4DDC2C
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Mar 2022 15:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiCROva (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Mar 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiCROvX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:51:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26FAE85BDA
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Mar 2022 07:49:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9C73560743;
        Fri, 18 Mar 2022 15:47:11 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf-next] netfilter: nf_conntrack_tcp: skip tracking for offloaded packets
Date:   Fri, 18 Mar 2022 15:49:39 +0100
Message-Id: <20220318144939.69465-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sometimes flowtable datapath passes up packets to classic forwarding
path, eg. mtu exceeded case. Skip TCP tracking otherwise these packets
are considered invalid by conntrack.

Fixes: ac2a66665e23 ("netfilter: add generic flow table infrastructure")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
This is a fix, but I'm routing it through nf-next at this stage.

 net/netfilter/nf_conntrack_proto_tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index d1582b888c0d..e0a1f86910ec 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -889,6 +889,9 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 	if (!nf_ct_is_confirmed(ct) && !tcp_new(ct, skb, dataoff, th))
 		return -NF_ACCEPT;
 
+	if (unlikely(test_bit(IPS_OFFLOAD_BIT, &ct->status)))
+		return NF_ACCEPT;
+
 	spin_lock_bh(&ct->lock);
 	old_state = ct->proto.tcp.state;
 	dir = CTINFO2DIR(ctinfo);
-- 
2.30.2

