Return-Path: <netfilter-devel+bounces-12725-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC4GG7YdDWrZtQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12725-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 04:34:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D200A586E04
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 04:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAF443028C88
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2026 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3A1C84A0;
	Wed, 20 May 2026 02:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sK4RNryr"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C32F3C3D
	for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2026 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244468; cv=none; b=POyrqJorPpdUqP4hNrEuvBw9BH70skEgPn9lX9Dg8UnfwUvQvkrrZemytTe/13LVvUUhK4FwK+285s3bWy4TbpwKLAz37RuYxV/xWbvh4MoMAxGP5abfXNiUH2r90GdyCOpr4VgCbclwqKWR4Nxe4F6r1krIWR0Z/CKDusjl1y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244468; c=relaxed/simple;
	bh=gDco/RmEGNnyb39Sm29Xio0IhOzYDc713d1m8dRy8pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UghVKMRkp8hF2Zcyv1Az6R8AXYhqqWACJjlZTza5uBo3O06K7EaXeNnUhYRZFFl/xxBEuvoFmQwg6J/aljrio3qqnsasAfl1fPcJ6ABxBbzcUWZy6ia6AFen9AbR2OPaMItnfveyaZMv/EXhaXvwsVl10mq2DevHUdCR/iqqcow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sK4RNryr; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779244465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAeSJpjLmQYYoUlL+o/0CbpAdNLSU9RphTzKQ0H/8KQ=;
	b=sK4RNryrx6udco3MRC7ntBfxeOoupSNiyckoU9OcMKuHeCsjr4MpIN6uyF0ODuALWORrr4
	EtJoBcSkslBK9pz6+nghUxXeAqLLEOly83Gmk+YSdGqIF9zGKUMvqYbrij6zEOVVTi7P2e
	rIvQ61z9Auu9H+2+7IlH6q/TSir/Ig0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org
Subject: [PATCH nf v2 1/3] netfilter: nft_fib_ipv6: walk fib6_siblings under RCU
Date: Wed, 20 May 2026 10:34:09 +0800
Message-ID: <20260520023411.391233-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260520023411.391233-1-jiayuan.chen@linux.dev>
References: <20260520023411.391233-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12725-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: D200A586E04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nft_fib6_info_nh_uses_dev() runs from nft_fib6_eval() in softirq under
rcu_read_lock().  fib6_siblings is modified by writers that hold
tb6_lock but do not wait for RCU readers, so the sibling walk should
use list_for_each_entry_rcu(): it adds READ_ONCE() on the ->next
pointer and lets CONFIG_PROVE_RCU_LIST validate the locking.

No functional change for non-debug builds.

Fixes: 1c32b24c234b ("netfilter: nft_fib_ipv6: switch to fib6_lookup")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/netfilter/nft_fib_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 8b2dba88ee96..5e192a446ec8 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -170,7 +170,7 @@ static bool nft_fib6_info_nh_uses_dev(struct fib6_info *rt,
 	if (nft_fib6_info_nh_dev_match(nh_dev, dev))
 		return true;
 
-	list_for_each_entry(iter, &rt->fib6_siblings, fib6_siblings) {
+	list_for_each_entry_rcu(iter, &rt->fib6_siblings, fib6_siblings) {
 		nh_dev = fib6_info_nh_dev(iter);
 
 		if (nft_fib6_info_nh_dev_match(nh_dev, dev))
-- 
2.43.0


