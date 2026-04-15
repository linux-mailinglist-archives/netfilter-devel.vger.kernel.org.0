Return-Path: <netfilter-devel+bounces-11931-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAqSGCnG32kmYwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11931-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 19:08:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7597406A4F
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 19:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB5EA301D4F6
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 17:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B03E5573;
	Wed, 15 Apr 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ubOpxq+0"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300133120C;
	Wed, 15 Apr 2026 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272934; cv=none; b=Bc27cjLx+/KNX3dlsnGlewN78FlSKVD5xisVDA11f7eCCZXE4+Bd0rU8dHak3n7x3zGkk+iGwyj915X17YLhJed/RVjf3ZuIe5dvteDM80ds1vxdkbKi3GPX2zdYPmGsDu84vKaAoUQtXdky+8YYmoY8A8Ios3BaubLadjj0E3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272934; c=relaxed/simple;
	bh=8EdpDbjWpEfY9zXDyutbjs8BUV0E1+6AmdmLmyEMfSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPzrIajZ75VS92XP+uAuT/JS+NIPuZB7QPdb2P6BzeBGqE8/13vgfhDlm3SUKA+Ve0g9FI/b3Csf5RnTNFJdWini5g4CHdIFwIePW204KVLMZuFV4A5TW22Qt2smQSBPhQXQpFBTHHXUx5q6mjiKyJ218oADo2kfueH0zAtjKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ubOpxq+0; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 1EF2B60177;
	Wed, 15 Apr 2026 19:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776272931;
	bh=6bOJS2bqcYmFCvqyYFWPjJ+z4vwva44OIAdYCVYUYSo=;
	h=From:To:Cc:Subject:Date:From;
	b=ubOpxq+02y2nkfryzTbNz7OyvqmyTWu6sHYiBPJgeLGpItsTJCx0xYalP8cAMA88b
	 Kz0ePAVgyk05w6OJM7my66kp4C0bvdquWxhHtmX3yZ5yao7d4Zkya3zQPTWTBwDz6r
	 Qnov6lW822xlJsuR6zjdMOZksXh1Z8Qs0nQE6wuHFF2KDqzssAZRjB9Alwv75/URnH
	 jUywN5eqFzvckPQqXNCsu4yBoZwUOpqdt30EmL7fjp9bXP5xl6PyDu9MH/cnltUJUV
	 XLYlzBDiVnG6kTKY6iCH5Pmns6zxpmKCrxfccyWipanjOJaBy67oY/w7zcx4P2NKg6
	 JUdhol/zGMnGQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org
Subject: [PATCH nf,v2 1/3] rculist: add list_splice_rcu() for private lists
Date: Wed, 15 Apr 2026 19:08:44 +0200
Message-ID: <20260415170844.41355-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11931-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,kernel.org,redhat.com,google.com,strlen.de,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7597406A4F
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

The function __list_splice_rcu() has been added for clarity and to
follow the same pattern as in the existing list_splice*() interfaces,
where there is a check to ensure that that the list to splice is not
empty. Note that __list_splice_rcu() has no documentation for this
reason.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: including comments by Paul McKenney.

    Except, I have deliberately keep back the suggestion to squash
    __list_splice_rcu() into list_splice_rcu(), I instead removed
    the documentation for __list_splice_rcu(). I am looking
    at other existing list_splice*() function in list.h and rculist.h
    to get this aligned with __list_splice(), which also has no users
    in the tree and no documentation. I find it easier to read with
    __list_splice(), but if this explaination is not sound so...

    @Paul: I can post v3 squashing __list_splice_rcu(), just let me
           know.

    Thanks!

 include/linux/rculist.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 2abba7552605..e3bc44225692 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -261,6 +261,35 @@ static inline void list_replace_rcu(struct list_head *old,
 	old->prev = LIST_POISON2;
 }
 
+static inline void __list_splice_rcu(struct list_head *list,
+				     struct list_head *prev,
+				     struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	last->next = next;
+	first->prev = prev;
+	next->prev = last;
+	rcu_assign_pointer(list_next_rcu(prev), first);
+}
+
+/**
+ * list_splice_rcu - splice a non-RCU list into an RCU-protected list,
+ *                   designed for stacks.
+ * @list:	the non RCU-protected list to splice
+ * @head:	the place in the existing RCU-protected list to splice
+ *
+ * The list pointed to by @head can be RCU-read traversed concurrently with
+ * this function.
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


