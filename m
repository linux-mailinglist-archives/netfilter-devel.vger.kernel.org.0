Return-Path: <netfilter-devel+bounces-764-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B5C83B1EE
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jan 2024 20:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453251C22EDA
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jan 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7F133418;
	Wed, 24 Jan 2024 19:12:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C5132C04;
	Wed, 24 Jan 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123579; cv=none; b=OoVXW1MYQWDUQ8wv9qmxf7k75nNd9GjR8UJPZP1VrYUe9ixdHzaEEr6FWzPaDY7M8/oHFG1g8ynE0A22cPNnXeh2kpsVU+V6OV4Gq6OP6GkfkHaqnK582mB+SDiLvAVzttoA5/2LknWY6DlKHHJ8RTYRYjydpm7dJfKQboQ2dSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123579; c=relaxed/simple;
	bh=a9RJaQcXDE2ki+6h0E8TsoXaM2cfkPsCs0FQbPPOCQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAUKj9G1VkmX8QUh2FKiaE96Nsk0jlOJ1AlwY24CSK+FSQvpWdITqwv8HDWWXKI1QxQsytnZoiINvcJVqMLvfAEPNTknOf/PcLZ/FhxUbL0ueje0i5q9DyjK/N6AJ5ZopFdd6zzk1FIYG3hk2QGkTh19WsBGb5pOHm5rFOVkFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
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
Subject: [PATCH net 5/6] netfilter: nf_tables: reject QUEUE/DROP verdict parameters
Date: Wed, 24 Jan 2024 20:12:47 +0100
Message-Id: <20240124191248.75463-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124191248.75463-1-pablo@netfilter.org>
References: <20240124191248.75463-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

This reverts commit e0abdadcc6e1.

core.c:nf_hook_slow assumes that the upper 16 bits of NF_DROP
verdicts contain a valid errno, i.e. -EPERM, -EHOSTUNREACH or similar,
or 0.

Due to the reverted commit, its possible to provide a positive
value, e.g. NF_ACCEPT (1), which results in use-after-free.

Its not clear to me why this commit was made.

NF_QUEUE is not used by nftables; "queue" rules in nftables
will result in use of "nft_queue" expression.

If we later need to allow specifiying errno values from userspace
(do not know why), this has to call NF_DROP_GETERR and check that
"err <= 0" holds true.

Fixes: e0abdadcc6e1 ("netfilter: nf_tables: accept QUEUE/DROP verdict parameters")
Cc: stable@vger.kernel.org
Reported-by: Notselwyn <notselwyn@pwning.tech>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 02f45424644b..c537104411e7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10992,16 +10992,10 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
-	default:
-		switch (data->verdict.code & NF_VERDICT_MASK) {
-		case NF_ACCEPT:
-		case NF_DROP:
-		case NF_QUEUE:
-			break;
-		default:
-			return -EINVAL;
-		}
-		fallthrough;
+	case NF_ACCEPT:
+	case NF_DROP:
+	case NF_QUEUE:
+		break;
 	case NFT_CONTINUE:
 	case NFT_BREAK:
 	case NFT_RETURN:
@@ -11036,6 +11030,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 		data->verdict.chain = chain;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	desc->len = sizeof(data->verdict);
-- 
2.30.2


