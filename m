Return-Path: <netfilter-devel+bounces-13209-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M9GvK1imKWqNbQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13209-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 20:00:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195166C1D5
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 20:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13209-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13209-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C83330DC17B
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED58356751;
	Wed, 10 Jun 2026 17:59:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D06352030;
	Wed, 10 Jun 2026 17:59:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114370; cv=none; b=Iz6sFRKQDTrebwBbyKA4XiHGaWRzCvRnkhF3DbaMgqurcbcYI5fzV5Czz4d2+6uN1RbSeAVYgh2Hcda1Y7aQbYdhFbaiWENA4rr9cPUt/TQ6QbGQQ3GR5ybmefu1KJaQ4ARE538kwk1C5+8bwYt0PPBQvAfkb5KUfTDDT71MeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114370; c=relaxed/simple;
	bh=zGRuR9lKpIsWFB3us5ApPBPy1f3dlTfeKxdJBrasOtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqyd5D8ZviUxD/9kIqIHyIu5LchYWS6kHYzskNEAr5Lw4TeGoB06TBljzyMPSGSNF9FIj8jNueFVGaHkMehepezYJZC5kW2ARciTIwhZL5wbH0fy8Tayz8F4M4NupHRpjrsuZPP2mxfhMRl0Jo3rzOL86nKGdXhQZ/4Oefn+dno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 146C4608DF; Wed, 10 Jun 2026 19:59:22 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next 1/2] netdevsim: tc: allow to test nf_tables offload control plane code
Date: Wed, 10 Jun 2026 19:58:43 +0200
Message-ID: <20260610175906.1767-2-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610175906.1767-1-fw@strlen.de>
References: <20260610175906.1767-1-fw@strlen.de>
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
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13209-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6195166C1D5

The actual 'offload' is phony, all commands are ignored: this is only
useful to test control plane code.

Tag the existing callback to permit error injection to test rollback/abort
code in nf_tables.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 drivers/net/netdevsim/tc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/tc.c b/drivers/net/netdevsim/tc.c
index 8f013a5895a2..0c55d23dae10 100644
--- a/drivers/net/netdevsim/tc.c
+++ b/drivers/net/netdevsim/tc.c
@@ -9,7 +9,20 @@
 static int
 nsim_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
 {
-	return nsim_bpf_setup_tc_block_cb(type, type_data, cb_priv);
+	int err = 0;
+
+	switch (type) {
+	case TC_SETUP_CLSBPF:
+		err = nsim_bpf_setup_tc_block_cb(type, type_data, cb_priv);
+		break;
+	case TC_SETUP_CLSFLOWER:
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
 }
 
 static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
@@ -73,7 +86,10 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 						  &nsim_block_cb_list,
 						  nsim_setup_tc_block_cb,
 						  ns, ns, true);
+	case TC_SETUP_FT:
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
+ALLOW_ERROR_INJECTION(nsim_setup_tc, ERRNO);
-- 
2.53.0


