Return-Path: <netfilter-devel+bounces-7281-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3031AC11AD
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 May 2025 18:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB9500BAA
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 May 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5D2BCF44;
	Thu, 22 May 2025 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="sjuXKri8";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="pPz3dkff"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F912BCF5D;
	Thu, 22 May 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932821; cv=none; b=VND0wRNXyLkQVOOeuOZFmUcx9xkyNEz5CeEMvB4YqJUO4KyCEx6nLJyZoIDWgKL6jiCaXLUcgeSR+ifQ2TrCyiIOVE5iaTkJcyHiWqhZ/uvmZq6UWGQJVUmuKbNT6beMolNkLimtSMM2/fi9sHJ/icTdN6Tse+NocftDFLYnbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932821; c=relaxed/simple;
	bh=akmQfZtxug1Xuc8Rcs3EujP+W3DwveUlHhWCIZRtbLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2+YWbMSwGdvo8kJMyjbaqsxjMF9upRPWISB0KEb/3aZXFwyDXqQnGgBGmnd+dpZw2PmOBcI7oZxXcNmnchQg7Rg2x/NNKCMgTmC8LMrM/iPuxEfRhOfQtxTIDGQu+2ZRtSDWj8dGgc4ifUi+vO4R6lfRLkrCG7wSV8o6yLsimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=sjuXKri8; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pPz3dkff; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 0F0226070A; Thu, 22 May 2025 18:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747932819;
	bh=2ENakxRhxCR56K7BFbVOQ5fINz4/hQq94s/zhj+I2p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjuXKri8HoNm/mTU6OtuTsNC17gH0p4KQeRxc9I63aa8EYfm4EZ8Hubpa6ZoYj9zZ
	 zmryD5tJ6okKONRukRNV2ajoAng2yv0rtMiO2tZ+//GZpz9zkrmf7AMOzejahWpvFV
	 jfsjSdbevWIrZr2qz+1ci6oRxZY4ZItVoYl7wZ22cFlKJbuVF0wqk+M57xN1XizU5I
	 DXviRXi7f1jL/oPQYzllJFGzNjQazXItfDcn7zD7r5vAwf2g7JYVmVc1aMiuLVzwP2
	 Ueyj+m7p6R1wl3fhx6/CdbZ0GOOgOC8w0lLA3cWqi/v15IFlvehvr+aLIsWxjmtjSx
	 Oo3ClMS9ZCMiw==
X-Spam-Level: 
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id AB92D6073F;
	Thu, 22 May 2025 18:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1747932784;
	bh=2ENakxRhxCR56K7BFbVOQ5fINz4/hQq94s/zhj+I2p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPz3dkffxEEcpSO7M4oYrjd+Fsjt7UHchl/5hojUwpb3Sx+swBnJQQjjyM2dgr8DD
	 QFJjeomQ/RsKEo0/I2XJB/9s7kn/I/C+ZgsC89+UDKEgCScjhCl/viT7rzcO6BSHJn
	 LZQgzAaFBWj8F6qDbnJBAIQZlA+6tfcCZoj0nCyqbzfjX4mTqkJWFC/79Tfg3My4mX
	 OlKrMxTAV4Qi24plKi4t+7P3DlhXAML6bacXxl7UwW1dmmFZJwT09ZlZLT0C8p2Orr
	 GAiB2MQ+755tPWpF+mSpy0izWQec6HDZRYMlvoYNajAnQQymYYlVqrSfNOov3u2na1
	 pAc4A4mzzNosQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 25/26] netfilter: nf_tables: Add notifications for hook changes
Date: Thu, 22 May 2025 18:52:37 +0200
Message-Id: <20250522165238.378456-26-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250522165238.378456-1-pablo@netfilter.org>
References: <20250522165238.378456-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

Notify user space if netdev hooks are updated due to netdev add/remove
events. Send minimal notification messages by introducing
NFT_MSG_NEWDEV/DELDEV message types describing a single device only.

Upon NETDEV_CHANGENAME, the callback has no information about the
interface's old name. To provide a clear message to user space, include
the hook's stored interface name in the notification.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h        |  5 ++
 include/uapi/linux/netfilter/nf_tables.h | 10 ++++
 include/uapi/linux/netfilter/nfnetlink.h |  2 +
 net/netfilter/nf_tables_api.c            | 59 ++++++++++++++++++++++++
 net/netfilter/nfnetlink.c                |  1 +
 net/netfilter/nft_chain_filter.c         |  2 +
 6 files changed, 79 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 5e49619ae49c..e4d8e451e935 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1142,6 +1142,11 @@ int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set);
 int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
 void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
 
+struct nft_hook;
+void nf_tables_chain_device_notify(const struct nft_chain *chain,
+				   const struct nft_hook *hook,
+				   const struct net_device *dev, int event);
+
 enum nft_chain_types {
 	NFT_CHAIN_T_DEFAULT = 0,
 	NFT_CHAIN_T_ROUTE,
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 2beb30be2c5f..518ba144544c 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -142,6 +142,8 @@ enum nf_tables_msg_types {
 	NFT_MSG_DESTROYOBJ,
 	NFT_MSG_DESTROYFLOWTABLE,
 	NFT_MSG_GETSETELEM_RESET,
+	NFT_MSG_NEWDEV,
+	NFT_MSG_DELDEV,
 	NFT_MSG_MAX,
 };
 
@@ -1784,10 +1786,18 @@ enum nft_synproxy_attributes {
  * enum nft_device_attributes - nf_tables device netlink attributes
  *
  * @NFTA_DEVICE_NAME: name of this device (NLA_STRING)
+ * @NFTA_DEVICE_TABLE: table containing the flowtable or chain hooking into the device (NLA_STRING)
+ * @NFTA_DEVICE_FLOWTABLE: flowtable hooking into the device (NLA_STRING)
+ * @NFTA_DEVICE_CHAIN: chain hooking into the device (NLA_STRING)
+ * @NFTA_DEVICE_SPEC: hook spec matching the device (NLA_STRING)
  */
 enum nft_devices_attributes {
 	NFTA_DEVICE_UNSPEC,
 	NFTA_DEVICE_NAME,
+	NFTA_DEVICE_TABLE,
+	NFTA_DEVICE_FLOWTABLE,
+	NFTA_DEVICE_CHAIN,
+	NFTA_DEVICE_SPEC,
 	__NFTA_DEVICE_MAX
 };
 #define NFTA_DEVICE_MAX		(__NFTA_DEVICE_MAX - 1)
diff --git a/include/uapi/linux/netfilter/nfnetlink.h b/include/uapi/linux/netfilter/nfnetlink.h
index 6cd58cd2a6f0..50d807af2649 100644
--- a/include/uapi/linux/netfilter/nfnetlink.h
+++ b/include/uapi/linux/netfilter/nfnetlink.h
@@ -25,6 +25,8 @@ enum nfnetlink_groups {
 #define NFNLGRP_ACCT_QUOTA		NFNLGRP_ACCT_QUOTA
 	NFNLGRP_NFTRACE,
 #define NFNLGRP_NFTRACE			NFNLGRP_NFTRACE
+	NFNLGRP_NFT_DEV,
+#define NFNLGRP_NFT_DEV			NFNLGRP_NFT_DEV
 	__NFNLGRP_MAX,
 };
 #define NFNLGRP_MAX	(__NFNLGRP_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a7240736f98e..24c71ecb2179 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9686,6 +9686,64 @@ struct nf_hook_ops *nft_hook_find_ops_rcu(const struct nft_hook *hook,
 }
 EXPORT_SYMBOL_GPL(nft_hook_find_ops_rcu);
 
+static void
+nf_tables_device_notify(const struct nft_table *table, int attr,
+			const char *name, const struct nft_hook *hook,
+			const struct net_device *dev, int event)
+{
+	struct net *net = dev_net(dev);
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+	u16 flags = 0;
+
+	if (!nfnetlink_has_listeners(net, NFNLGRP_NFT_DEV))
+		return;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		goto err;
+
+	event = event == NETDEV_REGISTER ? NFT_MSG_NEWDEV : NFT_MSG_DELDEV;
+	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
+	nlh = nfnl_msg_put(skb, 0, 0, event, flags, table->family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
+		goto err;
+
+	if (nla_put_string(skb, NFTA_DEVICE_TABLE, table->name) ||
+	    nla_put_string(skb, attr, name) ||
+	    nla_put(skb, NFTA_DEVICE_SPEC, hook->ifnamelen, hook->ifname) ||
+	    nla_put_string(skb, NFTA_DEVICE_NAME, dev->name))
+		goto err;
+
+	nlmsg_end(skb, nlh);
+	nfnetlink_send(skb, net, 0, NFNLGRP_NFT_DEV,
+		       nlmsg_report(nlh), GFP_KERNEL);
+	return;
+err:
+	if (skb)
+		kfree_skb(skb);
+	nfnetlink_set_err(net, 0, NFNLGRP_NFT_DEV, -ENOBUFS);
+}
+
+void
+nf_tables_chain_device_notify(const struct nft_chain *chain,
+			      const struct nft_hook *hook,
+			      const struct net_device *dev, int event)
+{
+	nf_tables_device_notify(chain->table, NFTA_DEVICE_CHAIN,
+				chain->name, hook, dev, event);
+}
+
+static void
+nf_tables_flowtable_device_notify(const struct nft_flowtable *ft,
+				  const struct nft_hook *hook,
+				  const struct net_device *dev, int event)
+{
+	nf_tables_device_notify(ft->table, NFTA_DEVICE_FLOWTABLE,
+				ft->name, hook, dev, event);
+}
+
 static int nft_flowtable_event(unsigned long event, struct net_device *dev,
 			       struct nft_flowtable *flowtable, bool changename)
 {
@@ -9733,6 +9791,7 @@ static int nft_flowtable_event(unsigned long event, struct net_device *dev,
 			list_add_tail_rcu(&ops->list, &hook->ops_list);
 			break;
 		}
+		nf_tables_flowtable_device_notify(flowtable, hook, dev, event);
 		break;
 	}
 	return 0;
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index e598a2a252b0..ac77fc21632d 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -86,6 +86,7 @@ static const int nfnl_group2type[NFNLGRP_MAX+1] = {
 	[NFNLGRP_NFTABLES]		= NFNL_SUBSYS_NFTABLES,
 	[NFNLGRP_ACCT_QUOTA]		= NFNL_SUBSYS_ACCT,
 	[NFNLGRP_NFTRACE]		= NFNL_SUBSYS_NFTABLES,
+	[NFNLGRP_NFT_DEV]		= NFNL_SUBSYS_NFTABLES,
 };
 
 static struct nfnl_net *nfnl_pernet(struct net *net)
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd..846d48ba8965 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -363,6 +363,8 @@ static int nft_netdev_event(unsigned long event, struct net_device *dev,
 			list_add_tail_rcu(&ops->list, &hook->ops_list);
 			break;
 		}
+		nf_tables_chain_device_notify(&basechain->chain,
+					      hook, dev, event);
 		break;
 	}
 	return 0;
-- 
2.30.2


