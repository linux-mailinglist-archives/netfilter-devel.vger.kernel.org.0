Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5808F24B0F5
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Aug 2020 10:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgHTIUg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Aug 2020 04:20:36 -0400
Received: from mx1.riseup.net ([198.252.153.129]:39108 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgHTIUZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:20:25 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BXHdZ4zy7zFmbX;
        Thu, 20 Aug 2020 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1597911624; bh=sT8u2dC6OdCQ/lshkv7yIMl2ayMYtYU4A58ILA6I2U0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2USWUbBykFtglPcENNX+6AC73Qyu20JwhRFpDUBvuF3sp4Yg7xBN9oTTW0NeEeW/
         GWH7kha+0uVfoFS/MpgdjUksOdnSVF1R7tv5JK2ipHyExfFnAR7isAn7KRcLhd6/Jk
         ZAJra7qXtlBQBkAW8094UrDWMosJz5HnflcmPsmM=
X-Riseup-User-ID: C2532B2E9616002DD2BD9526933F579330C146ACED4772CA5E74743C2DEF7D1D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BXHdY6BxNz8vX8;
        Thu, 20 Aug 2020 01:20:17 -0700 (PDT)
From:   "Jose M. Guisado Gomez" <guigom@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org
Subject: [PATCH nf-next 1/3] netfilter: nf_tables: add userdata attributes to nft_table
Date:   Thu, 20 Aug 2020 10:19:01 +0200
Message-Id: <20200820081903.36781-2-guigom@riseup.net>
In-Reply-To: <20200820081903.36781-1-guigom@riseup.net>
References: <20200820081903.36781-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Enables storing userdata for nft_table. Field udata points to user data
and udlen store its length.

Adds new attribute flag NFTA_TABLE_USERDATA

Signed-off-by: Jose M. Guisado Gomez <guigom@riseup.net>
---
 include/net/netfilter/nf_tables.h        |  2 ++
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c            | 25 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index bf9491b77d16..97a7e147a59a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1080,6 +1080,8 @@ struct nft_table {
 					flags:8,
 					genmask:2;
 	char				*name;
+	u16				udlen;
+	u8				*udata;
 };
 
 void nft_register_chain_type(const struct nft_chain_type *);
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 42f351c1f5c5..aeb88cbd303e 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -172,6 +172,7 @@ enum nft_table_flags {
  * @NFTA_TABLE_NAME: name of the table (NLA_STRING)
  * @NFTA_TABLE_FLAGS: bitmask of enum nft_table_flags (NLA_U32)
  * @NFTA_TABLE_USE: number of chains in this table (NLA_U32)
+ * @NFTA_TABLE_USERDATA: user data (NLA_BINARY)
  */
 enum nft_table_attributes {
 	NFTA_TABLE_UNSPEC,
@@ -180,6 +181,7 @@ enum nft_table_attributes {
 	NFTA_TABLE_USE,
 	NFTA_TABLE_HANDLE,
 	NFTA_TABLE_PAD,
+	NFTA_TABLE_USERDATA,
 	__NFTA_TABLE_MAX
 };
 #define NFTA_TABLE_MAX		(__NFTA_TABLE_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d878e34e3354..ca240a990eea 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -650,6 +650,8 @@ static const struct nla_policy nft_table_policy[NFTA_TABLE_MAX + 1] = {
 				    .len = NFT_TABLE_MAXNAMELEN - 1 },
 	[NFTA_TABLE_FLAGS]	= { .type = NLA_U32 },
 	[NFTA_TABLE_HANDLE]	= { .type = NLA_U64 },
+	[NFTA_TABLE_USERDATA]	= { .type = NLA_BINARY,
+				    .len = NFT_USERDATA_MAXLEN }
 };
 
 static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
@@ -676,6 +678,11 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 			 NFTA_TABLE_PAD))
 		goto nla_put_failure;
 
+	if (table->udata) {
+		if (nla_put(skb, NFTA_TABLE_USERDATA, table->udlen, table->udata))
+			goto nla_put_failure;
+	}
+
 	nlmsg_end(skb, nlh);
 	return 0;
 
@@ -980,6 +987,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	u32 flags = 0;
 	struct nft_ctx ctx;
 	int err;
+	u16 udlen = 0;
 
 	lockdep_assert_held(&net->nft.commit_mutex);
 	attr = nla[NFTA_TABLE_NAME];
@@ -1005,6 +1013,7 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 			return -EINVAL;
 	}
 
+
 	err = -ENOMEM;
 	table = kzalloc(sizeof(*table), GFP_KERNEL);
 	if (table == NULL)
@@ -1014,6 +1023,20 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 	if (table->name == NULL)
 		goto err_strdup;
 
+	if (nla[NFTA_TABLE_USERDATA]) {
+		udlen = nla_len(nla[NFTA_TABLE_USERDATA]);
+		table->udata = kzalloc(udlen, GFP_KERNEL);
+		if (table->udata == NULL)
+			goto err_table_udata;
+	} else {
+		table->udata = NULL;
+	}
+
+	if (udlen) {
+		nla_memcpy(table->udata, nla[NFTA_TABLE_USERDATA], udlen);
+		table->udlen = udlen;
+	}
+
 	err = rhltable_init(&table->chains_ht, &nft_chain_ht_params);
 	if (err)
 		goto err_chain_ht;
@@ -1036,6 +1059,8 @@ static int nf_tables_newtable(struct net *net, struct sock *nlsk,
 err_trans:
 	rhltable_destroy(&table->chains_ht);
 err_chain_ht:
+	kfree(table->udata);
+err_table_udata:
 	kfree(table->name);
 err_strdup:
 	kfree(table);
-- 
2.27.0

