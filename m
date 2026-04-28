Return-Path: <netfilter-devel+bounces-12248-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCqfLgaO8Gl4UwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12248-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 12:37:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283F482C0B
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 12:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14DE130C00CC
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB823E0C75;
	Tue, 28 Apr 2026 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="rrvyHmeM"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600293DA5BD;
	Tue, 28 Apr 2026 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371662; cv=none; b=q6aXABmFZ6W18xSTnRSS0UetcoUkhuV8aPJTPAnYxB7ajhJiz8bOdSP8IoX4AM7aZ6JdIj0pktHKgNQMwA4jz21eQfoi2cib0ls5FwAncvHfEv+ENqz3dUMn7HrPnKzOri3Cpl+Kk8o5+k6YXejRx4r96IUoh0T1y8LxfIcr4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371662; c=relaxed/simple;
	bh=EJdmfCjiMU1AlDmWQswL59SE9LDp3E5uZUB+a60eTP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAYm3pYeSUOXOKl5vVyIpvYDpQRNHR/9GOK8oisc+NATHGL73cO5dnTyr5gR6db2mYrUCbiLCZZvIj2T/HAuGvZ6mOD4+1ii8yXoLTz4i6ENxvADz0/VFQdzuI1dRjQ27mh3e0Yxjrt4QxCZ5UZMUtleciUmpsxa9y4cCKD7uYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=rrvyHmeM; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E41FC60180;
	Tue, 28 Apr 2026 12:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777371659;
	bh=Dd1whcvuSm/GI09QOtK5dQFfyV7EZd2UMIuTg6xDe0E=;
	h=From:To:Cc:Subject:Date:From;
	b=rrvyHmeM8d2oXeu+1g5QYb6mPAaglguf81Tiktkwbgx+yQkJvhna2HyfTFPgDFfeV
	 AFm+f/NBbnQ0RZpAk/09Jx2B71U6o+zsWj6iHwzxi5XM9UGUqf9g0PwZZJpKexh12K
	 EWj18DS2wlX95ZHRsUh4DiLdBaN7pSPIlrH8HFEfDmhIJnmo6SBfEM4Iij52rs77qR
	 RG7sMU0lDUlt3e9BaJ3t0oryqtMvHcVFu2l0r1zztLvAt6WDvdm3PVs6xIc8/c2POI
	 at2YnyFP9M/bfIby5aFIpEs/zHM2GL2EeZ3Lp3EdT0pIoDeNamaTVgng1zBDXzqF8h
	 vxiIG2VDUOK7Q==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net] neighbour: neigh_xmit needs to release skb on -EAFNOSUPPORT
Date: Tue, 28 Apr 2026 12:20:52 +0200
Message-ID: <20260428102052.53637-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1283F482C0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12248-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim,netfilter.org:mid]

Sashiko reports:

"... if the target neighbor table is NULL (for example, for
NEIGH_ND_TABLE when IPv6 is disabled), the code takes the out_unlock
path and bypasses the out_kfree_skb cleanup"

Fix this skb memleak by releasing the skb in case of -EAFNOSUPPORT.

Fixes: f8f2eb9de69a ("neighbour: add RCU protection to neigh_tables[]")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/core/neighbour.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9e12524b67fa..2191668b79e3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3210,8 +3210,10 @@ int neigh_xmit(int index, struct net_device *dev,
 
 		rcu_read_lock();
 		tbl = rcu_dereference(neigh_tables[index]);
-		if (!tbl)
-			goto out_unlock;
+		if (!tbl) {
+			rcu_read_unlock();
+			goto out_kfree_skb;
+		}
 		if (index == NEIGH_ARP_TABLE) {
 			u32 key = *((u32 *)addr);
 
@@ -3227,7 +3229,6 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		}
 		err = READ_ONCE(neigh->output)(neigh, skb);
-out_unlock:
 		rcu_read_unlock();
 	}
 	else if (index == NEIGH_LINK_TABLE) {
-- 
2.47.3


