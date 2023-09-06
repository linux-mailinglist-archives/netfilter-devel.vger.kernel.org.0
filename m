Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877B3794169
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Sep 2023 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243024AbjIFQ0C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Sep 2023 12:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjIFQ0B (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:26:01 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A214199A;
        Wed,  6 Sep 2023 09:25:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qdvLl-0007wk-IH; Wed, 06 Sep 2023 18:25:53 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Phil Sutter <phil@nwl.cc>
Subject: [PATCH net 6/6] netfilter: nf_tables: Unbreak audit log reset
Date:   Wed,  6 Sep 2023 18:25:12 +0200
Message-ID: <20230906162525.11079-7-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906162525.11079-1-fw@strlen.de>
References: <20230906162525.11079-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

Deliver audit log from __nf_tables_dump_rules(), table dereference at
the end of the table list loop might point to the list head, leading to
this crash.

[ 4137.407349] BUG: unable to handle page fault for address: 00000000001f3c50
[ 4137.407357] #PF: supervisor read access in kernel mode
[ 4137.407359] #PF: error_code(0x0000) - not-present page
[ 4137.407360] PGD 0 P4D 0
[ 4137.407363] Oops: 0000 [#1] PREEMPT SMP PTI
[ 4137.407365] CPU: 4 PID: 500177 Comm: nft Not tainted 6.5.0+ #277
[ 4137.407369] RIP: 0010:string+0x49/0xd0
[ 4137.407374] Code: ff 77 36 45 89 d1 31 f6 49 01 f9 66 45 85 d2 75 19 eb 1e 49 39 f8 76 02 88 07 48 83 c7 01 83 c6 01 48 83 c2 01 4c 39 cf 74 07 <0f> b6 02 84 c0 75 e2 4c 89 c2 e9 58 e5 ff ff 48 c7 c0 0e b2 ff 81
[ 4137.407377] RSP: 0018:ffff8881179737f0 EFLAGS: 00010286
[ 4137.407379] RAX: 00000000001f2c50 RBX: ffff888117973848 RCX: ffff0a00ffffff04
[ 4137.407380] RDX: 00000000001f3c50 RSI: 0000000000000000 RDI: 0000000000000000
[ 4137.407381] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
[ 4137.407383] R10: ffffffffffffffff R11: ffff88813584d200 R12: 0000000000000000
[ 4137.407384] R13: ffffffffa15cf709 R14: 0000000000000000 R15: ffffffffa15cf709
[ 4137.407385] FS:  00007fcfc18bb580(0000) GS:ffff88840e700000(0000) knlGS:0000000000000000
[ 4137.407387] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4137.407388] CR2: 00000000001f3c50 CR3: 00000001055b2001 CR4: 00000000001706e0
[ 4137.407390] Call Trace:
[ 4137.407392]  <TASK>
[ 4137.407393]  ? __die+0x1b/0x60
[ 4137.407397]  ? page_fault_oops+0x6b/0xa0
[ 4137.407399]  ? exc_page_fault+0x60/0x120
[ 4137.407403]  ? asm_exc_page_fault+0x22/0x30
[ 4137.407408]  ? string+0x49/0xd0
[ 4137.407410]  vsnprintf+0x257/0x4f0
[ 4137.407414]  kvasprintf+0x3e/0xb0
[ 4137.407417]  kasprintf+0x3e/0x50
[ 4137.407419]  nf_tables_dump_rules+0x1c0/0x360 [nf_tables]
[ 4137.407439]  ? __alloc_skb+0xc3/0x170
[ 4137.407442]  netlink_dump+0x170/0x330
[ 4137.407447]  __netlink_dump_start+0x227/0x300
[ 4137.407449]  nf_tables_getrule+0x205/0x390 [nf_tables]

Deliver audit log only once at the end of the rule dump+reset for
consistency with the set dump+reset.

Ensure audit reset access to table under rcu read side lock. The table
list iteration holds rcu read lock side, but recent audit code
dereferences table object out of the rcu read lock side.

Fixes: ea078ae9108e ("netfilter: nf_tables: Audit log rule reset")
Fixes: 7e9be1124dbe ("netfilter: nf_tables: Audit log setelem reset")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2c81cee858d6..e429ebba74b3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3480,6 +3480,10 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 cont_skip:
 		(*idx)++;
 	}
+
+	if (reset && *idx)
+		audit_log_rule_reset(table, cb->seq, *idx);
+
 	return 0;
 }
 
@@ -3540,9 +3544,6 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 done:
 	rcu_read_unlock();
 
-	if (reset && idx > cb->args[0])
-		audit_log_rule_reset(table, cb->seq, idx - cb->args[0]);
-
 	cb->args[0] = idx;
 	return skb->len;
 }
@@ -5760,8 +5761,6 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!args.iter.err && args.iter.count == cb->args[0])
 		args.iter.err = nft_set_catchall_dump(net, skb, set,
 						      reset, cb->seq);
-	rcu_read_unlock();
-
 	nla_nest_end(skb, nest);
 	nlmsg_end(skb, nlh);
 
@@ -5769,6 +5768,8 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 		audit_log_nft_set_reset(table, cb->seq,
 					args.iter.count - args.iter.skip);
 
+	rcu_read_unlock();
+
 	if (args.iter.err && args.iter.err != -EMSGSIZE)
 		return args.iter.err;
 	if (args.iter.count == cb->args[0])
-- 
2.41.0

