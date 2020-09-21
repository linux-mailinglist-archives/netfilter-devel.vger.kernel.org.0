Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403B52725AE
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Sep 2020 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUNfv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Sep 2020 09:35:51 -0400
Received: from mx1.riseup.net ([198.252.153.129]:40556 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIUNfu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:35:50 -0400
Received: from bell.riseup.net (bell-pn.riseup.net [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Bw4z54rYfzFdwP;
        Mon, 21 Sep 2020 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1600694945; bh=8rn7kDAAijHk3O8tDcXEWY7DP7elCS9PE1/nTiho9Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UagbDtkpQGF9epx6m7fVVtQ2EllKHXM6Z7uEh8l8C2bQG2c2nFVUBxDIJ0AG2fj6Q
         ulyHQcDOWxYUydKh06rEVvBmejh4hEjDJS/EEdajlrZ+HPbwK8h6L2309ED4sHIj8g
         IkWKxr5FGdHBoRoJ39m/C7gVjKKk6f8WDGEcVXBc=
X-Riseup-User-ID: 7BF4991D0C40CD34D39359B3F88545BF375379A8CF01C36C85C2F48812E3E130
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 4Bw4z46TK1zJnD0;
        Mon, 21 Sep 2020 06:29:04 -0700 (PDT)
From:   "Jose M. Guisado Gomez" <guigom@riseup.net>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/3] netfilter: nf_tables: add userdata attributes to nft_chain
Date:   Mon, 21 Sep 2020 15:28:21 +0200
Message-Id: <20200921132822.55231-2-guigom@riseup.net>
In-Reply-To: <20200921132822.55231-1-guigom@riseup.net>
References: <20200921132822.55231-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Enables storing userdata for nft_chain. Field udata points to user data
and udlen stores its length.

Adds new attribute flag NFTA_CHAIN_USERDATA.

Signed-off-by: Jose M. Guisado Gomez <guigom@riseup.net>
---
 include/net/netfilter/nf_tables.h        |  2 ++
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c            | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 8ceca0e419b3..4686fafbfd8a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -952,6 +952,8 @@ struct nft_chain {
 					bound:1,
 					genmask:2;
 	char				*name;
+	u16				udlen;
+	u8				*udata;
 
 	/* Only used during control plane commit phase: */
 	struct nft_rule			**rules_next;
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 3c2469b43742..352ee51707a1 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -208,6 +208,7 @@ enum nft_chain_flags {
  * @NFTA_CHAIN_COUNTERS: counter specification of the chain (NLA_NESTED: nft_counter_attributes)
  * @NFTA_CHAIN_FLAGS: chain flags
  * @NFTA_CHAIN_ID: uniquely identifies a chain in a transaction (NLA_U32)
+ * @NFTA_CHAIN_USERDATA: user data (NLA_BINARY)
  */
 enum nft_chain_attributes {
 	NFTA_CHAIN_UNSPEC,
@@ -222,6 +223,7 @@ enum nft_chain_attributes {
 	NFTA_CHAIN_PAD,
 	NFTA_CHAIN_FLAGS,
 	NFTA_CHAIN_ID,
+	NFTA_CHAIN_USERDATA,
 	__NFTA_CHAIN_MAX
 };
 #define NFTA_CHAIN_MAX		(__NFTA_CHAIN_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 84c0c1aaae99..c8065c6eae86 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1306,6 +1306,8 @@ static const struct nla_policy nft_chain_policy[NFTA_CHAIN_MAX + 1] = {
 	[NFTA_CHAIN_COUNTERS]	= { .type = NLA_NESTED },
 	[NFTA_CHAIN_FLAGS]	= { .type = NLA_U32 },
 	[NFTA_CHAIN_ID]		= { .type = NLA_U32 },
+	[NFTA_CHAIN_USERDATA]	= { .type = NLA_BINARY,
+				    .len = NFT_USERDATA_MAXLEN },
 };
 
 static const struct nla_policy nft_hook_policy[NFTA_HOOK_MAX + 1] = {
@@ -1447,6 +1449,10 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 	if (nla_put_be32(skb, NFTA_CHAIN_USE, htonl(chain->use)))
 		goto nla_put_failure;
 
+	if (chain->udata &&
+	    nla_put(skb, NFTA_CHAIN_USERDATA, chain->udlen, chain->udata))
+		goto nla_put_failure;
+
 	nlmsg_end(skb, nlh);
 	return 0;
 
@@ -1978,6 +1984,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	struct nft_trans *trans;
 	struct nft_chain *chain;
 	struct nft_rule **rules;
+	u16 udlen = 0;
 	int err;
 
 	if (table->use == UINT_MAX)
@@ -2052,6 +2059,18 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		goto err1;
 	}
 
+	if (nla[NFTA_CHAIN_USERDATA]) {
+		udlen = nla_len(nla[NFTA_CHAIN_USERDATA]);
+		chain->udata = kzalloc(udlen, GFP_KERNEL);
+		if (chain->udata == NULL) {
+			err = -ENOMEM;
+			goto err1;
+		}
+
+		nla_memcpy(chain->udata, nla[NFTA_CHAIN_USERDATA], udlen);
+		chain->udlen = udlen;
+	}
+
 	rules = nf_tables_chain_alloc_rules(chain, 0);
 	if (!rules) {
 		err = -ENOMEM;
-- 
2.27.0

