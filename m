Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA250DD19
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Apr 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiDYJuj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Apr 2022 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiDYJui (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:50:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426E1B7B2
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Apr 2022 02:47:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nivJd-00034c-9Y; Mon, 25 Apr 2022 11:47:33 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     edumazet@google.com, ncardwell@google.com,
        Florian Westphal <fw@strlen.de>, Jaco Kroon <jaco@uls.co.za>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH nf] netfilter: nf_conntrack_tcp: re-init for syn packets only
Date:   Mon, 25 Apr 2022 11:47:11 +0200
Message-Id: <20220425094711.6255-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jaco Kroon reported tcp problems that Eric Dumazet and Neal Cardwell
pinpointed to nf_conntrack tcp_in_window() bug.

tcp trace shows following sequence:

I > R Flags [S], seq 3451342529, win 62580, options [.. tfo [|tcp]>
R > I Flags [S.], seq 2699962254, ack 3451342530, win 65535, options [..]
R > I Flags [P.], seq 1:89, ack 1, [..]

Note 3rd ACK is from responder to initiator so following branch is taken:
    } else if (((state->state == TCP_CONNTRACK_SYN_SENT
               && dir == IP_CT_DIR_ORIGINAL)
               || (state->state == TCP_CONNTRACK_SYN_RECV
               && dir == IP_CT_DIR_REPLY))
               && after(end, sender->td_end)) {

... because state == TCP_CONNTRACK_SYN_RECV and dir is REPLY.
This causes the scaling factor to be reset to 0: window scale option
is only present in syn(ack) packets.  This in turn makes nf_conntrack
mark valid packets as out-of-window.

This was always broken, it exists even in original commit where
window tracking was added to ip_conntrack (nf_conntrack predecessor)
in 2.6.9-rc1 kernel.

Restrict to 'tcph->syn', just like the 3rd condtional added in
commit 82b72cb94666 ("netfilter: conntrack: re-init state for retransmitted syn-ack").

Upon closer look, those conditionals/branches can be merged:

Because earlier checks prevent syn-ack from showing up in
original direction, the 'dir' checks in the conditional quoted above are
redundant, remove them. Return early for pure syn retransmitted in reply
direction (simultaneous open).

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Reported-by: Jaco Kroon <jaco@uls.co.za>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 8ec55cd72572..204a5cdff5b1 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -556,24 +556,14 @@ static bool tcp_in_window(struct nf_conn *ct,
 			}
 
 		}
-	} else if (((state->state == TCP_CONNTRACK_SYN_SENT
-		     && dir == IP_CT_DIR_ORIGINAL)
-		   || (state->state == TCP_CONNTRACK_SYN_RECV
-		     && dir == IP_CT_DIR_REPLY))
-		   && after(end, sender->td_end)) {
+	} else if (tcph->syn &&
+		   after(end, sender->td_end) &&
+		   (state->state == TCP_CONNTRACK_SYN_SENT ||
+		    state->state == TCP_CONNTRACK_SYN_RECV)) {
 		/*
 		 * RFC 793: "if a TCP is reinitialized ... then it need
 		 * not wait at all; it must only be sure to use sequence
 		 * numbers larger than those recently used."
-		 */
-		sender->td_end =
-		sender->td_maxend = end;
-		sender->td_maxwin = (win == 0 ? 1 : win);
-
-		tcp_options(skb, dataoff, tcph, sender);
-	} else if (tcph->syn && dir == IP_CT_DIR_REPLY &&
-		   state->state == TCP_CONNTRACK_SYN_SENT) {
-		/* Retransmitted syn-ack, or syn (simultaneous open).
 		 *
 		 * Re-init state for this direction, just like for the first
 		 * syn(-ack) reply, it might differ in seq, ack or tcp options.
@@ -581,7 +571,8 @@ static bool tcp_in_window(struct nf_conn *ct,
 		tcp_init_sender(sender, receiver,
 				skb, dataoff, tcph,
 				end, win);
-		if (!tcph->ack)
+
+		if (dir == IP_CT_DIR_REPLY && !tcph->ack)
 			return true;
 	}
 
-- 
2.35.1

