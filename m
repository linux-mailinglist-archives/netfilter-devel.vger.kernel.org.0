Return-Path: <netfilter-devel+bounces-13804-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JZikIEL7T2rmrQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13804-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 21:49:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABE7352E0
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 21:49:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=GBBPp+V9;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13804-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13804-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBBC33020AB1
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58EE3C2788;
	Thu,  9 Jul 2026 19:46:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE511D5160
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 19:46:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626388; cv=none; b=kEnI94R8I2YWTDotyvGG9vTdMcjN61HmCZj2/elMPvpspobVe3x9c5lkRWfr+d/opQeKfBUI1LQmypxVkhQp0BIg2tGTV/ll+aVGG3vv9GcGNuRmRwicJvziDt68XBhCOWcjEbRqVF8rjp8bj9uqbv2ZKQhfC7Z6FGp5v4sU1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626388; c=relaxed/simple;
	bh=NYF2Qj1/2lKWbkjQQVJa93fSizAd3tfX17g2na1S1xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWqZcnHjp4BLG4fkuUCtX7ngDZ+5DW+qhUIHMkEtO3ttTrsdEOjmhEJhogsct4YBxZHrogEB19UL0q+SD6UeDsswrSi17z3LsYN5MzN3zd5RqujuRAsjhVAMwZovBMpWD4nhqYAlebFaHADxDIquWbHUw1LVfEULiy1h/7igg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=GBBPp+V9; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9NSlT4aU2S/KJIQ8Mc+v20oRHVTZpY/Uibq8DlSnXnc=; b=GBBPp+V9EGPwq2zPbfHFks/HVw
	mSQmoNuc+E3Ib6XEP6qBz+OqebXNxDrptAS71BO76hUjpGTx6uf27hNugmPUjFCmV2wixABY4fJXO
	uILo35bI8TcPT9/qyteXf8suviwo0WUrHXk7fHQT2sctiDB20n2wc0q1r83zHiM01x2CqUHAja/sx
	qHHFXPtRJhcvMw4gNZAQ3US3SHcxTB6/EBIHUK6KSKbyfPOkvlzymO2wHwXbPUH6sLTHRHfSp4SXN
	iF41p94rTCoxeN8i3VM/dYgSlgdDbQSmzYJL92fA9YdyASpE6PAXLZB5cdDxUt90u0AuIRXxJPezw
	/+9yLe9g==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whuhP-000000002jU-3IJ2;
	Thu, 09 Jul 2026 21:46:19 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH v2 4/5] netfilter: nfnetlink_hook: Handle multipart NAT hook dumps
Date: Thu,  9 Jul 2026 21:46:11 +0200
Message-ID: <20260709194612.1995795-5-phil@nwl.cc>
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
	TAGGED_FROM(0.00)[bounces-13804-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:from_mime,nwl.cc:email,nwl.cc:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAABE7352E0

If the number of hooks exceeds available sk_buff space, the function is
called again for the remaining data. Make use of the second
netlink_callback::args field to store the current index between
invocations. Since this is an inner dump loop, it may run multiple times
(for different hook types) with the same context buffer, so manually
zero the stored value if complete array dump was possible.

Fixes: b010e2a4a9ac ("netfilter: nfnetlink_hook: Dump nat type chains")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nfnetlink_hook.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index 95cc9a0cee20..e3b5d21eeb2e 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -352,22 +352,27 @@ static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
 	struct nf_hook_entries *e = rcu_dereference(priv->entries);
 	struct nfnl_dump_hook_data *ctx = cb->data;
 	struct nf_hook_ops **nat_ops;
-	int i, err;
+	unsigned int i = cb->args[1];
+	int err = 0;
 
 	if (!e)
 		return 0;
 
 	nat_ops = nf_hook_entries_get_hook_ops(e);
 
-	for (i = 0; i < e->num_hook_entries; i++) {
+	for (; i < e->num_hook_entries; i++) {
 		err = nfnl_hook_dump_one(nlskb, ctx,
 					 READ_ONCE(nat_ops[i]),
 					 ops->priority, family,
 					 cb->nlh->nlmsg_seq);
 		if (err)
-			return err;
+			break;
 	}
-	return 0;
+
+	if (!err)
+		i = 0;
+	cb->args[1] = i;
+	return err;
 }
 
 static int nfnl_hook_dump(struct sk_buff *nlskb,
-- 
2.54.0


