Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5B3DA788
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jul 2021 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbhG2PZR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Jul 2021 11:25:17 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21534 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbhG2PZP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627572165; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jhkmqTRjGd52ZhLUQeqGsRGIg3/auTMUUdmKUQD2hPEEFMTu5Bt9nfyPlTtfKroJZGnVuTO02n8+snoHGdy8Hd9NZiTGsJB7FDuAWi6IR3lbTkXhzuRhVdIsQJIjePY1umXDyfPlL4tZUotApYBTV4Kar+D56jIL53Gms6t32TE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627572165; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=h32FgQR1FyHKdL2NEJQZPRS68BEOl1ffiItsfhciJvo=; 
        b=lbbI45ftDqcCgPY1S19OsTgOFEjRIum8xIRMcCzwu9G/DvVka/1rNJdqGCUwzS0+6VJv0lvGo2JRB5PjDzdquz9XU/3i9i216gez4kjIF+zWU5gP21V+UogE6pBey3bpuVN3l4K29igSygevXELAYrY/YlPrJkH52QFfp0Rr6D8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=proelbtn.com;
        spf=pass  smtp.mailfrom=contact@proelbtn.com;
        dmarc=pass header.from=<contact@proelbtn.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627572165;
        s=default; d=proelbtn.com; i=contact@proelbtn.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=h32FgQR1FyHKdL2NEJQZPRS68BEOl1ffiItsfhciJvo=;
        b=CGoSVsSqOB1sYGkAM/1vCqoUptXnbKoGdalsg11Jmse696ixUhZei9mJRtf1jN8X
        fvxGJo31IVyXLsfGmi0e1sReuZIaSoKIXf6bL9w8P7DtM4xys08jYUwNXnS2Rxa13yM
        K4jVrP6shRsWC0DmiDGJbzvmMq9AsnQ2M6xSeKX4=
Received: from srv6.prochi.io (softbank060108183144.bbtec.net [60.108.183.144]) by mx.zohomail.com
        with SMTPS id 1627572164544562.4707704223355; Thu, 29 Jul 2021 08:22:44 -0700 (PDT)
From:   Ryoga Saito <contact@proelbtn.com>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org, stefano.salsano@uniroma2.it,
        andrea.mayer@uniroma2.it, davem@davemloft.net, kuba@kernel.org,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        Ryoga Saito <contact@proelbtn.com>
Subject: [PATCH v3 1/2] netfilter: add new sysctl toggle for lightweight tunnel netfilter hooks
Date:   Thu, 29 Jul 2021 15:22:33 +0000
Message-Id: <7369c6af9a8190f08ede4e936b505b6eedc871a6.1627571302.git.contact@proelbtn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627571302.git.contact@proelbtn.com>
References: <cover.1627571302.git.contact@proelbtn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch introduces new sysctl toggle for enabling lightweight tunnel
netfilter hooks.

Signed-off-by: Ryoga Saito <contact@proelbtn.com>
---
 .../networking/nf_conntrack-sysctl.rst        |  7 +++
 include/net/lwtunnel.h                        |  2 +
 include/net/netfilter/nf_conntrack.h          |  4 ++
 net/core/lwtunnel.c                           |  3 ++
 net/netfilter/Makefile                        |  2 +-
 net/netfilter/nf_conntrack_lwtunnel.c         | 52 +++++++++++++++++++
 net/netfilter/nf_conntrack_standalone.c       |  8 +++
 7 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 net/netfilter/nf_conntrack_lwtunnel.c

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index d31ed6c1cb0d..5afa4603aa4b 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -30,6 +30,13 @@ nf_conntrack_checksum - BOOLEAN
 	in INVALID state. If this is enabled, such packets will not be
 	considered for connection tracking.
 
+nf_conntrack_lwtunnel - BOOLEAN
+	- 0 - disabled (default)
+	- not 0 - enabled
+
+	If this option is enabled, the lightweight tunnel netfilter hooks are
+	enabled. This option cannot be disabled once it is enabled.
+
 nf_conntrack_count - INTEGER (read-only)
 	Number of currently allocated flow entries.
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 05cfd6ff6528..c6029f7eec14 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -51,6 +51,8 @@ struct lwtunnel_encap_ops {
 };
 
 #ifdef CONFIG_LWTUNNEL
+DECLARE_STATIC_KEY_FALSE(nf_ct_lwtunnel_enabled);
+
 void lwtstate_free(struct lwtunnel_state *lws);
 
 static inline struct lwtunnel_state *
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index cc663c68ddc4..d2a74fc75346 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -360,4 +360,8 @@ static inline struct nf_conntrack_net *nf_ct_pernet(const struct net *net)
 #define MODULE_ALIAS_NFCT_HELPER(helper) \
         MODULE_ALIAS("nfct-helper-" helper)
 
+int nf_conntrack_lwtunnel_sysctl_handler(struct ctl_table *table, int write,
+					 void *buffer, size_t *lenp,
+					 loff_t *ppos);
+
 #endif /* _NF_CONNTRACK_H */
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 8ec7d13d2860..8be3274e30ec 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -23,6 +23,9 @@
 #include <net/ip6_fib.h>
 #include <net/rtnh.h>
 
+DEFINE_STATIC_KEY_FALSE(nf_ct_lwtunnel_enabled);
+EXPORT_SYMBOL_GPL(nf_ct_lwtunnel_enabled);
+
 #ifdef CONFIG_MODULES
 
 static const char *lwtunnel_encap_str(enum lwtunnel_encap_types encap_type)
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 049890e00a3d..dd784b872c61 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -4,7 +4,7 @@ netfilter-objs := core.o nf_log.o nf_queue.o nf_sockopt.o utils.o
 nf_conntrack-y	:= nf_conntrack_core.o nf_conntrack_standalone.o nf_conntrack_expect.o nf_conntrack_helper.o \
 		   nf_conntrack_proto.o nf_conntrack_proto_generic.o nf_conntrack_proto_tcp.o nf_conntrack_proto_udp.o \
 		   nf_conntrack_proto_icmp.o \
-		   nf_conntrack_extend.o nf_conntrack_acct.o nf_conntrack_seqadj.o
+		   nf_conntrack_extend.o nf_conntrack_acct.o nf_conntrack_seqadj.o nf_conntrack_lwtunnel.o
 
 nf_conntrack-$(subst m,y,$(CONFIG_IPV6)) += nf_conntrack_proto_icmpv6.o
 nf_conntrack-$(CONFIG_NF_CONNTRACK_TIMEOUT) += nf_conntrack_timeout.o
diff --git a/net/netfilter/nf_conntrack_lwtunnel.c b/net/netfilter/nf_conntrack_lwtunnel.c
new file mode 100644
index 000000000000..cddbf8c5883a
--- /dev/null
+++ b/net/netfilter/nf_conntrack_lwtunnel.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/sysctl.h>
+#include <net/lwtunnel.h>
+#include <net/netfilter/nf_conntrack.h>
+
+static inline int nf_conntrack_lwtunnel_get(void)
+{
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
+		return 1;
+	else
+		return 0;
+}
+
+static inline int nf_conntrack_lwtunnel_set(int enable)
+{
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled)) {
+		if (!enable)
+			return -EPERM;
+	} else if (enable) {
+		static_branch_enable(&nf_ct_lwtunnel_enabled);
+	}
+
+	return 0;
+}
+
+int nf_conntrack_lwtunnel_sysctl_handler(struct ctl_table *table, int write,
+					 void *buffer, size_t *lenp,
+					 loff_t *ppos)
+{
+	int proc_nf_ct_lwtunnel_enabled = 0;
+	struct ctl_table tmp = {
+		.procname = table->procname,
+		.data = &proc_nf_ct_lwtunnel_enabled,
+		.maxlen = sizeof(int),
+		.mode = table->mode,
+		.extra1 = SYSCTL_ZERO,
+		.extra2 = SYSCTL_ONE,
+	};
+	int ret;
+
+	if (!write)
+		proc_nf_ct_lwtunnel_enabled = nf_conntrack_lwtunnel_get();
+
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+
+	if (write && ret == 0)
+		ret = nf_conntrack_lwtunnel_set(proc_nf_ct_lwtunnel_enabled);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nf_conntrack_lwtunnel_sysctl_handler);
\ No newline at end of file
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 214d9f9e499b..f20568496ef0 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -552,6 +552,7 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_COUNT,
 	NF_SYSCTL_CT_BUCKETS,
 	NF_SYSCTL_CT_CHECKSUM,
+	NF_SYSCTL_CT_LWTUNNEL,
 	NF_SYSCTL_CT_LOG_INVALID,
 	NF_SYSCTL_CT_EXPECT_MAX,
 	NF_SYSCTL_CT_ACCT,
@@ -650,6 +651,13 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.extra1 	= SYSCTL_ZERO,
 		.extra2 	= SYSCTL_ONE,
 	},
+	[NF_SYSCTL_CT_LWTUNNEL] = {
+		.procname	= "nf_conntrack_lwtunnel",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= nf_conntrack_lwtunnel_sysctl_handler,
+	},
 	[NF_SYSCTL_CT_LOG_INVALID] = {
 		.procname	= "nf_conntrack_log_invalid",
 		.data		= &init_net.ct.sysctl_log_invalid,
-- 
2.25.1

