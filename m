Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEE7FAF6
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Aug 2019 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393240AbfHBNUA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Aug 2019 09:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393238AbfHBNT7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:19:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6482A2087C;
        Fri,  2 Aug 2019 13:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564751998;
        bh=YQAVTzL1BNXGuPi0ICwc8Hd7ymKLulTzBQpBdUtpRV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJs82pjoVsr0XPIwIEeWPGe6ibOmXcZLqejv3Hx+z3zIXq6XaMHjKh6OJiNjeMW/R
         1AfPgrllRvn5+uwRl5jaeA5PnJofjX69TDDYgQEH/ibcBm7V7CE64vchxub+Lzy3VF
         GnxMBtoTR1XmOAmF523aR5hrD+DJj6RlWDfy7AEI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 05/76] netfilter: Fix rpfilter dropping vrf packets by mistake
Date:   Fri,  2 Aug 2019 09:18:39 -0400
Message-Id: <20190802131951.11600-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit b575b24b8eee37f10484e951b62ce2a31c579775 ]

When firewalld is enabled with ipv4/ipv6 rpfilter, vrf
ipv4/ipv6 packets will be dropped. Vrf device will pass
through netfilter hook twice. One with enslaved device
and another one with l3 master device. So in device may
dismatch witch out device because out device is always
enslaved device.So failed with the check of the rpfilter
and drop the packets by mistake.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/ipt_rpfilter.c  | 1 +
 net/ipv6/netfilter/ip6t_rpfilter.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/ipt_rpfilter.c b/net/ipv4/netfilter/ipt_rpfilter.c
index 59031670b16a0..cc23f1ce239c2 100644
--- a/net/ipv4/netfilter/ipt_rpfilter.c
+++ b/net/ipv4/netfilter/ipt_rpfilter.c
@@ -78,6 +78,7 @@ static bool rpfilter_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	flow.flowi4_mark = info->flags & XT_RPFILTER_VALID_MARK ? skb->mark : 0;
 	flow.flowi4_tos = RT_TOS(iph->tos);
 	flow.flowi4_scope = RT_SCOPE_UNIVERSE;
+	flow.flowi4_oif = l3mdev_master_ifindex_rcu(xt_in(par));
 
 	return rpfilter_lookup_reverse(xt_net(par), &flow, xt_in(par), info->flags) ^ invert;
 }
diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t_rpfilter.c
index 6bcaf73571834..d800801a5dd27 100644
--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -55,7 +55,9 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 	if (rpfilter_addr_linklocal(&iph->saddr)) {
 		lookup_flags |= RT6_LOOKUP_F_IFACE;
 		fl6.flowi6_oif = dev->ifindex;
-	} else if ((flags & XT_RPFILTER_LOOSE) == 0)
+	/* Set flowi6_oif for vrf devices to lookup route in l3mdev domain. */
+	} else if (netif_is_l3_master(dev) || netif_is_l3_slave(dev) ||
+		  (flags & XT_RPFILTER_LOOSE) == 0)
 		fl6.flowi6_oif = dev->ifindex;
 
 	rt = (void *)ip6_route_lookup(net, &fl6, skb, lookup_flags);
@@ -70,7 +72,9 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 		goto out;
 	}
 
-	if (rt->rt6i_idev->dev == dev || (flags & XT_RPFILTER_LOOSE))
+	if (rt->rt6i_idev->dev == dev ||
+	    l3mdev_master_ifindex_rcu(rt->rt6i_idev->dev) == dev->ifindex ||
+	    (flags & XT_RPFILTER_LOOSE))
 		ret = true;
  out:
 	ip6_rt_put(rt);
-- 
2.20.1

