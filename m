Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D07E5AAD
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Nov 2023 16:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjKHP6Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Nov 2023 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjKHP6N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:58:13 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF021FDB;
        Wed,  8 Nov 2023 07:58:11 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, fw@strlen.de,
        kadlec@netfilter.org
Subject: [PATCH net 5/5] netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses
Date:   Wed,  8 Nov 2023 16:58:02 +0100
Message-Id: <20231108155802.84617-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231108155802.84617-1-pablo@netfilter.org>
References: <20231108155802.84617-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

The ipv6 redirect target was derived from the ipv4 one, i.e. its
identical to a 'dnat' with the first (primary) address assigned to the
network interface.  The code has been moved around to make it usable
from nf_tables too, but its still the same as it was back when this
was added in 2012.

IPv6, however, has different types of addresses, if the 'wrong' address
comes first the redirection does not work.

In Daniels case, the addresses are:
  inet6 ::ffff:192 ...
  inet6 2a01: ...

... so the function attempts to redirect to the mapped address.

Add more checks before the address is deemed correct:
1. If the packets' daddr is scoped, search for a scoped address too
2. skip tentative addresses
3. skip mapped addresses

Use the first address that appears to match our needs.

Reported-by: Daniel Huhardeaux <tech@tootai.net>
Closes: https://lore.kernel.org/netfilter/71be06b8-6aa0-4cf9-9e0b-e2839b01b22f@tootai.net/
Fixes: 115e23ac78f8 ("netfilter: ip6tables: add REDIRECT target")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_nat_redirect.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_redirect.c b/net/netfilter/nf_nat_redirect.c
index 6616ba5d0b04..5b37487d9d11 100644
--- a/net/netfilter/nf_nat_redirect.c
+++ b/net/netfilter/nf_nat_redirect.c
@@ -80,6 +80,26 @@ EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv4);
 
 static const struct in6_addr loopback_addr = IN6ADDR_LOOPBACK_INIT;
 
+static bool nf_nat_redirect_ipv6_usable(const struct inet6_ifaddr *ifa, unsigned int scope)
+{
+	unsigned int ifa_addr_type = ipv6_addr_type(&ifa->addr);
+
+	if (ifa_addr_type & IPV6_ADDR_MAPPED)
+		return false;
+
+	if ((ifa->flags & IFA_F_TENTATIVE) && (!(ifa->flags & IFA_F_OPTIMISTIC)))
+		return false;
+
+	if (scope) {
+		unsigned int ifa_scope = ifa_addr_type & IPV6_ADDR_SCOPE_MASK;
+
+		if (!(scope & ifa_scope))
+			return false;
+	}
+
+	return true;
+}
+
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
@@ -89,14 +109,19 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 	if (hooknum == NF_INET_LOCAL_OUT) {
 		newdst.in6 = loopback_addr;
 	} else {
+		unsigned int scope = ipv6_addr_scope(&ipv6_hdr(skb)->daddr);
 		struct inet6_dev *idev;
-		struct inet6_ifaddr *ifa;
 		bool addr = false;
 
 		idev = __in6_dev_get(skb->dev);
 		if (idev != NULL) {
+			const struct inet6_ifaddr *ifa;
+
 			read_lock_bh(&idev->lock);
 			list_for_each_entry(ifa, &idev->addr_list, if_list) {
+				if (!nf_nat_redirect_ipv6_usable(ifa, scope))
+					continue;
+
 				newdst.in6 = ifa->addr;
 				addr = true;
 				break;
-- 
2.30.2

