Return-Path: <netfilter-devel+bounces-481-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB281C986
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Dec 2023 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF12B22F89
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Dec 2023 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFF1803E;
	Fri, 22 Dec 2023 11:57:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD791A5A3;
	Fri, 22 Dec 2023 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 8/8] netfilter: nf_tables: validate chain type update if available
Date: Fri, 22 Dec 2023 12:57:14 +0100
Message-Id: <20231222115714.364393-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222115714.364393-1-pablo@netfilter.org>
References: <20231222115714.364393-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse netlink attribute containing the chain type in this update, to
bail out if this is different from the existing type.

Otherwise, it is possible to define a chain with the same name, hook and
priority but different type, which is silently ignored.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4c3de1a2c52b..5531b13d92b6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2261,7 +2261,16 @@ static int nft_chain_parse_hook(struct net *net,
 				return -EOPNOTSUPP;
 		}
 
-		type = basechain->type;
+		if (nla[NFTA_CHAIN_TYPE]) {
+			type = __nf_tables_chain_type_lookup(nla[NFTA_CHAIN_TYPE],
+							     family);
+			if (!type) {
+				NL_SET_BAD_ATTR(extack, nla[NFTA_CHAIN_TYPE]);
+				return -ENOENT;
+			}
+		} else {
+			type = basechain->type;
+		}
 	}
 
 	if (!try_module_get(type->owner)) {
-- 
2.30.2


