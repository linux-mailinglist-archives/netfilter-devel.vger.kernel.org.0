Return-Path: <netfilter-devel+bounces-12637-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKQsFMlbCGrAkwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12637-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 May 2026 13:58:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9266F55B99F
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 May 2026 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EC7B3008D3F
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 May 2026 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC493E0097;
	Sat, 16 May 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="cRPRDPex"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A693DEADC;
	Sat, 16 May 2026 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932605; cv=none; b=VgLrDuPVzuLyOv72h0nX5A2QfEXhZYDYOYTGc+LhKLO03bPBQKYznYvs03ImhtyTQl7UtkY8v0JnVAyoYk0YG0U5MY/dYjmZQtSmE1LYn00aWhqob2bsYnTZ1pudoCpQEogO+wnvH3W1+MUa4zOFvD87Md6HlzsZOMNMm9LN/rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932605; c=relaxed/simple;
	bh=W0rW3ngmPiDSQ5KcHgnuJc8HkrZXnu4i7fmvwV70UqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgCSksw0gFglU8dc519QcLSoG6OutCjaKVqelAn9gsAbI7s3PxVCO9+XovjYfKTscvD0jxRjC2SXeZxk7jFckQtK2zxW2ChWgwWxAaC5FrdenGpCwzOKJgUnpofCp3oZva0MgJ3dxlfYP5E0BhPETFuzsIvf4DqjJOoSay+/evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=cRPRDPex; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 61A2F601AD;
	Sat, 16 May 2026 13:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778932601;
	bh=ZpmprRPZNvg/oOpTAMEKYZpMhSJbD2/SkUoV8T1PCSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRPRDPexye1qhCg9m/YH7AGWq8mrocveu0JgrOS8hGKtHmapsVP6AkAPrtz6K0zkU
	 amySiN62eyzm3wcGG82+d/ryVbND5ULkb5SYm91ATvSTUNOzsvhHTXsEqSv3y0ULu+
	 0nVa0mKVO5A231xvYEePp3MrNgmW1csCfO25wP8ZFTO5vaHjQLe/w0ARDc2DLbDzJO
	 1tlx1Iit2sfU+2s6A35+3Zp07fDBrin5d4T+UqxLVX6QNbmZclcqilDGOSYbIxrKUh
	 QdwoBI2iulwK3gMj2yOdEbbYIZWPlYabrWbIgXUbhGDvzfat2jeRELcvKHA+a/yvRI
	 hqEC7ctRzgRdA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 08/12] netfilter: ipset: Fix data race between add and list header in all hash types
Date: Sat, 16 May 2026 13:56:23 +0200
Message-ID: <20260516115627.967773-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516115627.967773-1-pablo@netfilter.org>
References: <20260516115627.967773-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9266F55B99F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12637-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Action: no action

From: Jozsef Kadlecsik <kadlec@netfilter.org>

The "ipset list -terse" command is actually a dump operation which
may run parallel with "ipset add" commands, which can trigger an
internal resizing of the hash type of sets just being dumped. However,
dumping just the header part of the set was not protected against
underlying resizing. Fix it by protecting the header dumping part
as well.

Fixes: c4c997839cf9 ("netfilter: ipset: Fix parallel resizing and listing of the same set")
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipset/ip_set_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0874029cb0f2..3706b4a85a0f 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1649,13 +1649,13 @@ ip_set_dump_do(struct sk_buff *skb, struct netlink_callback *cb)
 			if (cb->args[IPSET_CB_PROTO] > IPSET_PROTOCOL_MIN &&
 			    nla_put_net16(skb, IPSET_ATTR_INDEX, htons(index)))
 				goto nla_put_failure;
+			if (set->variant->uref)
+				set->variant->uref(set, cb, true);
 			ret = set->variant->head(set, skb);
 			if (ret < 0)
 				goto release_refcount;
 			if (dump_flags & IPSET_FLAG_LIST_HEADER)
 				goto next_set;
-			if (set->variant->uref)
-				set->variant->uref(set, cb, true);
 			fallthrough;
 		default:
 			ret = set->variant->list(set, skb, cb);
-- 
2.47.3


