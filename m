Return-Path: <netfilter-devel+bounces-13758-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g9BkLKx7TmqtNgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13758-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:32:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA6728BF2
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:32:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=DiBu6GJy;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13758-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13758-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 840C5300F7B1
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3C42DA39;
	Wed,  8 Jul 2026 16:19:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F8378825
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 16:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527597; cv=none; b=tLbPXxqUdMmcV+MK9ByjsjxEEwZeBmPwK1JpYWg3lL6YyYZGt8xGNculaq1v7kAer2bBbOb9Nt93OjOB7mf6uDKvstw6hP7+olA3FWSqkRBjrXkc/LZ0g1qjW3u1ZOmCg383r1Mn0f5uU7xbzpl2B/WwB1dyZu4GuDYH16KuwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527597; c=relaxed/simple;
	bh=HizqugCXKEwa1hJDadXAjjr8DJgzmKO688eeX0wfQXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktboODoHXlB68YgVYqchRIkOxQ30m+GecY7+hdQGDWmxz53O5Nxxm7wPzFdylR18H63ewu7l/XlGc1MPxSjilXEEqyQwBmf27rzcuWrD3XFJyEMpmkJMj93YyBKf3H8JehjaWeZFnyixuFSs5ANFxEhtMbzP5xsHoiiAqg0KlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=DiBu6GJy; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2STQtbLqkqH+DQrIE1hagzYIJ3FQlr+yIQGc2Vnj54A=; b=DiBu6GJyHLZTpsrf4evzJT+ADV
	c+NCQdFIgiq6kCGCnccBcn5xsvJWkXEJh9U6OiPsZYHzAh8y4DqHTsK3yLs8ZfKt76ZBnUSlP15b4
	Dw1Cn2ADcVZGZFb1koUxeLWd2QsbIl7EQ4c1ns6hJn41J4NpRvud90QM3xUAzqxp1g9FP+6I4yoh8
	0KGzgj0nFlSdi2MjrJkg/TQu+HOgW7BgEhlnfWeBQnf4pcLkQOjtxiHLC+gE0jBCELbjO65n/9eQP
	MBtz/sMr0TXFmKxF75iAyJdQ+yllLHCtejhqoO8jmbe7Y16gEdFqJKHGYg5EcReup6WN9ozaxrYF9
	/vPdZDig==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whUzy-000000001s7-3lEw;
	Wed, 08 Jul 2026 18:19:47 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [nf-next PATCH 2/4] netfilter: nfnetlink_hook: Deref hook entry using READ_ONCE()
Date: Wed,  8 Jul 2026 18:19:38 +0200
Message-ID: <20260708161940.1477671-3-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708161940.1477671-1-phil@nwl.cc>
References: <20260708161940.1477671-1-phil@nwl.cc>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13758-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nwl.cc:from_mime,nwl.cc:email,nwl.cc:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93AA6728BF2

Writer (nf_remove_net_hook) assigns to the field value using
WRITE_ONCE(), appropriately call READ_ONCE() to make sure reader
(nfnl_hook_dump) sees either the old or new value, not both.

Fixes: b010e2a4a9ac ("netfilter: nfnetlink_hook: Dump nat type chains")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nfnetlink_hook.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index e47a2add4d5b..efc674fc5adf 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -390,10 +390,12 @@ static int nfnl_hook_dump(struct sk_buff *nlskb,
 	ops = nf_hook_entries_get_hook_ops(e);
 
 	for (; i < e->num_hook_entries; i++) {
-		if (ops[i]->hook_ops_type == NF_HOOK_OP_NAT)
-			err = nfnl_hook_dump_nat(nlskb, cb, ops[i], family);
+		struct nf_hook_ops *cur = READ_ONCE(ops[i]);
+
+		if (cur->hook_ops_type == NF_HOOK_OP_NAT)
+			err = nfnl_hook_dump_nat(nlskb, cb, cur, family);
 		else
-			err = nfnl_hook_dump_one(nlskb, ctx, ops[i],
+			err = nfnl_hook_dump_one(nlskb, ctx, cur,
 						 ops[i]->priority, family,
 						 cb->nlh->nlmsg_seq);
 		if (err)
-- 
2.54.0


