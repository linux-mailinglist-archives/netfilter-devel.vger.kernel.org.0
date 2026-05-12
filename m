Return-Path: <netfilter-devel+bounces-12568-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJnZAjC7A2o69gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12568-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 01:43:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0765152B5E3
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 May 2026 01:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AABFF3002917
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832F385D9D;
	Tue, 12 May 2026 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Bqfi4nV2"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBA3815D9
	for <netfilter-devel@vger.kernel.org>; Tue, 12 May 2026 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629417; cv=none; b=lddwEdPn/FA3RddxsnhW7oxUMb8l/2u9uqDrCGvSHgKjK/vRG5WDTdG6f9GMRjOs3Nx8m/LwLZWHIuY+ZnECRnJyjhpZdeQwIpSXAh8hYEhu8ZlOuj5Nr35sDRJ3NU0wzsSvFmZwRsYz41OmMlWN9vrEzxclhYrUJYVaSfh5wxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629417; c=relaxed/simple;
	bh=Ru2wAsQsQfI0cwcVTpiXUaYel/AKpcOcqJIoDYTZE+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdZX0AmdABkEPD++w9vh5P9DeP1oiTyuU3lG016mtvu2YX+HLd59XBHAZlf2VMp0ztq/wXytfIfg8QcraXZ1sCuk5JIr4xjGgPmpAggU8nugWkVPA3pJc0Xe+kLhyvV206+ndt1uMSFrk8x0IFEAzF6cIZXJ7qtXcQrmJMjr1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Bqfi4nV2; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 7BDBA60180;
	Wed, 13 May 2026 01:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778629413;
	bh=MlRTGSaUXsEozshlql4HRv+af5rmczwwXbeQ3/5uKU8=;
	h=From:To:Cc:Subject:Date:From;
	b=Bqfi4nV2WLteXhw3mcdCHHroyW0oImhkeBSxAPtcfQ4f6kyVrN/DoOtVUW0mRl9Ni
	 NDPe4C56utU/TyHZNvGmVUHnvNOLryUIp9q4KYlkaFPoGyhGDWqfkOcuatZEAmZdHW
	 UhxPrQsmL5b6TilUxegrmLYEmcxJgENNrhXfA593o9D5uwO/eJQafHdQcwZBsUntN4
	 9QHx6BAqRlu1CIRAL4eIS+nCKnTTaGEJvtl0rlhnB+fPEd/RPPsvpcjKMdf8eiDktT
	 U8TJ9YRfUJupbzAuKWb+6hTxJFchwLeksE7jPioD8kfSzoyRf4oObmMfq0XD14P532
	 5+xjWHnLZrZzw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf,v2] netfilter: nf_queue: hold reference on skb->dev
Date: Wed, 13 May 2026 01:43:30 +0200
Message-ID: <20260512234330.817709-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0765152B5E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12568-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Action: no action

Before NF_BR_LOCAL_IN, skb->dev is mangled in a way that results in
state->in != skb->dev, which can result in UaF when accessing the bridge
device if removed while in the queue.

Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: remove check on NULL skb->dev, per Florian.

 net/netfilter/nf_queue.c        | 2 ++
 net/netfilter/nfnetlink_queue.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index a6c81c04b3a5..a0ff8717746d 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -61,6 +61,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 	struct nf_hook_state *state = &entry->state;
 
 	/* Release those devices we held, or Alexey will kill me. */
+	dev_put(entry->skb->dev);
 	dev_put(state->in);
 	dev_put(state->out);
 	if (state->sk)
@@ -102,6 +103,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 	if (state->sk && !refcount_inc_not_zero(&state->sk->sk_refcnt))
 		return false;
 
+	dev_hold(entry->skb->dev);
 	dev_hold(state->in);
 	dev_hold(state->out);
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 58304fd1f70f..7408b348da13 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1212,6 +1212,9 @@ dev_cmp(struct nf_queue_entry *entry, unsigned long ifindex)
 	if (physinif == ifindex || physoutif == ifindex)
 		return 1;
 #endif
+	if (entry->skb->dev)
+		if (entry->skb->dev->ifindex == ifindex)
+			return 1;
 	if (entry->state.in)
 		if (entry->state.in->ifindex == ifindex)
 			return 1;
-- 
2.47.3


