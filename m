Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFFE2CF4
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 11:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbfJXJPJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 05:15:09 -0400
Received: from correo.us.es ([193.147.175.20]:50356 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfJXJPJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:15:09 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A3E602EFEAC
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:03 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 94D1C202B7
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:03 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8A96ADA4D0; Thu, 24 Oct 2019 11:15:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A1AC3D190C
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:01 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 24 Oct 2019 11:15:01 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 8687542EE395
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:01 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/3] netfilter: nf_tables_offload: add nft_chain_offload_cmd()
Date:   Thu, 24 Oct 2019 11:14:58 +0200
Message-Id: <20191024091500.2074-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds the nft_chain_offload_cmd() helper function.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index beeb74f2b47d..70f50d306799 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -316,6 +316,20 @@ static int nft_indr_block_offload_cmd(struct nft_base_chain *chain,
 
 #define FLOW_SETUP_BLOCK TC_SETUP_BLOCK
 
+static int nft_chain_offload_cmd(struct nft_base_chain *basechain,
+				 struct net_device *dev,
+				 enum flow_block_command cmd)
+{
+	int err;
+
+	if (dev->netdev_ops->ndo_setup_tc)
+		err = nft_block_offload_cmd(basechain, dev, cmd);
+	else
+		err = nft_indr_block_offload_cmd(basechain, dev, cmd);
+
+	return err;
+}
+
 static int nft_flow_block_chain(struct nft_base_chain *basechain,
 				const struct net_device *this_dev,
 				enum flow_block_command cmd)
@@ -329,11 +343,7 @@ static int nft_flow_block_chain(struct nft_base_chain *basechain,
 		if (this_dev && this_dev != dev)
 			continue;
 
-		if (dev->netdev_ops->ndo_setup_tc)
-			err = nft_block_offload_cmd(basechain, dev, cmd);
-		else
-			err = nft_indr_block_offload_cmd(basechain, dev, cmd);
-
+		err = nft_chain_offload_cmd(basechain, dev, cmd);
 		if (err < 0)
 			return err;
 	}
-- 
2.11.0

