Return-Path: <netfilter-devel+bounces-681-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B08830A46
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jan 2024 17:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B364B24BE8
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jan 2024 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F222EF4;
	Wed, 17 Jan 2024 16:00:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7A224EA;
	Wed, 17 Jan 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507252; cv=none; b=mSPuh1BKhhVWcS2g8lQSHGb4ZqvdwsD+tk7niQJ14Gn6wj3igsWtKDjAnjhuRqH6PGrZ4tPKo/0GJQ0mKDKO048TlV06nti7ffKiPoAn6j0KBhSz3/IDeXxSPlTmVI+6mJdkQWi+j7L/D8/+nAb5Lf4hW9zWTsJeFFmIIMab+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507252; c=relaxed/simple;
	bh=0uOq3O0vrcPvSyLetUXeAUlNFT6UKkWK3KxVl0vRjJY=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=NGo44i8voU1RpQ/qs6ysvsshT64HXPOSJGUoP/cFGvDrLE7h8O4BwstF5BgNDqfmqGQaaaWf4DBsuBeDHbdbAWVLBGTbV21kj3hsfvWS588qoUSKaYCyaen8tSmrAi4LeqSUg18sH0UZ2tkhd7BOnDwZdyj1dSkWaXa3ZoS4RWs=
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
Subject: [PATCH net 12/14] netfilter: nf_tables: reject NFT_SET_CONCAT with not field length description
Date: Wed, 17 Jan 2024 17:00:28 +0100
Message-Id: <20240117160030.140264-13-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240117160030.140264-1-pablo@netfilter.org>
References: <20240117160030.140264-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is still possible to set on the NFT_SET_CONCAT flag by specifying a
set size and no field description, report EINVAL in such case.

Fixes: 1b6345d4160e ("netfilter: nf_tables: check NFT_SET_CONCAT flag if field_count is specified")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 88a6a858383b..4b55533ce5ca 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5070,8 +5070,12 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (err < 0)
 			return err;
 
-		if (desc.field_count > 1 && !(flags & NFT_SET_CONCAT))
+		if (desc.field_count > 1) {
+			if (!(flags & NFT_SET_CONCAT))
+				return -EINVAL;
+		} else if (flags & NFT_SET_CONCAT) {
 			return -EINVAL;
+		}
 	} else if (flags & NFT_SET_CONCAT) {
 		return -EINVAL;
 	}
-- 
2.30.2


