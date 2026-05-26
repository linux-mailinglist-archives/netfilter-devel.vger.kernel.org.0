Return-Path: <netfilter-devel+bounces-12839-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hdlSDUD/FGqpSAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12839-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 04:02:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DF5CFA7E
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 04:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A8733008C21
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 02:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A792DB781;
	Tue, 26 May 2026 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VPzHZvwO"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB72EA73D
	for <netfilter-devel@vger.kernel.org>; Tue, 26 May 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760956; cv=none; b=BgdT8tRKqjpD2sAfZqyjL9qp/7eMu7As8QLQe5tHfNx50ST9oi3Hl9KHQ0KZU5jl8SoSHSwF/b9tkrQNwS464vv3EzLgItHbAhh+8Z6/3OpGyA7DNac/SpBn/RCxMRGBJzBvwto4/3rfd8wCoxaanH9Z/4T/gw4JymVq1XFeQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760956; c=relaxed/simple;
	bh=9SSGgAKoAw3Ql2lZ4mxtyVQTNzFNPVrK8C19984UgHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpO/vheJjJRhtScoppn3MqKbSHYeINpVev0csHhHA0hRSJC5Ik6k2wE1dfvpKIBzmmOFW6apGh6O92v4sWFEXM5idIgDsehaXy4OHaDwTKF71jTLgftnnOJogW5FfJwb0yQz2eI+BfmEnm+26WZgHyG5UqRtCg3r6TMqkOxWRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VPzHZvwO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779760952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nlkUVQnxlsBn5Da8pELezcA3yclHp0l8rDUMAFVEJUs=;
	b=VPzHZvwOFhr5EEhsSsOoP/9BnzMJR5n7vtkezfADa/5lkV7PJio5ccVzfEseBGZNth3tLO
	A1rdgryVPRo8mF5Tf9VtgxW/EwT3/5rOzCMjWWosXHIDyaxiSEPGPsWsqfpSMvrGmarYRM
	r1bOHz8Zxz45lyDMZe6pVv3rkGA/13k=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netfilter-devel@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nft_fib_ipv6: bail out of sibling walk if rt got unlinked
Date: Tue, 26 May 2026 10:02:27 +0800
Message-ID: <20260526020227.4857-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12839-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 017DF5CFA7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This was reported by Sashiko [1].

The RCU walk over rt->fib6_siblings can spin forever if rt is unlinked
mid-iteration: rt->fib6_siblings.next still points into the old ring,
so the loop never meets &rt->fib6_siblings as its terminator.

fib6_purge_rt() always does WRITE_ONCE(rt->fib6_nsiblings, 0) before
list_del_rcu(), so readers can use rt->fib6_nsiblings == 0 as the
detach signal. The same pattern is used in fib6_info_uses_dev() and
rt6_nlmsg_size().

[1]: https://sashiko.dev/#/patchset/20260520023411.391233-1-jiayuan.chen%40linux.dev
Suggested-by: Florian Westphal <fw@strlen.de>
Fixes: 1c32b24c234b ("netfilter: nft_fib_ipv6: switch to fib6_lookup")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/netfilter/nft_fib_ipv6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index c0a0075e2590..2dbe44715df3 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -191,6 +191,9 @@ static bool nft_fib6_info_nh_uses_dev(struct fib6_info *rt,
 
 		if (nft_fib6_info_nh_dev_match(nh_dev, dev))
 			return true;
+
+		if (!READ_ONCE(rt->fib6_nsiblings))
+			return false;
 	}
 
 	return false;
-- 
2.43.0


