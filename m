Return-Path: <netfilter-devel+bounces-8592-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12BBB3DBF9
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Sep 2025 10:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115393B8886
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Sep 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913F2EF665;
	Mon,  1 Sep 2025 08:09:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E12EF647;
	Mon,  1 Sep 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714152; cv=none; b=TlNsy3vcMGzATdontBYbOxfUrvZEqSoQTMAs7dv/BXV+EetYRYUmBnrgDcwcpt7Exf9RUPwrqE3GKCpGBzX097JUyNkuHMh8w4/Hn87ljZ8HRXS0HW+VmtekxNHGquNjH1W7f9QqXX3hDtVi5Vx+zsfqdiOD+Qgh4oBXoJkRhqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714152; c=relaxed/simple;
	bh=JfPL21ohprPfrn5SL9nV8qYNl1rGABPc7jFJJaKe1Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYzchlMxqDuggfLykdcftvW1dzo27I/hlMYIw7PTD7mxskjPmYrx2xNX+h0MBpvPAAda3TWuSpsYSMt/efjfl3ew483/AI1nIMmcgpN03YprHAd3Dot1bQ8jMyOy7XJ8CfanR/etbYJXe0NkAKsEP0ZC47rtj+gkOKCfKm46jKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5287F60F59; Mon,  1 Sep 2025 10:09:09 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 5/8] netfilter: nf_tables: Introduce NFTA_DEVICE_PREFIX
Date: Mon,  1 Sep 2025 10:08:39 +0200
Message-ID: <20250901080843.1468-6-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901080843.1468-1-fw@strlen.de>
References: <20250901080843.1468-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

This new attribute is supposed to be used instead of NFTA_DEVICE_NAME
for simple wildcard interface specs. It holds a NUL-terminated string
representing an interface name prefix to match on.

While kernel code to distinguish full names from prefixes in
NFTA_DEVICE_NAME is simpler than this solution, reusing the existing
attribute with different semantics leads to confusion between different
versions of kernel and user space though:

* With old kernels, wildcards submitted by user space are accepted yet
  silently treated as regular names.
* With old user space, wildcards submitted by kernel may cause crashes
  since libnftnl expects NUL-termination when there is none.

Using a distinct attribute type sanitizes these situations as the
receiving part detects and rejects the unexpected attribute nested in
*_HOOK_DEVS attributes.

Fixes: 6d07a289504a ("netfilter: nf_tables: Support wildcard netdev hook specs")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c            | 42 +++++++++++++++++-------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 2beb30be2c5f..8e0eb832bc01 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1784,10 +1784,12 @@ enum nft_synproxy_attributes {
  * enum nft_device_attributes - nf_tables device netlink attributes
  *
  * @NFTA_DEVICE_NAME: name of this device (NLA_STRING)
+ * @NFTA_DEVICE_PREFIX: device name prefix, a simple wildcard (NLA_STRING)
  */
 enum nft_devices_attributes {
 	NFTA_DEVICE_UNSPEC,
 	NFTA_DEVICE_NAME,
+	NFTA_DEVICE_PREFIX,
 	__NFTA_DEVICE_MAX
 };
 #define NFTA_DEVICE_MAX		(__NFTA_DEVICE_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 54519b3d2868..68e273d8821a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1951,6 +1951,18 @@ static int nft_dump_stats(struct sk_buff *skb, struct nft_stats __percpu *stats)
 	return -ENOSPC;
 }
 
+static bool hook_is_prefix(struct nft_hook *hook)
+{
+	return strlen(hook->ifname) >= hook->ifnamelen;
+}
+
+static int nft_nla_put_hook_dev(struct sk_buff *skb, struct nft_hook *hook)
+{
+	int attr = hook_is_prefix(hook) ? NFTA_DEVICE_PREFIX : NFTA_DEVICE_NAME;
+
+	return nla_put_string(skb, attr, hook->ifname);
+}
+
 static int nft_dump_basechain_hook(struct sk_buff *skb,
 				   const struct net *net, int family,
 				   const struct nft_base_chain *basechain,
@@ -1982,16 +1994,15 @@ static int nft_dump_basechain_hook(struct sk_buff *skb,
 			if (!first)
 				first = hook;
 
-			if (nla_put(skb, NFTA_DEVICE_NAME,
-				    hook->ifnamelen, hook->ifname))
+			if (nft_nla_put_hook_dev(skb, hook))
 				goto nla_put_failure;
 			n++;
 		}
 		nla_nest_end(skb, nest_devs);
 
 		if (n == 1 &&
-		    nla_put(skb, NFTA_HOOK_DEV,
-			    first->ifnamelen, first->ifname))
+		    !hook_is_prefix(first) &&
+		    nla_put_string(skb, NFTA_HOOK_DEV, first->ifname))
 			goto nla_put_failure;
 	}
 	nla_nest_end(skb, nest);
@@ -2302,7 +2313,8 @@ void nf_tables_chain_destroy(struct nft_chain *chain)
 }
 
 static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
-					      const struct nlattr *attr)
+					      const struct nlattr *attr,
+					      bool prefix)
 {
 	struct nf_hook_ops *ops;
 	struct net_device *dev;
@@ -2319,7 +2331,8 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 	if (err < 0)
 		goto err_hook_free;
 
-	hook->ifnamelen = nla_len(attr);
+	/* include the terminating NUL-char when comparing non-prefixes */
+	hook->ifnamelen = strlen(hook->ifname) + !prefix;
 
 	/* nf_tables_netdev_event() is called under rtnl_mutex, this is
 	 * indirectly serializing all the other holders of the commit_mutex with
@@ -2366,14 +2379,22 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 	struct nft_hook *hook, *next;
 	const struct nlattr *tmp;
 	int rem, n = 0, err;
+	bool prefix;
 
 	nla_for_each_nested(tmp, attr, rem) {
-		if (nla_type(tmp) != NFTA_DEVICE_NAME) {
+		switch (nla_type(tmp)) {
+		case NFTA_DEVICE_NAME:
+			prefix = false;
+			break;
+		case NFTA_DEVICE_PREFIX:
+			prefix = true;
+			break;
+		default:
 			err = -EINVAL;
 			goto err_hook;
 		}
 
-		hook = nft_netdev_hook_alloc(net, tmp);
+		hook = nft_netdev_hook_alloc(net, tmp, prefix);
 		if (IS_ERR(hook)) {
 			NL_SET_BAD_ATTR(extack, tmp);
 			err = PTR_ERR(hook);
@@ -2419,7 +2440,7 @@ static int nft_chain_parse_netdev(struct net *net, struct nlattr *tb[],
 	int err;
 
 	if (tb[NFTA_HOOK_DEV]) {
-		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV]);
+		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV], false);
 		if (IS_ERR(hook)) {
 			NL_SET_BAD_ATTR(extack, tb[NFTA_HOOK_DEV]);
 			return PTR_ERR(hook);
@@ -9449,8 +9470,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 
 	list_for_each_entry_rcu(hook, hook_list, list,
 				lockdep_commit_lock_is_held(net)) {
-		if (nla_put(skb, NFTA_DEVICE_NAME,
-			    hook->ifnamelen, hook->ifname))
+		if (nft_nla_put_hook_dev(skb, hook))
 			goto nla_put_failure;
 	}
 	nla_nest_end(skb, nest_devs);
-- 
2.49.1


