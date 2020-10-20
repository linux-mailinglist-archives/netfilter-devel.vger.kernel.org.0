Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A964C286B69
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Oct 2020 01:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgJGXO6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Oct 2020 19:14:58 -0400
Received: from correo.us.es ([193.147.175.20]:45472 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgJGXO6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Oct 2020 19:14:58 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4D0C4E4B87
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 01:14:56 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3EBA2DA704
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 01:14:56 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 34125DA72F; Thu,  8 Oct 2020 01:14:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 22002DA704
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 01:14:54 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 08 Oct 2020 01:14:54 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 0D80B42EF42A
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 01:14:54 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/4] netfilter: add nf_ingress_hook() helper function
Date:   Thu,  8 Oct 2020 01:14:46 +0200
Message-Id: <20201007231448.27346-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007231448.27346-1-pablo@netfilter.org>
References: <20201007231448.27346-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add helper function to check if this is an ingress hook.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index b9ec8ecf7e30..a7639501d78b 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -311,6 +311,11 @@ nf_hook_entry_head(struct net *net, int pf, unsigned int hooknum,
 	return NULL;
 }
 
+static bool nf_ingress_hook(const struct nf_hook_ops *reg, int pf)
+{
+	return pf == NFPROTO_NETDEV && reg->hooknum == NF_NETDEV_INGRESS;
+}
+
 static void nf_static_key_inc(const struct nf_hook_ops *reg, int pf)
 {
 #ifdef CONFIG_JUMP_LABEL
@@ -359,7 +364,7 @@ static int __nf_register_net_hook(struct net *net, int pf,
 
 	hooks_validate(new_hooks);
 #ifdef CONFIG_NETFILTER_INGRESS
-	if (pf == NFPROTO_NETDEV && reg->hooknum == NF_NETDEV_INGRESS)
+	if (nf_ingress_hook(reg, pf))
 		net_inc_ingress_queue();
 #endif
 	nf_static_key_inc(reg, pf);
@@ -416,7 +421,7 @@ static void __nf_unregister_net_hook(struct net *net, int pf,
 
 	if (nf_remove_net_hook(p, reg)) {
 #ifdef CONFIG_NETFILTER_INGRESS
-		if (pf == NFPROTO_NETDEV && reg->hooknum == NF_NETDEV_INGRESS)
+		if (nf_ingress_hook(reg, pf))
 			net_dec_ingress_queue();
 #endif
 		nf_static_key_dec(reg, pf);
-- 
2.20.1

