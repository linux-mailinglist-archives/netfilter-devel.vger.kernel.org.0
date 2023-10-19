Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944C67D025F
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Oct 2023 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345872AbjJSTTq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Oct 2023 15:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbjJSTTq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:19:46 -0400
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFBCF
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Oct 2023 12:19:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id E6A63CC02C5;
        Thu, 19 Oct 2023 21:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:from:from:received:received
        :received; s=20151130; t=1697743178; x=1699557579; bh=n7MqbeVNSY
        ZzgO900Lf4v1aSl3huwnLNfn1Psh3CoLk=; b=JMGTh4n0kcuw0WNXLt4VdMKpj5
        nvZoRYpcas/ciXGgI1khfppIsBdxrUqzmCdCwCI5xoATS0esiIK9la2ryK4W1uyB
        9vAoU6YCNEwrjwm9ru3IwPNdYOz3e8WWykVBf2Hdi0debNOLaMlljnrAfyBQb6zG
        t0BTeZ7EnJ4GAUn4I=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Thu, 19 Oct 2023 21:19:38 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 2F7EFCC02BE;
        Thu, 19 Oct 2023 21:19:37 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id D79763431A8; Thu, 19 Oct 2023 21:19:37 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: [PATCH 1/1] netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test
Date:   Thu, 19 Oct 2023 21:19:37 +0200
Message-Id: <20231019191937.3931271-2-kadlec@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231019191937.3931271-1-kadlec@netfilter.org>
References: <20231019191937.3931271-1-kadlec@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Linkui Xiao reported that there's a race condition when ipset swap and de=
stroy is
called, which can lead to crash in add/del/test element operations. Swap =
then
destroy are usual operations to replace a set with another one in a produ=
ction
system. The issue can in some cases be reproduced with the script:

ipset create hash_ip1 hash:net family inet hashsize 1024 maxelem 1048576
ipset add hash_ip1 172.20.0.0/16
ipset add hash_ip1 192.168.0.0/16
iptables -A INPUT -m set --match-set hash_ip1 src -j ACCEPT
while [ 1 ]
do
	# ... Ongoing traffic...
        ipset create hash_ip2 hash:net family inet hashsize 1024 maxelem =
1048576
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

Swap replaces hash_ip1 with hash_ip2 and then destroy removes hash_ip2 wh=
ich
is the original hash_ip1. ip_set_test was called on hash_ip1 and because =
destroy
removed it, hash_net_kadt crashes.

The fix is to protect both the list of the sets and the set pointers in a=
n extended RCU
region and before calling destroy, wait to finish all started rcu_read_lo=
ck().

The first version of the patch was written by Linkui Xiao <xiaolinkui@kyl=
inos.cn>.

Closes: https://lore.kernel.org/all/69e7963b-e7f8-3ad0-210-7b86eebf7f78@n=
etfilter.org/
Reported by: Linkui Xiao <xiaolinkui@kylinos.cn>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
---
 net/netfilter/ipset/ip_set_core.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_s=
et_core.c
index e564b5174261..7eedd2825e0c 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -704,13 +704,18 @@ ip_set_rcu_get(struct net *net, ip_set_id_t index)
 	struct ip_set_net *inst =3D ip_set_pernet(net);
=20
 	rcu_read_lock();
-	/* ip_set_list itself needs to be protected */
+	/* ip_set_list and the set pointer need to be protected */
 	set =3D rcu_dereference(inst->ip_set_list)[index];
-	rcu_read_unlock();
=20
 	return set;
 }
=20
+static inline void
+ip_set_rcu_put(struct ip_set *set __always_unused)
+{
+	rcu_read_unlock();
+}
+
 static inline void
 ip_set_lock(struct ip_set *set)
 {
@@ -736,8 +741,10 @@ ip_set_test(ip_set_id_t index, const struct sk_buff =
*skb,
 	pr_debug("set %s, index %u\n", set->name, index);
=20
 	if (opt->dim < set->type->dimension ||
-	    !(opt->family =3D=3D set->family || set->family =3D=3D NFPROTO_UNSP=
EC))
+	    !(opt->family =3D=3D set->family || set->family =3D=3D NFPROTO_UNSP=
EC)) {
+		ip_set_rcu_put(set);
 		return 0;
+	}
=20
 	ret =3D set->variant->kadt(set, skb, par, IPSET_TEST, opt);
=20
@@ -756,6 +763,7 @@ ip_set_test(ip_set_id_t index, const struct sk_buff *=
skb,
 			ret =3D -ret;
 	}
=20
+	ip_set_rcu_put(set);
 	/* Convert error codes to nomatch */
 	return (ret < 0 ? 0 : ret);
 }
@@ -772,12 +780,15 @@ ip_set_add(ip_set_id_t index, const struct sk_buff =
*skb,
 	pr_debug("set %s, index %u\n", set->name, index);
=20
 	if (opt->dim < set->type->dimension ||
-	    !(opt->family =3D=3D set->family || set->family =3D=3D NFPROTO_UNSP=
EC))
+	    !(opt->family =3D=3D set->family || set->family =3D=3D NFPROTO_UNSP=
EC)) {
+		ip_set_rcu_put(set);
 		return -IPSET_ERR_TYPE_MISMATCH;
+	}
=20
 	ip_set_lock(set);
 	ret =3D set->variant->kadt(set, skb, par, IPSET_ADD, opt);
 	ip_set_unlock(set);
+	ip_set_rcu_put(set);
=20
 	return ret;
 }
@@ -794,12 +805,15 @@ ip_set_del(ip_set_id_t index, const struct sk_buff =
*skb,
 	pr_debug("set %s, index %u\n", set->name, index);
=20
 	if (opt->dim < set->type->dimension ||
-	    !(opt->family =3D=3D set->family || set->family =3D=3D NFPROTO_UNSP=
EC))
+	    !(opt->family =3D=3D set->family || set->family =3D=3D NFPROTO_UNSP=
EC)) {
+		ip_set_rcu_put(set);
 		return -IPSET_ERR_TYPE_MISMATCH;
+	}
=20
 	ip_set_lock(set);
 	ret =3D set->variant->kadt(set, skb, par, IPSET_DEL, opt);
 	ip_set_unlock(set);
+	ip_set_rcu_put(set);
=20
 	return ret;
 }
@@ -874,6 +888,7 @@ ip_set_name_byindex(struct net *net, ip_set_id_t inde=
x, char *name)
 	read_lock_bh(&ip_set_ref_lock);
 	strscpy_pad(name, set->name, IPSET_MAXNAMELEN);
 	read_unlock_bh(&ip_set_ref_lock);
+	ip_set_rcu_put(set);
 }
 EXPORT_SYMBOL_GPL(ip_set_name_byindex);
=20
@@ -1188,6 +1203,9 @@ static int ip_set_destroy(struct sk_buff *skb, cons=
t struct nfnl_info *info,
 	if (unlikely(protocol_min_failed(attr)))
 		return -IPSET_ERR_PROTOCOL;
=20
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	/* Must wait for flush to be really finished in list:set */
 	rcu_barrier();
=20
--=20
2.30.2

