Return-Path: <netfilter-devel+bounces-13124-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0t8YM/bpJmoknAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13124-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 18:12:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2E6588CA
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 18:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13124-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13124-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBBAD314D6C0
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4473F9F46;
	Mon,  8 Jun 2026 15:23:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFB3F9F45
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2026 15:23:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932221; cv=none; b=i5yBucyU9sQqUQeDDtBiFgezTx2BVeD78SUkpGGqRwAkFsgDHbLOMviOnWrRlP/aHmE5UlD2KmR/B5j3oUciWRFzrHwA9T7SumEwGxKiwWsADj0WL5zCG9dR5k5nUqH9seglPWZPXOnEwKQo9owKw7+G4dRfHy2Ji42YHhMul/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932221; c=relaxed/simple;
	bh=nXoL0RKKxegxkHGW6EazVetNUx8SoCpzwe3StgKon34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsxCTnRz34nG7D1wD2yQYOspWOneBTokBsgrJ59gcuzYVjb8DQpNCcLdAspLfV07rv1ShzJaaPXFLduqKW6la3ZWx1E5C5h1ZPpuU49hiYkC+E01yfy2F7vrFC+qSQrVHFG+54OXzztxTP+DY4lUXXt8CoEyLfmiVVRXiBOmHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 706F9602F8; Mon, 08 Jun 2026 17:23:38 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] netfilter: x_tables: avoid leaking percpu counter pointers
Date: Mon,  8 Jun 2026 17:23:17 +0200
Message-ID: <20260608152324.20700-3-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152324.20700-1-fw@strlen.de>
References: <20260608152324.20700-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:kylebot@openai.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13124-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DF2E6588CA

From: Kyle Zeng <kylebot@openai.com>

The native and compat get-entries paths copy the fixed rule entry header
from the kernelized rule blob to userspace before overwriting the entry's
counter fields with a sanitized counter snapshot.

On SMP kernels, entry->counters.pcnt contains the percpu allocation
address used by x_tables rule counters. A caller can provide a userspace
buffer that faults during the initial fixed-header copy after pcnt has
been copied but before the later sanitized counter copy runs. The syscall
then returns -EFAULT while leaving the raw percpu pointer in userspace.

Copy only the fixed entry prefix before counters from the kernelized rule
blob, then copy the sanitized counter snapshot into the counter field.
Apply this ordering to the IPv4, IPv6, and ARP native and compat
get-entries implementations so a fault cannot expose the internal percpu
counter pointer.

Fixes: 71ae0dff02d7 ("netfilter: xtables: use percpu rule counters")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/ipv4/netfilter/arp_tables.c | 15 ++++++---------
 net/ipv4/netfilter/ip_tables.c  | 15 ++++++---------
 net/ipv6/netfilter/ip6_tables.c | 15 ++++++---------
 3 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 85a01cbe448a..5773366de242 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -702,14 +702,12 @@ static int copy_entries_to_user(unsigned int total_size,
 		const struct xt_entry_target *t;
 
 		e = loc_cpu_entry + off;
-		if (copy_to_user(userptr + off, e, sizeof(*e))) {
-			ret = -EFAULT;
-			goto free_counters;
-		}
-		if (copy_to_user(userptr + off
+		if (copy_to_user(userptr + off, e,
+				 offsetof(struct arpt_entry, counters)) ||
+		    copy_to_user(userptr + off
 				 + offsetof(struct arpt_entry, counters),
 				 &counters[num],
-				 sizeof(counters[num])) != 0) {
+				 sizeof(counters[num]))) {
 			ret = -EFAULT;
 			goto free_counters;
 		}
@@ -1327,9 +1325,8 @@ static int compat_copy_entry_to_user(struct arpt_entry *e, void __user **dstptr,
 
 	origsize = *size;
 	ce = *dstptr;
-	if (copy_to_user(ce, e, sizeof(struct arpt_entry)) != 0 ||
-	    copy_to_user(&ce->counters, &counters[i],
-	    sizeof(counters[i])) != 0)
+	if (copy_to_user(ce, e, offsetof(struct compat_arpt_entry, counters)) ||
+	    copy_to_user(&ce->counters, &counters[i], sizeof(counters[i])))
 		return -EFAULT;
 
 	*dstptr += sizeof(struct compat_arpt_entry);
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index a0ceb618966f..e6e2a71d33b5 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -832,14 +832,12 @@ copy_entries_to_user(unsigned int total_size,
 		const struct xt_entry_target *t;
 
 		e = loc_cpu_entry + off;
-		if (copy_to_user(userptr + off, e, sizeof(*e))) {
-			ret = -EFAULT;
-			goto free_counters;
-		}
-		if (copy_to_user(userptr + off
+		if (copy_to_user(userptr + off, e,
+				 offsetof(struct ipt_entry, counters)) ||
+		    copy_to_user(userptr + off
 				 + offsetof(struct ipt_entry, counters),
 				 &counters[num],
-				 sizeof(counters[num])) != 0) {
+				 sizeof(counters[num]))) {
 			ret = -EFAULT;
 			goto free_counters;
 		}
@@ -1228,9 +1226,8 @@ compat_copy_entry_to_user(struct ipt_entry *e, void __user **dstptr,
 
 	origsize = *size;
 	ce = *dstptr;
-	if (copy_to_user(ce, e, sizeof(struct ipt_entry)) != 0 ||
-	    copy_to_user(&ce->counters, &counters[i],
-	    sizeof(counters[i])) != 0)
+	if (copy_to_user(ce, e, offsetof(struct compat_ipt_entry, counters)) ||
+	    copy_to_user(&ce->counters, &counters[i], sizeof(counters[i])))
 		return -EFAULT;
 
 	*dstptr += sizeof(struct compat_ipt_entry);
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 24a590c87eac..77f7cf526df8 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -848,14 +848,12 @@ copy_entries_to_user(unsigned int total_size,
 		const struct xt_entry_target *t;
 
 		e = loc_cpu_entry + off;
-		if (copy_to_user(userptr + off, e, sizeof(*e))) {
-			ret = -EFAULT;
-			goto free_counters;
-		}
-		if (copy_to_user(userptr + off
+		if (copy_to_user(userptr + off, e,
+				 offsetof(struct ip6t_entry, counters)) ||
+		    copy_to_user(userptr + off
 				 + offsetof(struct ip6t_entry, counters),
 				 &counters[num],
-				 sizeof(counters[num])) != 0) {
+				 sizeof(counters[num]))) {
 			ret = -EFAULT;
 			goto free_counters;
 		}
@@ -1244,9 +1242,8 @@ compat_copy_entry_to_user(struct ip6t_entry *e, void __user **dstptr,
 
 	origsize = *size;
 	ce = *dstptr;
-	if (copy_to_user(ce, e, sizeof(struct ip6t_entry)) != 0 ||
-	    copy_to_user(&ce->counters, &counters[i],
-	    sizeof(counters[i])) != 0)
+	if (copy_to_user(ce, e, offsetof(struct compat_ip6t_entry, counters)) ||
+	    copy_to_user(&ce->counters, &counters[i], sizeof(counters[i])))
 		return -EFAULT;
 
 	*dstptr += sizeof(struct compat_ip6t_entry);
-- 
2.43.0

