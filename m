Return-Path: <netfilter-devel+bounces-10527-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEPOBvw6fGkELgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10527-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 06:00:44 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EAEB72D5
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 06:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3929A3013033
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 05:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2827281D;
	Fri, 30 Jan 2026 05:00:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881C41C72;
	Fri, 30 Jan 2026 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749238; cv=none; b=oXwyB3uCgj7Gssq5O9VUxXlA3TmyXJ3jWjNMmJ1C8Mg4DoZkGt/gjp4pYcJd+y4OHZ/mfJZ7n8dA/LyLYTArQmB4Q5GEb6FVqODFPSEjSmWkOcWauwnRYQZyr0ffxyQe8/lEnmz7i2jNpCtfnvE4d/fx9XmAwGv7vmAdPcNa5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749238; c=relaxed/simple;
	bh=1Af3mEyk0q9nGH+AVFvTFCaP8SIK82SCL3yTzBbG660=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afpo/Xq+1gHBJIN76Bxx/me/RG5stQl6bCBsI3l6ok5jRNf/GiZU17kWCSNcdFG+iQTcc0WjxQqvq/NFqSEt40kPagkS/ZyoovEmwfkUOMDhlZOwLX1AiNgnDhEeBlHL2OiJt5IlQRYH/fc2LRSrd25lbD6mUVC/VwouTaseZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
	<phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<netdev@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] netfilter: conntrack: remove __read_mostly from nf_conntrack_generation
Date: Thu, 29 Jan 2026 23:43:48 -0500
Message-ID: <20260130044348.3095-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10527-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96EAEB72D5
X-Rspamd-Action: no action

From: Li RongQing <lirongqing@baidu.com>

The nf_conntrack_generation sequence counter is updated whenever
conntrack table generations are bumped (e.g., during netns exit or
heavy garbage collection). Under certain workloads, these updates
can be frequent enough that the variable no longer fits the
"read-mostly" criteria.

Applying __read_mostly to a variable that is updated regularly can
lead to cache line bouncing and performance degradation for other
variables residing in the same section. Remove the annotation to
let the variable reside in the standard data section.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/netfilter/nf_conntrack_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d1f8eb7..233a281 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL_GPL(nf_conntrack_htable_size);
 
 unsigned int nf_conntrack_max __read_mostly;
 EXPORT_SYMBOL_GPL(nf_conntrack_max);
-seqcount_spinlock_t nf_conntrack_generation __read_mostly;
+seqcount_spinlock_t nf_conntrack_generation;
 static siphash_aligned_key_t nf_conntrack_hash_rnd;
 
 static u32 hash_conntrack_raw(const struct nf_conntrack_tuple *tuple,
-- 
2.9.4


