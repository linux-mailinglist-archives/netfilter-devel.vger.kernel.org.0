Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BFD7F4AD9
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbjKVPgA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 10:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjKVPfc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:35:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938101BC0;
        Wed, 22 Nov 2023 07:33:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45252C433CB;
        Wed, 22 Nov 2023 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667236;
        bh=KNN7hkgAUhDYvHRh8LMiNipp5q373VB2dg8mVurAazc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huSmhb3KbSlFfKWE7IdkSnepjAjdCodTerdmFbHNta9UzGc94EwXVeV6r/HDmeCcR
         080pgrV3as7ugxGVsca4yxjJ3+htbXHfodneMnype/7edo5C94wmZTuchgKLtqxXlx
         vjTVYsS182DaMYjHhsQ5T1uNaGSY9zmDgS5o0kTeeJamlHUlux5yo6mUBk8tUmBy2b
         EkPSiQDojqi+krIsLU4HuQDjEqyNzuLh1Ff0zLGXTVnHiRtsCa6maXdM12hs5+Y/Rp
         AeRornDBWaTCtKCoVklanXe6++8FvtFT7LRjgIpqqZnRBrT1ykmNzNoTECZcYkD4v2
         +5jHqCafCWYTQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, fw@strlen.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, justinstitt@google.com, kuniyu@amazon.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 05/15] netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test
Date:   Wed, 22 Nov 2023 10:33:07 -0500
Message-ID: <20231122153340.852434-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153340.852434-1-sashal@kernel.org>
References: <20231122153340.852434-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 28628fa952fefc7f2072ce6e8016968cc452b1ba ]

Linkui Xiao reported that there's a race condition when ipset swap and destroy is
called, which can lead to crash in add/del/test element operations. Swap then
destroy are usual operations to replace a set with another one in a production
system. The issue can in some cases be reproduced with the script:

ipset create hash_ip1 hash:net family inet hashsize 1024 maxelem 1048576
ipset add hash_ip1 172.20.0.0/16
ipset add hash_ip1 192.168.0.0/16
iptables -A INPUT -m set --match-set hash_ip1 src -j ACCEPT
while [ 1 ]
do
	# ... Ongoing traffic...
        ipset create hash_ip2 hash:net family inet hashsize 1024 maxelem 1048576
        ipset add hash_ip2 172.20.0.0/16
        ipset swap hash_ip1 hash_ip2
        ipset destroy hash_ip2
        sleep 0.05
done

In the race case the possible order of the operations are

	CPU0			CPU1
	ip_set_test
				ipset swap hash_ip1 hash_ip2
				ipset destroy hash_ip2
	hash_net_kadt

Swap replaces hash_ip1 with hash_ip2 and then destroy removes hash_ip2 which
is the original hash_ip1. ip_set_test was called on hash_ip1 and because destroy
removed it, hash_net_kadt crashes.

The fix is to force ip_set_swap() to wait for all readers to finish accessing the
old set pointers by calling synchronize_rcu().

The first version of the patch was written by Linkui Xiao <xiaolinkui@kylinos.cn>.

v2: synchronize_rcu() is moved into ip_set_swap() in order not to burden
    ip_set_destroy() unnecessarily when all sets are destroyed.
v3: Florian Westphal pointed out that all netfilter hooks run with rcu_read_lock() held
    and em_ipset.c wraps the entire ip_set_test() in rcu read lock/unlock pair.
    So there's no need to extend the rcu read locked area in ipset itself.

Closes: https://lore.kernel.org/all/69e7963b-e7f8-3ad0-210-7b86eebf7f78@netfilter.org/
Reported by: Linkui Xiao <xiaolinkui@kylinos.cn>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 58608460cf6df..809b9b1a88afc 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -61,6 +61,8 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 	ip_set_dereference((inst)->ip_set_list)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
+#define ip_set_dereference_nfnl(p)	\
+	rcu_dereference_check(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -708,15 +710,10 @@ __ip_set_put_netlink(struct ip_set *set)
 static struct ip_set *
 ip_set_rcu_get(struct net *net, ip_set_id_t index)
 {
-	struct ip_set *set;
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	rcu_read_lock();
-	/* ip_set_list itself needs to be protected */
-	set = rcu_dereference(inst->ip_set_list)[index];
-	rcu_read_unlock();
-
-	return set;
+	/* ip_set_list and the set pointer need to be protected */
+	return ip_set_dereference_nfnl(inst->ip_set_list)[index];
 }
 
 static inline void
@@ -1397,6 +1394,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	return 0;
 }
 
-- 
2.42.0

