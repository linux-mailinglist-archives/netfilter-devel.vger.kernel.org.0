Return-Path: <netfilter-devel+bounces-12455-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHxWJZIU+2lLWQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12455-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 12:14:42 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7744D9326
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C55533076A3E
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2026 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770013FAE15;
	Wed,  6 May 2026 10:07:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422163FADFB
	for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062076; cv=none; b=lPY1ekaTUe8DnGO5VMJeOLzkZlZFXzwrxwkWzkuKZY3kxngqoZY+vkcXlyEwrim9YKxWlCZ+NdD4xPy7EMW7hjdjejq3prJrk2i7cb/d1HjKxnTuleeBDbaLRpR7E+BJ8QfyMecxfHPlx2ELeiulENHcxwSrtv+EMJftwzWwvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062076; c=relaxed/simple;
	bh=XBwSrgbRaweln8CmlRWyP1hsWeqY1HaKbv7/E7JcT1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdZy7c/IvJqTVZurMwvdmKzlU+JjNacJHrnsatGmBPbTYirwPSKlizfKU71q1duDtCwUwAFW+sP3P86+BO8BbmTYb6QHWht6EDhqh55x1pGYqDBHxR+Sjsi59TuqkOhiHNzOFnacV2+MLf5UYFI49FSGXGR6fqRDaWLP398y7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6D714605F3; Wed, 06 May 2026 12:07:51 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: tristan@talencesecurity.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 nf 4/8] netfilter: x_tables: unregister the templates first
Date: Wed,  6 May 2026 12:07:16 +0200
Message-ID: <20260506100728.2664-5-fw@strlen.de>
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
X-Rspamd-Queue-Id: 0A7744D9326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12455-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email,talencesecurity.com:email]

When the module is going away we need to zap the template
first.  Else there is a small race window where userspace
could instantiate a new table after the pernet exit function
has removed the current table.

Fixes: fdacd57c79b7 ("netfilter: x_tables: never register tables by default")
Reported-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Tristan Madani <tristan@talencesecurity.com>
Closes: https://lore.kernel.org/netfilter-devel/20260429175613.1459342-1-tristmd@gmail.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v3: no changes.
 net/ipv4/netfilter/arptable_filter.c   | 2 +-
 net/ipv4/netfilter/iptable_filter.c    | 2 +-
 net/ipv4/netfilter/iptable_mangle.c    | 2 +-
 net/ipv4/netfilter/iptable_raw.c       | 2 +-
 net/ipv4/netfilter/iptable_security.c  | 2 +-
 net/ipv6/netfilter/ip6table_filter.c   | 2 +-
 net/ipv6/netfilter/ip6table_mangle.c   | 2 +-
 net/ipv6/netfilter/ip6table_raw.c      | 2 +-
 net/ipv6/netfilter/ip6table_security.c | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/netfilter/arptable_filter.c b/net/ipv4/netfilter/arptable_filter.c
index 393d9a8c7739..382345567a60 100644
--- a/net/ipv4/netfilter/arptable_filter.c
+++ b/net/ipv4/netfilter/arptable_filter.c
@@ -82,8 +82,8 @@ static int __init arptable_filter_init(void)
 
 static void __exit arptable_filter_fini(void)
 {
-	unregister_pernet_subsys(&arptable_filter_net_ops);
 	xt_unregister_template(&packet_filter);
+	unregister_pernet_subsys(&arptable_filter_net_ops);
 	kfree(arpfilter_ops);
 }
 
diff --git a/net/ipv4/netfilter/iptable_filter.c b/net/ipv4/netfilter/iptable_filter.c
index b2fbd9651d61..0dea754a9120 100644
--- a/net/ipv4/netfilter/iptable_filter.c
+++ b/net/ipv4/netfilter/iptable_filter.c
@@ -101,8 +101,8 @@ static int __init iptable_filter_init(void)
 
 static void __exit iptable_filter_fini(void)
 {
-	unregister_pernet_subsys(&iptable_filter_net_ops);
 	xt_unregister_template(&packet_filter);
+	unregister_pernet_subsys(&iptable_filter_net_ops);
 	kfree(filter_ops);
 }
 
diff --git a/net/ipv4/netfilter/iptable_mangle.c b/net/ipv4/netfilter/iptable_mangle.c
index a99e61996197..4d3b12492308 100644
--- a/net/ipv4/netfilter/iptable_mangle.c
+++ b/net/ipv4/netfilter/iptable_mangle.c
@@ -135,8 +135,8 @@ static int __init iptable_mangle_init(void)
 
 static void __exit iptable_mangle_fini(void)
 {
-	unregister_pernet_subsys(&iptable_mangle_net_ops);
 	xt_unregister_template(&packet_mangler);
+	unregister_pernet_subsys(&iptable_mangle_net_ops);
 	kfree(mangle_ops);
 }
 
diff --git a/net/ipv4/netfilter/iptable_raw.c b/net/ipv4/netfilter/iptable_raw.c
index 42511721e538..6f7afec7954b 100644
--- a/net/ipv4/netfilter/iptable_raw.c
+++ b/net/ipv4/netfilter/iptable_raw.c
@@ -100,9 +100,9 @@ static int __init iptable_raw_init(void)
 
 static void __exit iptable_raw_fini(void)
 {
+	xt_unregister_template(&packet_raw);
 	unregister_pernet_subsys(&iptable_raw_net_ops);
 	kfree(rawtable_ops);
-	xt_unregister_template(&packet_raw);
 }
 
 module_init(iptable_raw_init);
diff --git a/net/ipv4/netfilter/iptable_security.c b/net/ipv4/netfilter/iptable_security.c
index 4646bf6d7d2b..81175c20ccbe 100644
--- a/net/ipv4/netfilter/iptable_security.c
+++ b/net/ipv4/netfilter/iptable_security.c
@@ -89,9 +89,9 @@ static int __init iptable_security_init(void)
 
 static void __exit iptable_security_fini(void)
 {
+	xt_unregister_template(&security_table);
 	unregister_pernet_subsys(&iptable_security_net_ops);
 	kfree(sectbl_ops);
-	xt_unregister_template(&security_table);
 }
 
 module_init(iptable_security_init);
diff --git a/net/ipv6/netfilter/ip6table_filter.c b/net/ipv6/netfilter/ip6table_filter.c
index f05a9e4b2c67..cf561919bde8 100644
--- a/net/ipv6/netfilter/ip6table_filter.c
+++ b/net/ipv6/netfilter/ip6table_filter.c
@@ -100,8 +100,8 @@ static int __init ip6table_filter_init(void)
 
 static void __exit ip6table_filter_fini(void)
 {
-	unregister_pernet_subsys(&ip6table_filter_net_ops);
 	xt_unregister_template(&packet_filter);
+	unregister_pernet_subsys(&ip6table_filter_net_ops);
 	kfree(filter_ops);
 }
 
diff --git a/net/ipv6/netfilter/ip6table_mangle.c b/net/ipv6/netfilter/ip6table_mangle.c
index afa4a5703e43..1a758f2bc537 100644
--- a/net/ipv6/netfilter/ip6table_mangle.c
+++ b/net/ipv6/netfilter/ip6table_mangle.c
@@ -128,8 +128,8 @@ static int __init ip6table_mangle_init(void)
 
 static void __exit ip6table_mangle_fini(void)
 {
-	unregister_pernet_subsys(&ip6table_mangle_net_ops);
 	xt_unregister_template(&packet_mangler);
+	unregister_pernet_subsys(&ip6table_mangle_net_ops);
 	kfree(mangle_ops);
 }
 
diff --git a/net/ipv6/netfilter/ip6table_raw.c b/net/ipv6/netfilter/ip6table_raw.c
index 32d2da81c52a..923455921c1d 100644
--- a/net/ipv6/netfilter/ip6table_raw.c
+++ b/net/ipv6/netfilter/ip6table_raw.c
@@ -98,8 +98,8 @@ static int __init ip6table_raw_init(void)
 
 static void __exit ip6table_raw_fini(void)
 {
-	unregister_pernet_subsys(&ip6table_raw_net_ops);
 	xt_unregister_template(&packet_raw);
+	unregister_pernet_subsys(&ip6table_raw_net_ops);
 	kfree(rawtable_ops);
 }
 
diff --git a/net/ipv6/netfilter/ip6table_security.c b/net/ipv6/netfilter/ip6table_security.c
index 3dfd8d6ea4b9..c44834d93fc7 100644
--- a/net/ipv6/netfilter/ip6table_security.c
+++ b/net/ipv6/netfilter/ip6table_security.c
@@ -88,8 +88,8 @@ static int __init ip6table_security_init(void)
 
 static void __exit ip6table_security_fini(void)
 {
-	unregister_pernet_subsys(&ip6table_security_net_ops);
 	xt_unregister_template(&security_table);
+	unregister_pernet_subsys(&ip6table_security_net_ops);
 	kfree(sectbl_ops);
 }
 
-- 
2.53.0


