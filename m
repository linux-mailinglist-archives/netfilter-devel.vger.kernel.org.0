Return-Path: <netfilter-devel+bounces-12102-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGT4MACj5mmfzAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12102-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 00:04:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C584A4347AC
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 00:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A69CE3012A88
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F1A3D1CA8;
	Mon, 20 Apr 2026 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="OhmsNA/0"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880B3D1706;
	Mon, 20 Apr 2026 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722552; cv=none; b=UuXtrmvGDb9VWjIsFqsEWAnFS83ACfhNBwyMIwfb/A3Sv/zZ9iOFfHJVwQqabdKLefOGutNkcgOzYdGazgfDT7WiUw1HhATbHjRqZxhY9gtl9sXQ/MhhlYjps/G/Get1ebtbrwREB0G9/Can5WdNd8t80IfgwTZSwtvcBA5MSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722552; c=relaxed/simple;
	bh=kUfeTFZk5IgFgJ7dBcDAuHKs7DNUx3pWt+DeQ56Keao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5wbYA7qrM2+uQufFuPSSNUK9FVLfGK0/gbpDB5DYoREiZi4wPnttn+WpdLizR9hnUmUX04nz5rYC09JnhB8QUJEajdihiehQ86/UvDh7LsU1dFhe470MZKjVie8ztCjE2j79u7l+p+H2RkfnrTE2EPveydU1irL6bKzr/T7fek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=OhmsNA/0; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 5BBF660255;
	Tue, 21 Apr 2026 00:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776722549;
	bh=y4oVjl5IwBD7c8hLHPmuW/Dp/NU6BKcOEDJo3EB03Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhmsNA/0kIWioJeEG9T+2U5S55+5hkBhPCeWIyPOubKajBcUGjjbc6WZpSKzqZQyF
	 4mKJn/wqDJeohJfS1qi0/gUBt1o2JrbTyx+EEjjauwqqR+xREtBFMfqCghkD4iGBev
	 YKT8aawQGl3sgvAMhaBIsFtdeISvhiKzrtiZDAhxclKtWv9F4TMH44GGl0lRSLlBXJ
	 WJqdL9UyEaBCLHXKPib7pexwLhXG9uY54bQeFGbA01pVId7fEtSLwwEp+6nWHUl8Vy
	 9Os8XcOOnGLGIDG2CCkmmLlSTrjvOc5x3l9vCnUsKSx4IT5NDapfHE8YpiKMwGSEze
	 al6U+caxK3c/g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 8/8] netfilter: nfnetlink_osf: fix potential NULL dereference in ttl check
Date: Tue, 21 Apr 2026 00:02:15 +0200
Message-ID: <20260420220215.111510-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420220215.111510-1-pablo@netfilter.org>
References: <20260420220215.111510-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12102-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: C584A4347AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fernando Fernandez Mancera <fmancera@suse.de>

The nf_osf_ttl() function accessed skb->dev to perform a local interface
address lookup without verifying that the device pointer was valid.

Additionally, the implementation utilized an in_dev_for_each_ifa_rcu
loop to match the packet source address against local interface
addresses. It assumed that packets from the same subnet should not see a
decrement on the initial TTL. A packet might appear it is from the same
subnet but it actually isn't especially in modern environments with
containers and virtual switching.

Remove the device dereference and interface loop. Replace the logic with
a switch statement that evaluates the TTL according to the ttl_check.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Reported-by: Kito Xu (veritas501) <hxzene@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/20260414074556.2512750-1-hxzene@gmail.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_osf.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 9b209241029b..acb753ec5697 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -31,26 +31,18 @@ EXPORT_SYMBOL_GPL(nf_osf_fingers);
 static inline int nf_osf_ttl(const struct sk_buff *skb,
 			     int ttl_check, unsigned char f_ttl)
 {
-	struct in_device *in_dev = __in_dev_get_rcu(skb->dev);
 	const struct iphdr *ip = ip_hdr(skb);
-	const struct in_ifaddr *ifa;
-	int ret = 0;
 
-	if (ttl_check == NF_OSF_TTL_TRUE)
+	switch (ttl_check) {
+	case NF_OSF_TTL_TRUE:
 		return ip->ttl == f_ttl;
-	if (ttl_check == NF_OSF_TTL_NOCHECK)
-		return 1;
-	else if (ip->ttl <= f_ttl)
+		break;
+	case NF_OSF_TTL_NOCHECK:
 		return 1;
-
-	in_dev_for_each_ifa_rcu(ifa, in_dev) {
-		if (inet_ifa_match(ip->saddr, ifa)) {
-			ret = (ip->ttl == f_ttl);
-			break;
-		}
+	case NF_OSF_TTL_LESS:
+	default:
+		return ip->ttl <= f_ttl;
 	}
-
-	return ret;
 }
 
 struct nf_osf_hdr_ctx {
-- 
2.47.3


