Return-Path: <netfilter-devel+bounces-12497-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC22Df0k/WkuYQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12497-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 01:49:17 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D871E4F0496
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 01:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17AC83085641
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 May 2026 23:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353935BDB2;
	Thu,  7 May 2026 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="T8UXXp7d"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FE35E95A;
	Thu,  7 May 2026 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197535; cv=none; b=U9j05wlrnSacO9Mp4vnLH0tTrozik/Gg763R6nV0PCpE7Dv4FByfnuUP7yrLr0jy/NYrROQ0jHLxfy/J8A6Os6wvXg/NGCtJQIxKj2TiyHB3qatQOzlgnreZ3bihpn7vmsO56MRroo6CfznSAF8/2kelU+J8pb6xWCPzO3RSt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197535; c=relaxed/simple;
	bh=BM3Yo7tNhlnrk7YdC3uZPShSYOMpWXOt5brLiwLQp3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHXdapyUgSvWqmSm6tCqkU8gDmaX/lRz7vbyc4S9mwlGISHpM98RWNEu0OgH0uMd28l88kmfWKVW2JwSwfsOkz38amCP7iAbxTzYvdMrfWnCEqGgNXiHR6bCVwlSwfv+rQ6eILt11/xUPHnE0xBgpCZ/cRTGM8wigxOCuj6SYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=T8UXXp7d; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id D07CF60253;
	Fri,  8 May 2026 01:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778197530;
	bh=ASgQ9PIkg52YMpQTI23/bvR8ND7n0S8U3N370V1fvAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8UXXp7dYenaYgZHBTA8yVTlLmcY8IpqKIXbLy1KJOJSxu4/9e4LdMEm27lMkXjxK
	 gZPS/D2TJhBVqFPJUMTLrjRi7lwx5zhJTqEV9D2hdwO/uvbxHbtehXlD1R2tSakcPI
	 4ZfA5ZiATsN0/JLE3fNfC9i3i68l9iWKWLNvpJDOjPi0EFhRgffAXzHUus0+LEwkEg
	 1wcHFOsBIDgn65quM6dhitP2VPR4wqlaHYU4+RGXlqIdSbL+Og11UM23lGRYFcsAbe
	 klZkeW2wB+4BXEjHNxmYV+RW8WhfLqQT8WEYeW48dWSt5Y0dLbt+h10rPitVTalMPZ
	 lyVbAL9xOGcsQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 11/13] netfilter: ctnetlink: check tuple and mask in expectations created via nfqueue
Date: Fri,  8 May 2026 01:45:07 +0200
Message-ID: <20260507234509.603182-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507234509.603182-1-pablo@netfilter.org>
References: <20260507234509.603182-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D871E4F0496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12497-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:mid,netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Ensure the expectation tuple and mask attributes are present in netlink
message, otherwise null-ptr-deref is possible.

Fixes: bd0779370588 ("netfilter: nfnetlink_queue: allow to attach expectations to conntracks")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d7209d124111..befa7e83ee49 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2872,6 +2872,9 @@ ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
 	if (err < 0)
 		return err;
 
+	if (!cda[CTA_EXPECT_TUPLE] || !cda[CTA_EXPECT_MASK])
+		return -EINVAL;
+
 	err = ctnetlink_glue_exp_parse((const struct nlattr * const *)cda,
 				       ct, &tuple, &mask);
 	if (err < 0)
-- 
2.47.3


