Return-Path: <netfilter-devel+bounces-3963-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D245D97C1D2
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Sep 2024 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17401C20DE3
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Sep 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400131CB32D;
	Wed, 18 Sep 2024 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcHceVoK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5ED1CB30D;
	Wed, 18 Sep 2024 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726697629; cv=none; b=XyT/SE4laUUMrVoeviZSfhnw4fRNhmRvqY1EoysKLSU3mEfq2he09lZN2rJ8r8eu44x3Vf6gW1weNVJRQ9OJ/hQ5IThmHHefxORwsXU7twjkQNQ9rS3S296+og1IO9MOpsWWm3KpelCiV0MHXMS9EWyJQqzPKE/qx7EfJKurUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726697629; c=relaxed/simple;
	bh=MYDtXZH5GC+kN+l+1VuhRFHhin6WvjjJmNkW7Zex45k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwP+UMeDQ6CxpXJO+BYBTF2xY7sYTBVbrId0oT70UGqC7Q6I4CGQXAnRrjcVxU7k3ytul/9LlbhQWh2OPsyel6AWnGCa50wgOim4LNDJKScnnZPFX3X4gZ+UXjJDGtFbSphWG44E+jDw4ZtJlXLZ4EyhsB+2GUUmQEdfxezY1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fcHceVoK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IJmKGm010047;
	Wed, 18 Sep 2024 22:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=ktHcNUIpZvm0fh
	8L1aIpXFWZ779Z5GHASlQSDemViwI=; b=fcHceVoKoXBvUqvsiYVMNWzqSNKVlC
	F1slFqk0BHtNLa+hG23jx4G8P8VMF6U0PMMVPuTY7N0jTScVlTAxmzH3EFXpGwE4
	RJcyBck0/vDhvzwXYHRrcC2FJZcEswi9Vht9je3oCDRlciLiMmIUfzDba20TAXHC
	GQEjeCXbwyQJ6niGxFu6T/+pIyOiNYWO2E3VurwZ2gTIXClogYWpTyhwFJ4LGCZO
	OfEYPMt+z+lIvR51zZ7ecHNpiMnSawiiwkQYY9VjYfR0KJHgFwyM+MBkGOOiXwGX
	AOIOVdDDmi2wSgANoDxCsFxJnCn3UY7OBfjud0/T9jP7xsdw6MWsOQqA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rk2cs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 22:12:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48IKqNfH010466;
	Wed, 18 Sep 2024 22:12:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb8x0a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 22:12:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48IMCiIH038557;
	Wed, 18 Sep 2024 22:12:44 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyb8x09t-1;
	Wed, 18 Sep 2024 22:12:44 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: 
Cc: saeed.mirzamohammadi@oracle.com, Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>,
        syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com,
        Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH 5.15.y 1/1] inet: inet_defrag: prevent sk release while still in use
Date: Wed, 18 Sep 2024 15:12:28 -0700
Message-ID: <20240918221230.3079874-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_14,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180147
X-Proofpoint-ORIG-GUID: L41KKXkU7Z3G-KqMIeF3n8OR9OQ6ySY8
X-Proofpoint-GUID: L41KKXkU7Z3G-KqMIeF3n8OR9OQ6ySY8

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 18685451fc4e546fc0e718580d32df3c0e5c8272 ]

ip_local_out() and other functions can pass skb->sk as function argument.

If the skb is a fragment and reassembly happens before such function call
returns, the sk must not be released.

This affects skb fragments reassembled via netfilter or similar
modules, e.g. openvswitch or ct_act.c, when run as part of tx pipeline.

Eric Dumazet made an initial analysis of this bug.  Quoting Eric:
  Calling ip_defrag() in output path is also implying skb_orphan(),
  which is buggy because output path relies on sk not disappearing.

  A relevant old patch about the issue was :
  8282f27449bf ("inet: frag: Always orphan skbs inside ip_defrag()")

  [..]

  net/ipv4/ip_output.c depends on skb->sk being set, and probably to an
  inet socket, not an arbitrary one.

  If we orphan the packet in ipvlan, then downstream things like FQ
  packet scheduler will not work properly.

  We need to change ip_defrag() to only use skb_orphan() when really
  needed, ie whenever frag_list is going to be used.

Eric suggested to stash sk in fragment queue and made an initial patch.
However there is a problem with this:

If skb is refragmented again right after, ip_do_fragment() will copy
head->sk to the new fragments, and sets up destructor to sock_wfree.
IOW, we have no choice but to fix up sk_wmem accouting to reflect the
fully reassembled skb, else wmem will underflow.

This change moves the orphan down into the core, to last possible moment.
As ip_defrag_offset is aliased with sk_buff->sk member, we must move the
offset into the FRAG_CB, else skb->sk gets clobbered.

This allows to delay the orphaning long enough to learn if the skb has
to be queued or if the skb is completing the reasm queue.

In the former case, things work as before, skb is orphaned.  This is
safe because skb gets queued/stolen and won't continue past reasm engine.

In the latter case, we will steal the skb->sk reference, reattach it to
the head skb, and fix up wmem accouting when inet_frag inflates truesize.

Fixes: 7026b1ddb6b8 ("netfilter: Pass socket pointer down through okfn().")
Diagnosed-by: Eric Dumazet <edumazet@google.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Reported-by: syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240326101845.30836-1-fw@strlen.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 7d0567842b78390dd9b60f00f1d8f838d540e325)

CVE: CVE-2024-26921
Cc: stable@vger.kernel.org # 5.15

Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 include/linux/skbuff.h                  |  7 +--
 net/ipv4/inet_fragment.c                | 70 ++++++++++++++++++++-----
 net/ipv4/ip_fragment.c                  |  2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c |  2 +-
 4 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b230c422dc3b9..7f52562fac19c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -660,8 +660,6 @@ typedef unsigned char *sk_buff_data_t;
  *	@rbnode: RB tree node, alternative to next/prev for netem/tcp
  *	@list: queue head
  *	@sk: Socket we are owned by
- *	@ip_defrag_offset: (aka @sk) alternate use of @sk, used in
- *		fragmentation management
  *	@dev: Device we arrived on/are leaving by
  *	@dev_scratch: (aka @dev) alternate use of @dev when @dev would be %NULL
  *	@cb: Control buffer. Free for use by every layer. Put private vars here
@@ -778,10 +776,7 @@ struct sk_buff {
 		struct list_head	list;
 	};
 
-	union {
-		struct sock		*sk;
-		int			ip_defrag_offset;
-	};
+	struct sock		*sk;
 
 	union {
 		ktime_t		tstamp;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 341096807100c..7e38170111999 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -24,6 +24,8 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "../core/sock_destructor.h"
+
 /* Use skb->cb to track consecutive/adjacent fragments coming at
  * the end of the queue. Nodes in the rb-tree queue will
  * contain "runs" of one or more adjacent fragments.
@@ -39,6 +41,7 @@ struct ipfrag_skb_cb {
 	};
 	struct sk_buff		*next_frag;
 	int			frag_run_len;
+	int			ip_defrag_offset;
 };
 
 #define FRAG_CB(skb)		((struct ipfrag_skb_cb *)((skb)->cb))
@@ -390,12 +393,12 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 	 */
 	if (!last)
 		fragrun_create(q, skb);  /* First fragment. */
-	else if (last->ip_defrag_offset + last->len < end) {
+	else if (FRAG_CB(last)->ip_defrag_offset + last->len < end) {
 		/* This is the common case: skb goes to the end. */
 		/* Detect and discard overlaps. */
-		if (offset < last->ip_defrag_offset + last->len)
+		if (offset < FRAG_CB(last)->ip_defrag_offset + last->len)
 			return IPFRAG_OVERLAP;
-		if (offset == last->ip_defrag_offset + last->len)
+		if (offset == FRAG_CB(last)->ip_defrag_offset + last->len)
 			fragrun_append_to_last(q, skb);
 		else
 			fragrun_create(q, skb);
@@ -412,13 +415,13 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 
 			parent = *rbn;
 			curr = rb_to_skb(parent);
-			curr_run_end = curr->ip_defrag_offset +
+			curr_run_end = FRAG_CB(curr)->ip_defrag_offset +
 					FRAG_CB(curr)->frag_run_len;
-			if (end <= curr->ip_defrag_offset)
+			if (end <= FRAG_CB(curr)->ip_defrag_offset)
 				rbn = &parent->rb_left;
 			else if (offset >= curr_run_end)
 				rbn = &parent->rb_right;
-			else if (offset >= curr->ip_defrag_offset &&
+			else if (offset >= FRAG_CB(curr)->ip_defrag_offset &&
 				 end <= curr_run_end)
 				return IPFRAG_DUP;
 			else
@@ -432,7 +435,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
 		rb_insert_color(&skb->rbnode, &q->rb_fragments);
 	}
 
-	skb->ip_defrag_offset = offset;
+	FRAG_CB(skb)->ip_defrag_offset = offset;
 
 	return IPFRAG_OK;
 }
@@ -442,13 +445,28 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 			      struct sk_buff *parent)
 {
 	struct sk_buff *fp, *head = skb_rb_first(&q->rb_fragments);
-	struct sk_buff **nextp;
+	void (*destructor)(struct sk_buff *);
+	unsigned int orig_truesize = 0;
+	struct sk_buff **nextp = NULL;
+	struct sock *sk = skb->sk;
 	int delta;
 
+	if (sk && is_skb_wmem(skb)) {
+		/* TX: skb->sk might have been passed as argument to
+		 * dst->output and must remain valid until tx completes.
+		 *
+		 * Move sk to reassembled skb and fix up wmem accounting.
+		 */
+		orig_truesize = skb->truesize;
+		destructor = skb->destructor;
+	}
+
 	if (head != skb) {
 		fp = skb_clone(skb, GFP_ATOMIC);
-		if (!fp)
-			return NULL;
+		if (!fp) {
+			head = skb;
+			goto out_restore_sk;
+		}
 		FRAG_CB(fp)->next_frag = FRAG_CB(skb)->next_frag;
 		if (RB_EMPTY_NODE(&skb->rbnode))
 			FRAG_CB(parent)->next_frag = fp;
@@ -457,6 +475,12 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 					&q->rb_fragments);
 		if (q->fragments_tail == skb)
 			q->fragments_tail = fp;
+
+		if (orig_truesize) {
+			/* prevent skb_morph from releasing sk */
+			skb->sk = NULL;
+			skb->destructor = NULL;
+		}
 		skb_morph(skb, head);
 		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
 		rb_replace_node(&head->rbnode, &skb->rbnode,
@@ -464,13 +488,13 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 		consume_skb(head);
 		head = skb;
 	}
-	WARN_ON(head->ip_defrag_offset != 0);
+	WARN_ON(FRAG_CB(head)->ip_defrag_offset != 0);
 
 	delta = -head->truesize;
 
 	/* Head of list must not be cloned. */
 	if (skb_unclone(head, GFP_ATOMIC))
-		return NULL;
+		goto out_restore_sk;
 
 	delta += head->truesize;
 	if (delta)
@@ -486,7 +510,7 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 
 		clone = alloc_skb(0, GFP_ATOMIC);
 		if (!clone)
-			return NULL;
+			goto out_restore_sk;
 		skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
 		skb_frag_list_init(head);
 		for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
@@ -503,6 +527,21 @@ void *inet_frag_reasm_prepare(struct inet_frag_queue *q, struct sk_buff *skb,
 		nextp = &skb_shinfo(head)->frag_list;
 	}
 
+out_restore_sk:
+	if (orig_truesize) {
+		int ts_delta = head->truesize - orig_truesize;
+
+		/* if this reassembled skb is fragmented later,
+		 * fraglist skbs will get skb->sk assigned from head->sk,
+		 * and each frag skb will be released via sock_wfree.
+		 *
+		 * Update sk_wmem_alloc.
+		 */
+		head->sk = sk;
+		head->destructor = destructor;
+		refcount_add(ts_delta, &sk->sk_wmem_alloc);
+	}
+
 	return nextp;
 }
 EXPORT_SYMBOL(inet_frag_reasm_prepare);
@@ -510,6 +549,8 @@ EXPORT_SYMBOL(inet_frag_reasm_prepare);
 void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 			    void *reasm_data, bool try_coalesce)
 {
+	struct sock *sk = is_skb_wmem(head) ? head->sk : NULL;
+	const unsigned int head_truesize = head->truesize;
 	struct sk_buff **nextp = (struct sk_buff **)reasm_data;
 	struct rb_node *rbn;
 	struct sk_buff *fp;
@@ -572,6 +613,9 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 	skb_mark_not_on_list(head);
 	head->prev = NULL;
 	head->tstamp = q->stamp;
+
+	if (sk)
+		refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);
 }
 EXPORT_SYMBOL(inet_frag_reasm_finish);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index fad803d2d711e..ec2264adf2a6a 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -377,6 +377,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
@@ -479,7 +480,6 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 	struct ipq *qp;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
-	skb_orphan(skb);
 
 	/* Lookup (or create) queue header */
 	qp = ip_find(net, ip_hdr(skb), user, vif);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 2e5b090d7c89f..0ec5ec5a5b45a 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -297,6 +297,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
@@ -472,7 +473,6 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	hdr = ipv6_hdr(skb);
 	fhdr = (struct frag_hdr *)skb_transport_header(skb);
 
-	skb_orphan(skb);
 	fq = fq_find(net, fhdr->identification, user, hdr,
 		     skb->dev ? skb->dev->ifindex : 0);
 	if (fq == NULL) {
-- 
2.45.2


