Return-Path: <netfilter-devel+bounces-829-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759B844B64
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Feb 2024 00:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B4D1F28748
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jan 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530803A8E4;
	Wed, 31 Jan 2024 22:59:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947FF3A29A;
	Wed, 31 Jan 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741996; cv=none; b=pJB6ZP2TtIXqdOPeeBJIkf8NvLVVVoglR5hW8uMJ6wCeSZXMFMlaCyWLUY06JuGUNunsnRdax0nIp4OkEu1o88meJKs4KffYff2Fy0lUqV1UIDKFv/9x8WiRky3Rv21ijc4cP70PcSVjZ2w/Ad6KHhDRgY13X5cjSQWceYFktuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741996; c=relaxed/simple;
	bh=n02mJWTwgOIsnqxBb4P+laHCDaYVU+bwTl0OfH+qFHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvbXq1/fxwVegnB5K/3Z+pOC85GTOWcznOznVVLSOKkQdS7GThhEiFB23pVU7fqQa6QgSV8e8zYidSud5au5BlzWv8t5/RTy7xr1nCpk/4UaSHCa8piIjwP/3XwdkC/CoqnqsIQgM7DzMxe3vgAWTjua9sXCDcjhNJigAPg7ufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 1/6] netfilter: conntrack: correct window scaling with retransmitted SYN
Date: Wed, 31 Jan 2024 23:59:38 +0100
Message-Id: <20240131225943.7536-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240131225943.7536-1-pablo@netfilter.org>
References: <20240131225943.7536-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Schaefer <ryanschf@amazon.com>

commit c7aab4f17021 ("netfilter: nf_conntrack_tcp: re-init for syn packets
only") introduces a bug where SYNs in ORIGINAL direction on reused 5-tuple
result in incorrect window scale negotiation. This commit merged the SYN
re-initialization and simultaneous open or SYN retransmits cases. Merging
this block added the logic in tcp_init_sender() that performed window scale
negotiation to the retransmitted syn case. Previously. this would only
result in updating the sender's scale and flags. After the merge the
additional logic results in improperly clearing the scale in ORIGINAL
direction before any packets in the REPLY direction are received. This
results in packets incorrectly being marked invalid for being
out-of-window.

This can be reproduced with the following trace:

Packet Sequence:
> Flags [S], seq 1687765604, win 62727, options [.. wscale 7], length 0
> Flags [S], seq 1944817196, win 62727, options [.. wscale 7], length 0

In order to fix the issue, only evaluate window negotiation for packets
in the REPLY direction. This was tested with simultaneous open, fast
open, and the above reproduction.

Fixes: c7aab4f17021 ("netfilter: nf_conntrack_tcp: re-init for syn packets only")
Signed-off-by: Ryan Schaefer <ryanschf@amazon.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index e573be5afde7..ae493599a3ef 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -457,7 +457,8 @@ static void tcp_init_sender(struct ip_ct_tcp_state *sender,
 			    const struct sk_buff *skb,
 			    unsigned int dataoff,
 			    const struct tcphdr *tcph,
-			    u32 end, u32 win)
+			    u32 end, u32 win,
+			    enum ip_conntrack_dir dir)
 {
 	/* SYN-ACK in reply to a SYN
 	 * or SYN from reply direction in simultaneous open.
@@ -471,7 +472,8 @@ static void tcp_init_sender(struct ip_ct_tcp_state *sender,
 	 * Both sides must send the Window Scale option
 	 * to enable window scaling in either direction.
 	 */
-	if (!(sender->flags & IP_CT_TCP_FLAG_WINDOW_SCALE &&
+	if (dir == IP_CT_DIR_REPLY &&
+	    !(sender->flags & IP_CT_TCP_FLAG_WINDOW_SCALE &&
 	      receiver->flags & IP_CT_TCP_FLAG_WINDOW_SCALE)) {
 		sender->td_scale = 0;
 		receiver->td_scale = 0;
@@ -542,7 +544,7 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 		if (tcph->syn) {
 			tcp_init_sender(sender, receiver,
 					skb, dataoff, tcph,
-					end, win);
+					end, win, dir);
 			if (!tcph->ack)
 				/* Simultaneous open */
 				return NFCT_TCP_ACCEPT;
@@ -585,7 +587,7 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
 		 */
 		tcp_init_sender(sender, receiver,
 				skb, dataoff, tcph,
-				end, win);
+				end, win, dir);
 
 		if (dir == IP_CT_DIR_REPLY && !tcph->ack)
 			return NFCT_TCP_ACCEPT;
-- 
2.30.2


