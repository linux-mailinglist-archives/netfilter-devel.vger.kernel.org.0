Return-Path: <netfilter-devel+bounces-13840-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O0CUFIIMUWqK+gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13840-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 17:15:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F21E73C236
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 17:15:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=bJAa8ccj;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13840-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13840-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE00301E7EB
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B9304BB2;
	Fri, 10 Jul 2026 15:14:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFF2F7EE1
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 15:14:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696461; cv=none; b=R7c4XsnKlqphbPmKcVDdwjKVuLImpDdGd4n9Qq7vIO7JfPhNK96izr1nqvdlY8mt59uDg/blqiUZ6QX+atQLkrvWtdqLTr13i/9lYHgHG+wwJEeoGcJOEyiQpzyFCnjR2AP/m38iaCK0Hg1joQazCGzZww/XpSNl9gwuYGyIGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696461; c=relaxed/simple;
	bh=bwZ2Qa1QFMGGrqbhUPdQDJPESLPGOZcHuyW2BVX+RFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F53JhyQn1AX4BmGiKHJbPwIq11iYrtxhd3NJk1kTbiE66H3kNK2b8NAaQqFhiehJ5+ak/mjrEL1Fdn64h/hUM70kED0Loq2m1ueAecPikE2WRDMp7eF5CI4oJOZgGkGhXZjeaNflPZTt5glvy/vlvSl6GTmNxLHuD2pbZ0lfFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=bJAa8ccj; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZLzLSQjAM3Py8lkIhr6LO2guoe2Wi7pN+ntwK23eofc=; b=bJAa8ccjYWLAyDOWD0sY5iylKT
	RVICQVVv00bEKzJAb6OYKGTrUWlPwq8ZpkLpH3Zx7AxZuBtL5paErJ4erDLeL5nGXVVwY1LyeI20d
	mYnv9y0AkC7Q+x4bIyb7+Ie36I03YPSjQDlxn4IDYO+HYulJGzzXkrEexzTN8dcTufOhwKu86WVik
	0AUvQqe7IBZVlepUcm9k+kT81AlAtK1wBOHMvUxSIln444W7FT9JlPrnE8D14hu1pl6e/baIKnfRQ
	Q4WBJgNjcbADPmt+Z7vOZnGsZfFLajNVS+cz1zQNR27IIEw3oJ5IGWGugYsnHMUTmrDr8cUJjJMwp
	kaviWmLg==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wiCvi-000000001u2-1Dyx;
	Fri, 10 Jul 2026 17:14:18 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH v3 2/4] netfilter: nfnetlink_hook: Address hook ops using READ_ONCE()
Date: Fri, 10 Jul 2026 17:14:09 +0200
Message-ID: <20260710151411.2358773-3-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710151411.2358773-1-phil@nwl.cc>
References: <20260710151411.2358773-1-phil@nwl.cc>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13840-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,nwl.cc:server fail,tor.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[nwl.cc:-];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F21E73C236

Writer (nf_remove_net_hook) assigns to the field value using
WRITE_ONCE(), appropriately call READ_ONCE() to make sure reader
(nfnl_hook_dump) sees either the old or new value, not both.

Fixes: b010e2a4a9ac ("netfilter: nfnetlink_hook: Dump nat type chains")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Cover for previously missed ops[i]->priority parameter
- Also cover for nat_ops field access, adjust patch subject
- Declare temporary variable as const
---
 net/netfilter/nfnetlink_hook.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index e47a2add4d5b..644070c8b456 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -353,7 +353,8 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
 	nat_ops = nf_hook_entries_get_hook_ops(e);
 
 	for (i = 0; i < e->num_hook_entries; i++) {
-		err = nfnl_hook_dump_one(nlskb, ctx, nat_ops[i],
+		err = nfnl_hook_dump_one(nlskb, ctx,
+					 READ_ONCE(nat_ops[i]),
 					 ops->priority, family,
 					 cb->nlh->nlmsg_seq);
 		if (err)
@@ -390,11 +391,13 @@ static int nfnl_hook_dump(struct sk_buff *nlskb,
 	ops = nf_hook_entries_get_hook_ops(e);
 
 	for (; i < e->num_hook_entries; i++) {
-		if (ops[i]->hook_ops_type == NF_HOOK_OP_NAT)
-			err = nfnl_hook_dump_nat(nlskb, cb, ops[i], family);
+		const struct nf_hook_ops *cur = READ_ONCE(ops[i]);
+
+		if (cur->hook_ops_type == NF_HOOK_OP_NAT)
+			err = nfnl_hook_dump_nat(nlskb, cb, cur, family);
 		else
-			err = nfnl_hook_dump_one(nlskb, ctx, ops[i],
-						 ops[i]->priority, family,
+			err = nfnl_hook_dump_one(nlskb, ctx, cur,
+						 cur->priority, family,
 						 cb->nlh->nlmsg_seq);
 		if (err)
 			break;
-- 
2.54.0


