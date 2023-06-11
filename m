Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B472B42A
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Jun 2023 23:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjFKVWO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Jun 2023 17:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFKVWM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:22:12 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 651D8E55
        for <netfilter-devel@vger.kernel.org>; Sun, 11 Jun 2023 14:22:10 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 4/6] netfilter: nf_tables: reject unbound chain set before commit phase
Date:   Sun, 11 Jun 2023 23:22:01 +0200
Message-Id: <20230611212203.1127-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230611212203.1127-1-pablo@netfilter.org>
References: <20230611212203.1127-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use binding list to track set transaction and to check for unbound
chains before entering the commit phase.

Bail out if chain binding remain unused before entering the commit
step.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 92cc9141de5d..a4f1a9f3d6d4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -343,6 +343,11 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
 		    nft_set_is_anonymous(nft_trans_set(trans)))
 			list_add_tail(&trans->binding_list, &nft_net->binding_list);
 		break;
+	case NFT_MSG_NEWCHAIN:
+		if (!nft_trans_chain_update(trans) &&
+		    nft_chain_binding(nft_trans_chain(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
 	}
 
 	list_add_tail(&trans->list, &nft_net->commit_list);
@@ -9365,6 +9370,14 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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

