Return-Path: <netfilter-devel+bounces-760-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98E83B1FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jan 2024 20:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C7EB238A0
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jan 2024 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D6132C07;
	Wed, 24 Jan 2024 19:12:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82912A161;
	Wed, 24 Jan 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123577; cv=none; b=foxW22k1BlcO8M7jMzVj+MnQr9TizDPFOBjz6HxtNA0ZtLZZmFvqnANlfk8d2/3YeQve8QtdxgBBP3Ilw4+Na7dxSGOsZ5vmzm2t7JPmZN8+2gWzOkRv9k4hJ0e1Kg+vgiuf4RpzT0SV5IPN9S0hAgH6SogNgdqLuQcSlxKkQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123577; c=relaxed/simple;
	bh=noOaV9W5kabxafYN7THKZ9w6GbWDAlZsy5YEvAmKphE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvXb3TE7EJRl2EvpR7grThtjjgRa26Yyvq75vKbTUUHfcqaD96jpw3zYy8g4p/3gcAl772lFSlZrROr3pJoOJAi6bY2s4wlQfERMGE9nSJFLdHd8uHtQQqvLrAAcky00+EoXoBJoDhoMzODwwsAAa5m3vhFjIBuSBza/NpjmoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 1/6] netfilter: nf_tables: cleanup documentation
Date: Wed, 24 Jan 2024 20:12:43 +0100
Message-Id: <20240124191248.75463-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124191248.75463-1-pablo@netfilter.org>
References: <20240124191248.75463-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George Guo <guodongtai@kylinos.cn>

- Correct comments for nlpid, family, udlen and udata in struct nft_table,
  and afinfo is no longer a member of enum nft_set_class.

- Add comment for data in struct nft_set_elem.

- Add comment for flags in struct nft_ctx.

- Add comments for timeout in struct nft_set_iter, and flags is not a
  member of struct nft_set_iter, remove the comment for it.

- Add comments for commit, abort, estimate and gc_init in struct
  nft_set_ops.

- Add comments for pending_update, num_exprs, exprs and catchall_list
  in struct nft_set.

- Add comment for ext_len in struct nft_set_ext_tmpl.

- Add comment for inner_ops in struct nft_expr_type.

- Add comments for clone, destroy_clone, reduce, gc, offload,
  offload_action, offload_stats in struct nft_expr_ops.

- Add comments for blob_gen_0, blob_gen_1, bound, genmask, udlen, udata,
  blob_next in struct nft_chain.

- Add comment for flags in struct nft_base_chain.

- Add comments for udlen, udata in struct nft_object.

- Add comment for type in struct nft_object_ops.

- Add comment for hook_list in struct nft_flowtable, and remove comments
  for dev_name and ops which are not members of struct nft_flowtable.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 49 ++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index b157c5cafd14..4e1ea18eb5f0 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -205,6 +205,7 @@ static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
  *	@nla: netlink attributes
  *	@portid: netlink portID of the original message
  *	@seq: netlink sequence number
+ *	@flags: modifiers to new request
  *	@family: protocol family
  *	@level: depth of the chains
  *	@report: notify via unicast netlink message
@@ -282,6 +283,7 @@ struct nft_elem_priv { };
  *
  *	@key: element key
  *	@key_end: closing element key
+ *	@data: element data
  *	@priv: element private data and extensions
  */
 struct nft_set_elem {
@@ -325,10 +327,10 @@ struct nft_set_iter {
  *	@dtype: data type
  *	@dlen: data length
  *	@objtype: object type
- *	@flags: flags
  *	@size: number of set elements
  *	@policy: set policy
  *	@gc_int: garbage collector interval
+ *	@timeout: element timeout
  *	@field_len: length of each field in concatenation, bytes
  *	@field_count: number of concatenated fields in element
  *	@expr: set must support for expressions
@@ -351,9 +353,9 @@ struct nft_set_desc {
 /**
  *	enum nft_set_class - performance class
  *
- *	@NFT_LOOKUP_O_1: constant, O(1)
- *	@NFT_LOOKUP_O_LOG_N: logarithmic, O(log N)
- *	@NFT_LOOKUP_O_N: linear, O(N)
+ *	@NFT_SET_CLASS_O_1: constant, O(1)
+ *	@NFT_SET_CLASS_O_LOG_N: logarithmic, O(log N)
+ *	@NFT_SET_CLASS_O_N: linear, O(N)
  */
 enum nft_set_class {
 	NFT_SET_CLASS_O_1,
@@ -422,9 +424,13 @@ struct nft_set_ext;
  *	@remove: remove element from set
  *	@walk: iterate over all set elements
  *	@get: get set elements
+ *	@commit: commit set elements
+ *	@abort: abort set elements
  *	@privsize: function to return size of set private data
+ *	@estimate: estimate the required memory size and the lookup complexity class
  *	@init: initialize private data of new set instance
  *	@destroy: destroy private data of set instance
+ *	@gc_init: initialize garbage collection
  *	@elemsize: element private size
  *
  *	Operations lookup, update and delete have simpler interfaces, are faster
@@ -540,13 +546,16 @@ struct nft_set_elem_expr {
  *	@policy: set parameterization (see enum nft_set_policies)
  *	@udlen: user data length
  *	@udata: user data
- *	@expr: stateful expression
+ *	@pending_update: list of pending update set element
  * 	@ops: set ops
  * 	@flags: set flags
  *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length
+ *	@num_exprs: numbers of exprs
+ *	@exprs: stateful expression
+ *	@catchall_list: list of catch-all set element
  * 	@data: private set data
  */
 struct nft_set {
@@ -692,6 +701,7 @@ extern const struct nft_set_ext_type nft_set_ext_types[];
  *
  *	@len: length of extension area
  *	@offset: offsets of individual extension types
+ *	@ext_len: length of the expected extension(used to sanity check)
  */
 struct nft_set_ext_tmpl {
 	u16	len;
@@ -840,6 +850,7 @@ struct nft_expr_ops;
  *	@select_ops: function to select nft_expr_ops
  *	@release_ops: release nft_expr_ops
  *	@ops: default ops, used when no select_ops functions is present
+ *	@inner_ops: inner ops, used for inner packet operation
  *	@list: used internally
  *	@name: Identifier
  *	@owner: module reference
@@ -881,14 +892,22 @@ struct nft_offload_ctx;
  *	struct nft_expr_ops - nf_tables expression operations
  *
  *	@eval: Expression evaluation function
+ *	@clone: Expression clone function
  *	@size: full expression size, including private data size
  *	@init: initialization function
  *	@activate: activate expression in the next generation
  *	@deactivate: deactivate expression in next generation
  *	@destroy: destruction function, called after synchronize_rcu
+ *	@destroy_clone: destruction clone function
  *	@dump: function to dump parameters
- *	@type: expression type
  *	@validate: validate expression, called during loop detection
+ *	@reduce: reduce expression
+ *	@gc: garbage collection expression
+ *	@offload: hardware offload expression
+ *	@offload_action: function to report true/false to allocate one slot or not in the flow
+ *			 offload array
+ *	@offload_stats: function to synchronize hardware stats via updating the counter expression
+ *	@type: expression type
  *	@data: extra data to attach to this expression operation
  */
 struct nft_expr_ops {
@@ -1041,14 +1060,21 @@ struct nft_rule_blob {
 /**
  *	struct nft_chain - nf_tables chain
  *
+ *	@blob_gen_0: rule blob pointer to the current generation
+ *	@blob_gen_1: rule blob pointer to the future generation
  *	@rules: list of rules in the chain
  *	@list: used internally
  *	@rhlhead: used internally
  *	@table: table that this chain belongs to
  *	@handle: chain handle
  *	@use: number of jump references to this chain
- *	@flags: bitmask of enum nft_chain_flags
+ *	@flags: bitmask of enum NFTA_CHAIN_FLAGS
+ *	@bound: bind or not
+ *	@genmask: generation mask
  *	@name: name of the chain
+ *	@udlen: user data length
+ *	@udata: user data in the chain
+ *	@blob_next: rule blob pointer to the next in the chain
  */
 struct nft_chain {
 	struct nft_rule_blob		__rcu *blob_gen_0;
@@ -1146,6 +1172,7 @@ struct nft_hook {
  *	@hook_list: list of netfilter hooks (for NFPROTO_NETDEV family)
  *	@type: chain type
  *	@policy: default policy
+ *	@flags: indicate the base chain disabled or not
  *	@stats: per-cpu chain stats
  *	@chain: the chain
  *	@flow_block: flow block (for hardware offload)
@@ -1274,11 +1301,13 @@ struct nft_object_hash_key {
  *	struct nft_object - nf_tables stateful object
  *
  *	@list: table stateful object list node
- *	@key:  keys that identify this object
  *	@rhlhead: nft_objname_ht node
+ *	@key: keys that identify this object
  *	@genmask: generation mask
  *	@use: number of references to this stateful object
  *	@handle: unique object handle
+ *	@udlen: length of user data
+ *	@udata: user data
  *	@ops: object operations
  *	@data: object data, layout depends on type
  */
@@ -1344,6 +1373,7 @@ struct nft_object_type {
  *	@destroy: release existing stateful object
  *	@dump: netlink dump stateful object
  *	@update: update stateful object
+ *	@type: pointer to object type
  */
 struct nft_object_ops {
 	void				(*eval)(struct nft_object *obj,
@@ -1379,9 +1409,8 @@ void nft_unregister_obj(struct nft_object_type *obj_type);
  *	@genmask: generation mask
  *	@use: number of references to this flow table
  * 	@handle: unique object handle
- *	@dev_name: array of device names
+ *	@hook_list: hook list for hooks per net_device in flowtables
  *	@data: rhashtable and garbage collector
- * 	@ops: array of hooks
  */
 struct nft_flowtable {
 	struct list_head		list;
-- 
2.30.2


