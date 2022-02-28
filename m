Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703284C61BF
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Feb 2022 04:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiB1DTA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Feb 2022 22:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbiB1DS4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:18:56 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3312AC62
        for <netfilter-devel@vger.kernel.org>; Sun, 27 Feb 2022 19:18:18 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nOWYD-0007Xr-27; Mon, 28 Feb 2022 04:18:17 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH nf] netfilter: egress: silence egress hook lockdep splats
Date:   Mon, 28 Feb 2022 04:18:05 +0100
Message-Id: <20220228031805.32347-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
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

Netfilter assumes its called with rcu_read_lock held, but in egress
hook case it may be called with BH readlock.

This triggers lockdep splat.

In order to avoid to change all rcu_dereference() to
rcu_dereference_check(..., rcu_read_lock_bh_held()), wrap nf_hook_slow
with read lock/unlock pair.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter_netdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netfilter_netdev.h b/include/linux/netfilter_netdev.h
index b4dd96e4dc8d..e6487a691136 100644
--- a/include/linux/netfilter_netdev.h
+++ b/include/linux/netfilter_netdev.h
@@ -101,7 +101,11 @@ static inline struct sk_buff *nf_hook_egress(struct sk_buff *skb, int *rc,
 	nf_hook_state_init(&state, NF_NETDEV_EGRESS,
 			   NFPROTO_NETDEV, dev, NULL, NULL,
 			   dev_net(dev), NULL);
+
+	/* nf assumes rcu_read_lock, not just read_lock_bh */
+	rcu_read_lock();
 	ret = nf_hook_slow(skb, &state, e, 0);
+	rcu_read_unlock();
 
 	if (ret == 1) {
 		return skb;
-- 
2.34.1

