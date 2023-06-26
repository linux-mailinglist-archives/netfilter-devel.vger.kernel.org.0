Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7654F73D7EA
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jun 2023 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjFZGsB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jun 2023 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFZGr7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:47:59 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E7C5E4E;
        Sun, 25 Jun 2023 23:47:57 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net-next 4/8] netfilter: ipset: remove rcu_read_lock_bh pair from ip_set_test
Date:   Mon, 26 Jun 2023 08:47:45 +0200
Message-Id: <20230626064749.75525-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230626064749.75525-1-pablo@netfilter.org>
References: <20230626064749.75525-1-pablo@netfilter.org>
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

Callers already hold rcu_read_lock.

Prior to RCU conversion this used to be a read_lock_bh(), but now the
bh-disable isn't needed anymore.

Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
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
2.30.2

