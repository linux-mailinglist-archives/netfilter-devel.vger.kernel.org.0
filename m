Return-Path: <netfilter-devel+bounces-2288-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A0B8CD1C6
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 May 2024 14:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F765282427
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 May 2024 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214DB13F44A;
	Thu, 23 May 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP35etOo"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9D13D88A;
	Thu, 23 May 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465994; cv=none; b=JygQmj/+hXB4Rh0B8DHpIYtDqZH3ceMEf9Z3hwhdz+3hRrmDk0mTotFw/JP7vu4S0HSfgmifApG6GHfHbTi+0vNTrwj05jVSDQsnb1yO9FY1xX2vQreZLZLoWiQwFYehpOdxG3kjicfWK141RbIgfMzc7LA+1fASFemluZQrT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465994; c=relaxed/simple;
	bh=jgJYIq/cbG2jNLL2jPMlz1UYJrIOF/DoaqycAwjl18w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZrUVw+9b8sOkfbi3qCo3WoEdFKR0knGlnuV4bnlsq4QIUqj3kvIwYjt0MjUMq+DP4P8Ht3uheULlkscZfq6kY8rjQxVtklabm++HetCL/A5nQ91c2SQ8ECI9edgPFtxZFclQWM7ZQ7nkrZBt2nmpEPAheLBGdHJjpoCdOqyMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP35etOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC5C32782;
	Thu, 23 May 2024 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716465993;
	bh=jgJYIq/cbG2jNLL2jPMlz1UYJrIOF/DoaqycAwjl18w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EP35etOogs89GbXgXnGT2f3+eWXR/2LkB1/MBA3XgG2Bjlu0esbd23tVMTjrauzqU
	 vQOEs9AfmWwjaclamtNqmJTyZ/+YAeXQ7NTBw3YSPaBU7rqNMISsbwdfEUepm2Z8+B
	 PKr9A7Q0Uc75YtEZhMVtSun03FjATLpC6D9t/B+veNdtwjfanEW+EkBoMNo7lt8YAx
	 /2LMaT2iOP9dn5r2KpLnPtGGsoLXNt1rzzdr8dZ5clQUGxnAhSoHxoHBuaKwfh12w6
	 7d3BdjC5oBG1B+osGKmtdXFSl/1zyduzwhfONj2LOSC8UDGzqjNEEAQJ7/0PwakIkV
	 9BSBqzxivRl/w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	lorenzo.bianconi@redhat.com,
	toke@redhat.com,
	fw@strlen.de,
	hawk@kernel.org,
	horms@kernel.org,
	donhunte@redhat.com,
	memxor@gmail.com
Subject: [PATCH v3 bpf-next 1/3] netfilter: nf_tables: add flowtable map for xdp offload
Date: Thu, 23 May 2024 14:06:16 +0200
Message-ID: <1925643414ddbea91659007826fd829f8aa56864.1716465377.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716465377.git.lorenzo@kernel.org>
References: <cover.1716465377.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

This adds a small internal mapping table so that a new bpf (xdp) kfunc
can perform lookups in a flowtable.

As-is, xdp program has access to the device pointer, but no way to do a
lookup in a flowtable -- there is no way to obtain the needed struct
without questionable stunts.

This allows to obtain an nf_flowtable pointer given a net_device
structure.

In order to keep backward compatibility, the infrastructure allows the
user to add a given device to multiple flowtables, but it will always
return the first added mapping performing the lookup since it assumes
the right configuration is 1:1 mapping between flowtables and net_devices.

Signed-off-by: Florian Westphal <fw@strlen.de>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/netfilter/nf_flow_table.h |   2 +
 net/netfilter/nf_flow_table_offload.c | 161 +++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 9abb7ee40d72f..0bbe6ea8e0651 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -305,6 +305,8 @@ struct flow_ports {
 	__be16 source, dest;
 };
 
+struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev);
+
 unsigned int nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state);
 unsigned int nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index a010b25076ca0..1acfcdbee42e8 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -17,6 +17,129 @@ static struct workqueue_struct *nf_flow_offload_add_wq;
 static struct workqueue_struct *nf_flow_offload_del_wq;
 static struct workqueue_struct *nf_flow_offload_stats_wq;
 
+struct flow_offload_xdp_ft {
+	struct list_head head;
+	struct nf_flowtable *ft;
+	struct rcu_head rcuhead;
+};
+
+struct flow_offload_xdp {
+	struct hlist_node hnode;
+	unsigned long net_device_addr;
+	struct list_head head;
+};
+
+#define NF_XDP_HT_BITS	4
+static DEFINE_HASHTABLE(nf_xdp_hashtable, NF_XDP_HT_BITS);
+static DEFINE_MUTEX(nf_xdp_hashtable_lock);
+
+/* caller must hold rcu read lock */
+struct nf_flowtable *nf_flowtable_by_dev(const struct net_device *dev)
+{
+	unsigned long key = (unsigned long)dev;
+	struct flow_offload_xdp *iter;
+
+	hash_for_each_possible_rcu(nf_xdp_hashtable, iter, hnode, key) {
+		if (key == iter->net_device_addr) {
+			struct flow_offload_xdp_ft *ft_elem;
+
+			/* The user is supposed to insert a given net_device
+			 * just into a single nf_flowtable so we always return
+			 * the first element here.
+			 */
+			ft_elem = list_first_or_null_rcu(&iter->head,
+							 struct flow_offload_xdp_ft,
+							 head);
+			return ft_elem ? ft_elem->ft : NULL;
+		}
+	}
+
+	return NULL;
+}
+
+static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
+				      const struct net_device *dev)
+{
+	struct flow_offload_xdp *iter, *elem = NULL;
+	unsigned long key = (unsigned long)dev;
+	struct flow_offload_xdp_ft *ft_elem;
+
+	ft_elem = kzalloc(sizeof(*ft_elem), GFP_KERNEL_ACCOUNT);
+	if (!ft_elem)
+		return -ENOMEM;
+
+	ft_elem->ft = ft;
+
+	mutex_lock(&nf_xdp_hashtable_lock);
+
+	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
+		if (key == iter->net_device_addr) {
+			elem = iter;
+			break;
+		}
+	}
+
+	if (!elem) {
+		elem = kzalloc(sizeof(*elem), GFP_KERNEL_ACCOUNT);
+		if (!elem)
+			goto err_unlock;
+
+		elem->net_device_addr = key;
+		INIT_LIST_HEAD(&elem->head);
+		hash_add_rcu(nf_xdp_hashtable, &elem->hnode, key);
+	}
+	list_add_tail_rcu(&ft_elem->head, &elem->head);
+
+	mutex_unlock(&nf_xdp_hashtable_lock);
+
+	return 0;
+
+err_unlock:
+	mutex_unlock(&nf_xdp_hashtable_lock);
+	kfree(ft_elem);
+
+	return -ENOMEM;
+}
+
+static void nf_flowtable_by_dev_remove(struct nf_flowtable *ft,
+				       const struct net_device *dev)
+{
+	struct flow_offload_xdp *iter, *elem = NULL;
+	unsigned long key = (unsigned long)dev;
+
+	mutex_lock(&nf_xdp_hashtable_lock);
+
+	hash_for_each_possible(nf_xdp_hashtable, iter, hnode, key) {
+		if (key == iter->net_device_addr) {
+			elem = iter;
+			break;
+		}
+	}
+
+	if (elem) {
+		struct flow_offload_xdp_ft *ft_elem, *ft_next;
+
+		list_for_each_entry_safe(ft_elem, ft_next, &elem->head, head) {
+			if (ft_elem->ft == ft) {
+				list_del_rcu(&ft_elem->head);
+				kfree_rcu(ft_elem, rcuhead);
+			}
+		}
+
+		if (list_empty(&elem->head))
+			hash_del_rcu(&elem->hnode);
+		else
+			elem = NULL;
+	}
+
+	mutex_unlock(&nf_xdp_hashtable_lock);
+
+	if (elem) {
+		synchronize_rcu();
+		kfree(elem);
+	}
+}
+
 struct flow_offload_work {
 	struct list_head	list;
 	enum flow_cls_command	cmd;
@@ -1183,6 +1306,38 @@ static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
 	return 0;
 }
 
+static int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
+				     struct net_device *dev,
+				     enum flow_block_command cmd)
+{
+	switch (cmd) {
+	case FLOW_BLOCK_BIND:
+		return nf_flowtable_by_dev_insert(flowtable, dev);
+	case FLOW_BLOCK_UNBIND:
+		nf_flowtable_by_dev_remove(flowtable, dev);
+		return 0;
+	}
+
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static void nf_flow_offload_xdp_cancel(struct nf_flowtable *flowtable,
+				       struct net_device *dev,
+				       enum flow_block_command cmd)
+{
+	switch (cmd) {
+	case FLOW_BLOCK_BIND:
+		nf_flowtable_by_dev_remove(flowtable, dev);
+		return;
+	case FLOW_BLOCK_UNBIND:
+		/* We do not re-bind in case hw offload would report error
+		 * on *unregister*.
+		 */
+		break;
+	}
+}
+
 int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 				struct net_device *dev,
 				enum flow_block_command cmd)
@@ -1192,7 +1347,7 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	int err;
 
 	if (!nf_flowtable_hw_offload(flowtable))
-		return 0;
+		return nf_flow_offload_xdp_setup(flowtable, dev, cmd);
 
 	if (dev->netdev_ops->ndo_setup_tc)
 		err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd,
@@ -1200,8 +1355,10 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	else
 		err = nf_flow_table_indr_offload_cmd(&bo, flowtable, dev, cmd,
 						     &extack);
-	if (err < 0)
+	if (err < 0) {
+		nf_flow_offload_xdp_cancel(flowtable, dev, cmd);
 		return err;
+	}
 
 	return nf_flow_table_block_setup(flowtable, &bo, cmd);
 }
-- 
2.45.1


