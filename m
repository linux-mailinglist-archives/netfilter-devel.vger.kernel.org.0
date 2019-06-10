Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214A83B4DB
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jun 2019 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389902AbfFJMYX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jun 2019 08:24:23 -0400
Received: from smtp-out.kfki.hu ([148.6.0.46]:54165 "EHLO smtp-out.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389573AbfFJMYX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:24:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id 6EA703C800FD;
        Mon, 10 Jun 2019 14:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:from:from:received:received
        :received; s=20151130; t=1560169459; x=1561983860; bh=n9xlYtPBiV
        yD5+w46fGZ2Zl+gqxMgKFDoutMiil6Ez8=; b=O0LCx1CUTGkUVeQr3xG+pHdF9X
        PUe7lD8sy09djU/fqVpRyYmmouc1D/JNGvNF2Ww6KJn1kqET7/rwSILW3lW2pYKJ
        Aq1MCswfdN5QlRE6FdPe8SmOS7qrrS+jWH4Ub8jTb7uf5VG2sCNElOy+pE0QoAav
        WkYhqsrZNyLcZZ7h0=
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 10 Jun 2019 14:24:19 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [148.6.240.2])
        by smtp1.kfki.hu (Postfix) with ESMTP id 001253C800FB;
        Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id E75F220B3E; Mon, 10 Jun 2019 14:24:16 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3/7] netfilter: ipset: fix a missing check of nla_parse
Date:   Mon, 10 Jun 2019 14:24:12 +0200
Message-Id: <20190610122416.22708-4-kadlec@blackhole.kfki.hu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610122416.22708-1-kadlec@blackhole.kfki.hu>
References: <20190610122416.22708-1-kadlec@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

When nla_parse fails, we should not use the results (the first
argument). The fix checks if it fails, and if so, returns its error code
upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
---
 net/netfilter/ipset/ip_set_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_s=
et_core.c
index 2ad609900b22..d0f4c627ff91 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1544,10 +1544,14 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, s=
truct ip_set *set,
 		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
 		cmdattr =3D (void *)&errmsg->msg + min_len;
=20
-		nla_parse_deprecated(cda, IPSET_ATTR_CMD_MAX, cmdattr,
-				     nlh->nlmsg_len - min_len,
-				     ip_set_adt_policy, NULL);
+		ret =3D nla_parse_deprecated(cda, IPSET_ATTR_CMD_MAX, cmdattr,
+					   nlh->nlmsg_len - min_len,
+					   ip_set_adt_policy, NULL);
=20
+		if (ret) {
+			nlmsg_free(skb2);
+			return ret;
+		}
 		errline =3D nla_data(cda[IPSET_ATTR_LINENO]);
=20
 		*errline =3D lineno;
--=20
2.20.1

