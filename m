Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF971398A1
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jan 2020 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMSQK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jan 2020 13:16:10 -0500
Received: from correo.us.es ([193.147.175.20]:34744 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbgAMSQJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:16:09 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DCD1D15AEAB
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:07 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CC9E3DA712
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:07 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 654E5DA729; Mon, 13 Jan 2020 19:16:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F1C7DA70F
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:04 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 13 Jan 2020 19:16:03 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (50.pool85-54-104.dynamic.orange.es [85.54.104.50])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id E429642EF52A
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:03 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 9/9] netfilter: flowtable: add nf_flow_table_offload_cmd()
Date:   Mon, 13 Jan 2020 19:15:54 +0100
Message-Id: <20200113181554.52612-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113181554.52612-1-pablo@netfilter.org>
References: <20200113181554.52612-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Split nf_flow_table_offload_setup() in two functions to make it more
maintainable.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_offload.c | 38 +++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index a08756dc96e4..cb10d903cc47 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -838,12 +838,12 @@ static int nf_flow_table_block_setup(struct nf_flowtable *flowtable,
 	return err;
 }
 
-int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
-				struct net_device *dev,
-				enum flow_block_command cmd)
+static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
+				     struct nf_flowtable *flowtable,
+				     struct net_device *dev,
+				     enum flow_block_command cmd,
+				     struct netlink_ext_ack *extack)
 {
-	struct netlink_ext_ack extack = {};
-	struct flow_block_offload bo = {};
 	int err;
 
 	if (!nf_flowtable_hw_offload(flowtable))
@@ -852,17 +852,33 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	if (!dev->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
 
-	bo.net		= dev_net(dev);
-	bo.block	= &flowtable->flow_block;
-	bo.command	= cmd;
-	bo.binder_type	= FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
-	bo.extack	= &extack;
-	INIT_LIST_HEAD(&bo.cb_list);
+	memset(bo, 0, sizeof(*bo));
+	bo->net		= dev_net(dev);
+	bo->block	= &flowtable->flow_block;
+	bo->command	= cmd;
+	bo->binder_type	= FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
+	bo->extack	= extack;
+	INIT_LIST_HEAD(&bo->cb_list);
 
 	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, &bo);
 	if (err < 0)
 		return err;
 
+	return 0;
+}
+
+int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
+				struct net_device *dev,
+				enum flow_block_command cmd)
+{
+	struct netlink_ext_ack extack = {};
+	struct flow_block_offload bo;
+	int err;
+
+	err = nf_flow_table_offload_cmd(&bo, flowtable, dev, cmd, &extack);
+	if (err < 0)
+		return err;
+
 	return nf_flow_table_block_setup(flowtable, &bo, cmd);
 }
 EXPORT_SYMBOL_GPL(nf_flow_table_offload_setup);
-- 
2.11.0

