Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DFB3BEBF3
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Jul 2021 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhGGQVl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Jul 2021 12:21:41 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55144 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhGGQVf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:21:35 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id E59E66244E;
        Wed,  7 Jul 2021 18:18:41 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 06/11] netfilter: conntrack: improve RST handling when tuple is re-used
Date:   Wed,  7 Jul 2021 18:18:39 +0200
Message-Id: <20210707161844.20827-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210707161844.20827-1-pablo@netfilter.org>
References: <20210707161844.20827-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Ali Abdallah <aabdallah@suse.de>

If we receive a SYN packet in original direction on an existing
connection tracking entry, we let this SYN through because conntrack
might be out-of-sync.

Conntrack gets back in sync when server responds with SYN/ACK and state
gets updated accordingly.

However, if server replies with RST, this packet might be marked as
INVALID because td_maxack value reflects the *old* conntrack state
and not the state of the originator of the RST.

Avoid td_maxack-based checks if previous packet was a SYN.

Unfortunately that is not be enough: an out of order ACK in original
direction updates last_index, so we still end up marking valid RST.

Thus disable the sequence check when we are not in established state and
the received RST has a sequence of 0.

Because marking RSTs as invalid usually leads to unwanted timeouts,
also skip RST sequence checks if a conntrack entry is already closing.

Such entries can already be evicted via GC in case the table is full.

Co-developed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Ali Abdallah <aabdallah@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 53 +++++++++++++++++---------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index eb4de92077a8..b8ff67671e93 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -823,6 +823,22 @@ static noinline bool tcp_new(struct nf_conn *ct, const struct sk_buff *skb,
 	return true;
 }
 
+static bool tcp_can_early_drop(const struct nf_conn *ct)
+{
+	switch (ct->proto.tcp.state) {
+	case TCP_CONNTRACK_FIN_WAIT:
+	case TCP_CONNTRACK_LAST_ACK:
+	case TCP_CONNTRACK_TIME_WAIT:
+	case TCP_CONNTRACK_CLOSE:
+	case TCP_CONNTRACK_CLOSE_WAIT:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /* Returns verdict for packet, or -1 for invalid. */
 int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			    struct sk_buff *skb,
@@ -1030,9 +1046,28 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 		if (index != TCP_RST_SET)
 			break;
 
-		if (ct->proto.tcp.seen[!dir].flags & IP_CT_TCP_FLAG_MAXACK_SET) {
+		/* If we are closing, tuple might have been re-used already.
+		 * last_index, last_ack, and all other ct fields used for
+		 * sequence/window validation are outdated in that case.
+		 *
+		 * As the conntrack can already be expired by GC under pressure,
+		 * just skip validation checks.
+		 */
+		if (tcp_can_early_drop(ct))
+			goto in_window;
+
+		/* td_maxack might be outdated if we let a SYN through earlier */
+		if ((ct->proto.tcp.seen[!dir].flags & IP_CT_TCP_FLAG_MAXACK_SET) &&
+		    ct->proto.tcp.last_index != TCP_SYN_SET) {
 			u32 seq = ntohl(th->seq);
 
+			/* If we are not in established state and SEQ=0 this is most
+			 * likely an answer to a SYN we let go through above (last_index
+			 * can be updated due to out-of-order ACKs).
+			 */
+			if (seq == 0 && !nf_conntrack_tcp_established(ct))
+				break;
+
 			if (before(seq, ct->proto.tcp.seen[!dir].td_maxack)) {
 				/* Invalid RST  */
 				spin_unlock_bh(&ct->lock);
@@ -1165,22 +1200,6 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 	return NF_ACCEPT;
 }
 
-static bool tcp_can_early_drop(const struct nf_conn *ct)
-{
-	switch (ct->proto.tcp.state) {
-	case TCP_CONNTRACK_FIN_WAIT:
-	case TCP_CONNTRACK_LAST_ACK:
-	case TCP_CONNTRACK_TIME_WAIT:
-	case TCP_CONNTRACK_CLOSE:
-	case TCP_CONNTRACK_CLOSE_WAIT:
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
 #if IS_ENABLED(CONFIG_NF_CT_NETLINK)
 
 #include <linux/netfilter/nfnetlink.h>
-- 
2.20.1

