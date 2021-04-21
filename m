Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3236667F
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Apr 2021 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhDUHwO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Apr 2021 03:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbhDUHwK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:52:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19324C061344
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Apr 2021 00:51:37 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lZ7e3-0004tI-MH; Wed, 21 Apr 2021 09:51:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 12/12] netfilter: remove all xt_table anchors from struct net
Date:   Wed, 21 Apr 2021 09:51:10 +0200
Message-Id: <20210421075110.19334-13-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421075110.19334-1-fw@strlen.de>
References: <20210421075110.19334-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

No longer needed, table pointer arg is now passed via netfilter core.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netns/ipv4.h | 10 ----------
 include/net/netns/ipv6.h |  9 ---------
 2 files changed, 19 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 87e1612497ea..f6af8d96d3c6 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -76,16 +76,6 @@ struct netns_ipv4 {
 	struct inet_peer_base	*peers;
 	struct sock  * __percpu	*tcp_sk;
 	struct fqdir		*fqdir;
-#ifdef CONFIG_NETFILTER
-	struct xt_table		*iptable_filter;
-	struct xt_table		*iptable_mangle;
-	struct xt_table		*iptable_raw;
-	struct xt_table		*arptable_filter;
-#ifdef CONFIG_SECURITY
-	struct xt_table		*iptable_security;
-#endif
-	struct xt_table		*nat_table;
-#endif
 
 	u8 sysctl_icmp_echo_ignore_all;
 	u8 sysctl_icmp_echo_enable_probe;
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 808f0f79ea9c..6153c8067009 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -63,15 +63,6 @@ struct netns_ipv6 {
 	struct ipv6_devconf	*devconf_dflt;
 	struct inet_peer_base	*peers;
 	struct fqdir		*fqdir;
-#ifdef CONFIG_NETFILTER
-	struct xt_table		*ip6table_filter;
-	struct xt_table		*ip6table_mangle;
-	struct xt_table		*ip6table_raw;
-#ifdef CONFIG_SECURITY
-	struct xt_table		*ip6table_security;
-#endif
-	struct xt_table		*ip6table_nat;
-#endif
 	struct fib6_info	*fib6_null_entry;
 	struct rt6_info		*ip6_null_entry;
 	struct rt6_statistics   *rt6_stats;
-- 
2.26.3

