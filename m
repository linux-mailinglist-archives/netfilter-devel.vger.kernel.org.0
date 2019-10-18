Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19729DC477
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfJRMNG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 08:13:06 -0400
Received: from correo.us.es ([193.147.175.20]:42836 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388269AbfJRMNF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:13:05 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3756CC328D
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 14:13:01 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2968CDA72F
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 14:13:01 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1E7A4B8009; Fri, 18 Oct 2019 14:13:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2923BDA72F
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 14:12:59 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 18 Oct 2019 14:12:59 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0779142EF4E2
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 14:12:58 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables_offload: restore basechain deletion
Date:   Fri, 18 Oct 2019 14:12:58 +0200
Message-Id: <20191018121258.14046-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Unbind callbacks on chain deletion.

Fixes: 8fc618c52d16 ("netfilter: nf_tables_offload: refactor the nft_flow_offload_chain function")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index e4f42427244b..8aa0f912d008 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -376,7 +376,7 @@ int nft_flow_rule_offload_commit(struct net *net)
 
 			policy = nft_trans_chain_policy(trans);
 			err = nft_flow_offload_chain(trans->ctx.chain, &policy,
-						     FLOW_BLOCK_BIND);
+						     FLOW_BLOCK_UNBIND);
 			break;
 		case NFT_MSG_NEWRULE:
 			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
-- 
2.11.0

