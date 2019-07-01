Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972FE3B4DA
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jun 2019 14:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389884AbfFJMYW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jun 2019 08:24:22 -0400
Received: from smtp-out.kfki.hu ([148.6.0.46]:50381 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389831AbfFJMYV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:24:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id BC87C3C800F5;
        Mon, 10 Jun 2019 14:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:from:from:received:received
        :received; s=20151130; t=1560169457; x=1561983858; bh=ZOqmCwAeHN
        XXqHubWMo6iQ2KUKE5EIsmXb1Qk1qpXgA=; b=ZAtwAxHW/iNXGBVfPvUekJTbLP
        EEUTlZ8eKrLX7xZH1PyicpQp2kw1vKxISix+V61cp5p/DK5AgkVA8uHdBXKlRJDH
        qklWpictYpRZINLogh4WlkzAklLZ8b8BZJMqCrfpdbUVRISRXJBPvAP1x2kg2Lql
        TbgjlxDT2irNAbsZ0=
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 10 Jun 2019 14:24:17 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [148.6.240.2])
        by smtp1.kfki.hu (Postfix) with ESMTP id D6EB73C800F6;
        Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id C0D6920B3E; Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 1/7] netfilter: ipset: remove useless memset() calls
Date:   Mon, 10 Jun 2019 14:24:10 +0200
Message-Id: <20190610122416.22708-2-kadlec@blackhole.kfki.hu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610122416.22708-1-kadlec@blackhole.kfki.hu>
References: <20190610122416.22708-1-kadlec@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florent Fourcot <florent.fourcot@wifirst.fr>

One of the memset call is buggy: it does not erase full array, but only p=
ointer size.
Moreover, after a check, first step of nla_parse_nested/nla_parse is to
erase tb array as well. We can remove both calls safely.

Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
---
 net/netfilter/ipset/ip_set_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_s=
et_core.c
index 3f4a4936f63c..faddcf398b73 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1599,7 +1599,6 @@ static int ip_set_uadd(struct net *net, struct sock=
 *ctnl, struct sk_buff *skb,
 		int nla_rem;
=20
 		nla_for_each_nested(nla, attr[IPSET_ATTR_ADT], nla_rem) {
-			memset(tb, 0, sizeof(tb));
 			if (nla_type(nla) !=3D IPSET_ATTR_DATA ||
 			    !flag_nested(nla) ||
 			    nla_parse_nested_deprecated(tb, IPSET_ATTR_ADT_MAX, nla, set->typ=
e->adt_policy, NULL))
@@ -1651,7 +1650,6 @@ static int ip_set_udel(struct net *net, struct sock=
 *ctnl, struct sk_buff *skb,
 		int nla_rem;
=20
 		nla_for_each_nested(nla, attr[IPSET_ATTR_ADT], nla_rem) {
-			memset(tb, 0, sizeof(*tb));
 			if (nla_type(nla) !=3D IPSET_ATTR_DATA ||
 			    !flag_nested(nla) ||
 			    nla_parse_nested_deprecated(tb, IPSET_ATTR_ADT_MAX, nla, set->typ=
e->adt_policy, NULL))
--=20
2.20.1

