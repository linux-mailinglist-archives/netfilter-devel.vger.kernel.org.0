Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A561FC74C
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Nov 2019 14:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNNYg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Nov 2019 08:24:36 -0500
Received: from correo.us.es ([193.147.175.20]:59374 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKNNYg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:24:36 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ABE23D2C9D
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:32 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89187DA4D0
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:32 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8271CDA801; Thu, 14 Nov 2019 14:24:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 95BB3DA4CA
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:29 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 14 Nov 2019 14:24:29 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 7615742EE38F
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:29 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/3] netfilter: nf_tables_offload: release flow_rule on error from commit path
Date:   Thu, 14 Nov 2019 14:24:26 +0100
Message-Id: <20191114132427.10869-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191114132427.10869-1-pablo@netfilter.org>
References: <20191114132427.10869-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If hardware offload commit path fails, release all flow_rule object.

Fixes: c9626a2cbdb2 ("netfilter: nf_tables: add hardware offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 528886bb3481..6d5f3cd7f1b7 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -422,14 +422,14 @@ int nft_flow_rule_offload_commit(struct net *net)
 				continue;
 
 			if (trans->ctx.flags & NLM_F_REPLACE ||
-			    !(trans->ctx.flags & NLM_F_APPEND))
-				return -EOPNOTSUPP;
-
+			    !(trans->ctx.flags & NLM_F_APPEND)) {
+				err = -EOPNOTSUPP;
+				break;
+			}
 			err = nft_flow_offload_rule(trans->ctx.chain,
 						    nft_trans_rule(trans),
 						    nft_trans_flow_rule(trans),
 						    FLOW_CLS_REPLACE);
-			nft_flow_rule_destroy(nft_trans_flow_rule(trans));
 			break;
 		case NFT_MSG_DELRULE:
 			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
@@ -442,7 +442,23 @@ int nft_flow_rule_offload_commit(struct net *net)
 		}
 
 		if (err)
-			return err;
+			break;
+	}
+
+	list_for_each_entry(trans, &net->nft.commit_list, list) {
+		if (trans->ctx.family != NFPROTO_NETDEV)
+			continue;
+
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWRULE:
+			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
+				continue;
+
+			nft_flow_rule_destroy(nft_trans_flow_rule(trans));
+			break;
+		default:
+			break;
+		}
 	}
 
 	return err;
-- 
2.11.0

