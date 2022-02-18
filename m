Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C614BB8A4
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Feb 2022 12:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiBRLt4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Feb 2022 06:49:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiBRLtz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:49:55 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07DC31A02B9
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Feb 2022 03:49:36 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C07B96020E
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Feb 2022 12:48:50 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: unregister flowtable hooks on netns exit
Date:   Fri, 18 Feb 2022 12:49:32 +0100
Message-Id: <20220218114932.2735042-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

Unregister flowtable hooks before they are releases via
nf_tables_flowtable_destroy() otherwise hook core reports UAF.

BUG: KASAN: use-after-free in nf_hook_entries_grow+0x5a7/0x700 net/netfilter/core.c:142 net/netfilter/core.c:142
Read of size 4 at addr ffff8880736f7438 by task syz-executor579/3666

CPU: 0 PID: 3666 Comm: syz-executor579 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 __dump_stack lib/dump_stack.c:88 [inline] lib/dump_stack.c:106
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106 lib/dump_stack.c:106
 print_address_description+0x65/0x380 mm/kasan/report.c:247 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 __kasan_report mm/kasan/report.c:433 [inline] mm/kasan/report.c:450
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:450 mm/kasan/report.c:450
 nf_hook_entries_grow+0x5a7/0x700 net/netfilter/core.c:142 net/netfilter/core.c:142
 __nf_register_net_hook+0x27e/0x8d0 net/netfilter/core.c:429 net/netfilter/core.c:429
 nf_register_net_hook+0xaa/0x180 net/netfilter/core.c:571 net/netfilter/core.c:571
 nft_register_flowtable_net_hooks+0x3c5/0x730 net/netfilter/nf_tables_api.c:7232 net/netfilter/nf_tables_api.c:7232
 nf_tables_newflowtable+0x2022/0x2cf0 net/netfilter/nf_tables_api.c:7430 net/netfilter/nf_tables_api.c:7430
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:513 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:634 [inline]
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:513 [inline] net/netfilter/nfnetlink.c:652
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:634 [inline] net/netfilter/nfnetlink.c:652
 nfnetlink_rcv+0x10e6/0x2550 net/netfilter/nfnetlink.c:652 net/netfilter/nfnetlink.c:652

Fixes: ff4bf2f42a40 ("netfilter: nf_tables: add nft_unregister_flowtable_hook()")
Reported-by: syzbot+e918523f77e62790d6d9@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5fa16990da95..3081c4399f10 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9636,10 +9636,13 @@ EXPORT_SYMBOL_GPL(__nft_release_basechain);
 
 static void __nft_release_hook(struct net *net, struct nft_table *table)
 {
+	struct nft_flowtable *flowtable;
 	struct nft_chain *chain;
 
 	list_for_each_entry(chain, &table->chains, list)
 		nf_tables_unregister_hook(net, table, chain);
+	list_for_each_entry(flowtable, &table->flowtables, list)
+		nft_unregister_flowtable_net_hooks(net, &flowtable->hook_list);
 }
 
 static void __nft_release_hooks(struct net *net)
-- 
2.30.2

