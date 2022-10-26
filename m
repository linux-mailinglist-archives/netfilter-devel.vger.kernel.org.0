Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476A960DC9A
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Oct 2022 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiJZH4V (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Oct 2022 03:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiJZH4V (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:56:21 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2FA48E714
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Oct 2022 00:56:19 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf 1/2] netfilter: nf_tables: netlink notifier might race to release objects
Date:   Wed, 26 Oct 2022 09:56:12 +0200
Message-Id: <20221026075613.2560-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

commit release path is invoked via call_rcu and it runs lockless to
release the objects after rcu grace period. The netlink notifier handler
might win race to remove objects that the transaction context is still
referencing from the commit release path.

Call rcu_barrier() to ensure pending rcu callbacks run to completion
if the list of transactions to be destroyed is not empty.

Fixes: 6001a930ce03 ("netfilter: nftables: introduce table ownership")
Reported-by: syzbot+8f747f62763bc6c32916@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
as a follow up to:
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20221024133104.77813-1-fw@strlen.de/

 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 58d9cbc9ccdc..2197118aa7b0 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10030,6 +10030,8 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	nft_net = nft_pernet(net);
 	deleted = 0;
 	mutex_lock(&nft_net->commit_mutex);
+	if (!list_empty(&nf_tables_destroy_list))
+		rcu_barrier();
 again:
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (nft_table_has_owner(table) &&
-- 
2.30.2

