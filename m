Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0F150C8D
	for <lists+netfilter-devel@lfdr.de>; Mon,  3 Feb 2020 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbgBCQh3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Feb 2020 11:37:29 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:59392 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731066AbgBCQh2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:28 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1iyej0-0005Ye-Ka; Mon, 03 Feb 2020 17:37:26 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 3/4] netfilter: conntrack: split resolve_clash function
Date:   Mon,  3 Feb 2020 17:37:06 +0100
Message-Id: <20200203163707.27254-4-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203163707.27254-1-fw@strlen.de>
References: <20200203163707.27254-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Followup patch will need a helper function with the 'clashing entries
refer to the identical tuple in both directions' resolution logic.

This patch will add another resolve_clash helper where loser_ct must
not be added to the dying list because it will be inserted into the
table.

Therefore this also moves the stat counters and dying-list insertion
of the losing ct.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 58 ++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 5fda5bd10160..3f069eb0f0fc 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -907,6 +907,39 @@ static void __nf_conntrack_insert_prepare(struct nf_conn *ct)
 		tstamp->start = ktime_get_real_ns();
 }
 
+static int __nf_ct_resolve_clash(struct sk_buff *skb,
+				 struct nf_conntrack_tuple_hash *h)
+{
+	/* This is the conntrack entry already in hashes that won race. */
+	struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *loser_ct;
+
+	loser_ct = nf_ct_get(skb, &ctinfo);
+
+	if (nf_ct_is_dying(ct))
+		return NF_DROP;
+
+	if (!atomic_inc_not_zero(&ct->ct_general.use))
+		return NF_DROP;
+
+	if (((ct->status & IPS_NAT_DONE_MASK) == 0) ||
+	    nf_ct_match(ct, loser_ct)) {
+		struct net *net = nf_ct_net(ct);
+
+		nf_ct_acct_merge(ct, ctinfo, loser_ct);
+		nf_ct_add_to_dying_list(loser_ct);
+		nf_conntrack_put(&loser_ct->ct_general);
+		nf_ct_set(skb, ct, ctinfo);
+
+		NF_CT_STAT_INC(net, insert_failed);
+		return NF_ACCEPT;
+	}
+
+	nf_ct_put(ct);
+	return NF_DROP;
+}
+
 /**
  * nf_ct_resolve_clash - attempt to handle clash without packet drop
  *
@@ -941,31 +974,23 @@ nf_ct_resolve_clash(struct sk_buff *skb, struct nf_conntrack_tuple_hash *h)
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *loser_ct;
 	struct net *net;
+	int ret;
 
 	loser_ct = nf_ct_get(skb, &ctinfo);
+	net = nf_ct_net(loser_ct);
 
 	l4proto = nf_ct_l4proto_find(nf_ct_protonum(ct));
 	if (!l4proto->allow_clash)
 		goto drop;
 
-	if (nf_ct_is_dying(ct))
-		goto drop;
-
-	if (!atomic_inc_not_zero(&ct->ct_general.use))
-		goto drop;
-
-	if (((ct->status & IPS_NAT_DONE_MASK) == 0) ||
-	    nf_ct_match(ct, loser_ct)) {
-		nf_ct_acct_merge(ct, ctinfo, loser_ct);
-		nf_conntrack_put(&loser_ct->ct_general);
-		nf_ct_set(skb, ct, ctinfo);
-		return NF_ACCEPT;
-	}
+	ret = __nf_ct_resolve_clash(skb, h);
+	if (ret == NF_ACCEPT)
+		return ret;
 
-	nf_ct_put(ct);
 drop:
-	net = nf_ct_net(loser_ct);
+	nf_ct_add_to_dying_list(loser_ct);
 	NF_CT_STAT_INC(net, drop);
+	NF_CT_STAT_INC(net, insert_failed);
 	return NF_DROP;
 }
 
@@ -1034,6 +1059,7 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 
 	if (unlikely(nf_ct_is_dying(ct))) {
 		nf_ct_add_to_dying_list(ct);
+		NF_CT_STAT_INC(net, insert_failed);
 		goto dying;
 	}
 
@@ -1075,11 +1101,9 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	return NF_ACCEPT;
 
 out:
-	nf_ct_add_to_dying_list(ct);
 	ret = nf_ct_resolve_clash(skb, h);
 dying:
 	nf_conntrack_double_unlock(hash, reply_hash);
-	NF_CT_STAT_INC(net, insert_failed);
 	local_bh_enable();
 	return ret;
 }
-- 
2.24.1

