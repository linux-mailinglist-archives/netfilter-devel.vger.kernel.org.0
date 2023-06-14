Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E2724174
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Jun 2023 13:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbjFFL6n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Jun 2023 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbjFFL6j (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:58:39 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7AD10D7
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Jun 2023 04:58:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1q6VKa-0006Jr-RD; Tue, 06 Jun 2023 13:58:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Subject: [PATCH nf-next] netfilter: ipset: remove rcu_read_lock_bh pair from ip_set_test
Date:   Tue,  6 Jun 2023 13:58:27 +0200
Message-Id: <20230606115827.8597-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
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

Callers already hold rcu_read_lock.

Prior to RCU conversion this used to be a read_lock_bh(), but now the
bh-disable isn't needed anymore.

Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipset/ip_set_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 46ebee9400da..a77c75f6dfb9 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -739,9 +739,7 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *skb,
 	    !(opt->family == set->family || set->family == NFPROTO_UNSPEC))
 		return 0;
 
-	rcu_read_lock_bh();
 	ret = set->variant->kadt(set, skb, par, IPSET_TEST, opt);
-	rcu_read_unlock_bh();
 
 	if (ret == -EAGAIN) {
 		/* Type requests element to be completed */
-- 
2.39.2

