Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E76D43D8
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Apr 2023 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjDCLy7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Apr 2023 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCLy5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:54:57 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF093F9
        for <netfilter-devel@vger.kernel.org>; Mon,  3 Apr 2023 04:54:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pjIlt-0003pk-4Y; Mon, 03 Apr 2023 13:54:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Farid BENAMROUCHE <fariouche@yahoo.fr>
Subject: [PATCH nf] netfilter: br_netfilter: fix recent physdev match breakage
Date:   Mon,  3 Apr 2023 13:54:37 +0200
Message-Id: <20230403115437.1923-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Recent attempt to ensure PREROUTING hook is executed again when a
decrypted ipsec packet received on a bridge passes through the network
stack a second time broke the physdev match in INPUT hook.

We can't discard the nf_bridge info strct from sabotage_in hook, as
this is needed by the physdev match.

Keep the struct around and handle this with another conditional instead.

Fixes: 2b272bb558f1 ("netfilter: br_netfilter: disable sabotage_in hook after first suppression")
Reported-and-tested-by: Farid BENAMROUCHE <fariouche@yahoo.fr>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/skbuff.h          |  1 +
 net/bridge/br_netfilter_hooks.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ff7ad331fb82..1ec3530c8191 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -294,6 +294,7 @@ struct nf_bridge_info {
 	u8			pkt_otherhost:1;
 	u8			in_prerouting:1;
 	u8			bridged_dnat:1;
+	u8			sabotage_in_done:1;
 	__u16			frag_max_size;
 	struct net_device	*physindev;
 
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 638a4d5359db..4bc6761517bb 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -868,12 +868,17 @@ static unsigned int ip_sabotage_in(void *priv,
 {
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 
-	if (nf_bridge && !nf_bridge->in_prerouting &&
-	    !netif_is_l3_master(skb->dev) &&
-	    !netif_is_l3_slave(skb->dev)) {
-		nf_bridge_info_free(skb);
-		state->okfn(state->net, state->sk, skb);
-		return NF_STOLEN;
+	if (nf_bridge) {
+		if (nf_bridge->sabotage_in_done)
+			return NF_ACCEPT;
+
+		if (!nf_bridge->in_prerouting &&
+		    !netif_is_l3_master(skb->dev) &&
+		    !netif_is_l3_slave(skb->dev)) {
+			nf_bridge->sabotage_in_done = 1;
+			state->okfn(state->net, state->sk, skb);
+			return NF_STOLEN;
+		}
 	}
 
 	return NF_ACCEPT;
-- 
2.39.2

