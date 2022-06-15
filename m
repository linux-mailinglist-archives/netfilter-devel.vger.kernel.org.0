Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4214A54C9FF
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jun 2022 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348211AbiFONkm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jun 2022 09:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONkl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:40:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C63369FA
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Jun 2022 06:40:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1o1TG9-000808-JS; Wed, 15 Jun 2022 15:40:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     syzkaller-bugs@googlegroups.com, Florian Westphal <fw@strlen.de>,
        syzbot+92968395eedbdbd3617d@syzkaller.appspotmail.com
Subject: [PATCH nf] netfilter: cttimeout: fix slab-out-of-bounds read typo in cttimeout_net_exit
Date:   Wed, 15 Jun 2022 15:40:32 +0200
Message-Id: <20220615134032.4201-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <00000000000067fcb705e17b59da@google.com>
References: <00000000000067fcb705e17b59da@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

syzbot reports:
  BUG: KASAN: slab-out-of-bounds in __list_del_entry_valid+0xcc/0xf0 lib/list_debug.c:42
  [..]
  list_del include/linux/list.h:148 [inline]
  cttimeout_net_exit+0x211/0x540 net/netfilter/nfnetlink_cttimeout.c:617

Problem is the wrong name of the list member, so container_of yields
incorrect onj address.

Reported-by: <syzbot+92968395eedbdbd3617d@syzkaller.appspotmail.com>
Fixes: 78222bacfca9 ("netfilter: cttimeout: decouple unlink and free on netns destruction")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_cttimeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index af15102bc696..f466af4f8531 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -614,7 +614,7 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 
 	nf_ct_untimeout(net, NULL);
 
-	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, head) {
+	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, free_head) {
 		list_del(&cur->free_head);
 
 		if (refcount_dec_and_test(&cur->refcnt))
-- 
2.35.1

