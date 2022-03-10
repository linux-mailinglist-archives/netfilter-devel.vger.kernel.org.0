Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB04D4D4F7B
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Mar 2022 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbiCJQlp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Mar 2022 11:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbiCJQll (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:41:41 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD00190C20
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 08:40:39 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nSLqA-0005UY-BM; Thu, 10 Mar 2022 17:40:38 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     kadlec@netfilter.org, Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/4] netfilter: conntrack: ignore overly delayed tcp packets
Date:   Thu, 10 Mar 2022 17:40:16 +0100
Message-Id: <20220310164017.7317-4-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310164017.7317-1-fw@strlen.de>
References: <20220310164017.7317-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If 'nf_conntrack_tcp_loose' is off (the default), tcp packets that are
outside of the current window are marked as INVALID.

nf/iptables rulesets often drop such packets via 'ct state invalid' or
similar checks.

For overly delayed acks, this can be a nuisance if such 'invalid' packets
are also logged.

Since they are not invalid in a strict sense, just ignore them, i.e.
conntrack won't extend timeout or change state so that they do not match
invalid state rules anymore.

This also avoids unwantend connection stalls in case conntrack considers
retransmission (of data that did not reach the peer) as too old.

The else branch of the conditional becomes obsolete.
Next patch will reformat the now always-true if condition.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 45 ++++++++++++--------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 1b4de78b5c30..edfbbfa3ad3c 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -48,6 +48,7 @@ static const char *const tcp_conntrack_names[] = {
 };
 
 enum nf_ct_tcp_action {
+	NFCT_TCP_IGNORE,
 	NFCT_TCP_INVALID,
 	NFCT_TCP_ACCEPT,
 };
@@ -510,8 +511,6 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 	      const struct nf_hook_state *hook_state)
 {
 	struct ip_ct_tcp *state = &ct->proto.tcp;
-	struct net *net = nf_ct_net(ct);
-	struct nf_tcp_net *tn = nf_tcp_pernet(net);
 	struct ip_ct_tcp_state *sender = &state->seen[dir];
 	struct ip_ct_tcp_state *receiver = &state->seen[!dir];
 	__u32 seq, ack, sack, end, win, swin;
@@ -636,9 +635,17 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 	/* Is the ending sequence in the receive window (if available)? */
 	in_recv_win = !receiver->td_maxwin ||
 		      after(end, sender->td_end - receiver->td_maxwin - 1);
+	if (!in_recv_win)
+		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_IGNORE,
+					  "SEQ is under lower bound %u (already ACKed data retransmitted)",
+					  sender->td_end - receiver->td_maxwin - 1);
+	if (!after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1))
+		return nf_tcp_log_invalid(skb, ct, hook_state, sender, NFCT_TCP_IGNORE,
+					  "ignored ACK under lower bound %u (possible overly delayed)",
+					  receiver->td_end - MAXACKWINDOW(sender) - 1);
+
 
-	if (in_recv_win &&
-	    after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1)) {
+	if (1) {
 		/*
 		 * Take into account window scaling (RFC 1323).
 		 */
@@ -695,24 +702,6 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 				state->retrans = 0;
 			}
 		}
-	} else {
-		if (sender->flags & IP_CT_TCP_FLAG_BE_LIBERAL ||
-		    tn->tcp_be_liberal)
-			return NFCT_TCP_ACCEPT;
-		{
-			nf_ct_l4proto_log_invalid(skb, ct, hook_state,
-			"%s",
-			before(seq, sender->td_maxend + 1) ?
-			in_recv_win ?
-			before(sack, receiver->td_end + 1) ?
-			after(sack, receiver->td_end - MAXACKWINDOW(sender) - 1) ? "BUG"
-			: "ACK is under the lower bound (possible overly delayed ACK)"
-			: "ACK is over the upper bound (ACKed data not seen yet)"
-			: "SEQ is under the lower bound (already ACKed data retransmitted)"
-			: "SEQ is over the upper bound (over the window of the receiver)");
-		}
-
-		return NFCT_TCP_INVALID;
 	}
 
 	return NFCT_TCP_ACCEPT;
@@ -867,6 +856,7 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 	struct nf_conntrack_tuple *tuple;
 	enum tcp_conntrack new_state, old_state;
 	unsigned int index, *timeouts;
+	enum nf_ct_tcp_action res;
 	enum ip_conntrack_dir dir;
 	const struct tcphdr *th;
 	struct tcphdr _tcph;
@@ -1133,10 +1123,17 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 		break;
 	}
 
-	if (!tcp_in_window(ct, dir, index,
-			   skb, dataoff, th, state)) {
+	res = tcp_in_window(ct, dir, index,
+			    skb, dataoff, th, state);
+	switch (res) {
+	case NFCT_TCP_IGNORE:
+		spin_unlock_bh(&ct->lock);
+		return NF_ACCEPT;
+	case NFCT_TCP_INVALID:
 		spin_unlock_bh(&ct->lock);
 		return -NF_ACCEPT;
+	case NFCT_TCP_ACCEPT:
+		break;
 	}
      in_window:
 	/* From now on we have got in-window packets */
-- 
2.34.1

