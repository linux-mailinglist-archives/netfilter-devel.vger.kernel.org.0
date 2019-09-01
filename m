Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A7A4C17
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Sep 2019 23:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfIAVB1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Sep 2019 17:01:27 -0400
Received: from kadath.azazel.net ([81.187.231.250]:53594 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfIAVB0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=r9S7Dxs7DO9XiJ41OrTPUN98EC2kOoXhONqBWFJaaFo=; b=c5jLqD5kT1eqwilEMn/T89SDXV
        aKUPr8LYyVOoFD6mmqmET2tMKkuSrEBKB3dV46opiYXwCnmqpittWMht/pqNQ95roce1358hAY3EL
        VdqSoCgrSI89S5QRiEibPrHOoJ8LYiGeisfmrf+y8rRymarfxzpeEVXY5sldbWK3XYTGf+fpYqcAJ
        7vgTtFfadG8y+puNZk4MoqYggz5ZRFIaz9z34BYCRwkX/HVybxT+4WmOrveFYorVzWEZ6zAazp0T7
        7xQmKJX3HtNiJonriCuZ26gRhIkNsPkCrNzbdMgWWhD2rK3Dn4xdEv+gDKvalLfyAA8PU3tRpp2Tt
        XCBf2GNg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4Wor-0002Uf-Hz; Sun, 01 Sep 2019 21:51:29 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 22/29] netfilter: wrap some nat-related conntrack code in a CONFIG_NF_NAT check.
Date:   Sun,  1 Sep 2019 21:51:18 +0100
Message-Id: <20190901205126.6935-23-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190901205126.6935-1-jeremy@azazel.net>
References: <20190901205126.6935-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_conntrack_update uses nf_nat_hook to do some nat stuff.  However, it
will only be not NULL if CONFIG_NF_NAT is enabled.  Wrap the code in a
CONFIG_NF_NAT check to skip it altogether.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nf_conntrack_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 81a8ef42b88d..c597b3e8450b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1885,7 +1885,9 @@ static int nf_conntrack_update(struct net *net, struct sk_buff *skb)
 	struct nf_conntrack_tuple_hash *h;
 	struct nf_conntrack_tuple tuple;
 	enum ip_conntrack_info ctinfo;
+#if IS_ENABLED(CONFIG_NF_NAT)
 	struct nf_nat_hook *nat_hook;
+#endif
 	unsigned int status;
 	struct nf_conn *ct;
 	int dataoff;
@@ -1935,6 +1937,7 @@ static int nf_conntrack_update(struct net *net, struct sk_buff *skb)
 	ct = nf_ct_tuplehash_to_ctrack(h);
 	nf_ct_set(skb, ct, ctinfo);
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 	nat_hook = rcu_dereference(nf_nat_hook);
 	if (!nat_hook)
 		return 0;
@@ -1948,6 +1951,7 @@ static int nf_conntrack_update(struct net *net, struct sk_buff *skb)
 	    nat_hook->manip_pkt(skb, ct, NF_NAT_MANIP_DST,
 				IP_CT_DIR_ORIGINAL) == NF_DROP)
 		return -1;
+#endif
 
 	return 0;
 }
-- 
2.23.0.rc1

