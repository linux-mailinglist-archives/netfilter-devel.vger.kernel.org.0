Return-Path: <netfilter-devel+bounces-10937-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCyFIo9Op2nKggAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10937-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 22:11:43 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F001F739E
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 22:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AACE3129850
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2026 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7A39657D;
	Tue,  3 Mar 2026 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="DVX0YjnL"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF273750DD;
	Tue,  3 Mar 2026 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572091; cv=none; b=u5ibSs81XDDvIw1R8pzvBrj5DFObGIvuYuv60uyGhyki7KCrzKrpRvYKQbzM5EvgRtTyhZL4s96jSBGSo9UonJ4YjPcYe0b9CgYVh1Ob9Vbm9KT3tWtCBVUGyayrtYLk2dZwjSXIIlzEhCjMI/2xi9LNw9ZcOdiO77nUeanDrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572091; c=relaxed/simple;
	bh=YpQVzMNQYwubgAblRHLy5reB5gle/I0QeomSycZdkAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFjBzzxZYmVVc2geY/byQTYpnf1IHsYDRvB8fVihEzPHWdCCBvg26LcWuqY1o/XmxipMpJFLkemNTipBAuNdi6w0W1E4JtUXXebril4Qxle3V69DQBq5C1ZAOrQfzXsDDX4QDTsLgb9p55um7FdhQ7VXUKcZkfSWas17QYJfsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=DVX0YjnL; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 5882621D16;
	Tue, 03 Mar 2026 23:08:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=luGPi+clXTffMVgstG1zKlKX62vMfhcFqk6l1hfDpoU=; b=DVX0YjnL19uQ
	4xBRyPGo/rTiHq/buD6UteqHXc86iyHwGWUYZGO8myRMX8UnDcci4EH8naLBY2OC
	Ch5m1TvSepQ2IA2RKpFWdxhH7YNQjd+SFAbLh0KZoYC0RCbBcmGzBXV1KznQlGDN
	hwQ9QuHegiKjeyTGZmWqEAFx++NG+ysF1bjDgO/lsbkJqj8i4ufh5thv7SlrppOZ
	Oo42sM/qUsPO2qLWCy0lt9zX+PzyW13oaVwLzSIPDzN3e0ZseLxR+bRKaFHbYoq9
	PVKNc9l92+VObzIMOj681d+mW/y/A4hNip6KJ1SMAcMNLcY5ATMwoxAxDJFUmDsC
	w2MaQH39ICaRPrKEyTRyMGIGPnPfB8BdpsgSR6bwzIvaQSnLhr73zwDC4kRTmZbz
	9yjve18ox0U1vQweL0FjYECoPlH+1giyJ78lycdzyZH9HYTExPeqzhNP4aVjKMvE
	GH6yMZjqFkrZQ5RACf+MNNbiba7tPVxPjVl5qDDCLzPjEGSl9Y/JSKHdzK7Dz4WM
	/NhSdeWgrwFh3M6pHRvK3IohtkE7ohll3PSr62xTgi5+pRlu/ZM7VXRse0R272g/
	+94+XGtGPjrs1oV5wLLDCoFJAJn+k+2HW4gUcc8gxvq09YG4VMVuFG/nUc7OiiJX
	pVgmHbrBR2kDa7ElxS+EB8n6DwQhtwo=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Tue, 03 Mar 2026 23:08:06 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 7A07F600C6;
	Tue,  3 Mar 2026 23:08:05 +0200 (EET)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 623L56XS087505;
	Tue, 3 Mar 2026 23:05:06 +0200
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 623L56WV087503;
	Tue, 3 Mar 2026 23:05:06 +0200
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: [PATCHv2 nf-next 1/5] rculist_bl: add hlist_bl_for_each_entry_continue_rcu
Date: Tue,  3 Mar 2026 23:04:04 +0200
Message-ID: <20260303210408.87468-2-ja@ssi.bg>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303210408.87468-1-ja@ssi.bg>
References: <20260303210408.87468-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 02F001F739E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ssi.bg:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10937-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ssi.bg:dkim,ssi.bg:email,ssi.bg:mid];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Change the old hlist_bl_first_rcu to hlist_bl_first_rcu_dereference
to indicate that it is a RCU dereference.

Add hlist_bl_next_rcu and hlist_bl_first_rcu to use RCU pointers
and use them to fix sparse warnings.

Add hlist_bl_for_each_entry_continue_rcu.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/linux/rculist_bl.h | 49 +++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 0b952d06eb0b..36363b876e53 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -8,21 +8,31 @@
 #include <linux/list_bl.h>
 #include <linux/rcupdate.h>
 
+/* return the first ptr or next element in an RCU protected list */
+#define hlist_bl_first_rcu(head)	\
+	(*((struct hlist_bl_node __rcu **)(&(head)->first)))
+#define hlist_bl_next_rcu(node)	\
+	(*((struct hlist_bl_node __rcu **)(&(node)->next)))
+
 static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
 					struct hlist_bl_node *n)
 {
 	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
 	LIST_BL_BUG_ON(((unsigned long)h->first & LIST_BL_LOCKMASK) !=
 							LIST_BL_LOCKMASK);
-	rcu_assign_pointer(h->first,
+	rcu_assign_pointer(hlist_bl_first_rcu(h),
 		(struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK));
 }
 
-static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
-{
-	return (struct hlist_bl_node *)
-		((unsigned long)rcu_dereference_check(h->first, hlist_bl_is_locked(h)) & ~LIST_BL_LOCKMASK);
-}
+#define hlist_bl_first_rcu_dereference(head)				\
+({									\
+	struct hlist_bl_head *__head = (head);				\
+									\
+	(struct hlist_bl_node *)					\
+	((unsigned long)rcu_dereference_check(hlist_bl_first_rcu(__head), \
+					      hlist_bl_is_locked(__head)) & \
+					      ~LIST_BL_LOCKMASK);	\
+})
 
 /**
  * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
@@ -73,7 +83,7 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
 {
 	struct hlist_bl_node *first;
 
-	/* don't need hlist_bl_first_rcu because we're under lock */
+	/* don't need hlist_bl_first_rcu* because we're under lock */
 	first = hlist_bl_first(h);
 
 	n->next = first;
@@ -93,9 +103,30 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
  *
  */
 #define hlist_bl_for_each_entry_rcu(tpos, pos, head, member)		\
-	for (pos = hlist_bl_first_rcu(head);				\
+	for (pos = hlist_bl_first_rcu_dereference(head);		\
 		pos &&							\
 		({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
-		pos = rcu_dereference_raw(pos->next))
+		pos = rcu_dereference_raw(hlist_bl_next_rcu(pos)))
+
+/**
+ * hlist_bl_for_each_entry_continue_rcu - continue iteration over list of given
+ *   type
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_bl_node to use as a loop cursor.
+ * @member:	the name of the hlist_bl_node within the struct.
+ *
+ * Continue to iterate over list of given type, continuing after
+ * the current position which must have been in the list when the RCU read
+ * lock was taken.
+ * This would typically require either that you obtained the node from a
+ * previous walk of the list in the same RCU read-side critical section, or
+ * that you held some sort of non-RCU reference (such as a reference count)
+ * to keep the node alive *and* in the list.
+ */
+#define hlist_bl_for_each_entry_continue_rcu(tpos, pos, member)		\
+	for (pos = rcu_dereference_raw(hlist_bl_next_rcu(&(tpos)->member)); \
+	     pos &&							\
+	     ({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
+	     pos = rcu_dereference_raw(hlist_bl_next_rcu(pos)))
 
 #endif
-- 
2.53.0



