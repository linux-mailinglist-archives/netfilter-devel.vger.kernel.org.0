Return-Path: <netfilter-devel+bounces-11850-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGczAXZo3WnsdgkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11850-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 00:04:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC73F3B25
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 00:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55C533020FFC
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F136397E88;
	Mon, 13 Apr 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="I2sRu22k"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F106A39A064
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Apr 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117873; cv=none; b=CTUykDrVZP4qpC6sihGPOLNohDQgru35vitxSme60DXACL2NEO96rP+ShMvvIobxtu6xhAlmPMDLzQlpN6yBZsI9KVOjVH+CpMfimUzpE3/q7ihsSJzgXZsrUEKY7mbZHvX/W5kCiBfUJeJkE+8QE6uh2o8PncozpCfy44fQz80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117873; c=relaxed/simple;
	bh=JeZHR8BoU0I9sPwIIIlrOqPFwmrY+IiqBFGD2SUEcAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4JaF4ByPk39uoxBIv5dgxnK9qAuTNkXOFWU3Y2ycPF8/ve2BfYZh0UdbKfBx6iTQFBkTuQhKnpYV2W25UZ8j6JR/X7MkURBiAenlnyNVEwZHdcnlNGW5YbKcI7IWV9UyO/KzRte829g1JZET1g7sUNMa/Jidow/QEW3P4rYZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=I2sRu22k; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C2FFA60177;
	Tue, 14 Apr 2026 00:04:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776117861;
	bh=3DDPZdVM15K4srZL7RqUlDuF3O+UYgjXiHYOsa+hOTs=;
	h=From:To:Cc:Subject:Date:From;
	b=I2sRu22kolw0neFLKYIHkk6ALsj6sTIGIsNK7sowTiP9yoRncSuE3BcuJ4o0HKT8o
	 YTHpT+cD2mvv7rHpRbDEBvDNG6x7Y5iQnB3iOu7qeSQgOtGE9TzSztpCRb9kQYjmmV
	 9VJclU7EesPq1eg3t1/8nB5NH6W956pAj0DS3kKbwYrg6qwSkPz+zIGewUyvu/8KyV
	 zC+7v9fm9vhyggjdwdYh82hVmsBuWqNPXBey7VCELCoJF68rwZq0CdA39MwKN4wiyj
	 41ea3pRbhVLi52C83Hdww4KVL+SdvGbk/27mC3FOBjObDjcWxiqFqffSdTscctQGQP
	 GRD15W0VGbj8A==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: paulmck@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	fw@strlen.de
Subject: [PATCH nf 1/3] rculist: add list_splice_rcu() for private lists
Date: Tue, 14 Apr 2026 00:04:15 +0200
Message-ID: <20260413220415.43221-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11850-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid]
X-Rspamd-Queue-Id: 71CC73F3B25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds a helper function, list_splice_rcu(), to safely splice
a private (non-RCU-protected) list into an RCU-protected list.

The function ensures that only the pointer visible to RCU readers
(prev->next) is updated using rcu_assign_pointer(), while the rest of
the list manipulations are performed with regular assignments, as the
source list is private and not visible to concurrent RCU readers.

This is useful for moving elements from a private list into a global
RCU-protected list, ensuring safe publication for RCU readers.
Subsystems with some sort of batching mechanism from userspace can
benefit from this new function.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
@I need this to fix a unsafe list_splice() of a private list to an
existing RCU-protected list. This is based on an existing idiom in
__list_splice_init_rcu().

 include/linux/rculist.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 2abba7552605..3c18c3336459 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -261,6 +261,41 @@ static inline void list_replace_rcu(struct list_head *old,
 	old->prev = LIST_POISON2;
 }
 
+/**
+ * __list_splice_rcu - join a non-RCU list into an existing list.
+ * @list:	the RCU-protected list to splice
+ * @prev:	points to the last element of the existing list
+ * @next:	points to the first element of the existing list
+ *
+ * The list pointed to by @prev and @next can be RCU-read traversed
+ * concurrently with this function.
+ */
+static inline void __list_splice_rcu(struct list_head *list,
+				     struct list_head *prev,
+				     struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	last->next = next;
+	rcu_assign_pointer(list_next_rcu(prev), first);
+	first->prev = prev;
+	next->prev = last;
+}
+
+/**
+ * list_splice_rcu - splice a non-RCU list into an RCU-protected list,
+ *                   designed for stacks.
+ * @list:	the non RCU-protected list to splice
+ * @head:	the place in the existing list to splice the first list into
+ */
+static inline void list_splice_rcu(struct list_head *list,
+				   struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice_rcu(list, head, head->next);
+}
+
 /**
  * __list_splice_init_rcu - join an RCU-protected list into an existing list.
  * @list:	the RCU-protected list to splice
-- 
2.47.3


