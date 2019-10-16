Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B546ED912C
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Oct 2019 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393163AbfJPMkn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 08:40:43 -0400
Received: from correo.us.es ([193.147.175.20]:55124 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391329AbfJPMkn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:40:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 38C581BFA91
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2B9C4123943
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 21655123942; Wed, 16 Oct 2019 14:40:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 340F8123947
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 16 Oct 2019 14:40:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 1EA5D42EE393
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:40:37 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/5] netfilter: nf_tables_offload: add nft_flow_cls_offload_setup()
Date:   Wed, 16 Oct 2019 14:40:32 +0200
Message-Id: <20191016124034.9847-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016124034.9847-1-pablo@netfilter.org>
References: <20191016124034.9847-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add helper function to set up the flow_cls_offload object.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index b85ea768ca80..93363c7ab177 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -155,30 +155,41 @@ int nft_chain_offload_priority(struct nft_base_chain *basechain)
 	return 0;
 }
 
+static void nft_flow_cls_offload_setup(struct flow_cls_offload *cls_flow,
+				       const struct nft_base_chain *basechain,
+				       const struct nft_rule *rule,
+				       const struct nft_flow_rule *flow,
+				       enum flow_cls_command command)
+{
+	struct netlink_ext_ack extack;
+	__be16 proto = ETH_P_ALL;
+
+	memset(cls_flow, 0, sizeof(*cls_flow));
+
+	if (flow)
+		proto = flow->proto;
+
+	nft_flow_offload_common_init(&cls_flow->common, proto,
+				     basechain->ops.priority, &extack);
+	cls_flow->command = command;
+	cls_flow->cookie = (unsigned long) rule;
+	if (flow)
+		cls_flow->rule = flow->rule;
+}
+
 static int nft_flow_offload_rule(struct nft_chain *chain,
 				 struct nft_rule *rule,
 				 struct nft_flow_rule *flow,
 				 enum flow_cls_command command)
 {
-	struct flow_cls_offload cls_flow = {};
+	struct flow_cls_offload cls_flow;
 	struct nft_base_chain *basechain;
-	struct netlink_ext_ack extack;
-	__be16 proto = ETH_P_ALL;
 
 	if (!nft_is_base_chain(chain))
 		return -EOPNOTSUPP;
 
 	basechain = nft_base_chain(chain);
-
-	if (flow)
-		proto = flow->proto;
-
-	nft_flow_offload_common_init(&cls_flow.common, proto,
-				     basechain->ops.priority, &extack);
-	cls_flow.command = command;
-	cls_flow.cookie = (unsigned long) rule;
-	if (flow)
-		cls_flow.rule = flow->rule;
+	nft_flow_cls_offload_setup(&cls_flow, basechain, rule, flow, command);
 
 	return nft_setup_cb_call(TC_SETUP_CLSFLOWER, &cls_flow,
 				 &basechain->flow_block.cb_list);
-- 
2.11.0

