Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E63507EF
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhCaULa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhCaULL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:11:11 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F839C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Mar 2021 13:11:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lRhBG-0005B5-3e; Wed, 31 Mar 2021 22:11:10 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 11/11] net: remove obsolete members from struct net
Date:   Wed, 31 Mar 2021 22:10:14 +0200
Message-Id: <20210331201014.23293-12-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210331201014.23293-1-fw@strlen.de>
References: <20210331201014.23293-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

all have been moved to generic_net infra. On x86_64, this reduces
struct net size from 70 to 63 cache lines (4480 to 4032 byte).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/net_namespace.h   | 9 ---------
 include/net/netns/conntrack.h | 4 ----
 include/net/netns/netfilter.h | 6 ------
 include/net/netns/nftables.h  | 7 -------
 include/net/netns/x_tables.h  | 1 -
 5 files changed, 27 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index dcaee24a4d87..fdb16dc33703 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -142,15 +142,6 @@ struct net {
 #if defined(CONFIG_NF_TABLES) || defined(CONFIG_NF_TABLES_MODULE)
 	struct netns_nftables	nft;
 #endif
-#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
-	struct netns_nf_frag	nf_frag;
-	struct ctl_table_header *nf_frag_frags_hdr;
-#endif
-	struct sock		*nfnl;
-	struct sock		*nfnl_stash;
-#if IS_ENABLED(CONFIG_NF_CT_NETLINK_TIMEOUT)
-	struct list_head	nfct_timeout_list;
-#endif
 #endif
 #ifdef CONFIG_WEXT_CORE
 	struct sk_buff_head	wext_nlevents;
diff --git a/include/net/netns/conntrack.h b/include/net/netns/conntrack.h
index 806454e767bf..e5f664d69ead 100644
--- a/include/net/netns/conntrack.h
+++ b/include/net/netns/conntrack.h
@@ -96,13 +96,9 @@ struct netns_ct {
 	atomic_t		count;
 	unsigned int		expect_count;
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-	struct delayed_work ecache_dwork;
 	bool ecache_dwork_pending;
 #endif
 	bool			auto_assign_helper_warned;
-#ifdef CONFIG_SYSCTL
-	struct ctl_table_header	*sysctl_header;
-#endif
 	unsigned int		sysctl_log_invalid; /* Log invalid packets */
 	int			sysctl_events;
 	int			sysctl_acct;
diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
index ca043342c0eb..15e2b13fb0c0 100644
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -28,11 +28,5 @@ struct netns_nf {
 #if IS_ENABLED(CONFIG_DECNET)
 	struct nf_hook_entries __rcu *hooks_decnet[NF_DN_NUMHOOKS];
 #endif
-#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
-	bool			defrag_ipv4;
-#endif
-#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
-	bool			defrag_ipv6;
-#endif
 };
 #endif
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 6c0806bd8d1e..8c77832d0240 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -5,14 +5,7 @@
 #include <linux/list.h>
 
 struct netns_nftables {
-	struct list_head	tables;
-	struct list_head	commit_list;
-	struct list_head	module_list;
-	struct list_head	notify_list;
-	struct mutex		commit_mutex;
-	unsigned int		base_seq;
 	u8			gencursor;
-	u8			validate_state;
 };
 
 #endif
diff --git a/include/net/netns/x_tables.h b/include/net/netns/x_tables.h
index 9bc5a12fdbb0..83c8ea2e87a6 100644
--- a/include/net/netns/x_tables.h
+++ b/include/net/netns/x_tables.h
@@ -8,7 +8,6 @@
 struct ebt_table;
 
 struct netns_xt {
-	struct list_head tables[NFPROTO_NUMPROTO];
 	bool notrack_deprecated_warning;
 	bool clusterip_deprecated_warning;
 #if defined(CONFIG_BRIDGE_NF_EBTABLES) || \
-- 
2.26.3

