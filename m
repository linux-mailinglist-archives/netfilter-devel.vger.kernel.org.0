Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB58A5D5E
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2019 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfIBVLm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 17:11:42 -0400
Received: from correo.us.es ([193.147.175.20]:47172 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfIBVLm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:11:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF524172C76
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2019 23:11:38 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A2BCED2B1F
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2019 23:11:38 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 98980D2B1E; Mon,  2 Sep 2019 23:11:38 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9401ADA72F;
        Mon,  2 Sep 2019 23:11:36 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 02 Sep 2019 23:11:36 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 73A854265A5A;
        Mon,  2 Sep 2019 23:11:36 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     wenxu@ucloud.cn
Subject: [PATCH nf-next 2/2] netfilter: nf_tables_offload: save one indent level in nft_indr_block_cb()
Date:   Mon,  2 Sep 2019 23:11:32 +0200
Message-Id: <20190902211132.32200-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190902211132.32200-1-pablo@netfilter.org>
References: <20190902211132.32200-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Save one indent level in the nft_indr_block_cb() loop.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 1e69bd7f9fe1..b2f169be2a37 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -354,8 +354,9 @@ int nft_flow_rule_offload_commit(struct net *net)
 
 static void nft_indr_block_cb(struct net_device *dev,
 			      flow_indr_block_bind_cb_t *cb, void *cb_priv,
-			      enum flow_block_command command)
+			      enum flow_block_command cmd)
 {
+	struct nft_base_chain *basechain;
 	struct net *net = dev_net(dev);
 	const struct nft_table *table;
 	const struct nft_chain *chain;
@@ -365,18 +366,15 @@ static void nft_indr_block_cb(struct net_device *dev,
 			continue;
 
 		list_for_each_entry_rcu(chain, &table->chains, list) {
-			if (nft_is_base_chain(chain)) {
-				struct nft_base_chain *basechain;
-
-				basechain = nft_base_chain(chain);
-				if (!strncmp(basechain->dev_name, dev->name,
-					     IFNAMSIZ)) {
-					nft_indr_block_ing_cmd(dev, basechain,
-							       cb, cb_priv,
-							       command);
-					return;
-				}
-			}
+			if (!nft_is_base_chain(chain))
+				continue;
+
+			basechain = nft_base_chain(chain);
+			if (strncmp(basechain->dev_name, dev->name, IFNAMSIZ))
+				continue;
+
+			nft_indr_block_ing_cmd(dev, basechain, cb, cb_priv, cmd);
+			return;
 		}
 	}
 }
-- 
2.11.0

