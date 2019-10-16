Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0FD912A
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Oct 2019 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393159AbfJPMkm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 08:40:42 -0400
Received: from correo.us.es ([193.147.175.20]:55116 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391364AbfJPMkm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:40:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1D4171BFA87
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:38 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F8DB123941
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:38 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 05402123946; Wed, 16 Oct 2019 14:40:38 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 24EB1123941
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:36 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 16 Oct 2019 14:40:36 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 06F1F42EE393
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:35 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/5] netfilter: nf_tables_offload: add nft_flow_block_chain()
Date:   Wed, 16 Oct 2019 14:40:30 +0200
Message-Id: <20191016124034.9847-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016124034.9847-1-pablo@netfilter.org>
References: <20191016124034.9847-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add nft_flow_block_chain() helper function.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index e546f759b7a7..4554bc661817 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -294,6 +294,16 @@ static int nft_indr_block_offload_cmd(struct nft_base_chain *chain,
 
 #define FLOW_SETUP_BLOCK TC_SETUP_BLOCK
 
+static int nft_flow_block_chain(struct nft_base_chain *basechain,
+				struct net_device *dev,
+				enum flow_block_command cmd)
+{
+	if (dev->netdev_ops->ndo_setup_tc)
+		return nft_block_offload_cmd(basechain, dev, cmd);
+
+	return nft_indr_block_offload_cmd(basechain, dev, cmd);
+}
+
 static int nft_flow_offload_chain(struct nft_chain *chain,
 				  u8 *ppolicy,
 				  enum flow_block_command cmd)
@@ -316,10 +326,7 @@ static int nft_flow_offload_chain(struct nft_chain *chain,
 	if (cmd == FLOW_BLOCK_BIND && policy == NF_DROP)
 		return -EOPNOTSUPP;
 
-	if (dev->netdev_ops->ndo_setup_tc)
-		return nft_block_offload_cmd(basechain, dev, cmd);
-	else
-		return nft_indr_block_offload_cmd(basechain, dev, cmd);
+	return nft_flow_block_chain(basechain, dev, cmd);
 }
 
 int nft_flow_rule_offload_commit(struct net *net)
-- 
2.11.0

