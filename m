Return-Path: <netfilter-devel+bounces-12458-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCR4KwwT+2lLWQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12458-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 12:08:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8494D91ED
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710F930067A3
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2026 10:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717243FADFB;
	Wed,  6 May 2026 10:08:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0B3F7880
	for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062089; cv=none; b=bayZ+iHGCdUksgtDiEF+kU8FIWRodp/D0mHU8/QQw6Pd9cHWefmLTFh/D+D2vV6fhi4XYmrHnUhpY1hHRTXzDxFVVwSu2yHt1FqTnKkWp1veXxNBuoNUEKycynU2weXcu7H9mqL5Ok1oOJn92lKBiCda/xbhkvGOcio3fa3CvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062089; c=relaxed/simple;
	bh=NATWsAYtPPhUJ4K6Lqbf2G53tIuEblC3ewFI5ErIgW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVPS0KGVmcLv0JkrK3Y0wLuJiGv/4WE+0sxlh2n7GQw7cWGxjtmQGOa6wLK/Xt0XSRV+l2G6aTCw97y7Jax4gm4tlD+jooe8b2d8HAWjekhb5S4Jtgpb1f67Sw7ZPe+YMgmdjLh+gIW/x1bm+OmE0T6Y3qHXQm6gQFT776avHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 68F8560D41; Wed, 06 May 2026 12:08:04 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: tristan@talencesecurity.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 nf 7/8] netfilter: ebtables: close dangling table module init race
Date: Wed,  6 May 2026 12:07:19 +0200
Message-ID: <20260506100728.2664-8-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506100728.2664-1-fw@strlen.de>
References: <20260506100728.2664-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A8494D91ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12458-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

sashiko reported for a related patch:
 In modules like iptable_raw.c, [..], if register_pernet_subsys() fails,
 the rollback might call kfree(rawtable_ops) before [..]
 During this window, could a concurrent userspace process find the globally
 visible template, trigger table_init(), [..]

The table init functions must always register the template last.

Otherwise, set/getsockopt can instantiate a table in a namespace
while the required pernet ops (contain the destructor) isn't available.
This change is also required in x_tables, handled in followup change.

Fixes: 87663c39f898 ("netfilter: ebtables: do not hook tables by default")
Reviewed-by: Tristan Madani <tristan@talencesecurity.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v3: no changes.
 net/bridge/netfilter/ebtable_broute.c | 12 +++++-------
 net/bridge/netfilter/ebtable_filter.c | 12 +++++-------
 net/bridge/netfilter/ebtable_nat.c    | 10 ++++------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/net/bridge/netfilter/ebtable_broute.c b/net/bridge/netfilter/ebtable_broute.c
index e6f9e343b41f..f05c79f215ea 100644
--- a/net/bridge/netfilter/ebtable_broute.c
+++ b/net/bridge/netfilter/ebtable_broute.c
@@ -112,18 +112,16 @@ static struct pernet_operations broute_net_ops = {
 
 static int __init ebtable_broute_init(void)
 {
-	int ret = ebt_register_template(&broute_table, broute_table_init);
+	int ret = register_pernet_subsys(&broute_net_ops);
 
 	if (ret)
 		return ret;
 
-	ret = register_pernet_subsys(&broute_net_ops);
-	if (ret) {
-		ebt_unregister_template(&broute_table);
-		return ret;
-	}
+	ret = ebt_register_template(&broute_table, broute_table_init);
+	if (ret)
+		unregister_pernet_subsys(&broute_net_ops);
 
-	return 0;
+	return ret;
 }
 
 static void __exit ebtable_broute_fini(void)
diff --git a/net/bridge/netfilter/ebtable_filter.c b/net/bridge/netfilter/ebtable_filter.c
index 02b6501c15a5..0fc03b07e62a 100644
--- a/net/bridge/netfilter/ebtable_filter.c
+++ b/net/bridge/netfilter/ebtable_filter.c
@@ -93,18 +93,16 @@ static struct pernet_operations frame_filter_net_ops = {
 
 static int __init ebtable_filter_init(void)
 {
-	int ret = ebt_register_template(&frame_filter, frame_filter_table_init);
+	int ret = register_pernet_subsys(&frame_filter_net_ops);
 
 	if (ret)
 		return ret;
 
-	ret = register_pernet_subsys(&frame_filter_net_ops);
-	if (ret) {
-		ebt_unregister_template(&frame_filter);
-		return ret;
-	}
+	ret = ebt_register_template(&frame_filter, frame_filter_table_init);
+	if (ret)
+		unregister_pernet_subsys(&frame_filter_net_ops);
 
-	return 0;
+	return ret;
 }
 
 static void __exit ebtable_filter_fini(void)
diff --git a/net/bridge/netfilter/ebtable_nat.c b/net/bridge/netfilter/ebtable_nat.c
index 9985a82555c4..8a10375d8909 100644
--- a/net/bridge/netfilter/ebtable_nat.c
+++ b/net/bridge/netfilter/ebtable_nat.c
@@ -93,16 +93,14 @@ static struct pernet_operations frame_nat_net_ops = {
 
 static int __init ebtable_nat_init(void)
 {
-	int ret = ebt_register_template(&frame_nat, frame_nat_table_init);
+	int ret = register_pernet_subsys(&frame_nat_net_ops);
 
 	if (ret)
 		return ret;
 
-	ret = register_pernet_subsys(&frame_nat_net_ops);
-	if (ret) {
-		ebt_unregister_template(&frame_nat);
-		return ret;
-	}
+	ret = ebt_register_template(&frame_nat, frame_nat_table_init);
+	if (ret)
+		unregister_pernet_subsys(&frame_nat_net_ops);
 
 	return ret;
 }
-- 
2.53.0


