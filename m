Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2168CE2CF5
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfJXJPK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 05:15:10 -0400
Received: from correo.us.es ([193.147.175.20]:50396 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388971AbfJXJPJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:15:09 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 799DB2EFEC4
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:05 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6AEB4A7EC2
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:05 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6A0C6DA72F; Thu, 24 Oct 2019 11:15:05 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4B289DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:03 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 24 Oct 2019 11:15:03 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 3006142EE395
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 11:15:03 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/3] netfilter: nf_tables_offload: unbind if multi-device binding fails
Date:   Thu, 24 Oct 2019 11:15:00 +0200
Message-Id: <20191024091500.2074-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191024091500.2074-1-pablo@netfilter.org>
References: <20191024091500.2074-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft_flow_block_chain() needs to unbind in case of error when performing
the multi-device binding.

Fixes: d54725cd11a5 ("netfilter: nf_tables: support for multiple devices per netdev hook")
Reported-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index d51728affa1c..4e0625cce647 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -336,7 +336,7 @@ static int nft_flow_block_chain(struct nft_base_chain *basechain,
 {
 	struct net_device *dev;
 	struct nft_hook *hook;
-	int err;
+	int err, i = 0;
 
 	list_for_each_entry(hook, &basechain->hook_list, list) {
 		dev = hook->ops.dev;
@@ -344,11 +344,26 @@ static int nft_flow_block_chain(struct nft_base_chain *basechain,
 			continue;
 
 		err = nft_chain_offload_cmd(basechain, dev, cmd);
-		if (err < 0)
+		if (err < 0 && cmd == FLOW_BLOCK_BIND) {
+			if (!this_dev)
+				goto err_flow_block;
+
 			return err;
+		}
+		i++;
 	}
 
 	return 0;
+
+err_flow_block:
+	list_for_each_entry(hook, &basechain->hook_list, list) {
+		if (i-- <= 0)
+			break;
+
+		dev = hook->ops.dev;
+		nft_chain_offload_cmd(basechain, dev, FLOW_BLOCK_UNBIND);
+	}
+	return err;
 }
 
 static int nft_flow_offload_chain(struct nft_chain *chain, u8 *ppolicy,
-- 
2.11.0

