Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED374914A
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Jul 2023 01:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGEXEV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 19:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjGEXET (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:04:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3E9F102;
        Wed,  5 Jul 2023 16:04:18 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 5/6] netfilter: nf_tables: do not ignore genmask when looking up chain by id
Date:   Thu,  6 Jul 2023 01:04:05 +0200
Message-Id: <20230705230406.52201-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705230406.52201-1-pablo@netfilter.org>
References: <20230705230406.52201-1-pablo@netfilter.org>
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

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

When adding a rule to a chain referring to its ID, if that chain had been
deleted on the same batch, the rule might end up referring to a deleted
chain.

This will lead to a WARNING like following:

[   33.098431] ------------[ cut here ]------------
[   33.098678] WARNING: CPU: 5 PID: 69 at net/netfilter/nf_tables_api.c:2037 nf_tables_chain_destroy+0x23d/0x260
[   33.099217] Modules linked in:
[   33.099388] CPU: 5 PID: 69 Comm: kworker/5:1 Not tainted 6.4.0+ #409
[   33.099726] Workqueue: events nf_tables_trans_destroy_work
[   33.100018] RIP: 0010:nf_tables_chain_destroy+0x23d/0x260
[   33.100306] Code: 8b 7c 24 68 e8 64 9c ed fe 4c 89 e7 e8 5c 9c ed fe 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 89 c6 89 c7 c3 cc cc cc cc <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 89 c6 89 c7
[   33.101271] RSP: 0018:ffffc900004ffc48 EFLAGS: 00010202
[   33.101546] RAX: 0000000000000001 RBX: ffff888006fc0a28 RCX: 0000000000000000
[   33.101920] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   33.102649] RBP: ffffc900004ffc78 R08: 0000000000000000 R09: 0000000000000000
[   33.103018] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880135ef500
[   33.103385] R13: 0000000000000000 R14: dead000000000122 R15: ffff888006fc0a10
[   33.103762] FS:  0000000000000000(0000) GS:ffff888024c80000(0000) knlGS:0000000000000000
[   33.104184] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.104493] CR2: 00007fe863b56a50 CR3: 00000000124b0001 CR4: 0000000000770ee0
[   33.104872] PKRU: 55555554
[   33.104999] Call Trace:
[   33.105113]  <TASK>
[   33.105214]  ? show_regs+0x72/0x90
[   33.105371]  ? __warn+0xa5/0x210
[   33.105520]  ? nf_tables_chain_destroy+0x23d/0x260
[   33.105732]  ? report_bug+0x1f2/0x200
[   33.105902]  ? handle_bug+0x46/0x90
[   33.106546]  ? exc_invalid_op+0x19/0x50
[   33.106762]  ? asm_exc_invalid_op+0x1b/0x20
[   33.106995]  ? nf_tables_chain_destroy+0x23d/0x260
[   33.107249]  ? nf_tables_chain_destroy+0x30/0x260
[   33.107506]  nf_tables_trans_destroy_work+0x669/0x680
[   33.107782]  ? mark_held_locks+0x28/0xa0
[   33.107996]  ? __pfx_nf_tables_trans_destroy_work+0x10/0x10
[   33.108294]  ? _raw_spin_unlock_irq+0x28/0x70
[   33.108538]  process_one_work+0x68c/0xb70
[   33.108755]  ? lock_acquire+0x17f/0x420
[   33.108977]  ? __pfx_process_one_work+0x10/0x10
[   33.109218]  ? do_raw_spin_lock+0x128/0x1d0
[   33.109435]  ? _raw_spin_lock_irq+0x71/0x80
[   33.109634]  worker_thread+0x2bd/0x700
[   33.109817]  ? __pfx_worker_thread+0x10/0x10
[   33.110254]  kthread+0x18b/0x1d0
[   33.110410]  ? __pfx_kthread+0x10/0x10
[   33.110581]  ret_from_fork+0x29/0x50
[   33.110757]  </TASK>
[   33.110866] irq event stamp: 1651
[   33.111017] hardirqs last  enabled at (1659): [<ffffffffa206a209>] __up_console_sem+0x79/0xa0
[   33.111379] hardirqs last disabled at (1666): [<ffffffffa206a1ee>] __up_console_sem+0x5e/0xa0
[   33.111740] softirqs last  enabled at (1616): [<ffffffffa1f5d40e>] __irq_exit_rcu+0x9e/0xe0
[   33.112094] softirqs last disabled at (1367): [<ffffffffa1f5d40e>] __irq_exit_rcu+0x9e/0xe0
[   33.112453] ---[ end trace 0000000000000000 ]---

This is due to the nft_chain_lookup_byid ignoring the genmask. After this
change, adding the new rule will fail as it will not find the chain.

Fixes: 837830a4b439 ("netfilter: nf_tables: add NFTA_RULE_CHAIN_ID attribute")
Cc: stable@vger.kernel.org
Reported-by: Mingi Cho of Theori working with ZDI
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 86b3c4de7f40..237f739da3ca 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2699,7 +2699,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	u32 id = ntohl(nla_get_be32(nla));
@@ -2710,7 +2710,8 @@ static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -3814,7 +3815,8 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -10540,7 +10542,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 						 genmask);
 		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
 			chain = nft_chain_lookup_byid(ctx->net, ctx->table,
-						      tb[NFTA_VERDICT_CHAIN_ID]);
+						      tb[NFTA_VERDICT_CHAIN_ID],
+						      genmask);
 			if (IS_ERR(chain))
 				return PTR_ERR(chain);
 		} else {
-- 
2.30.2

