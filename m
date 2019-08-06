Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB55582FBE
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Aug 2019 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbfHFK3z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Aug 2019 06:29:55 -0400
Received: from mx1.riseup.net ([198.252.153.129]:38892 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfHFK3z (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:29:55 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id DCC5B1B9298
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Aug 2019 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1565087394; bh=PTWyCLsJvvVRd6ExvngHCwwMWbvwWbGhAQBke+Yqb3c=;
        h=From:To:Cc:Subject:Date:From;
        b=XVbPNo07+P2oLSE+aIyfW6DdQY6OKbK0o436Gu2uhh+wVr0hqVhked8m1MfmNFQvW
         yA00bCox9ANuL4loM8PiQPkvKTn2awsEFDgusmIuKiB9cc0wrUFC7CQt9YuI6wCUvR
         0N+R6Zpl7VdCfRo5mnbN9kGHhlaO2dUhqqQXfifM=
X-Riseup-User-ID: C6F080D7B0299B8AAA5DE0044A05620A6E785AD5470A93CB11BF75BC9D22D662
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 1797512098F;
        Tue,  6 Aug 2019 03:29:53 -0700 (PDT)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH RFC nf-next] Introducing stateful object update operation
Date:   Tue,  6 Aug 2019 12:29:45 +0200
Message-Id: <20190806102945.728-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I have been thinking of a way to update a quota object. i.e raise or lower the
quota limit of an existing object. I think it would be ideal to implement the
operations of updating objects in the API in a generic way.

Therefore, we could easily give update support to each object type by adding an
update operation in the "nft_object_ops" struct. This is a conceptual patch so
it does not work.

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 include/net/netfilter/nf_tables.h        |  4 ++++
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c            | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 9b624566b82d..bd1e6c19d23f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1101,6 +1101,7 @@ struct nft_object_type {
  *	@eval: stateful object evaluation function
  *	@size: stateful object size
  *	@init: initialize object from netlink attributes
+ *	@update: update object from netlink attributes
  *	@destroy: release existing stateful object
  *	@dump: netlink dump stateful object
  */
@@ -1112,6 +1113,9 @@ struct nft_object_ops {
 	int				(*init)(const struct nft_ctx *ctx,
 						const struct nlattr *const tb[],
 						struct nft_object *obj);
+	int				(*update)(const struct nft_ctx *ctx,
+						  const struct nlattr *const tb[],
+						  struct nft_object *obj);
 	void				(*destroy)(const struct nft_ctx *ctx,
 						   struct nft_object *obj);
 	int				(*dump)(struct sk_buff *skb,
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 82abaa183fc3..8b0a012e9177 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -92,6 +92,7 @@ enum nft_verdicts {
  * @NFT_MSG_NEWOBJ: create a stateful object (enum nft_obj_attributes)
  * @NFT_MSG_GETOBJ: get a stateful object (enum nft_obj_attributes)
  * @NFT_MSG_DELOBJ: delete a stateful object (enum nft_obj_attributes)
+ * @NFT_MSG_UPDOBJ: update a stateful object (enum nft_obj_attributes)
  * @NFT_MSG_GETOBJ_RESET: get and reset a stateful object (enum nft_obj_attributes)
  * @NFT_MSG_NEWFLOWTABLE: add new flow table (enum nft_flowtable_attributes)
  * @NFT_MSG_GETFLOWTABLE: get flow table (enum nft_flowtable_attributes)
@@ -119,6 +120,7 @@ enum nf_tables_msg_types {
 	NFT_MSG_NEWOBJ,
 	NFT_MSG_GETOBJ,
 	NFT_MSG_DELOBJ,
+	NFT_MSG_UPDOBJ,
 	NFT_MSG_GETOBJ_RESET,
 	NFT_MSG_NEWFLOWTABLE,
 	NFT_MSG_GETFLOWTABLE,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 605a7cfe7ca7..c7267f418808 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5420,6 +5420,16 @@ static void nft_obj_destroy(const struct nft_ctx *ctx, struct nft_object *obj)
 	kfree(obj);
 }
 
+static int nf_tables_updobj(struct net *net, struct sock *nlsk,
+			    struct sk_buff *skb, const struct nlmsghdr *nlh,
+			    const struct nlattr * const nla[],
+			    struct netlink_ext_ack *extack)
+{
+	/* Placeholder function, here we would need to check if the object
+	 * exists. Then init the context and update the object.*/
+	return 1;
+}
+
 static int nf_tables_delobj(struct net *net, struct sock *nlsk,
 			    struct sk_buff *skb, const struct nlmsghdr *nlh,
 			    const struct nlattr * const nla[],
@@ -6323,6 +6333,11 @@ static const struct nfnl_callback nf_tables_cb[NFT_MSG_MAX] = {
 		.attr_count	= NFTA_OBJ_MAX,
 		.policy		= nft_obj_policy,
 	},
+	[NFT_MSG_UPDOBJ] = {
+		.call_rcu	= nf_tables_updobj,
+		.attr_count	= NFTA_OBJ_MAX,
+		.policy		= nft_obj_policy,
+	},
 	[NFT_MSG_DELOBJ] = {
 		.call_batch	= nf_tables_delobj,
 		.attr_count	= NFTA_OBJ_MAX,
@@ -6791,6 +6806,10 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 					     NFT_MSG_NEWOBJ);
 			nft_trans_destroy(trans);
 			break;
+		case NFT_MSG_UPDOBJ:
+			nf_tables_obj_notify(&trans->ctx, nft_trans_obj(trans),
+					     NFT_MSG_UPDOBJ);
+			break;
 		case NFT_MSG_DELOBJ:
 			nft_obj_del(nft_trans_obj(trans));
 			nf_tables_obj_notify(&trans->ctx, nft_trans_obj(trans),
@@ -6939,6 +6958,9 @@ static int __nf_tables_abort(struct net *net)
 			trans->ctx.table->use--;
 			nft_obj_del(nft_trans_obj(trans));
 			break;
+		case NFT_MSG_UPDOBJ:
+			nft_trans_destroy(trans);
+			break;
 		case NFT_MSG_DELOBJ:
 			trans->ctx.table->use++;
 			nft_clear(trans->ctx.net, nft_trans_obj(trans));
-- 
2.20.1

