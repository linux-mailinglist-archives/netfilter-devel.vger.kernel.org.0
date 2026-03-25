Return-Path: <netfilter-devel+bounces-11424-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JFUKABixGkuywQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11424-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 23:30:24 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119732D026
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 23:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A20630B7A2A
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6A38839B;
	Wed, 25 Mar 2026 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Is8pgJJv"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA851381B1D;
	Wed, 25 Mar 2026 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477597; cv=none; b=PUgJb+5LMV4V6Q/n8T0Ok/THDd27VjEMfNhHkvYnoegyfDsJtOOA8IPE/KSYALu0k3lD8z74scvvpckcYvwidKiay7EM6xpjvNqIMnHFBpgfxKYJ+O4yfDWOGkB75581EXTNAP2enjCShpgb4803rjVJv6BLiVpnv2Jr3IWVm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477597; c=relaxed/simple;
	bh=K7RSrdEFZy6Z+RlJPtEraPlErH2kH671nvcT1Ug4334=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtOV3iW9f9OEk9qwByR/EU3b5i088bCtAESxDdojN4t1ulTjcoi+VFxFzLUqjwcYpEl7km6yzDeBCsJ5L3Q+IVcVgaABCUB0j8Y5bEySTMLfhV4pBP9kEBXV/S5V4IdoIEG0VAVGoSNmCeJBHKEBW4a+P11myozr7pl0JlOFsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Is8pgJJv; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C893B60180;
	Wed, 25 Mar 2026 23:26:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774477589;
	bh=PIh+oFx3ncJBBFZxKgZDh/cS8gnROLybKH/NG8EuEkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Is8pgJJvbBEHBFukM7CRaU4lKTha55XlKQnijXNkRApB/2eCo5Tg8ittoZtX8r4l3
	 hjW9iNWZOv2WXsmbNeskBgL8Sfkd9z422DpHON5SKp59RLVLYBfKgJ5aBAzsryq/ZT
	 89pw5Um4jsEeT8W17S4ZqRTB4ycrjm8baZBtJYu9D5IWREiaCgVvWqkkA84L0o4Dpe
	 575V+5daaRrHr/hcrj5C/SyKZCNAHNFFPajbOL2dkrXkD/GZo7vz9RF+T54DDwMm0t
	 omecxgkbAUwHG4D6Fo2M/xlrFcQSKtgHgSs9CF3PqnlluSjwKVgh6REww4VeM/wTKk
	 JJ1fXv1Z9EsXg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 04/14] netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
Date: Wed, 25 Mar 2026 23:26:05 +0100
Message-ID: <20260325222615.637793-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325222615.637793-1-pablo@netfilter.org>
References: <20260325222615.637793-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-11424-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid]
X-Rspamd-Queue-Id: 5119732D026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Weiming Shi <bestswngs@gmail.com>

__build_packet_message() manually constructs the NFULA_PAYLOAD netlink
attribute using skb_put() and skb_copy_bits(), bypassing the standard
nla_reserve()/nla_put() helpers. While nla_total_size(data_len) bytes
are allocated (including NLA alignment padding), only data_len bytes
of actual packet data are copied. The trailing nla_padlen(data_len)
bytes (1-3 when data_len is not 4-byte aligned) are never initialized,
leaking stale heap contents to userspace via the NFLOG netlink socket.

Replace the manual attribute construction with nla_reserve(), which
handles the tailroom check, header setup, and padding zeroing via
__nla_reserve(). The subsequent skb_copy_bits() fills in the payload
data on top of the properly initialized attribute.

Fixes: df6fb868d611 ("[NETFILTER]: nfnetlink: convert to generic netlink attribute functions")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_log.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index b35a90955e2e..fcbe54940b2e 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -647,15 +647,11 @@ __build_packet_message(struct nfnl_log_net *log,
 
 	if (data_len) {
 		struct nlattr *nla;
-		int size = nla_attr_size(data_len);
 
-		if (skb_tailroom(inst->skb) < nla_total_size(data_len))
+		nla = nla_reserve(inst->skb, NFULA_PAYLOAD, data_len);
+		if (!nla)
 			goto nla_put_failure;
 
-		nla = skb_put(inst->skb, nla_total_size(data_len));
-		nla->nla_type = NFULA_PAYLOAD;
-		nla->nla_len = size;
-
 		if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
 			BUG();
 	}
-- 
2.47.3


