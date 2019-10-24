Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9771BE2CF6
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfJXJPK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 05:15:10 -0400
Received: from correo.us.es ([193.147.175.20]:50382 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfJXJPK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:15:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 45D972EFEB1
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:05 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 36AB0B8009
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:05 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2C36EB7FF9; Thu, 24 Oct 2019 11:15:05 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B6EAE66DF
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:02 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 24 Oct 2019 11:15:02 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 9C04F42EE395
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:02 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/3] netfilter: nf_tables_offload: add nft_flow_block_offload_init()
Date:   Thu, 24 Oct 2019 11:14:59 +0200
Message-Id: <20191024091500.2074-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191024091500.2074-1-pablo@netfilter.org>
References: <20191024091500.2074-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds the nft_flow_block_offload_init() helper function to
initialize the flow_block_offload object.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 70f50d306799..d51728affa1c 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -246,20 +246,30 @@ static int nft_block_setup(struct nft_base_chain *basechain,
 	return err;
 }
 
+static void nft_flow_block_offload_init(struct flow_block_offload *bo,
+					struct net *net,
+					enum flow_block_command cmd,
+					struct nft_base_chain *basechain,
+					struct netlink_ext_ack *extack)
+{
+	memset(bo, 0, sizeof(*bo));
+	bo->net		= net;
+	bo->block	= &basechain->flow_block;
+	bo->command	= cmd;
+	bo->binder_type	= FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
+	bo->extack	= extack;
+	INIT_LIST_HEAD(&bo->cb_list);
+}
+
 static int nft_block_offload_cmd(struct nft_base_chain *chain,
 				 struct net_device *dev,
 				 enum flow_block_command cmd)
 {
 	struct netlink_ext_ack extack = {};
-	struct flow_block_offload bo = {};
+	struct flow_block_offload bo;
 	int err;
 
-	bo.net = dev_net(dev);
-	bo.block = &chain->flow_block;
-	bo.command = cmd;
-	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
-	bo.extack = &extack;
-	INIT_LIST_HEAD(&bo.cb_list);
+	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
 	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 	if (err < 0)
@@ -275,17 +285,12 @@ static void nft_indr_block_ing_cmd(struct net_device *dev,
 				   enum flow_block_command cmd)
 {
 	struct netlink_ext_ack extack = {};
-	struct flow_block_offload bo = {};
+	struct flow_block_offload bo;
 
 	if (!chain)
 		return;
 
-	bo.net = dev_net(dev);
-	bo.block = &chain->flow_block;
-	bo.command = cmd;
-	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
-	bo.extack = &extack;
-	INIT_LIST_HEAD(&bo.cb_list);
+	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
 	cb(dev, cb_priv, TC_SETUP_BLOCK, &bo);
 
@@ -296,15 +301,10 @@ static int nft_indr_block_offload_cmd(struct nft_base_chain *chain,
 				      struct net_device *dev,
 				      enum flow_block_command cmd)
 {
-	struct flow_block_offload bo = {};
 	struct netlink_ext_ack extack = {};
+	struct flow_block_offload bo;
 
-	bo.net = dev_net(dev);
-	bo.block = &chain->flow_block;
-	bo.command = cmd;
-	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
-	bo.extack = &extack;
-	INIT_LIST_HEAD(&bo.cb_list);
+	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
 	flow_indr_block_call(dev, &bo, cmd);
 
-- 
2.11.0

