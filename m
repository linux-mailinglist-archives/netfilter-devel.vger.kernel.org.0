Return-Path: <netfilter-devel+bounces-12545-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEOqI6b0AmrpywEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12545-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 11:36:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4051DDA0
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D519530AB317
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627F3A542E;
	Tue, 12 May 2026 09:31:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C63A6411
	for <netfilter-devel@vger.kernel.org>; Tue, 12 May 2026 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578270; cv=none; b=m96a0JxwC4cubUXX2/x65rVGuXsa9JNMRPb4Ry0pIVl8Ltr/qu6FjcyBgeRn2fN5MMMLth6fMJ4DqClkSuCCZUAc9jg64i46WjjVoDX673NV3vyyF9uIIve13ioMNNWdkYtL0Qwuj7TJdU2Ai7mQPUcNebkes1/NqwWsGJB1iWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578270; c=relaxed/simple;
	bh=ZAyIWr6p6Lb02Xg0O/JRK7iNnMHkl31gnQ6U5oig1sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2zjfk7mUa8+Dh3w6d1GBR4cdlTzJTJcvk1wXXoF4tYL9aryri3o8hTF01IHijNfRT7VHXCoL0FbL60TsYF1X8uR2cr56M7ZJgMyRauX17D0/4c3xHbA8xBAg7NGcgsIi17nb9C8AAB+lYNX/8u7BeZsc9EMjD8Z6h/zLgOK8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A907060D57; Tue, 12 May 2026 11:31:00 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nft_inner: release local_lock before re-enabling softirqs
Date: Tue, 12 May 2026 11:30:49 +0200
Message-ID: <20260512093052.24326-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2DE4051DDA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12545-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.868];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Action: no action

Quoting sashiko:
 In the error path, local_bh_enable() is called before
 local_unlock_nested_bh().

Fixes: ba36fada9ab4 ("netfilter: nft_inner: Use nested-BH locking for nft_pcpu_tun_ctx")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_inner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 03ffb1159fc1..85164369b924 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -247,8 +247,8 @@ static bool nft_inner_restore_tun_ctx(const struct nft_pktinfo *pkt,
 	local_lock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
 	this_cpu_tun_ctx = this_cpu_ptr(&nft_pcpu_tun_ctx.ctx);
 	if (this_cpu_tun_ctx->cookie != (unsigned long)pkt->skb) {
-		local_bh_enable();
 		local_unlock_nested_bh(&nft_pcpu_tun_ctx.bh_lock);
+		local_bh_enable();
 		return false;
 	}
 	*tun_ctx = *this_cpu_tun_ctx;
-- 
2.53.0


