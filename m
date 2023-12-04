Return-Path: <netfilter-devel+bounces-147-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A85803598
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 14:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDFA1F2109D
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE425574;
	Mon,  4 Dec 2023 13:54:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52A62DF
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Dec 2023 05:54:48 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: validate family when identifying table via handle
Date: Mon,  4 Dec 2023 14:54:44 +0100
Message-Id: <20231204135444.3881-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate table family when looking up for it via NFTA_TABLE_HANDLE.

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Fixes: 3ecbfd65f50e ("netfilter: nf_tables: allocate handle and delete objects via handle")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c0a42989b982..c5c17c6e80ed 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -803,7 +803,7 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 
 static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
-						   u8 genmask, u32 nlpid)
+						   int family, u8 genmask, u32 nlpid)
 {
 	struct nftables_pernet *nft_net;
 	struct nft_table *table;
@@ -811,6 +811,7 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 	nft_net = nft_pernet(net);
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
+		    table->family == family &&
 		    nft_active_genmask(table, genmask)) {
 			if (nft_table_has_owner(table) &&
 			    nlpid && table->nlpid != nlpid)
@@ -1544,7 +1545,7 @@ static int nf_tables_deltable(struct sk_buff *skb, const struct nfnl_info *info,
 
 	if (nla[NFTA_TABLE_HANDLE]) {
 		attr = nla[NFTA_TABLE_HANDLE];
-		table = nft_table_lookup_byhandle(net, attr, genmask,
+		table = nft_table_lookup_byhandle(net, attr, family, genmask,
 						  NETLINK_CB(skb).portid);
 	} else {
 		attr = nla[NFTA_TABLE_NAME];
-- 
2.30.2


