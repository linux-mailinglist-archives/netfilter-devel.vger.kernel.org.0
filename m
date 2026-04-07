Return-Path: <netfilter-devel+bounces-11680-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF9PFLsT1Wm30AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11680-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:24:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF6F3AFF89
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8DB130D5750
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDE3B7B61;
	Tue,  7 Apr 2026 14:16:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2702E285CA2;
	Tue,  7 Apr 2026 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571366; cv=none; b=BgoibUVPhUjJhnzf8HOT1DI1KFmwG4EJNeaMzPLNh8Dko6fmoTuu8Ev4pUX4mPof4GJZlnwTORMMHaw8fFqFXgIppy7Xw1w4hfzWMBBujuz0XRYkitaI8BZtIEzHxBD94s9438guYVcmibH0YxPeu4EcOW1FrhdU4mRIzZyAHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571366; c=relaxed/simple;
	bh=jJiF0ReFvtDk4dMiPQ1+PWLa5EvISevfznDTu2dC5VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI4tMwMwDvThZvklVmy5PJu+jMzr/r1GxQSD2h6ueRt/mDkpi5y2LwT2MTsnYjUBB48/YWdVqR+IRElT86LpVV/wqoE2P/fr/rY2Z48zUL4Vha+1O7R3iDoCrxMD5np08849ztI8fL8IKoL66P9quaM75WFAFAQJmrPybrzja/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5FE9160660; Tue, 07 Apr 2026 16:16:02 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 04/13] netfilter: add deprecation warning for dccp support
Date: Tue,  7 Apr 2026 16:15:31 +0200
Message-ID: <20260407141540.11549-5-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407141540.11549-1-fw@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11680-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFF6F3AFF89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a deprecation warning for the xt_dccp match and the
nft exthdr code.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_exthdr.c | 3 +++
 net/netfilter/xt_dccp.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 5f01269a49bd..14d4ad7f518c 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -796,6 +796,9 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 		break;
 #ifdef CONFIG_NFT_EXTHDR_DCCP
 	case NFT_EXTHDR_OP_DCCP:
+		pr_warn_once("The dccp option matching is deprecated and scheduled to be removed in 2027.\n"
+			     "Please contact the netfilter-devel mailing list or update your nftables rules.\n");
+
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_dccp_ops;
 		break;
diff --git a/net/netfilter/xt_dccp.c b/net/netfilter/xt_dccp.c
index 037ab93e25d0..3db81e041af9 100644
--- a/net/netfilter/xt_dccp.c
+++ b/net/netfilter/xt_dccp.c
@@ -159,6 +159,9 @@ static int __init dccp_mt_init(void)
 {
 	int ret;
 
+	pr_warn_once("The DCCP match is deprecated and scheduled to be removed in 2027.\n"
+		     "Please contact the netfilter-devel mailing list or update your iptables rules\n");
+
 	/* doff is 8 bits, so the maximum option size is (4*256).  Don't put
 	 * this in BSS since DaveM is worried about locked TLB's for kernel
 	 * BSS. */
-- 
2.52.0


