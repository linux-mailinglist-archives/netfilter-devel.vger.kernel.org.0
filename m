Return-Path: <netfilter-devel+bounces-13838-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bvlcFiwEUWr29wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13838-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 16:39:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 164FD73BD1C
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 16:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13838-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13838-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B62B303B68E
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EBD3F076F;
	Fri, 10 Jul 2026 14:38:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91B434BA24;
	Fri, 10 Jul 2026 14:38:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694304; cv=none; b=UaZiXhg3olUNZSxPHw2JdC3WtbF+wm2iIjMWC6onKnbQxWfikIrQ9pry1sqFYK9W+5jhJffSaD6zhQG/0VRlY0DGpaC6XWUlfJpQJWUBdUkaAr0ZqWwm5/Lred2DMW4sMl1VxuHu0mQ7WH/fOlf774TEee9rep3sso/TUZ9U31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694304; c=relaxed/simple;
	bh=KKGIM6zOLU/HugjefWhG4K+DlRpyzK05p2KB/HClii0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGueueutBegyRdyFj8hn7LZBQKlIb5RFofAJ+73wXVnSsCdd1CyVWw85roguGOgEyb7B4SK4Y9KRFptjMis30li71AKRmm6yuW7fgEiKUxRqeIk0vc1d+cCnXHYVZKRHAZF/rsou0EQ88ooaQOJMAwetmZtKiwWYK1SGEiL/n4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 450B4606BC; Fri, 10 Jul 2026 16:38:21 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 9/9] netfilter: xt_physdev: masks are not c-strings
Date: Fri, 10 Jul 2026 16:37:33 +0200
Message-ID: <20260710143733.29741-10-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143733.29741-1-fw@strlen.de>
References: <20260710143733.29741-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13838-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:from_mime,strlen.de:email,strlen.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,launchpad.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 164FD73BD1C

... and must not be subjected to the 'nul terminated' constraint.
If the interface name is 15 characters long, the mask is 16-bytes
'0xff' (to cover for \0) and the valid device name is rejected.

Fixes: 8df772afc9d0 ("netfilter: x_physdev: reject empty or not-nul terminated device names")
Closes: https://bugs.launchpad.net/neutron/+bug/2159935
Cc: stable@vger.kernel.org
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_physdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index dd98f758176c..a388881c68d4 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -130,11 +130,6 @@ static int physdev_mt_check(const struct xt_mtchk_param *par)
 		if (X(physoutdev))
 			return -ENAMETOOLONG;
 	}
-
-	if (X(in_mask))
-		return -ENAMETOOLONG;
-	if (X(out_mask))
-		return -ENAMETOOLONG;
 #undef X
 
 	if (!brnf_probed) {
-- 
2.54.0


