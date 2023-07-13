Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB678751C33
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jul 2023 10:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjGMIts (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Jul 2023 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjGMItW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:49:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A5D61FDE;
        Thu, 13 Jul 2023 01:49:14 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.10 v3 07/11] netfilter: nf_tables: reject unbound chain set before commit phase
Date:   Thu, 13 Jul 2023 10:48:55 +0200
Message-Id: <20230713084859.71541-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713084859.71541-1-pablo@netfilter.org>
References: <20230713084859.71541-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

[ Upstream commit 62e1e94b246e685d89c3163aaef4b160e42ceb02 ]

Use binding list to track set transaction and to check for unbound
chains before entering the commit phase.

Bail out if chain binding remain unused before entering the commit
step.

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ff65de8119c3..ef965056bcca 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -360,6 +360,11 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
 		if (nft_set_is_anonymous(nft_trans_set(trans)))
 			list_add_tail(&trans->binding_list, &nft_net->binding_list);
 		break;
+	case NFT_MSG_NEWCHAIN:
+		if (!nft_trans_chain_update(trans) &&
+		    nft_chain_binding(nft_trans_chain(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
 	}
 
 	list_add_tail(&trans->list, &nft_net->commit_list);
@@ -8043,6 +8048,14 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 				return -EINVAL;
 			}
 			break;
+		case NFT_MSG_NEWCHAIN:
+			if (!nft_trans_chain_update(trans) &&
+			    nft_chain_binding(nft_trans_chain(trans)) &&
+			    !nft_trans_chain_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound chain\n");
+				return -EINVAL;
+			}
+			break;
 		}
 	}
 
-- 
2.30.2

