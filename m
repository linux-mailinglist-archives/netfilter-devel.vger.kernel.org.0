Return-Path: <netfilter-devel+bounces-3634-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BC969066
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2024 01:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708741F22899
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2024 23:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87A188901;
	Mon,  2 Sep 2024 23:23:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB418858C
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2024 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725319432; cv=none; b=PAZI/4wlb8QYd74D1SYkYRN1xCzBiapLV53BNzjsndXSombTAo3nwF/90WWzo3AQU4oG0o7RwUc5LCmlz3Bk2lNgpCkUXFjPINv8CA8oloQdusVCgAfetluKV5NhBylMBpiOQjB8XpmLcEoi13dp/ujtBStGtnoR2wM3GneuZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725319432; c=relaxed/simple;
	bh=UuUR++W5bXrEP2Gouo/4MSt+TlH8U8eOEVVlgrXPZdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRBkwpLMlhbXbYZoH6xZ1dhOVxLIiB1ps8x7C1bY4SqZaLY+vypQKBLgIlnE/2qvf2ywzC5rUYyoujUiQIU3nB2CjmxDriYXLrrUACtVfJ7spkq7fGNAOo/KC6fn5tMXwcVUnFvjLqAb9wkkHUa2QkeswKKy5HAaLuGenXsToS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	fw@strlen.de
Subject: [PATCH nf-next,v2 2/9] netfilter: nf_tables: reject element expiration with no timeout
Date: Tue,  3 Sep 2024 01:17:19 +0200
Message-Id: <20240902231726.171964-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240902231726.171964-1-pablo@netfilter.org>
References: <20240902231726.171964-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If element timeout is unset and set provides no default timeout, the
element expiration is silently ignored, reject this instead to let user
know this is unsupported.

Also prepare for supporting timeout that never expire, where zero
timeout and expiration must be also rejected.

Fixes: 8e1102d5a159 ("netfilter: nf_tables: support timeouts larger than 23 days")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: remove leftover sentence in patch description, as per Phil.

 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6de74dae50fc..1884125ebb28 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6917,6 +6917,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (nla[NFTA_SET_ELEM_EXPIRATION] != NULL) {
 		if (!(set->flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+		if (timeout == 0)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_ELEM_EXPIRATION],
 					    &expiration);
 		if (err)
-- 
2.30.2


