Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94598FC74B
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Nov 2019 14:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfKNNYf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Nov 2019 08:24:35 -0500
Received: from correo.us.es ([193.147.175.20]:59306 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfKNNYf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:24:35 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 03529E04B9
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:31 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E2B04B7FF2
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:30 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E18B95D0; Thu, 14 Nov 2019 14:24:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 90CB87E4DE
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:28 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 14 Nov 2019 14:24:28 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 6759B42EE38E
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Nov 2019 14:24:28 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/3] netfilter: nf_tables_offload: remove reference to flow rule from deletion path
Date:   Thu, 14 Nov 2019 14:24:25 +0100
Message-Id: <20191114132427.10869-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The cookie is sufficient to delete the rule from the hardware.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 741045eb530e..528886bb3481 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -437,8 +437,7 @@ int nft_flow_rule_offload_commit(struct net *net)
 
 			err = nft_flow_offload_rule(trans->ctx.chain,
 						    nft_trans_rule(trans),
-						    nft_trans_flow_rule(trans),
-						    FLOW_CLS_DESTROY);
+						    NULL, FLOW_CLS_DESTROY);
 			break;
 		}
 
-- 
2.11.0

