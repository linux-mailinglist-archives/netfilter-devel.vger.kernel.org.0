Return-Path: <netfilter-devel+bounces-13802-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m82gHzf7T2rkrQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13802-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 21:49:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7647352D5
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 21:49:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b="b/LKsl1m";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13802-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13802-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE66301D040
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F34C4499BD;
	Thu,  9 Jul 2026 19:46:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FB44998E
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 19:46:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626388; cv=none; b=OLOByxBvnBGrvbK5ZbOw5V47QifnT/Cwt6Z/RCXUY99s1sXe7eBh65C8Q76z7elO2MlZ7ecc/T+czc7nBGel8q3ayi2rmFXO0rrNPICvHxoPN0HHphSheDi+SHg/34/6b9eLlWt30P6Xl1psUN5JsMlMSBY9hi+y3sa/SXKIh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626388; c=relaxed/simple;
	bh=VXfOxB9DkS6y/xrzhqqFwdHgeE3o+5mpU+bxsvmWWf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYuScC3bsXPyOGWHbWQnXlj8W4e7Rdbp3oIaFuxpfheohgdKwVYP5FilczwLRUbgtd5f2ZaNTHXRxDK/4/4Hgck4tWbdN2Z3OuYHqLNCltXD8WqdtIxVciQK61W+4jnalc9G7/KHLjPA0HlLtVzwaWuVVjrbesAIkzUfvVDO7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=b/LKsl1m; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OAgX7v1SroL2pBxqX4cgsicm+HGhxsVhluY8cPvZovc=; b=b/LKsl1m329dF2GhTCcpYATkjw
	DqzxQnJ5qHFgJIY37CUCt870o9ndVS8nFXXHkySVOT/RD2lx6uNv7jPmIq/mwBFsDO3hzpC4uFqe2
	kJOtVI2jpwmOGnbrIS0LEN56px2KszDLO2XDVd8vQ3cXDxJ7rAWQfdyt2bPt7HA1+d+TBPcGYPwGS
	EJedXrKBGuxtd4uG3/x9deaBawlt3Vmpk1/1rvI5CaceFIFv8e5Leesb11v3M3L43RMdOaOBvp1mH
	+AWpuqdvteeUpWPKRyEtZMNcJKUndJESOVg6s6mYor2Z9qweExb8gzni0dtMo6C1HTuR+QIwirj4U
	RR9OAlvg==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whuhO-000000002iy-1ILT;
	Thu, 09 Jul 2026 21:46:18 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH v2 5/5] netfilter: nfnetlink_hook: Fix for concurrent NAT hooks dump and change
Date: Thu,  9 Jul 2026 21:46:12 +0200
Message-ID: <20260709194612.1995795-6-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709194612.1995795-1-phil@nwl.cc>
References: <20260709194612.1995795-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13802-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:from_mime,nwl.cc:email,nwl.cc:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE7647352D5

If hooks are added or deleted, the nf_hook_entries buffer is reallocated
and the RCU-protected pointer updated. If a dump requires multiple parts
(exceeding sk_buff space) the second invocation may see a different
nf_hook_entries pointer than the first one. Detect this just like the
outer nfnl_hook_dump function does, by storing the pointer value in
context. If it changes, signal user space it must restart.

As with the stored loop counter, that stored pointer value must be
manually zeroed upon successful loop completion since this inner
function may run multiple times for different nf_hook_ops but with same
context.

Fixes: b010e2a4a9ac ("netfilter: nfnetlink_hook: Dump nat type chains")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Fix a stupid typo introduced last minute when resolving checkpatch.pl
  complaints
- If 'e' becomes zero, it also indicates an interrupted dump
---
 net/netfilter/nfnetlink_hook.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index e3b5d21eeb2e..95873c7a524f 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -55,6 +55,7 @@ static int nf_netlink_dump_start_rcu(struct sock *nlsk, struct sk_buff *skb,
 struct nfnl_dump_hook_data {
 	char devname[IFNAMSIZ];
 	unsigned long headv;
+	unsigned long natv;
 	u8 hook;
 };
 
@@ -355,6 +356,15 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
 	unsigned int i = cb->args[1];
 	int err = 0;
 
+	if (!ctx->natv)
+		ctx->natv = (unsigned long)e;
+
+	if ((e && i >= e->num_hook_entries) ||
+	    ctx->natv != (unsigned long)e) {
+		cb->seq++;
+		return -EINTR;
+	}
+
 	if (!e)
 		return 0;
 
@@ -369,8 +379,10 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
 			break;
 	}
 
-	if (!err)
+	if (!err) {
+		ctx->natv = 0;
 		i = 0;
+	}
 	cb->args[1] = i;
 	return err;
 }
-- 
2.54.0


