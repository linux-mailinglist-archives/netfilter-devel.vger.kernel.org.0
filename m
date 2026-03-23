Return-Path: <netfilter-devel+bounces-11370-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJiTD+EAwWlUPgQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11370-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Mar 2026 09:59:13 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A91092EE905
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Mar 2026 09:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0DE33025F62
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Mar 2026 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0536E484;
	Mon, 23 Mar 2026 08:56:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A039385531
	for <netfilter-devel@vger.kernel.org>; Mon, 23 Mar 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256204; cv=none; b=CwqETmfFdjQTEinct0sZ433Svtkzz7vl5YaMbu5bIx5Iu1gFFiU07z4/5BYVdmu/JvFgBXz3dYxDOVkwRauC/YAd5OJtol3tzuBi1lS2IXlIj1qgP0j/73L0Z3uxhQ3v8uXP5KPx4KRD5C/6YyiHnnvemLIMe+47xOoaaXWA+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256204; c=relaxed/simple;
	bh=uBy18IQwDRIAyR5Eb8ya5V7+kYqSy6nwgeivzxAPZAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvgJsUfcY1pQwjNlbbXYKstNVMdHo32ajA/1PpPST71mUCMSyYKWA0vRuvsdfwBFGvShWiP9s4IgZb17Ik/jNzxh0JnHMZ2gUTjCOiei/4/k0xb0SanXnMSwagig3B1fX+o00eZ6g683XBb5SydIei4Me/HVUHPbD8kb6z9Aa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2A76660904; Mon, 23 Mar 2026 09:56:35 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: osf: add deprecation notices
Date: Mon, 23 Mar 2026 09:56:26 +0100
Message-ID: <20260323085629.43927-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-11370-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: A91092EE905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The p0f fingerprints haven't been updated in years, it doesn't look like
this feature is still in a useful/working state.

Add deprecation notices.  We can remove them again if people still use this
feature.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_osf.c | 3 +++
 net/netfilter/nft_osf.c       | 3 +++
 net/netfilter/xt_osf.c        | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index d64ce21c7b55..ca943ea71d1a 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -423,6 +423,9 @@ static int __init nfnl_osf_init(void)
 	int err = -EINVAL;
 	int i;
 
+	pr_warn_once("The osf nfnetlink helper is deprecated and scheduled to be removed in 2027.\n"
+		     "Please contact the netfilter-devel mailing list\n");
+
 	for (i = 0; i < ARRAY_SIZE(nf_osf_fingers); ++i)
 		INIT_LIST_HEAD(&nf_osf_fingers[i]);
 
diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 18003433476c..38d3260a954c 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -147,6 +147,9 @@ static struct nft_expr_type nft_osf_type __read_mostly = {
 
 static int __init nft_osf_module_init(void)
 {
+	pr_warn_once("The osf expression is deprecated and scheduled to be removed in 2027.\n"
+		     "Please contact the netfilter-devel mailing list or update your nftables rules\n");
+
 	return nft_register_expr(&nft_osf_type);
 }
 
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index dc9485854002..0d8ee8542e16 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -48,6 +48,9 @@ static int __init xt_osf_init(void)
 {
 	int err;
 
+	pr_warn_once("The osf match is deprecated and scheduled to be removed in 2027.\n"
+		     "Please contact the netfilter-devel mailing list or update your iptables rules\n");
+
 	err = xt_register_match(&xt_osf_match);
 	if (err) {
 		pr_err("Failed to register OS fingerprint "
-- 
2.53.0


