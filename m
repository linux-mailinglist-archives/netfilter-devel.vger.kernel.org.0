Return-Path: <netfilter-devel+bounces-13093-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CHTYCQ8/JWquEwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13093-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:51:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7364F446
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:51:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=TOiIVu2w;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13093-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13093-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6CD3036429
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2026 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B043876B0;
	Sun,  7 Jun 2026 09:50:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0D388391;
	Sun,  7 Jun 2026 09:50:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825808; cv=none; b=nrRD2ndrTBcZQNQPHEaDh9OhweL8vGYfYBWW1lz1CzQV2B67dfNezidHBn0ohbg/kLXkX0ke3/uJmQvT78b6fMOkcABgRnMOfjHROmY5QKMF/zhhxzeyM7lTBx9kbjUq4IX7AkvnFzCm3+upt4bFQTgj2MaQWMWQWJRApnDShnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825808; c=relaxed/simple;
	bh=vMxFXfCKHC67JeeyMYzv3O4y6gNYwNjsEOUcJeVSs/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEzOhCA5HObWev7lDXsJtwLBjbwXCO7YVWKmlJiQX0jyaonV87UYjm/tOYbfSsCJuDHNO+YWFNBPwlE/ZsUALWh5q1px/zQH6eR2eUOBHErItGa06fBdppRRZf6i93iHWI/RckTNW8lYrAHeU4gHBMKjz6wUUWqo86Gyrv/zaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=TOiIVu2w; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 8519B6017D;
	Sun,  7 Jun 2026 11:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780825805;
	bh=CIXRuEsD+agHYMUhgqvZAUY7hs+vYC5tV5NWgG6DzDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOiIVu2wnI+7CIYmsn+mSbMBY7djG0iZCbTIp+ZjizjyP2J0lhpSDvj78GVZXcUjP
	 QwbeLtHWKGIBs0vSnVTcfuCB3ofbTxcR7NMBBazV29X3BJQIkIHXsGmXOZsNe0ylWL
	 hNSBqvCy5plLquIGaCCY/7cG6deuaai3S5R6UyTyQ3yuENTiyyBgJfiaQmRsVh+TmU
	 iIXyAGi6Xk/eQA/AH984zc3miVdELSfM58caz53W74/TMlSHLse9a2O8UTgAgYk3uj
	 Oagn0v4hlBO85jVxOBCl5nXnoolRPAe7xx7M5aBJ1rGbID4vMsAcjvFYez/QivtMA7
	 tuCRO57ORO7pw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 03/15] netfilter: nfnetlink_cthelper: use {READ,WRITE}_ONCE for accessing helper flags
Date: Sun,  7 Jun 2026 11:49:42 +0200
Message-ID: <20260607094954.48892-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607094954.48892-1-pablo@netfilter.org>
References: <20260607094954.48892-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13093-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:mid,netfilter.org:dkim,netfilter.org:from_mime,netfilter.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5A7364F446

Conntrack helper flags are accessed from packet and netlink dump path.
Concurrent update of userspace helper flags is not possible, because the
nfnl_mutex in held on updates. These flags are only used by userspace
helpers. Use {READ,WRITE}_ONCE() to access this flags from lockless
paths.

Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_core.c  |  4 +++-
 net/netfilter/nfnetlink_cthelper.c | 20 +++++++++++++-------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index b521b5ebd664..c072a14a306a 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2213,6 +2213,7 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 {
 	const struct nf_conntrack_helper *helper;
 	const struct nf_conn_help *help;
+	unsigned int helper_flags;
 	int protoff;
 
 	help = nfct_help(ct);
@@ -2223,7 +2224,8 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 	if (!helper)
 		return NF_ACCEPT;
 
-	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
+	helper_flags = READ_ONCE(helper->flags);
+	if (!(helper_flags & NF_CT_HELPER_F_USERSPACE))
 		return NF_ACCEPT;
 
 	switch (nf_ct_l3num(ct)) {
diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index 34af6840803e..267eac1167f3 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -41,8 +41,9 @@ static int
 nfnl_userspace_cthelper(struct sk_buff *skb, unsigned int protoff,
 			struct nf_conn *ct, enum ip_conntrack_info ctinfo)
 {
-	const struct nf_conn_help *help;
 	struct nf_conntrack_helper *helper;
+	const struct nf_conn_help *help;
+	unsigned int helper_flags;
 
 	help = nfct_help(ct);
 	if (help == NULL)
@@ -53,8 +54,10 @@ nfnl_userspace_cthelper(struct sk_buff *skb, unsigned int protoff,
 	if (helper == NULL)
 		return NF_DROP;
 
+	helper_flags = READ_ONCE(helper->flags);
+
 	/* This is a user-space helper not yet configured, skip. */
-	if ((helper->flags &
+	if ((helper_flags &
 	    (NF_CT_HELPER_F_USERSPACE | NF_CT_HELPER_F_CONFIGURED)) ==
 	     NF_CT_HELPER_F_USERSPACE)
 		return NF_ACCEPT;
@@ -404,10 +407,10 @@ nfnl_cthelper_update(const struct nlattr * const tb[],
 
 		switch(status) {
 		case NFCT_HELPER_STATUS_ENABLED:
-			helper->flags |= NF_CT_HELPER_F_CONFIGURED;
+			WRITE_ONCE(helper->flags, helper->flags | NF_CT_HELPER_F_CONFIGURED);
 			break;
 		case NFCT_HELPER_STATUS_DISABLED:
-			helper->flags &= ~NF_CT_HELPER_F_CONFIGURED;
+			WRITE_ONCE(helper->flags, helper->flags & ~NF_CT_HELPER_F_CONFIGURED);
 			break;
 		}
 	}
@@ -529,8 +532,8 @@ static int
 nfnl_cthelper_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			int event, struct nf_conntrack_helper *helper)
 {
-	struct nlmsghdr *nlh;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
+	struct nlmsghdr *nlh;
 	int status;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTHELPER, event);
@@ -554,7 +557,7 @@ nfnl_cthelper_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 	if (nla_put_be32(skb, NFCTH_PRIV_DATA_LEN, htonl(helper->data_len)))
 		goto nla_put_failure;
 
-	if (helper->flags & NF_CT_HELPER_F_CONFIGURED)
+	if (READ_ONCE(helper->flags) & NF_CT_HELPER_F_CONFIGURED)
 		status = NFCT_HELPER_STATUS_ENABLED;
 	else
 		status = NFCT_HELPER_STATUS_DISABLED;
@@ -575,6 +578,7 @@ static int
 nfnl_cthelper_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nf_conntrack_helper *cur, *last;
+	unsigned int helper_flags;
 
 	rcu_read_lock();
 	last = (struct nf_conntrack_helper *)cb->args[1];
@@ -583,8 +587,10 @@ nfnl_cthelper_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 		hlist_for_each_entry_rcu(cur,
 				&nf_ct_helper_hash[cb->args[0]], hnode) {
 
+			helper_flags = READ_ONCE(cur->flags);
+
 			/* skip non-userspace conntrack helpers. */
-			if (!(cur->flags & NF_CT_HELPER_F_USERSPACE))
+			if (!(helper_flags & NF_CT_HELPER_F_USERSPACE))
 				continue;
 
 			if (cb->args[1]) {
-- 
2.47.3


