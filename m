Return-Path: <netfilter-devel+bounces-5138-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278549CE0DD
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2024 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7BE288569
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B41CD210;
	Fri, 15 Nov 2024 14:02:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D71CD20F
	for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679369; cv=none; b=D1nx9IYHda/FIZEJs76E/n3VBg2ii9zbL/XlQrad6+7B1S9GPkHsJujNvf88aUsem2JRB1mscaEdSQw5ZQ9QgsXPmw/jwlWjL1DBHt3NBaIJytZ1YZyW8wGFw3aZxDOBaXWaVXs8VkrdsCUwgTgBeSwACeTO5jEdeUdvrvADnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679369; c=relaxed/simple;
	bh=DBwyeUXcwhc6GfqNbf4JQg+xFecLBQKszlNnVqmrAKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZMr+IPwC5GB2ZDegFj1mTHIW5jg+bS/3Lp8oKTocdsKGw71Rj+ddpsILQ97sm2AZR9q98IwfGu3xqmCpy2ma+25qza6o2B+2fmzTE4nCL5UFZpRgCeXLctc73d6RwpGjPlXuH9cjHZVXtdl/NoDZCbvbJNli8CKz2TugfBpvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1tBwuL-00086u-Cw; Fri, 15 Nov 2024 15:02:45 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Nadia Pinaeva <n.m.pinaeva@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH nf-next] netfilter: conntrack: add conntrack event timestamp
Date: Fri, 15 Nov 2024 14:46:09 +0100
Message-ID: <20241115134612.1333-1-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nadia Pinaeva writes:
  I am working on a tool that allows collecting network performance
  metrics by using conntrack events.
  Start time of a conntrack entry is used to evaluate seen_reply
  latency, therefore the sooner it is timestamped, the better the
  precision is.
  In particular, when using this tool to compare the performance of the
  same feature implemented using iptables/nftables/OVS it is crucial
  to have the entry timestamped earlier to see any difference.

At this time, conntrack events can only get timestamped at recv time in
userspace, so there can be some delay between the event being generated
and the userspace process consuming the message.

There is sys/net/netfilter/nf_conntrack_timestamp, which adds a
64bit timestamp (ns resolution) that records start and stop times,
but its not suited for this either, start time is the 'hashtable insertion
time', not 'conntrack allocation time'.

There is concern that moving the start-time moment to conntrack
allocation will add overhead in case of flooding, where conntrack
entries are allocated and released right away without getting inserted
into the hashtable.

Also, even if this was changed it would not with events other than
new (start time) and destroy (stop time).

Pablo suggested to add new CTA_TIMESTAMP_EVENT, this adds this feature.
The timestamp is recorded in case both events are requested and the
sys/net/netfilter/nf_conntrack_timestamp toggle is enabled.

Reported-by: Nadia Pinaeva <n.m.pinaeva@gmail.com>
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: fix a few warnings on 32bit, afaics its because of missing
 includes.

 Fix build error/unused function warning when EVENTS=n.

 include/net/netfilter/nf_conntrack_ecache.h   | 12 +++++++++
 .../linux/netfilter/nfnetlink_conntrack.h     |  1 +
 net/netfilter/nf_conntrack_ecache.c           | 23 +++++++++++++++++
 net/netfilter/nf_conntrack_netlink.c          | 25 +++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack_ecache.h b/include/net/netfilter/nf_conntrack_ecache.h
index 0c1dac318e02..8dcf7c371ee9 100644
--- a/include/net/netfilter/nf_conntrack_ecache.h
+++ b/include/net/netfilter/nf_conntrack_ecache.h
@@ -12,6 +12,7 @@
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_conntrack_tuple_common.h>
 #include <net/netfilter/nf_conntrack_extend.h>
+#include <asm/local64.h>
 
 enum nf_ct_ecache_state {
 	NFCT_ECACHE_DESTROY_FAIL,	/* tried but failed to send destroy event */
@@ -20,6 +21,9 @@ enum nf_ct_ecache_state {
 
 struct nf_conntrack_ecache {
 	unsigned long cache;		/* bitops want long */
+#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
+	local64_t timestamp;		/* event timestamp, in nanoseconds */
+#endif
 	u16 ctmask;			/* bitmask of ct events to be delivered */
 	u16 expmask;			/* bitmask of expect events to be delivered */
 	u32 missed;			/* missed events */
@@ -108,6 +112,14 @@ nf_conntrack_event_cache(enum ip_conntrack_events event, struct nf_conn *ct)
 	if (e == NULL)
 		return;
 
+#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
+	/* renew only if this is the first cached event, so that the
+	 * timestamp reflects the first, not the last, generated event.
+	 */
+	if (local64_read(&e->timestamp) && READ_ONCE(e->cache) == 0)
+		local64_set(&e->timestamp, ktime_get_real_ns());
+#endif
+
 	set_bit(event, &e->cache);
 #endif
 }
diff --git a/include/uapi/linux/netfilter/nfnetlink_conntrack.h b/include/uapi/linux/netfilter/nfnetlink_conntrack.h
index c2ac7269acf7..43233af75b9d 100644
--- a/include/uapi/linux/netfilter/nfnetlink_conntrack.h
+++ b/include/uapi/linux/netfilter/nfnetlink_conntrack.h
@@ -57,6 +57,7 @@ enum ctattr_type {
 	CTA_SYNPROXY,
 	CTA_FILTER,
 	CTA_STATUS_MASK,
+	CTA_TIMESTAMP_EVENT,
 	__CTA_MAX
 };
 #define CTA_MAX (__CTA_MAX - 1)
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index 69948e1d6974..af68c64acaab 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -162,6 +162,14 @@ static int __nf_conntrack_eventmask_report(struct nf_conntrack_ecache *e,
 	return ret;
 }
 
+static void nf_ct_ecache_tstamp_refresh(struct nf_conntrack_ecache *e)
+{
+#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
+	if (local64_read(&e->timestamp))
+		local64_set(&e->timestamp, ktime_get_real_ns());
+#endif
+}
+
 int nf_conntrack_eventmask_report(unsigned int events, struct nf_conn *ct,
 				  u32 portid, int report)
 {
@@ -186,6 +194,8 @@ int nf_conntrack_eventmask_report(unsigned int events, struct nf_conn *ct,
 	/* This is a resent of a destroy event? If so, skip missed */
 	missed = e->portid ? 0 : e->missed;
 
+	nf_ct_ecache_tstamp_refresh(e);
+
 	ret = __nf_conntrack_eventmask_report(e, events, missed, &item);
 	if (unlikely(ret < 0 && (events & (1 << IPCT_DESTROY)))) {
 		/* This is a destroy event that has been triggered by a process,
@@ -297,6 +307,18 @@ void nf_conntrack_ecache_work(struct net *net, enum nf_ct_ecache_state state)
 	}
 }
 
+static void nf_ct_ecache_tstamp_new(const struct nf_conn *ct, struct nf_conntrack_ecache *e)
+{
+#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
+	u64 ts = 0;
+
+	if (nf_ct_ext_exist(ct, NF_CT_EXT_TSTAMP))
+		ts = ktime_get_real_ns();
+
+	local64_set(&e->timestamp, ts);
+#endif
+}
+
 bool nf_ct_ecache_ext_add(struct nf_conn *ct, u16 ctmask, u16 expmask, gfp_t gfp)
 {
 	struct net *net = nf_ct_net(ct);
@@ -326,6 +348,7 @@ bool nf_ct_ecache_ext_add(struct nf_conn *ct, u16 ctmask, u16 expmask, gfp_t gfp
 
 	e = nf_ct_ext_add(ct, NF_CT_EXT_ECACHE, gfp);
 	if (e) {
+		nf_ct_ecache_tstamp_new(ct, e);
 		e->ctmask  = ctmask;
 		e->expmask = expmask;
 	}
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 36168f8b6efa..2277b744eb2c 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -383,6 +383,23 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 #endif
 
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
+static int
+ctnetlink_dump_event_timestamp(struct sk_buff *skb, const struct nf_conn *ct)
+{
+#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
+	const struct nf_conntrack_ecache *e = nf_ct_ecache_find(ct);
+
+	if (e) {
+		u64 ts = local64_read(&e->timestamp);
+
+		if (ts)
+			return nla_put_be64(skb, CTA_TIMESTAMP_EVENT,
+					    cpu_to_be64(ts), CTA_TIMESTAMP_PAD);
+	}
+#endif
+	return 0;
+}
+
 static inline int ctnetlink_label_size(const struct nf_conn *ct)
 {
 	struct nf_conn_labels *labels = nf_ct_labels_find(ct);
@@ -717,6 +734,9 @@ static size_t ctnetlink_nlmsg_size(const struct nf_conn *ct)
 #endif
 	       + ctnetlink_proto_size(ct)
 	       + ctnetlink_label_size(ct)
+#ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
+	       + nla_total_size(sizeof(u64)) /* CTA_TIMESTAMP_EVENT */
+#endif
 	       ;
 }
 
@@ -838,6 +858,10 @@ ctnetlink_conntrack_event(unsigned int events, const struct nf_ct_event *item)
 	if (ctnetlink_dump_mark(skb, ct, events & (1 << IPCT_MARK)))
 		goto nla_put_failure;
 #endif
+
+	if (ctnetlink_dump_event_timestamp(skb, ct))
+		goto nla_put_failure;
+
 	nlmsg_end(skb, nlh);
 	err = nfnetlink_send(skb, net, item->portid, group, item->report,
 			     GFP_ATOMIC);
@@ -1557,6 +1581,7 @@ static const struct nla_policy ct_nla_policy[CTA_MAX+1] = {
 				    .len = NF_CT_LABELS_MAX_SIZE },
 	[CTA_FILTER]		= { .type = NLA_NESTED },
 	[CTA_STATUS_MASK]	= { .type = NLA_U32 },
+	[CTA_TIMESTAMP_EVENT]	= { .type = NLA_REJECT },
 };
 
 static int ctnetlink_flush_iterate(struct nf_conn *ct, void *data)
-- 
2.45.2


