Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D904B430C9C
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Oct 2021 00:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbhJQWR4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 17 Oct 2021 18:17:56 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53416 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbhJQWRy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 17 Oct 2021 18:17:54 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id D4A3063F10;
        Mon, 18 Oct 2021 00:14:02 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH nf-next 06/15] af_packet: Introduce egress hook
Date:   Mon, 18 Oct 2021 00:15:13 +0200
Message-Id: <20211017221522.853838-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017221522.853838-1-pablo@netfilter.org>
References: <20211017221522.853838-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add egress hook for AF_PACKET sockets that have the PACKET_QDISC_BYPASS
socket option set to on, which allows packets to escape without being
filtered in the egress path.

This patch only updates the AF_PACKET path, it does not update
dev_direct_xmit() so the XDP infrastructure has a chance to bypass
Netfilter.

[lukas: acquire rcu_read_lock, fix typos, rebase]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/packet/af_packet.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 2a2bc64f75cf..46943a18a10d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -91,6 +91,7 @@
 #endif
 #include <linux/bpf.h>
 #include <net/compat.h>
+#include <linux/netfilter_netdev.h>
 
 #include "internal.h"
 
@@ -241,8 +242,42 @@ struct packet_skb_cb {
 static void __fanout_unlink(struct sock *sk, struct packet_sock *po);
 static void __fanout_link(struct sock *sk, struct packet_sock *po);
 
+#ifdef CONFIG_NETFILTER_EGRESS
+static noinline struct sk_buff *nf_hook_direct_egress(struct sk_buff *skb)
+{
+	struct sk_buff *next, *head = NULL, *tail;
+	int rc;
+
+	rcu_read_lock();
+	for (; skb != NULL; skb = next) {
+		next = skb->next;
+		skb_mark_not_on_list(skb);
+
+		if (!nf_hook_egress(skb, &rc, skb->dev))
+			continue;
+
+		if (!head)
+			head = skb;
+		else
+			tail->next = skb;
+
+		tail = skb;
+	}
+	rcu_read_unlock();
+
+	return head;
+}
+#endif
+
 static int packet_direct_xmit(struct sk_buff *skb)
 {
+#ifdef CONFIG_NETFILTER_EGRESS
+	if (nf_hook_egress_active()) {
+		skb = nf_hook_direct_egress(skb);
+		if (!skb)
+			return NET_XMIT_DROP;
+	}
+#endif
 	return dev_direct_xmit(skb, packet_pick_tx_queue(skb));
 }
 
-- 
2.30.2

