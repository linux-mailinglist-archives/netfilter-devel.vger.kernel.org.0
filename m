Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E294597082
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Aug 2022 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbiHQOBw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Aug 2022 10:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbiHQOBR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:01:17 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737B97D44;
        Wed, 17 Aug 2022 07:01:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oOJba-0008PI-Tk; Wed, 17 Aug 2022 16:01:10 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netdev@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH net 05/17] netfilter: nf_ct_h323: cap packet size at 64k
Date:   Wed, 17 Aug 2022 16:00:03 +0200
Message-Id: <20220817140015.25843-6-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817140015.25843-1-fw@strlen.de>
References: <20220817140015.25843-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With BIG TCP, packets generated by tcp stack may exceed 64kb.
Cap datalen at 64kb.  The internal message format uses 16bit fields,
so no embedded message can exceed 64k size.

Multiple h323 messages in a single superpacket may now result
in a message to get treated as incomplete/truncated, but thats
better than scribbling past h323_buffer.

Another alternative suitable for net tree would be a switch to
skb_linearize().

Fixes: 7c4e983c4f3c ("net: allow gso_max_size to exceed 65536")
Fixes: 0fe79f28bfaf ("net: allow gro_max_size to exceed 65536")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_h323_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index bb76305bb7ff..5a9bce24f3c3 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -34,6 +34,8 @@
 #include <net/netfilter/nf_conntrack_zones.h>
 #include <linux/netfilter/nf_conntrack_h323.h>
 
+#define H323_MAX_SIZE 65535
+
 /* Parameters */
 static unsigned int default_rrq_ttl __read_mostly = 300;
 module_param(default_rrq_ttl, uint, 0600);
@@ -86,6 +88,9 @@ static int get_tpkt_data(struct sk_buff *skb, unsigned int protoff,
 	if (tcpdatalen <= 0)	/* No TCP data */
 		goto clear_out;
 
+	if (tcpdatalen > H323_MAX_SIZE)
+		tcpdatalen = H323_MAX_SIZE;
+
 	if (*data == NULL) {	/* first TPKT */
 		/* Get first TPKT pointer */
 		tpkt = skb_header_pointer(skb, tcpdataoff, tcpdatalen,
@@ -1169,6 +1174,9 @@ static unsigned char *get_udp_data(struct sk_buff *skb, unsigned int protoff,
 	if (dataoff >= skb->len)
 		return NULL;
 	*datalen = skb->len - dataoff;
+	if (*datalen > H323_MAX_SIZE)
+		*datalen = H323_MAX_SIZE;
+
 	return skb_header_pointer(skb, dataoff, *datalen, h323_buffer);
 }
 
@@ -1770,7 +1778,7 @@ static int __init nf_conntrack_h323_init(void)
 
 	NF_CT_HELPER_BUILD_BUG_ON(sizeof(struct nf_ct_h323_master));
 
-	h323_buffer = kmalloc(65536, GFP_KERNEL);
+	h323_buffer = kmalloc(H323_MAX_SIZE + 1, GFP_KERNEL);
 	if (!h323_buffer)
 		return -ENOMEM;
 	ret = h323_helper_init();
-- 
2.35.1

