Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874AB7367D9
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jun 2023 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjFTJgG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Jun 2023 05:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjFTJfz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:35:55 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D28910FE;
        Tue, 20 Jun 2023 02:35:54 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 09/14] netfilter: nf_tables: reject unbound chain set before commit phase
Date:   Tue, 20 Jun 2023 11:35:37 +0200
Message-Id: <20230620093542.69232-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230620093542.69232-1-pablo@netfilter.org>
References: <20230620093542.69232-1-pablo@netfilter.org>
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

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 66da44bff5e4..bab792434a8d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -370,6 +370,11 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
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
@@ -9501,6 +9506,14 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
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

