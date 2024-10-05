Return-Path: <netfilter-devel+bounces-4257-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5699129E
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Oct 2024 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F2CB21757
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Oct 2024 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D2146A68;
	Fri,  4 Oct 2024 23:01:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4E13D2BE
	for <netfilter-devel@vger.kernel.org>; Fri,  4 Oct 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082913; cv=none; b=j5/+EGBCzu4+X4HkHVobXBlNrkCb83bKWpyK6Tz5qWKtkC1gh8SnhxTUag1r6aLPy9ZCCWy2QVGt19sjTRDzgQ58Z7qLL0MrYqeBTqtbmgX0F4MmfMcS1a3QIzb0QV2tGCwD5BbWSgxWMHs7VnWuGrg8ITnygaL4Vov2OjXz6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082913; c=relaxed/simple;
	bh=dQhtRS3WLMePqQOlX6iRfIbLByrM+et91fgPqvWNqfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQmcNCLIuA8qn0Pp37clqgsP+F4SJsbQxYNLnEJLfu6TsOZ9bZ39qE5ExhGcL9dCI68E1davb+fHVUGl/qu2rxzei3oXqKrXLExm+7WG+KsKzTlEV3xiMPmhJ6IUwzLVGPr/AyO7q3+WX5OsKZNbvCyd/nlhiH6LzHko4If3m2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1swrIr-0002Iv-FM; Sat, 05 Oct 2024 01:01:41 +0200
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel <netfilter-devel@vger.kernel.org>
Cc: syzkaller-bugs@googlegroups.com,
	Florian Westphal <fw@strlen.de>,
	syzbot+256c348558aa5cf611a9@syzkaller.appspotmail.com,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH nf v2] netfilter: xtables: avoid NFPROTO_UNSPEC where needed
Date: Sat,  5 Oct 2024 01:01:17 +0200
Message-ID: <20241004230134.75274-1-fw@strlen.de>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot managed to call xt_cluster match via ebtables:

 WARNING: CPU: 0 PID: 11 at net/netfilter/xt_cluster.c:72 xt_cluster_mt+0x196/0x780
 [..]
 ebt_do_table+0x174b/0x2a40

Module registers to NFPROTO_UNSPEC, but it assumes ipv4/ipv6 packet
processing.  As this is only useful to restrict locally terminating
TCP/UDP traffic, register this for ipv4 and ipv6 family only.

Pablo points out that this is a general issue, direct users of the
set/getsockopt interface can call into targets/matches that were only
intended for use with ip(6)tables.

Check all UNSPEC matches and targets for similar issues:

- matches and targets are fine except if they assume skb_network_header()
  is valid -- this is only true when called from inet layer: ip(6) stack
  pulls the ip/ipv6 header into linear data area.
- targets that return XT_CONTINUE or other xtables verdicts must be
  restricted too, they are incompatbile with the ebtables traverser, e.g.
  EBT_CONTINUE is a completely different value than XT_CONTINUE.

Most matches/targets are changed to register for NFPROTO_IPV4/IPV6, as
they are provided for use by ip(6)tables.

The MARK target is also used by arptables, so register for NFPROTO_ARP too.

This change passes the selftests in iptables.git.

Reported-by: syzbot+256c348558aa5cf611a9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netfilter-devel/66fec2e2.050a0220.9ec68.0047.GAE@google.com/
Fixes: 0269ea493734 ("netfilter: xtables: add cluster match")
Signed-off-by: Florian Westphal <fw@strlen.de>
Co-developed-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 v2: audit all unspec instead of just fixing this
 particular xt_cluster splat.

 net/netfilter/xt_CHECKSUM.c    |  33 ++++++----
 net/netfilter/xt_CLASSIFY.c    |  16 ++++-
 net/netfilter/xt_CONNSECMARK.c |  36 +++++++----
 net/netfilter/xt_CT.c          | 106 +++++++++++++++++++++------------
 net/netfilter/xt_IDLETIMER.c   |  29 +++++++--
 net/netfilter/xt_LED.c         |  39 ++++++++----
 net/netfilter/xt_NFLOG.c       |  36 +++++++----
 net/netfilter/xt_RATEEST.c     |  39 ++++++++----
 net/netfilter/xt_SECMARK.c     |  27 ++++++++-
 net/netfilter/xt_TRACE.c       |  35 +++++++----
 net/netfilter/xt_addrtype.c    |  15 ++++-
 net/netfilter/xt_cluster.c     |  33 ++++++----
 net/netfilter/xt_connbytes.c   |   4 +-
 net/netfilter/xt_connlimit.c   |  39 ++++++++----
 net/netfilter/xt_connmark.c    |  28 ++++++++-
 net/netfilter/xt_mark.c        |  42 +++++++++----
 16 files changed, 407 insertions(+), 150 deletions(-)

diff --git a/net/netfilter/xt_CHECKSUM.c b/net/netfilter/xt_CHECKSUM.c
index c8a639f56168..3a52143a55b2 100644
--- a/net/netfilter/xt_CHECKSUM.c
+++ b/net/netfilter/xt_CHECKSUM.c
@@ -63,24 +63,37 @@ static int checksum_tg_check(const struct xt_tgchk_param *par)
 	return 0;
 }
 
-static struct xt_target checksum_tg_reg __read_mostly = {
-	.name		= "CHECKSUM",
-	.family		= NFPROTO_UNSPEC,
-	.target		= checksum_tg,
-	.targetsize	= sizeof(struct xt_CHECKSUM_info),
-	.table		= "mangle",
-	.checkentry	= checksum_tg_check,
-	.me		= THIS_MODULE,
+static struct xt_target checksum_tg_reg[] __read_mostly = {
+	{
+		.name		= "CHECKSUM",
+		.family		= NFPROTO_IPV4,
+		.target		= checksum_tg,
+		.targetsize	= sizeof(struct xt_CHECKSUM_info),
+		.table		= "mangle",
+		.checkentry	= checksum_tg_check,
+		.me		= THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "CHECKSUM",
+		.family		= NFPROTO_IPV6,
+		.target		= checksum_tg,
+		.targetsize	= sizeof(struct xt_CHECKSUM_info),
+		.table		= "mangle",
+		.checkentry	= checksum_tg_check,
+		.me		= THIS_MODULE,
+	}
+#endif
 };
 
 static int __init checksum_tg_init(void)
 {
-	return xt_register_target(&checksum_tg_reg);
+	return xt_register_targets(checksum_tg_reg, ARRAY_SIZE(checksum_tg_reg));
 }
 
 static void __exit checksum_tg_exit(void)
 {
-	xt_unregister_target(&checksum_tg_reg);
+	xt_unregister_targets(checksum_tg_reg, ARRAY_SIZE(checksum_tg_reg));
 }
 
 module_init(checksum_tg_init);
diff --git a/net/netfilter/xt_CLASSIFY.c b/net/netfilter/xt_CLASSIFY.c
index 0accac98dea7..0ae8d8a1216e 100644
--- a/net/netfilter/xt_CLASSIFY.c
+++ b/net/netfilter/xt_CLASSIFY.c
@@ -38,9 +38,9 @@ static struct xt_target classify_tg_reg[] __read_mostly = {
 	{
 		.name       = "CLASSIFY",
 		.revision   = 0,
-		.family     = NFPROTO_UNSPEC,
+		.family     = NFPROTO_IPV4,
 		.hooks      = (1 << NF_INET_LOCAL_OUT) | (1 << NF_INET_FORWARD) |
-		              (1 << NF_INET_POST_ROUTING),
+			      (1 << NF_INET_POST_ROUTING),
 		.target     = classify_tg,
 		.targetsize = sizeof(struct xt_classify_target_info),
 		.me         = THIS_MODULE,
@@ -54,6 +54,18 @@ static struct xt_target classify_tg_reg[] __read_mostly = {
 		.targetsize = sizeof(struct xt_classify_target_info),
 		.me         = THIS_MODULE,
 	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name       = "CLASSIFY",
+		.revision   = 0,
+		.family     = NFPROTO_IPV6,
+		.hooks      = (1 << NF_INET_LOCAL_OUT) | (1 << NF_INET_FORWARD) |
+			      (1 << NF_INET_POST_ROUTING),
+		.target     = classify_tg,
+		.targetsize = sizeof(struct xt_classify_target_info),
+		.me         = THIS_MODULE,
+	},
+#endif
 };
 
 static int __init classify_tg_init(void)
diff --git a/net/netfilter/xt_CONNSECMARK.c b/net/netfilter/xt_CONNSECMARK.c
index 76acecf3e757..1494b3ee30e1 100644
--- a/net/netfilter/xt_CONNSECMARK.c
+++ b/net/netfilter/xt_CONNSECMARK.c
@@ -114,25 +114,39 @@ static void connsecmark_tg_destroy(const struct xt_tgdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-static struct xt_target connsecmark_tg_reg __read_mostly = {
-	.name       = "CONNSECMARK",
-	.revision   = 0,
-	.family     = NFPROTO_UNSPEC,
-	.checkentry = connsecmark_tg_check,
-	.destroy    = connsecmark_tg_destroy,
-	.target     = connsecmark_tg,
-	.targetsize = sizeof(struct xt_connsecmark_target_info),
-	.me         = THIS_MODULE,
+static struct xt_target connsecmark_tg_reg[] __read_mostly = {
+	{
+		.name       = "CONNSECMARK",
+		.revision   = 0,
+		.family     = NFPROTO_IPV4,
+		.checkentry = connsecmark_tg_check,
+		.destroy    = connsecmark_tg_destroy,
+		.target     = connsecmark_tg,
+		.targetsize = sizeof(struct xt_connsecmark_target_info),
+		.me         = THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name       = "CONNSECMARK",
+		.revision   = 0,
+		.family     = NFPROTO_IPV6,
+		.checkentry = connsecmark_tg_check,
+		.destroy    = connsecmark_tg_destroy,
+		.target     = connsecmark_tg,
+		.targetsize = sizeof(struct xt_connsecmark_target_info),
+		.me         = THIS_MODULE,
+	},
+#endif
 };
 
 static int __init connsecmark_tg_init(void)
 {
-	return xt_register_target(&connsecmark_tg_reg);
+	return xt_register_targets(connsecmark_tg_reg, ARRAY_SIZE(connsecmark_tg_reg));
 }
 
 static void __exit connsecmark_tg_exit(void)
 {
-	xt_unregister_target(&connsecmark_tg_reg);
+	xt_unregister_targets(connsecmark_tg_reg, ARRAY_SIZE(connsecmark_tg_reg));
 }
 
 module_init(connsecmark_tg_init);
diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index 2be2f7a7b60f..3ba94c34297c 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -313,10 +313,30 @@ static void xt_ct_tg_destroy_v1(const struct xt_tgdtor_param *par)
 	xt_ct_tg_destroy(par, par->targinfo);
 }
 
+static unsigned int
+notrack_tg(struct sk_buff *skb, const struct xt_action_param *par)
+{
+	/* Previously seen (loopback)? Ignore. */
+	if (skb->_nfct != 0)
+		return XT_CONTINUE;
+
+	nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
+
+	return XT_CONTINUE;
+}
+
 static struct xt_target xt_ct_tg_reg[] __read_mostly = {
+	{
+		.name		= "NOTRACK",
+		.revision	= 0,
+		.family		= NFPROTO_IPV4,
+		.target		= notrack_tg,
+		.table		= "raw",
+		.me		= THIS_MODULE,
+	},
 	{
 		.name		= "CT",
-		.family		= NFPROTO_UNSPEC,
+		.family		= NFPROTO_IPV4,
 		.targetsize	= sizeof(struct xt_ct_target_info),
 		.usersize	= offsetof(struct xt_ct_target_info, ct),
 		.checkentry	= xt_ct_tg_check_v0,
@@ -327,7 +347,7 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 	},
 	{
 		.name		= "CT",
-		.family		= NFPROTO_UNSPEC,
+		.family		= NFPROTO_IPV4,
 		.revision	= 1,
 		.targetsize	= sizeof(struct xt_ct_target_info_v1),
 		.usersize	= offsetof(struct xt_ct_target_info, ct),
@@ -339,7 +359,7 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 	},
 	{
 		.name		= "CT",
-		.family		= NFPROTO_UNSPEC,
+		.family		= NFPROTO_IPV4,
 		.revision	= 2,
 		.targetsize	= sizeof(struct xt_ct_target_info_v1),
 		.usersize	= offsetof(struct xt_ct_target_info, ct),
@@ -349,49 +369,61 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 		.table		= "raw",
 		.me		= THIS_MODULE,
 	},
-};
-
-static unsigned int
-notrack_tg(struct sk_buff *skb, const struct xt_action_param *par)
-{
-	/* Previously seen (loopback)? Ignore. */
-	if (skb->_nfct != 0)
-		return XT_CONTINUE;
-
-	nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-
-	return XT_CONTINUE;
-}
-
-static struct xt_target notrack_tg_reg __read_mostly = {
-	.name		= "NOTRACK",
-	.revision	= 0,
-	.family		= NFPROTO_UNSPEC,
-	.target		= notrack_tg,
-	.table		= "raw",
-	.me		= THIS_MODULE,
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "NOTRACK",
+		.revision	= 0,
+		.family		= NFPROTO_IPV6,
+		.target		= notrack_tg,
+		.table		= "raw",
+		.me		= THIS_MODULE,
+	},
+	{
+		.name		= "CT",
+		.family		= NFPROTO_IPV6,
+		.targetsize	= sizeof(struct xt_ct_target_info),
+		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.checkentry	= xt_ct_tg_check_v0,
+		.destroy	= xt_ct_tg_destroy_v0,
+		.target		= xt_ct_target_v0,
+		.table		= "raw",
+		.me		= THIS_MODULE,
+	},
+	{
+		.name		= "CT",
+		.family		= NFPROTO_IPV6,
+		.revision	= 1,
+		.targetsize	= sizeof(struct xt_ct_target_info_v1),
+		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.checkentry	= xt_ct_tg_check_v1,
+		.destroy	= xt_ct_tg_destroy_v1,
+		.target		= xt_ct_target_v1,
+		.table		= "raw",
+		.me		= THIS_MODULE,
+	},
+	{
+		.name		= "CT",
+		.family		= NFPROTO_IPV6,
+		.revision	= 2,
+		.targetsize	= sizeof(struct xt_ct_target_info_v1),
+		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.checkentry	= xt_ct_tg_check_v2,
+		.destroy	= xt_ct_tg_destroy_v1,
+		.target		= xt_ct_target_v1,
+		.table		= "raw",
+		.me		= THIS_MODULE,
+	},
+#endif
 };
 
 static int __init xt_ct_tg_init(void)
 {
-	int ret;
-
-	ret = xt_register_target(&notrack_tg_reg);
-	if (ret < 0)
-		return ret;
-
-	ret = xt_register_targets(xt_ct_tg_reg, ARRAY_SIZE(xt_ct_tg_reg));
-	if (ret < 0) {
-		xt_unregister_target(&notrack_tg_reg);
-		return ret;
-	}
-	return 0;
+	return xt_register_targets(xt_ct_tg_reg, ARRAY_SIZE(xt_ct_tg_reg));
 }
 
 static void __exit xt_ct_tg_exit(void)
 {
 	xt_unregister_targets(xt_ct_tg_reg, ARRAY_SIZE(xt_ct_tg_reg));
-	xt_unregister_target(&notrack_tg_reg);
 }
 
 module_init(xt_ct_tg_init);
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index db720efa811d..f298c22b34c1 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -459,7 +459,7 @@ static void idletimer_tg_destroy_v1(const struct xt_tgdtor_param *par)
 static struct xt_target idletimer_tg[] __read_mostly = {
 	{
 	.name		= "IDLETIMER",
-	.family		= NFPROTO_UNSPEC,
+	.family		= NFPROTO_IPV4,
 	.target		= idletimer_tg_target,
 	.targetsize     = sizeof(struct idletimer_tg_info),
 	.usersize	= offsetof(struct idletimer_tg_info, timer),
@@ -469,7 +469,7 @@ static struct xt_target idletimer_tg[] __read_mostly = {
 	},
 	{
 	.name		= "IDLETIMER",
-	.family		= NFPROTO_UNSPEC,
+	.family		= NFPROTO_IPV4,
 	.revision	= 1,
 	.target		= idletimer_tg_target_v1,
 	.targetsize     = sizeof(struct idletimer_tg_info_v1),
@@ -478,8 +478,29 @@ static struct xt_target idletimer_tg[] __read_mostly = {
 	.destroy        = idletimer_tg_destroy_v1,
 	.me		= THIS_MODULE,
 	},
-
-
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+	.name		= "IDLETIMER",
+	.family		= NFPROTO_IPV6,
+	.target		= idletimer_tg_target,
+	.targetsize     = sizeof(struct idletimer_tg_info),
+	.usersize	= offsetof(struct idletimer_tg_info, timer),
+	.checkentry	= idletimer_tg_checkentry,
+	.destroy        = idletimer_tg_destroy,
+	.me		= THIS_MODULE,
+	},
+	{
+	.name		= "IDLETIMER",
+	.family		= NFPROTO_IPV6,
+	.revision	= 1,
+	.target		= idletimer_tg_target_v1,
+	.targetsize     = sizeof(struct idletimer_tg_info_v1),
+	.usersize	= offsetof(struct idletimer_tg_info_v1, timer),
+	.checkentry	= idletimer_tg_checkentry_v1,
+	.destroy        = idletimer_tg_destroy_v1,
+	.me		= THIS_MODULE,
+	},
+#endif
 };
 
 static struct class *idletimer_tg_class;
diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index 36c9720ad8d6..f7b0286d106a 100644
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -175,26 +175,41 @@ static void led_tg_destroy(const struct xt_tgdtor_param *par)
 	kfree(ledinternal);
 }
 
-static struct xt_target led_tg_reg __read_mostly = {
-	.name		= "LED",
-	.revision	= 0,
-	.family		= NFPROTO_UNSPEC,
-	.target		= led_tg,
-	.targetsize	= sizeof(struct xt_led_info),
-	.usersize	= offsetof(struct xt_led_info, internal_data),
-	.checkentry	= led_tg_check,
-	.destroy	= led_tg_destroy,
-	.me		= THIS_MODULE,
+static struct xt_target led_tg_reg[] __read_mostly = {
+	{
+		.name		= "LED",
+		.revision	= 0,
+		.family		= NFPROTO_IPV4,
+		.target		= led_tg,
+		.targetsize	= sizeof(struct xt_led_info),
+		.usersize	= offsetof(struct xt_led_info, internal_data),
+		.checkentry	= led_tg_check,
+		.destroy	= led_tg_destroy,
+		.me		= THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "LED",
+		.revision	= 0,
+		.family		= NFPROTO_IPV6,
+		.target		= led_tg,
+		.targetsize	= sizeof(struct xt_led_info),
+		.usersize	= offsetof(struct xt_led_info, internal_data),
+		.checkentry	= led_tg_check,
+		.destroy	= led_tg_destroy,
+		.me		= THIS_MODULE,
+	},
+#endif
 };
 
 static int __init led_tg_init(void)
 {
-	return xt_register_target(&led_tg_reg);
+	return xt_register_targets(led_tg_reg, ARRAY_SIZE(led_tg_reg));
 }
 
 static void __exit led_tg_exit(void)
 {
-	xt_unregister_target(&led_tg_reg);
+	xt_unregister_targets(led_tg_reg, ARRAY_SIZE(led_tg_reg));
 }
 
 module_init(led_tg_init);
diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index e660c3710a10..d80abd6ccaf8 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -64,25 +64,39 @@ static void nflog_tg_destroy(const struct xt_tgdtor_param *par)
 	nf_logger_put(par->family, NF_LOG_TYPE_ULOG);
 }
 
-static struct xt_target nflog_tg_reg __read_mostly = {
-	.name       = "NFLOG",
-	.revision   = 0,
-	.family     = NFPROTO_UNSPEC,
-	.checkentry = nflog_tg_check,
-	.destroy    = nflog_tg_destroy,
-	.target     = nflog_tg,
-	.targetsize = sizeof(struct xt_nflog_info),
-	.me         = THIS_MODULE,
+static struct xt_target nflog_tg_reg[] __read_mostly = {
+	{
+		.name       = "NFLOG",
+		.revision   = 0,
+		.family     = NFPROTO_IPV4,
+		.checkentry = nflog_tg_check,
+		.destroy    = nflog_tg_destroy,
+		.target     = nflog_tg,
+		.targetsize = sizeof(struct xt_nflog_info),
+		.me         = THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name       = "NFLOG",
+		.revision   = 0,
+		.family     = NFPROTO_IPV4,
+		.checkentry = nflog_tg_check,
+		.destroy    = nflog_tg_destroy,
+		.target     = nflog_tg,
+		.targetsize = sizeof(struct xt_nflog_info),
+		.me         = THIS_MODULE,
+	},
+#endif
 };
 
 static int __init nflog_tg_init(void)
 {
-	return xt_register_target(&nflog_tg_reg);
+	return xt_register_targets(nflog_tg_reg, ARRAY_SIZE(nflog_tg_reg));
 }
 
 static void __exit nflog_tg_exit(void)
 {
-	xt_unregister_target(&nflog_tg_reg);
+	xt_unregister_targets(nflog_tg_reg, ARRAY_SIZE(nflog_tg_reg));
 }
 
 module_init(nflog_tg_init);
diff --git a/net/netfilter/xt_RATEEST.c b/net/netfilter/xt_RATEEST.c
index 80f6624e2355..4f49cfc27831 100644
--- a/net/netfilter/xt_RATEEST.c
+++ b/net/netfilter/xt_RATEEST.c
@@ -179,16 +179,31 @@ static void xt_rateest_tg_destroy(const struct xt_tgdtor_param *par)
 	xt_rateest_put(par->net, info->est);
 }
 
-static struct xt_target xt_rateest_tg_reg __read_mostly = {
-	.name       = "RATEEST",
-	.revision   = 0,
-	.family     = NFPROTO_UNSPEC,
-	.target     = xt_rateest_tg,
-	.checkentry = xt_rateest_tg_checkentry,
-	.destroy    = xt_rateest_tg_destroy,
-	.targetsize = sizeof(struct xt_rateest_target_info),
-	.usersize   = offsetof(struct xt_rateest_target_info, est),
-	.me         = THIS_MODULE,
+static struct xt_target xt_rateest_tg_reg[] __read_mostly = {
+	{
+		.name       = "RATEEST",
+		.revision   = 0,
+		.family     = NFPROTO_IPV4,
+		.target     = xt_rateest_tg,
+		.checkentry = xt_rateest_tg_checkentry,
+		.destroy    = xt_rateest_tg_destroy,
+		.targetsize = sizeof(struct xt_rateest_target_info),
+		.usersize   = offsetof(struct xt_rateest_target_info, est),
+		.me         = THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name       = "RATEEST",
+		.revision   = 0,
+		.family     = NFPROTO_IPV6,
+		.target     = xt_rateest_tg,
+		.checkentry = xt_rateest_tg_checkentry,
+		.destroy    = xt_rateest_tg_destroy,
+		.targetsize = sizeof(struct xt_rateest_target_info),
+		.usersize   = offsetof(struct xt_rateest_target_info, est),
+		.me         = THIS_MODULE,
+	},
+#endif
 };
 
 static __net_init int xt_rateest_net_init(struct net *net)
@@ -214,12 +229,12 @@ static int __init xt_rateest_tg_init(void)
 
 	if (err)
 		return err;
-	return xt_register_target(&xt_rateest_tg_reg);
+	return xt_register_targets(xt_rateest_tg_reg, ARRAY_SIZE(xt_rateest_tg_reg));
 }
 
 static void __exit xt_rateest_tg_fini(void)
 {
-	xt_unregister_target(&xt_rateest_tg_reg);
+	xt_unregister_targets(xt_rateest_tg_reg, ARRAY_SIZE(xt_rateest_tg_reg));
 	unregister_pernet_subsys(&xt_rateest_net_ops);
 }
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 498a0bf6f044..5bc5ea505eb9 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -157,7 +157,7 @@ static struct xt_target secmark_tg_reg[] __read_mostly = {
 	{
 		.name		= "SECMARK",
 		.revision	= 0,
-		.family		= NFPROTO_UNSPEC,
+		.family		= NFPROTO_IPV4,
 		.checkentry	= secmark_tg_check_v0,
 		.destroy	= secmark_tg_destroy,
 		.target		= secmark_tg_v0,
@@ -167,7 +167,7 @@ static struct xt_target secmark_tg_reg[] __read_mostly = {
 	{
 		.name		= "SECMARK",
 		.revision	= 1,
-		.family		= NFPROTO_UNSPEC,
+		.family		= NFPROTO_IPV4,
 		.checkentry	= secmark_tg_check_v1,
 		.destroy	= secmark_tg_destroy,
 		.target		= secmark_tg_v1,
@@ -175,6 +175,29 @@ static struct xt_target secmark_tg_reg[] __read_mostly = {
 		.usersize	= offsetof(struct xt_secmark_target_info_v1, secid),
 		.me		= THIS_MODULE,
 	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "SECMARK",
+		.revision	= 0,
+		.family		= NFPROTO_IPV6,
+		.checkentry	= secmark_tg_check_v0,
+		.destroy	= secmark_tg_destroy,
+		.target		= secmark_tg_v0,
+		.targetsize	= sizeof(struct xt_secmark_target_info),
+		.me		= THIS_MODULE,
+	},
+	{
+		.name		= "SECMARK",
+		.revision	= 1,
+		.family		= NFPROTO_IPV6,
+		.checkentry	= secmark_tg_check_v1,
+		.destroy	= secmark_tg_destroy,
+		.target		= secmark_tg_v1,
+		.targetsize	= sizeof(struct xt_secmark_target_info_v1),
+		.usersize	= offsetof(struct xt_secmark_target_info_v1, secid),
+		.me		= THIS_MODULE,
+	},
+#endif
 };
 
 static int __init secmark_tg_init(void)
diff --git a/net/netfilter/xt_TRACE.c b/net/netfilter/xt_TRACE.c
index 5582dce98cae..f3fa4f11348c 100644
--- a/net/netfilter/xt_TRACE.c
+++ b/net/netfilter/xt_TRACE.c
@@ -29,25 +29,38 @@ trace_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	return XT_CONTINUE;
 }
 
-static struct xt_target trace_tg_reg __read_mostly = {
-	.name		= "TRACE",
-	.revision	= 0,
-	.family		= NFPROTO_UNSPEC,
-	.table		= "raw",
-	.target		= trace_tg,
-	.checkentry	= trace_tg_check,
-	.destroy	= trace_tg_destroy,
-	.me		= THIS_MODULE,
+static struct xt_target trace_tg_reg[] __read_mostly = {
+	{
+		.name		= "TRACE",
+		.revision	= 0,
+		.family		= NFPROTO_IPV4,
+		.table		= "raw",
+		.target		= trace_tg,
+		.checkentry	= trace_tg_check,
+		.destroy	= trace_tg_destroy,
+		.me		= THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "TRACE",
+		.revision	= 0,
+		.family		= NFPROTO_IPV6,
+		.table		= "raw",
+		.target		= trace_tg,
+		.checkentry	= trace_tg_check,
+		.destroy	= trace_tg_destroy,
+	},
+#endif
 };
 
 static int __init trace_tg_init(void)
 {
-	return xt_register_target(&trace_tg_reg);
+	return xt_register_targets(trace_tg_reg, ARRAY_SIZE(trace_tg_reg));
 }
 
 static void __exit trace_tg_exit(void)
 {
-	xt_unregister_target(&trace_tg_reg);
+	xt_unregister_targets(trace_tg_reg, ARRAY_SIZE(trace_tg_reg));
 }
 
 module_init(trace_tg_init);
diff --git a/net/netfilter/xt_addrtype.c b/net/netfilter/xt_addrtype.c
index e9b2181e8c42..a77088943107 100644
--- a/net/netfilter/xt_addrtype.c
+++ b/net/netfilter/xt_addrtype.c
@@ -208,13 +208,24 @@ static struct xt_match addrtype_mt_reg[] __read_mostly = {
 	},
 	{
 		.name		= "addrtype",
-		.family		= NFPROTO_UNSPEC,
+		.family		= NFPROTO_IPV4,
 		.revision	= 1,
 		.match		= addrtype_mt_v1,
 		.checkentry	= addrtype_mt_checkentry_v1,
 		.matchsize	= sizeof(struct xt_addrtype_info_v1),
 		.me		= THIS_MODULE
-	}
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "addrtype",
+		.family		= NFPROTO_IPV6,
+		.revision	= 1,
+		.match		= addrtype_mt_v1,
+		.checkentry	= addrtype_mt_checkentry_v1,
+		.matchsize	= sizeof(struct xt_addrtype_info_v1),
+		.me		= THIS_MODULE
+	},
+#endif
 };
 
 static int __init addrtype_mt_init(void)
diff --git a/net/netfilter/xt_cluster.c b/net/netfilter/xt_cluster.c
index a047a545371e..908fd5f2c3c8 100644
--- a/net/netfilter/xt_cluster.c
+++ b/net/netfilter/xt_cluster.c
@@ -146,24 +146,37 @@ static void xt_cluster_mt_destroy(const struct xt_mtdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-static struct xt_match xt_cluster_match __read_mostly = {
-	.name		= "cluster",
-	.family		= NFPROTO_UNSPEC,
-	.match		= xt_cluster_mt,
-	.checkentry	= xt_cluster_mt_checkentry,
-	.matchsize	= sizeof(struct xt_cluster_match_info),
-	.destroy	= xt_cluster_mt_destroy,
-	.me		= THIS_MODULE,
+static struct xt_match xt_cluster_match[] __read_mostly = {
+	{
+		.name		= "cluster",
+		.family		= NFPROTO_IPV4,
+		.match		= xt_cluster_mt,
+		.checkentry	= xt_cluster_mt_checkentry,
+		.matchsize	= sizeof(struct xt_cluster_match_info),
+		.destroy	= xt_cluster_mt_destroy,
+		.me		= THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name		= "cluster",
+		.family		= NFPROTO_IPV6,
+		.match		= xt_cluster_mt,
+		.checkentry	= xt_cluster_mt_checkentry,
+		.matchsize	= sizeof(struct xt_cluster_match_info),
+		.destroy	= xt_cluster_mt_destroy,
+		.me		= THIS_MODULE,
+	},
+#endif
 };
 
 static int __init xt_cluster_mt_init(void)
 {
-	return xt_register_match(&xt_cluster_match);
+	return xt_register_matches(xt_cluster_match, ARRAY_SIZE(xt_cluster_match));
 }
 
 static void __exit xt_cluster_mt_fini(void)
 {
-	xt_unregister_match(&xt_cluster_match);
+	xt_unregister_matches(xt_cluster_match, ARRAY_SIZE(xt_cluster_match));
 }
 
 MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
diff --git a/net/netfilter/xt_connbytes.c b/net/netfilter/xt_connbytes.c
index 93cb018c3055..2aabdcea8707 100644
--- a/net/netfilter/xt_connbytes.c
+++ b/net/netfilter/xt_connbytes.c
@@ -111,9 +111,11 @@ static int connbytes_mt_check(const struct xt_mtchk_param *par)
 		return -EINVAL;
 
 	ret = nf_ct_netns_get(par->net, par->family);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info_ratelimited("cannot load conntrack support for proto=%u\n",
 				    par->family);
+		return ret;
+	}
 
 	/*
 	 * This filter cannot function correctly unless connection tracking
diff --git a/net/netfilter/xt_connlimit.c b/net/netfilter/xt_connlimit.c
index 0e762277bcf8..b88135840d8a 100644
--- a/net/netfilter/xt_connlimit.c
+++ b/net/netfilter/xt_connlimit.c
@@ -117,26 +117,41 @@ static void connlimit_mt_destroy(const struct xt_mtdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-static struct xt_match connlimit_mt_reg __read_mostly = {
-	.name       = "connlimit",
-	.revision   = 1,
-	.family     = NFPROTO_UNSPEC,
-	.checkentry = connlimit_mt_check,
-	.match      = connlimit_mt,
-	.matchsize  = sizeof(struct xt_connlimit_info),
-	.usersize   = offsetof(struct xt_connlimit_info, data),
-	.destroy    = connlimit_mt_destroy,
-	.me         = THIS_MODULE,
+static struct xt_match connlimit_mt_reg[] __read_mostly = {
+	{
+		.name       = "connlimit",
+		.revision   = 1,
+		.family     = NFPROTO_IPV4,
+		.checkentry = connlimit_mt_check,
+		.match      = connlimit_mt,
+		.matchsize  = sizeof(struct xt_connlimit_info),
+		.usersize   = offsetof(struct xt_connlimit_info, data),
+		.destroy    = connlimit_mt_destroy,
+		.me         = THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name       = "connlimit",
+		.revision   = 1,
+		.family     = NFPROTO_IPV6,
+		.checkentry = connlimit_mt_check,
+		.match      = connlimit_mt,
+		.matchsize  = sizeof(struct xt_connlimit_info),
+		.usersize   = offsetof(struct xt_connlimit_info, data),
+		.destroy    = connlimit_mt_destroy,
+		.me         = THIS_MODULE,
+#endif
+	}
 };
 
 static int __init connlimit_mt_init(void)
 {
-	return xt_register_match(&connlimit_mt_reg);
+	return xt_register_matches(connlimit_mt_reg, ARRAY_SIZE(connlimit_mt_reg));
 }
 
 static void __exit connlimit_mt_exit(void)
 {
-	xt_unregister_match(&connlimit_mt_reg);
+	xt_unregister_matches(connlimit_mt_reg, ARRAY_SIZE(connlimit_mt_reg));
 }
 
 module_init(connlimit_mt_init);
diff --git a/net/netfilter/xt_connmark.c b/net/netfilter/xt_connmark.c
index ad3c033db64e..4277084de2e7 100644
--- a/net/netfilter/xt_connmark.c
+++ b/net/netfilter/xt_connmark.c
@@ -151,7 +151,7 @@ static struct xt_target connmark_tg_reg[] __read_mostly = {
 	{
 		.name           = "CONNMARK",
 		.revision       = 1,
-		.family         = NFPROTO_UNSPEC,
+		.family         = NFPROTO_IPV4,
 		.checkentry     = connmark_tg_check,
 		.target         = connmark_tg,
 		.targetsize     = sizeof(struct xt_connmark_tginfo1),
@@ -161,13 +161,35 @@ static struct xt_target connmark_tg_reg[] __read_mostly = {
 	{
 		.name           = "CONNMARK",
 		.revision       = 2,
-		.family         = NFPROTO_UNSPEC,
+		.family         = NFPROTO_IPV4,
 		.checkentry     = connmark_tg_check,
 		.target         = connmark_tg_v2,
 		.targetsize     = sizeof(struct xt_connmark_tginfo2),
 		.destroy        = connmark_tg_destroy,
 		.me             = THIS_MODULE,
-	}
+	},
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name           = "CONNMARK",
+		.revision       = 1,
+		.family         = NFPROTO_IPV6,
+		.checkentry     = connmark_tg_check,
+		.target         = connmark_tg,
+		.targetsize     = sizeof(struct xt_connmark_tginfo1),
+		.destroy        = connmark_tg_destroy,
+		.me             = THIS_MODULE,
+	},
+	{
+		.name           = "CONNMARK",
+		.revision       = 2,
+		.family         = NFPROTO_IPV6,
+		.checkentry     = connmark_tg_check,
+		.target         = connmark_tg_v2,
+		.targetsize     = sizeof(struct xt_connmark_tginfo2),
+		.destroy        = connmark_tg_destroy,
+		.me             = THIS_MODULE,
+	},
+#endif
 };
 
 static struct xt_match connmark_mt_reg __read_mostly = {
diff --git a/net/netfilter/xt_mark.c b/net/netfilter/xt_mark.c
index 1ad74b5920b5..f76fe04fc9a4 100644
--- a/net/netfilter/xt_mark.c
+++ b/net/netfilter/xt_mark.c
@@ -39,13 +39,35 @@ mark_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return ((skb->mark & info->mask) == info->mark) ^ info->invert;
 }
 
-static struct xt_target mark_tg_reg __read_mostly = {
-	.name           = "MARK",
-	.revision       = 2,
-	.family         = NFPROTO_UNSPEC,
-	.target         = mark_tg,
-	.targetsize     = sizeof(struct xt_mark_tginfo2),
-	.me             = THIS_MODULE,
+static struct xt_target mark_tg_reg[] __read_mostly = {
+	{
+		.name           = "MARK",
+		.revision       = 2,
+		.family         = NFPROTO_IPV4,
+		.target         = mark_tg,
+		.targetsize     = sizeof(struct xt_mark_tginfo2),
+		.me             = THIS_MODULE,
+	},
+#if IS_ENABLED(CONFIG_IP_NF_ARPTABLES)
+	{
+		.name           = "MARK",
+		.revision       = 2,
+		.family         = NFPROTO_ARP,
+		.target         = mark_tg,
+		.targetsize     = sizeof(struct xt_mark_tginfo2),
+		.me             = THIS_MODULE,
+	},
+#endif
+#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
+	{
+		.name           = "MARK",
+		.revision       = 2,
+		.family         = NFPROTO_IPV4,
+		.target         = mark_tg,
+		.targetsize     = sizeof(struct xt_mark_tginfo2),
+		.me             = THIS_MODULE,
+	},
+#endif
 };
 
 static struct xt_match mark_mt_reg __read_mostly = {
@@ -61,12 +83,12 @@ static int __init mark_mt_init(void)
 {
 	int ret;
 
-	ret = xt_register_target(&mark_tg_reg);
+	ret = xt_register_targets(mark_tg_reg, ARRAY_SIZE(mark_tg_reg));
 	if (ret < 0)
 		return ret;
 	ret = xt_register_match(&mark_mt_reg);
 	if (ret < 0) {
-		xt_unregister_target(&mark_tg_reg);
+		xt_unregister_targets(mark_tg_reg, ARRAY_SIZE(mark_tg_reg));
 		return ret;
 	}
 	return 0;
@@ -75,7 +97,7 @@ static int __init mark_mt_init(void)
 static void __exit mark_mt_exit(void)
 {
 	xt_unregister_match(&mark_mt_reg);
-	xt_unregister_target(&mark_tg_reg);
+	xt_unregister_targets(mark_tg_reg, ARRAY_SIZE(mark_tg_reg));
 }
 
 module_init(mark_mt_init);
-- 
2.46.2


