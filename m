Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E102A417DA1
	for <lists+netfilter-devel@lfdr.de>; Sat, 25 Sep 2021 00:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345749AbhIXWNN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Sep 2021 18:13:13 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49774 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbhIXWND (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:13:03 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id BF4C963EBD;
        Sat, 25 Sep 2021 00:10:07 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 14/15] netfilter: log: work around missing softdep backend module
Date:   Sat, 25 Sep 2021 00:11:12 +0200
Message-Id: <20210924221113.348767-15-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924221113.348767-1-pablo@netfilter.org>
References: <20210924221113.348767-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

iptables/nftables has two types of log modules:

1. backend, e.g. nf_log_syslog, which implement the functionality
2. frontend, e.g. xt_LOG or nft_log, which call the functionality
   provided by backend based on nf_tables or xtables rule set.

Problem is that the request_module() call to load the backed in
nf_logger_find_get() might happen with nftables transaction mutex held
in case the call path is via nf_tables/nft_compat.

This can cause deadlocks (see 'Fixes' tags for details).

The chosen solution as to let modprobe deal with this by adding 'pre: '
soft dep tag to xt_LOG (to load the syslog backend) and xt_NFLOG (to
load nflog backend).

Eric reports that this breaks on systems with older modprobe that
doesn't support softdeps.

Another, similar issue occurs when someone either insmods xt_(NF)LOG
directly or unloads the backend module (possible if no log frontend
is in use): because the frontend module is already loaded, modprobe is
not invoked again so the softdep isn't evaluated.

Add a workaround: If nf_logger_find_get() returns -ENOENT and call
is not via nft_compat, load the backend explicitly and try again.

Else, let nft_compat ask for deferred request_module via nf_tables
infra.

Softdeps are kept in-place, so with newer modprobe the dependencies
are resolved from userspace.

Fixes: cefa31a9d461 ("netfilter: nft_log: perform module load from nf_tables")
Fixes: a38b5b56d6f4 ("netfilter: nf_log: add module softdeps")
Reported-and-tested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_compat.c | 17 ++++++++++++++++-
 net/netfilter/xt_LOG.c     | 10 +++++++++-
 net/netfilter/xt_NFLOG.c   | 10 +++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 272bcdb1392d..f69cc73c5813 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -19,6 +19,7 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_arp/arp_tables.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/netfilter/nf_log.h>
 
 /* Used for matches where *info is larger than X byte */
 #define NFT_MATCH_LARGE_THRESH	192
@@ -257,8 +258,22 @@ nft_target_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	nft_compat_wait_for_destructors();
 
 	ret = xt_check_target(&par, size, proto, inv);
-	if (ret < 0)
+	if (ret < 0) {
+		if (ret == -ENOENT) {
+			const char *modname = NULL;
+
+			if (strcmp(target->name, "LOG") == 0)
+				modname = "nf_log_syslog";
+			else if (strcmp(target->name, "NFLOG") == 0)
+				modname = "nfnetlink_log";
+
+			if (modname &&
+			    nft_request_module(ctx->net, "%s", modname) == -EAGAIN)
+				return -EAGAIN;
+		}
+
 		return ret;
+	}
 
 	/* The standard target cannot be used */
 	if (!target->target)
diff --git a/net/netfilter/xt_LOG.c b/net/netfilter/xt_LOG.c
index 2ff75f7637b0..f39244f9c0ed 100644
--- a/net/netfilter/xt_LOG.c
+++ b/net/netfilter/xt_LOG.c
@@ -44,6 +44,7 @@ log_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int log_tg_check(const struct xt_tgchk_param *par)
 {
 	const struct xt_log_info *loginfo = par->targinfo;
+	int ret;
 
 	if (par->family != NFPROTO_IPV4 && par->family != NFPROTO_IPV6)
 		return -EINVAL;
@@ -58,7 +59,14 @@ static int log_tg_check(const struct xt_tgchk_param *par)
 		return -EINVAL;
 	}
 
-	return nf_logger_find_get(par->family, NF_LOG_TYPE_LOG);
+	ret = nf_logger_find_get(par->family, NF_LOG_TYPE_LOG);
+	if (ret != 0 && !par->nft_compat) {
+		request_module("%s", "nf_log_syslog");
+
+		ret = nf_logger_find_get(par->family, NF_LOG_TYPE_LOG);
+	}
+
+	return ret;
 }
 
 static void log_tg_destroy(const struct xt_tgdtor_param *par)
diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index fb5793208059..e660c3710a10 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -42,13 +42,21 @@ nflog_tg(struct sk_buff *skb, const struct xt_action_param *par)
 static int nflog_tg_check(const struct xt_tgchk_param *par)
 {
 	const struct xt_nflog_info *info = par->targinfo;
+	int ret;
 
 	if (info->flags & ~XT_NFLOG_MASK)
 		return -EINVAL;
 	if (info->prefix[sizeof(info->prefix) - 1] != '\0')
 		return -EINVAL;
 
-	return nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	ret = nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	if (ret != 0 && !par->nft_compat) {
+		request_module("%s", "nfnetlink_log");
+
+		ret = nf_logger_find_get(par->family, NF_LOG_TYPE_ULOG);
+	}
+
+	return ret;
 }
 
 static void nflog_tg_destroy(const struct xt_tgdtor_param *par)
-- 
2.30.2

