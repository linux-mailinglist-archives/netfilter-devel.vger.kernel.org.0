Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5212A798CA
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 22:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfG2TeA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Jul 2019 15:34:00 -0400
Received: from smtp-out.kfki.hu ([148.6.0.48]:43343 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388048AbfG2Td7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:33:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id DA7ADCC0104;
        Mon, 29 Jul 2019 21:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:from:from:received:received
        :received; s=20151130; t=1564428834; x=1566243235; bh=bp59LHP0eE
        iFa3K26GxorPUVWVezu2C4uUOX+XbORf4=; b=MLs+ai41oDSA0hzr7r3gyCfdk8
        qGXFM03So/xqRBpig2912/RrfoGa6y5qjnhkTtLhhLTOc7jGRUhcshHuScg18vv0
        X5+c6bEBdRdsTJEL4b3jgMYs11xBlcd+Q/6Lr1qrwB5kzl/f2kWxLJhfVmDAXmv3
        /WIvkzHQEko1EabvA=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 29 Jul 2019 21:33:54 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [IPv6:2001:738:5001:1::240:2])
        by smtp2.kfki.hu (Postfix) with ESMTP id D1060CC00F4;
        Mon, 29 Jul 2019 21:33:54 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id B766D207E9; Mon, 29 Jul 2019 21:33:54 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 1/3] netfilter: ipset: Actually allow destination MAC address for hash:ip,mac sets too
Date:   Mon, 29 Jul 2019 21:33:52 +0200
Message-Id: <20190729193354.26559-2-kadlec@blackhole.kfki.hu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729193354.26559-1-kadlec@blackhole.kfki.hu>
References: <20190729193354.26559-1-kadlec@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>

In commit 8cc4ccf58379 ("ipset: Allow matching on destination MAC address
for mac and ipmac sets"), ipset.git commit 1543514c46a7, I removed the
KADT check that prevents matching on destination MAC addresses for
hash:mac sets, but forgot to remove the same check for hash:ip,mac set.

Drop this check: functionality is now commented in man pages and there's
no reason to restrict to source MAC address matching anymore.

Reported-by: Chen Yi <yiche@redhat.com>
Fixes: 8cc4ccf58379 ("ipset: Allow matching on destination MAC address fo=
r mac and ipmac sets")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_hash_ipmac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_ipmac.c b/net/netfilter/ipse=
t/ip_set_hash_ipmac.c
index faf59b6a998f..eb1443408320 100644
--- a/net/netfilter/ipset/ip_set_hash_ipmac.c
+++ b/net/netfilter/ipset/ip_set_hash_ipmac.c
@@ -89,10 +89,6 @@ hash_ipmac4_kadt(struct ip_set *set, const struct sk_b=
uff *skb,
 	struct hash_ipmac4_elem e =3D { .ip =3D 0, { .foo[0] =3D 0, .foo[1] =3D=
 0 } };
 	struct ip_set_ext ext =3D IP_SET_INIT_KEXT(skb, opt, set);
=20
-	 /* MAC can be src only */
-	if (!(opt->flags & IPSET_DIM_TWO_SRC))
-		return 0;
-
 	if (skb_mac_header(skb) < skb->head ||
 	    (skb_mac_header(skb) + ETH_HLEN) > skb->data)
 		return -EINVAL;
--=20
2.20.1

