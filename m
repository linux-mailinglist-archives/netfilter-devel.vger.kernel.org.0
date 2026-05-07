Return-Path: <netfilter-devel+bounces-12478-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G7VNV9e/Gm7OwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12478-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 07 May 2026 11:41:51 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0384E6285
	for <lists+netfilter-devel@lfdr.de>; Thu, 07 May 2026 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2220830CA45A
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 May 2026 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC23CAE70;
	Thu,  7 May 2026 09:34:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C053C65F4
	for <netfilter-devel@vger.kernel.org>; Thu,  7 May 2026 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146467; cv=none; b=tLneVwshyMJkI7P2kNuyNj3Swr6L8WOKlX4odbScmN45I9Y16v4WRZ83hQI8CRPQTKcqO1n5i6mz1RoDp3qnZFpNMYQAPPGKjIUIuDEf1q3jkIWwTDBWb40/ramIzsNA7MotJVx+VkYOFtg6DY7bkMXBZndc7XkAg74iwI+Jucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146467; c=relaxed/simple;
	bh=ZPCpreWxkTckdWroQC4EmllguCRWJYt+Y+X99cw/zbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RT/98iUClGehBKvBqmW+KsQOQBdf3Qgs0JshO9n9EEzncSozgcSODjSmVwnCFhUm/3ZqyyCyW4cJf5yEWMHpmBx82C7NUe+rPWWLX0QSle3FUmWxk5tAQ3PjfiAvNQyg6DnQG+HUd1/GBqneW6PBrmIYnzrZQ3pZW5iSkzfliRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6E1EC60D41; Thu, 07 May 2026 11:34:23 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: add option for GCOV profiling
Date: Thu,  7 May 2026 11:34:15 +0200
Message-ID: <20260507093418.29858-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D0384E6285
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-12478-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Action: no action

Similar to a few other subsystems: add a new config toggle to
enable netfilter gcov profiling in netfilter, including ebtables,
arptables and so on.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 NB: This doesn't enable profiling for br_netfilter kludge,
 because it resides in net/bridge/ dir.  As I'm not interested
 in extending coverage for that thing I did not extend this.

 net/bridge/netfilter/Makefile | 4 ++++
 net/ipv4/netfilter/Makefile   | 4 ++++
 net/ipv6/netfilter/Makefile   | 4 ++++
 net/netfilter/Kconfig         | 8 ++++++++
 net/netfilter/Makefile        | 4 ++++
 5 files changed, 24 insertions(+)

diff --git a/net/bridge/netfilter/Makefile b/net/bridge/netfilter/Makefile
index b9a1303da977..af0c903aa4ac 100644
--- a/net/bridge/netfilter/Makefile
+++ b/net/bridge/netfilter/Makefile
@@ -38,3 +38,7 @@ obj-$(CONFIG_BRIDGE_EBT_SNAT) += ebt_snat.o
 # watchers
 obj-$(CONFIG_BRIDGE_EBT_LOG) += ebt_log.o
 obj-$(CONFIG_BRIDGE_EBT_NFLOG) += ebt_nflog.o
+
+ifdef CONFIG_GCOV_PROFILE_NETFILTER
+GCOV_PROFILE := y
+endif
diff --git a/net/ipv4/netfilter/Makefile b/net/ipv4/netfilter/Makefile
index 85502d4dfbb4..dbfb1c4739a8 100644
--- a/net/ipv4/netfilter/Makefile
+++ b/net/ipv4/netfilter/Makefile
@@ -51,3 +51,7 @@ obj-$(CONFIG_IP_NF_ARP_MANGLE) += arpt_mangle.o
 obj-$(CONFIG_IP_NF_ARPFILTER) += arptable_filter.o
 
 obj-$(CONFIG_NF_DUP_IPV4) += nf_dup_ipv4.o
+
+ifdef CONFIG_GCOV_PROFILE_NETFILTER
+GCOV_PROFILE := y
+endif
diff --git a/net/ipv6/netfilter/Makefile b/net/ipv6/netfilter/Makefile
index 66ce6fa5b2f5..72902d8005ad 100644
--- a/net/ipv6/netfilter/Makefile
+++ b/net/ipv6/netfilter/Makefile
@@ -43,3 +43,7 @@ obj-$(CONFIG_IP6_NF_MATCH_SRH) += ip6t_srh.o
 obj-$(CONFIG_IP6_NF_TARGET_NPT) += ip6t_NPT.o
 obj-$(CONFIG_IP6_NF_TARGET_REJECT) += ip6t_REJECT.o
 obj-$(CONFIG_IP6_NF_TARGET_SYNPROXY) += ip6t_SYNPROXY.o
+
+ifdef CONFIG_GCOV_PROFILE_NETFILTER
+GCOV_PROFILE := y
+endif
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 682c675125fc..a3b844421515 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -1648,6 +1648,14 @@ config NETFILTER_XT_MATCH_U32
 
 endif # NETFILTER_XTABLES
 
+config GCOV_PROFILE_NETFILTER
+	bool "Enable GCOV profiling for netilter"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling for netfilter for checking which functions/lines
+	  are executed.
+
+	  If unsure, say N.
 endmenu
 
 source "net/netfilter/ipset/Kconfig"
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 6bfc250e474f..f0751ca302c6 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -240,3 +240,7 @@ obj-$(CONFIG_IP_VS) += ipvs/
 
 # lwtunnel
 obj-$(CONFIG_LWTUNNEL) += nf_hooks_lwtunnel.o
+
+ifdef CONFIG_GCOV_PROFILE_NETFILTER
+GCOV_PROFILE := y
+endif
-- 
2.53.0


