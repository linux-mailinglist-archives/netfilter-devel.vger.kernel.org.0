Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB287489AA
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jul 2023 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGEQzY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGEQzX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:55:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 221B210EA;
        Wed,  5 Jul 2023 09:55:22 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sashal@kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,4.19 01/10] netfilter: nf_tables: fix nat hook table deletion
Date:   Wed,  5 Jul 2023 18:55:07 +0200
Message-Id: <20230705165516.50145-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705165516.50145-1-pablo@netfilter.org>
References: <20230705165516.50145-1-pablo@netfilter.org>
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

From: Florian Westphal <fw@strlen.de>

[ 1e9451cbda456a170518b2bfd643e2cb980880bf ]

sybot came up with following transaction:
 add table ip syz0
 add chain ip syz0 syz2 { type nat hook prerouting priority 0; policy accept; }
 add table ip syz0 { flags dormant; }
 delete chain ip syz0 syz2
 delete table ip syz0

which yields:
hook not found, pf 2 num 0
WARNING: CPU: 0 PID: 6775 at net/netfilter/core.c:413 __nf_unregister_net_hook+0x3e6/0x4a0 net/netfilter/core.c:413
[..]
 nft_unregister_basechain_hooks net/netfilter/nf_tables_api.c:206 [inline]
 nft_table_disable net/netfilter/nf_tables_api.c:835 [inline]
 nf_tables_table_disable net/netfilter/nf_tables_api.c:868 [inline]
 nf_tables_commit+0x32d3/0x4d70 net/netfilter/nf_tables_api.c:7550
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:486 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:544 [inline]
 nfnetlink_rcv+0x14a5/0x1e50 net/netfilter/nfnetlink.c:562
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]

Problem is that when I added ability to override base hook registration
to make nat basechains register with the nat core instead of netfilter
core, I forgot to update nft_table_disable() to use that instead of
the 'raw' hook register interface.

In syzbot transaction, the basechain is of 'nat' type. Its registered
with the nat core.  The switch to 'dormant mode' attempts to delete from
netfilter core instead.

After updating nft_table_disable/enable to use the correct helper,
nft_(un)register_basechain_hooks can be folded into the only remaining
caller.

Because nft_trans_table_enable() won't do anything when the DORMANT flag
is set, remove the flag first, then re-add it in case re-enablement
fails, else this patch breaks sequence:

add table ip x { flags dormant; }
/* add base chains */
add table ip x

The last 'add' will remove the dormant flags, but won't have any other
effect -- base chains are not registered.
Then, next 'set dormant flag' will create another 'hook not found'
splat.

Reported-by: syzbot+2570f2c036e3da5db176@syzkaller.appspotmail.com
Fixes: 4e25ceb80b58 ("netfilter: nf_tables: allow chain type to override hook register")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
(cherry picked from commit 1e9451cbda456a170518b2bfd643e2cb980880bf)
---
 net/netfilter/nf_tables_api.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2968f21915dd..fe9db14d01ce 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -743,7 +743,7 @@ static void nft_table_disable(struct net *net, struct nft_table *table, u32 cnt)
 		if (cnt && i++ == cnt)
 			break;
 
-		nf_unregister_net_hook(net, &nft_base_chain(chain)->ops);
+		nf_tables_unregister_hook(net, table, chain);
 	}
 }
 
@@ -758,7 +758,7 @@ static int nf_tables_table_enable(struct net *net, struct nft_table *table)
 		if (!nft_is_base_chain(chain))
 			continue;
 
-		err = nf_register_net_hook(net, &nft_base_chain(chain)->ops);
+		err = nf_tables_register_hook(net, table, chain);
 		if (err < 0)
 			goto err;
 
@@ -802,11 +802,12 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 		nft_trans_table_enable(trans) = false;
 	} else if (!(flags & NFT_TABLE_F_DORMANT) &&
 		   ctx->table->flags & NFT_TABLE_F_DORMANT) {
+		ctx->table->flags &= ~NFT_TABLE_F_DORMANT;
 		ret = nf_tables_table_enable(ctx->net, ctx->table);
-		if (ret >= 0) {
-			ctx->table->flags &= ~NFT_TABLE_F_DORMANT;
+		if (ret >= 0)
 			nft_trans_table_enable(trans) = true;
-		}
+		else
+			ctx->table->flags |= NFT_TABLE_F_DORMANT;
 	}
 	if (ret < 0)
 		goto err;
-- 
2.30.2

