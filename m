Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DAE7483F3
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jul 2023 14:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGEMOQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGEMON (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:14:13 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E44F1BDF;
        Wed,  5 Jul 2023 05:13:54 -0700 (PDT)
Received: from localhost.localdomain (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 122AE41495;
        Wed,  5 Jul 2023 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688559231;
        bh=8mO+gHO62oR5Y3zx2yeUDLrgxlGAkZdbGA7wp8GIV6M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ZalshJJ2VINs221Ao6wSsOBLvK2rqlyuu0dLoEZEFVE4cAcbgAsrj1NEkolJHrd0j
         gFZS+ejig3wrv5UKd0gSzD5+iC5XlgY/1xOF/EQq/J479mmnqkACzUVjWlRW7XXuYO
         853IbXDvEkVKW7ex6u7DxPEBPO/hGmviWcYJfHWChUeFR66tRWhpY1tZlC/P8aZqSI
         FRAhj67iMsATEY8rEJsz1sYjRd/bqELzRvbOIzsIuQipM+hofFZve4UWd55v57Dq7T
         UY/N3Hjet3E71Ry/uPx/p3XwTSA3KZKnkG8ki+916WMDsJLB+43dYozqvcHj2H172x
         y6iJJZPrZQCpw==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     netfilter-devel@vger.kernel.org
Cc:     cascardo@canonical.com, netdev@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH] netfilter: nf_tables: do not ignore genmask when looking up chain by id
Date:   Wed,  5 Jul 2023 09:12:55 -0300
Message-Id: <20230705121255.746628-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

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
---
 net/netfilter/nf_tables_api.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 9573a8fcad79..3701493e5401 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2694,7 +2694,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	u32 id = ntohl(nla_get_be32(nla));
@@ -2705,7 +2705,8 @@ static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -3809,7 +3810,8 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -10502,7 +10504,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
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
2.34.1

