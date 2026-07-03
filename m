Return-Path: <netfilter-devel+bounces-13620-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4IzFGtWzR2oEdwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13620-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 15:06:29 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8752702A8E
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 15:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13620-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13620-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF6D630B5A7C
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200313D7A07;
	Fri,  3 Jul 2026 12:57:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D53D79E9;
	Fri,  3 Jul 2026 12:57:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083446; cv=none; b=cx/Izf+B2a6Q/Pqjk1GMxw3Ptyx4ZuqFZwJ34kbKZO244WaQUPvLPiCWWoDDlOvrblOD5vFc2oZYqCCyEuWQsJbHgkJCIwe9GkOpckJ6aNO0fYLeDvxiuLMcmVKzxsyiBrhNoBAfb9HQs1Rx3NcMNJECUwmLBI8+gwxRvPGgFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083446; c=relaxed/simple;
	bh=gZc9YY5Gj2KemtF7T5avDpk6BOoxtbO21s0HbTJyteA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTURSYpkWD1u1jI1m14Nt1M7uRKE6r0o6+6he1vd686BtA5BoCln2V+hBNlo0vQK2wKwcgkidxZ3h1hxKXfeaFwpH77jyoU5qxA2UoRD52THl+eYTBCkQvNuy7NrXyar458kW95vL6tId25cGCpEdreQDpVOYUQyMpqJwrVr3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C7F4A607B2; Fri, 03 Jul 2026 14:57:22 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 2/9] netfilter: xt_u32: reject invalid shift counts
Date: Fri,  3 Jul 2026 14:57:02 +0200
Message-ID: <20260703125709.16493-3-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703125709.16493-1-fw@strlen.de>
References: <20260703125709.16493-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13620-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,icloud.com:email,strlen.de:from_mime,strlen.de:email,strlen.de:mid,lzu.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8752702A8E

From: Wyatt Feng <bronzed_45_vested@icloud.com>

u32_match_it() executes rule-supplied shift operands on a 32-bit
value. A malformed u32 rule can provide a shift count of 32 or more,
triggering an undefined shift out-of-bounds during packet evaluation.

Validate XT_U32_LEFTSH and XT_U32_RIGHTSH operands in
u32_mt_checkentry() and reject malformed rules before they reach the
packet path.

Fixes: 1b50b8a371e9 ("[NETFILTER]: Add u32 match")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_u32.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
index 117d4615d668..ec1a21e3b6e2 100644
--- a/net/netfilter/xt_u32.c
+++ b/net/netfilter/xt_u32.c
@@ -100,7 +100,7 @@ static int u32_mt_checkentry(const struct xt_mtchk_param *par)
 {
 	const struct xt_u32 *data = par->matchinfo;
 	const struct xt_u32_test *ct;
-	unsigned int i;
+	unsigned int i, j;
 
 	if (data->ntests > ARRAY_SIZE(data->tests))
 		return -EINVAL;
@@ -111,6 +111,16 @@ static int u32_mt_checkentry(const struct xt_mtchk_param *par)
 		if (ct->nnums > ARRAY_SIZE(ct->location) ||
 		    ct->nvalues > ARRAY_SIZE(ct->value))
 			return -EINVAL;
+
+		for (j = 1; j < ct->nnums; ++j) {
+			switch (ct->location[j].nextop) {
+			case XT_U32_LEFTSH:
+			case XT_U32_RIGHTSH:
+				if (ct->location[j].number >= 32)
+					return -EINVAL;
+				break;
+			}
+		}
 	}
 
 	return 0;
-- 
2.54.0


