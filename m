Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1745221422A
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Jul 2020 02:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgGDACe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Jul 2020 20:02:34 -0400
Received: from correo.us.es ([193.147.175.20]:55866 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgGDACe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:02:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7623FED5BE
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 02:02:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 670DCDA72F
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 02:02:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5C858DA78C; Sat,  4 Jul 2020 02:02:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1FB25DA72F
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 02:02:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 04 Jul 2020 02:02:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0E52E4265A32
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 02:02:30 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 2/6] netfilter: nf_tables: add NFTA_RULE_CHAIN_ID attribute
Date:   Sat,  4 Jul 2020 02:02:20 +0200
Message-Id: <20200704000224.32541-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200704000224.32541-1-pablo@netfilter.org>
References: <20200704000224.32541-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This new netlink attribute allows you to add rules to chains by the
chain ID.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes.

 include/uapi/linux/netfilter/nf_tables.h |  1 +
 net/netfilter/nf_tables_api.c            | 36 +++++++++++++++++++++---
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 477779595b78..2304d1b7ba5e 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -240,6 +240,7 @@ enum nft_rule_attributes {
 	NFTA_RULE_PAD,
 	NFTA_RULE_ID,
 	NFTA_RULE_POSITION_ID,
+	NFTA_RULE_CHAIN_ID,
 	__NFTA_RULE_MAX
 };
 #define NFTA_RULE_MAX		(__NFTA_RULE_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 650ef0dd0773..fbe8f9209813 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2153,6 +2153,22 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 	return err;
 }
 
+static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
+					       const struct nlattr *nla)
+{
+	u32 id = ntohl(nla_get_be32(nla));
+	struct nft_trans *trans;
+
+	list_for_each_entry(trans, &net->nft.commit_list, list) {
+		struct nft_chain *chain = trans->ctx.chain;
+
+		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
+		    id == nft_trans_chain_id(trans))
+			return chain;
+	}
+	return ERR_PTR(-ENOENT);
+}
+
 static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 			      struct sk_buff *skb, const struct nlmsghdr *nlh,
 			      const struct nlattr * const nla[],
@@ -2633,6 +2649,7 @@ static const struct nla_policy nft_rule_policy[NFTA_RULE_MAX + 1] = {
 				    .len = NFT_USERDATA_MAXLEN },
 	[NFTA_RULE_ID]		= { .type = NLA_U32 },
 	[NFTA_RULE_POSITION_ID]	= { .type = NLA_U32 },
+	[NFTA_RULE_CHAIN_ID]	= { .type = NLA_U32 },
 };
 
 static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
@@ -3039,10 +3056,21 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 		return PTR_ERR(table);
 	}
 
-	chain = nft_chain_lookup(net, table, nla[NFTA_RULE_CHAIN], genmask);
-	if (IS_ERR(chain)) {
-		NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
-		return PTR_ERR(chain);
+	if (nla[NFTA_RULE_CHAIN]) {
+		chain = nft_chain_lookup(net, table, nla[NFTA_RULE_CHAIN],
+					 genmask);
+		if (IS_ERR(chain)) {
+			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
+			return PTR_ERR(chain);
+		}
+	} else if (nla[NFTA_RULE_CHAIN_ID]) {
+		chain = nft_chain_lookup_byid(net, nla[NFTA_RULE_CHAIN_ID]);
+		if (IS_ERR(chain)) {
+			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
+			return PTR_ERR(chain);
+		}
+	} else {
+		return -EINVAL;
 	}
 
 	if (nla[NFTA_RULE_HANDLE]) {
-- 
2.20.1

