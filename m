Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C82D910B
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Oct 2019 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393125AbfJPMek (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 08:34:40 -0400
Received: from correo.us.es ([193.147.175.20]:50984 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbfJPMek (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:34:40 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9534318CDD4
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 86ABCA7E18
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:35 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7C29BA7E11; Wed, 16 Oct 2019 14:34:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8F226A7E18
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 16 Oct 2019 14:34:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 7610342EE38F
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Oct 2019 14:34:33 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/4] netfilter: nf_flow_table: move priority to struct nf_flowtable
Date:   Wed, 16 Oct 2019 14:34:28 +0200
Message-Id: <20191016123431.9072-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191016123431.9072-1-pablo@netfilter.org>
References: <20191016123431.9072-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hardware offload needs access to the priority field, store this field in
the nf_flowtable object.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_flow_table.h |  1 +
 include/net/netfilter/nf_tables.h     |  2 --
 net/netfilter/nf_tables_api.c         | 10 +++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index b37a7d608134..158514281a75 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -24,6 +24,7 @@ struct nf_flowtable_type {
 struct nf_flowtable {
 	struct list_head		list;
 	struct rhashtable		rhashtable;
+	int				priority;
 	const struct nf_flowtable_type	*type;
 	struct delayed_work		gc_work;
 };
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 001d294edf57..d529dfb5aa64 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1155,7 +1155,6 @@ void nft_unregister_obj(struct nft_object_type *obj_type);
  * 	@table: the table the flow table is contained in
  *	@name: name of this flow table
  *	@hooknum: hook number
- *	@priority: hook priority
  *	@ops_len: number of hooks in array
  *	@genmask: generation mask
  *	@use: number of references to this flow table
@@ -1169,7 +1168,6 @@ struct nft_flowtable {
 	struct nft_table		*table;
 	char				*name;
 	int				hooknum;
-	int				priority;
 	int				ops_len;
 	u32				genmask:2,
 					use:30;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d481f9baca2f..bfea0d6effc5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5706,10 +5706,10 @@ static int nf_tables_flowtable_parse_hook(const struct nft_ctx *ctx,
 	if (!ops)
 		return -ENOMEM;
 
-	flowtable->hooknum	= hooknum;
-	flowtable->priority	= priority;
-	flowtable->ops		= ops;
-	flowtable->ops_len	= n;
+	flowtable->hooknum		= hooknum;
+	flowtable->data.priority	= priority;
+	flowtable->ops			= ops;
+	flowtable->ops_len		= n;
 
 	for (i = 0; i < n; i++) {
 		flowtable->ops[i].pf		= NFPROTO_NETDEV;
@@ -5969,7 +5969,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 	if (!nest)
 		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_FLOWTABLE_HOOK_NUM, htonl(flowtable->hooknum)) ||
-	    nla_put_be32(skb, NFTA_FLOWTABLE_HOOK_PRIORITY, htonl(flowtable->priority)))
+	    nla_put_be32(skb, NFTA_FLOWTABLE_HOOK_PRIORITY, htonl(flowtable->data.priority)))
 		goto nla_put_failure;
 
 	nest_devs = nla_nest_start_noflag(skb, NFTA_FLOWTABLE_HOOK_DEVS);
-- 
2.11.0

