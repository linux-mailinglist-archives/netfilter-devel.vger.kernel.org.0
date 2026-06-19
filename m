Return-Path: <netfilter-devel+bounces-13349-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id feeELqQuNWproAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13349-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 13:57:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2476A58BB
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 13:57:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=vl1osgok;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13349-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13349-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 090EE3042C73
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822D9384CE1;
	Fri, 19 Jun 2026 11:55:13 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6538332A;
	Fri, 19 Jun 2026 11:55:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870113; cv=none; b=s/eptV3/NOECb0V1fMC5dI6end+mqyvJRQFUdxK3IF7mFCSKlKqUB7hl6/yX3tKv0VBkZ4xy1osjTcQvQq9b7Y6cmuwd3GsdfZ2JGU46MyqX4fOB1wT9RQlDTNJhc8ow7fWJXXJu72I/+Y/Ltz73fYT+Dj7ReTshMFZRTEqkRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870113; c=relaxed/simple;
	bh=Iujzt5heb9H8WLppDhY1E1rPktZleQ5dnFQhD90BUFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hyn6lxZ82Cy/tOSOZZs8Le2UslDqqfxJJ62/yIdpOCwF0YK5BYLyouTTXDDBi5szWrndtbKaSYj4jP77/85BlqJ0dC2LH3cHHs6YYZXRpSD6XQhY9g4fZ7s7oBcUMDPrNlGVQmOydfjF6zB3or0vMmtseRBtaal1+/ziVbeiS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=vl1osgok; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 783F4601C1;
	Fri, 19 Jun 2026 13:55:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781870109;
	bh=fUUW68ZRi9UR+MamkxJBulOTEpebj5NGu71sMmoSmRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vl1osgokoqJnKmY05p2BEyQsltnnccySTHU/geK+Qhlt2YPm7Iw/W1Cfh/BAipt4v
	 1QpYJoUa7ClsKsJ7vqXZQi8pIzK4cO+OvCvjEqRewTzhpvwXJgj7Yb/I/np9+ZJBq0
	 So1gCcJ5mGxA5XhMCIz2x8C4VCP/5XLqxaFKG0S9oYvsmXgz/68APDFfzAFzqLBCpB
	 /mCoBYCkANSG0jPaqD45pZqgGMO4jB6EIVrl3YND9D1d5ZrErfqWTtw/hDK7l87u1M
	 Z16yrs9wQqNQ9aVpklM8yGn7ZSwYj0dITOYAhd+zHl8KWNtEEV4UXJ36A2asLcUzL2
	 Oz5PuZaKXxtcQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 09/16] netfilter: ipset: make sure gc is properly stopped
Date: Fri, 19 Jun 2026 13:54:44 +0200
Message-ID: <20260619115452.93949-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619115452.93949-1-pablo@netfilter.org>
References: <20260619115452.93949-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13349-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B2476A58BB

From: Jozsef Kadlecsik <kadlec@netfilter.org>

Sashiko noticed that when destroying a set,
cancel_delayed_work_sync() was called while gc
calls queue_delayed_work() unconditionally which
can lead not to properly shutting down the gc.

Fixes: f66ee0410b1c ("netfilter: ipset: Fix "INFO: rcu detected stall in hash_xxx" reports")
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 00c27b95207f..dedf59b661dd 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -606,7 +606,7 @@ mtype_cancel_gc(struct ip_set *set)
 	struct htype *h = set->data;
 
 	if (SET_WITH_TIMEOUT(set))
-		cancel_delayed_work_sync(&h->gc.dwork);
+		disable_delayed_work_sync(&h->gc.dwork);
 }
 
 static int
-- 
2.47.3


