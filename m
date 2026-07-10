Return-Path: <netfilter-devel+bounces-13843-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ZvyCqoNUWrd+gIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13843-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 17:20:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E0973C2B6
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 17:20:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=BppPdIQX;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13843-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13843-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ECAC3044F2C
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB6230DEBE;
	Fri, 10 Jul 2026 15:14:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A872F1FEC
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 15:14:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696462; cv=none; b=HvOc9HXNjIssxufKNb9LZL0uyCKA2ePRfv3gteWrG9xe7EKJw/TE6cyfiOqPZK2710sJ5JUNmSzK23mMYPcSC2LA4O+qin5xiVoyOGsehP5b7+Oik0u5bvJiwOdqYo2gGX5gBKzPc7fUy5/cyTAz+D2G6mGDcU7DfJC+uIDt8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696462; c=relaxed/simple;
	bh=3wpPkR21OkYtp/vxh8BodhVhOBeHmFjIhfttOlPy6dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3lqtIxSwzSNbJQ3KjwlfObtEg+lZw0byuuIXFMld0Bmxjjqo21NoyYil2AKrPFt05k7FJekL0Xz+z3pyFiDoMSz5riJUqRRVQ21TVBf2tcRxHvnt7YGov4KbGLfQaiyMC9spMjqM4HVxMetLMOH6drCB0WWAgu7BzdmfnxXVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=BppPdIQX; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kg8SBj6nWTbk7Z+jofjFwVHKraJkxW0Ms1Lnw2I0Ps0=; b=BppPdIQXHzqUCB9F9xbQolybtP
	npad9+g/C6K90edakQ/NLS+iP8+6IWuWrGSe765McyP0XCaF4d0eKyjtEXAvWkzogeoqiKv4Zwx7S
	zNky2sn0bUhiUH+yYoCBpopC3OoXOM6m3O8UN1AeydSSSXY8b09tBc4vsp0hrtoQn+r8OFnaoQy53
	FalK6c+y6HW+i5SHiKfs1CmJjwndGMNRyoOEm2lpqr8fzykivcoBSyLBOxnEIKormDyGO6f04keDZ
	GKLfTrtMIbjdVBiJ5+0WsUN0IMFA7CRxjvzFzfA+gMJ8mv51Xo9zifxPrVNSWw4HVD5kHMAlppRAR
	PPNbL/bw==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1wiCvh-000000001tq-1Gzy;
	Fri, 10 Jul 2026 17:14:17 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH v3 4/4] netfilter: nfnetlink_hook: Fix for concurrent NAT hooks dump and change
Date: Fri, 10 Jul 2026 17:14:11 +0200
Message-ID: <20260710151411.2358773-5-phil@nwl.cc>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13843-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nwl.cc:from_mime,nwl.cc:email,nwl.cc:mid,checkpatch.pl:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69E0973C2B6

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
index be2f99b678be..ad135419d08f 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -55,6 +55,7 @@ static int nf_netlink_dump_start_rcu(struct sock *nlsk, struct sk_buff *skb,
 struct nfnl_dump_hook_data {
 	char devname[IFNAMSIZ];
 	unsigned long headv;
+	unsigned long natv;
 	u8 hook;
 };
 
@@ -348,6 +349,15 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
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
 
@@ -362,8 +372,10 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
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


