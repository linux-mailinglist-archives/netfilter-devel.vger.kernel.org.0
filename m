Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65EC670BA7
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Jan 2023 23:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjAQWaA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Jan 2023 17:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjAQW3Y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:29:24 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17A28C41DA
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Jan 2023 14:07:09 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH net 1/1] netfilter: conntrack: handle tcp challenge acks during connection reuse
Date:   Tue, 17 Jan 2023 23:06:53 +0100
Message-Id: <20230117220653.739229-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117220653.739229-1-pablo@netfilter.org>
References: <20230117220653.739229-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

When a connection is re-used, following can happen:
[ connection starts to close, fin sent in either direction ]
 > syn   # initator quickly reuses connection
 < ack   # peer sends a challenge ack
 > rst   # rst, sequence number == ack_seq of previous challenge ack
 > syn   # this syn is expected to pass

Problem is that the rst will fail window validation, so it gets
tagged as invalid.

If ruleset drops such packets, we get repeated syn-retransmits until
initator gives up or peer starts responding with syn/ack.

Before the commit indicated in the "Fixes" tag below this used to work:

The challenge-ack made conntrack re-init state based on the challenge
ack itself, so the following rst would pass window validation.

Add challenge-ack support: If we get ack for syn, record the ack_seq,
and then check if the rst sequence number matches the last ack number
seen in reverse direction.

Fixes: c7aab4f17021 ("netfilter: nf_conntrack_tcp: re-init for syn packets only")
Reported-by: Michal Tesar <mtesar@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 656631083177..3ac1af6f59fc 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1068,6 +1068,13 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 				ct->proto.tcp.last_flags |=
 					IP_CT_EXP_CHALLENGE_ACK;
 		}
+
+		/* possible challenge ack reply to syn */
+		if (old_state == TCP_CONNTRACK_SYN_SENT &&
+		    index == TCP_ACK_SET &&
+		    dir == IP_CT_DIR_REPLY)
+			ct->proto.tcp.last_ack = ntohl(th->ack_seq);
+
 		spin_unlock_bh(&ct->lock);
 		nf_ct_l4proto_log_invalid(skb, ct, state,
 					  "packet (index %d) in dir %d ignored, state %s",
@@ -1193,6 +1200,14 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			 * segments we ignored. */
 			goto in_window;
 		}
+
+		/* Reset in response to a challenge-ack we let through earlier */
+		if (old_state == TCP_CONNTRACK_SYN_SENT &&
+		    ct->proto.tcp.last_index == TCP_ACK_SET &&
+		    ct->proto.tcp.last_dir == IP_CT_DIR_REPLY &&
+		    ntohl(th->seq) == ct->proto.tcp.last_ack)
+			goto in_window;
+
 		break;
 	default:
 		/* Keep compilers happy. */
-- 
2.30.2

