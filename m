Return-Path: <netfilter-devel+bounces-1130-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A086D874
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Mar 2024 01:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1C6283589
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Mar 2024 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98261BE7E;
	Fri,  1 Mar 2024 00:46:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E25C134
	for <netfilter-devel@vger.kernel.org>; Fri,  1 Mar 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253988; cv=none; b=YD+RBXOYBhLehT9HALP8FXOiST0K3u2u781oSNxNZi5SwHisSelWGg5WGEy09UTq/ecAS4fYMDdpK06Jq0ZxkxI0PjvpRJqb30gxwtSgLJQQi6Dzqt63lc2GK0/p9bciWh0QIzdtFjsPxcmB8kO6NAk7sNg6DBglh3D6R72FqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253988; c=relaxed/simple;
	bh=JG65XC+0DX0STNIR9JvvZ5Gej8ckUjrZ04ai089mC2g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hToETpyn2fKCh7a+60UM2PTPtKGbifXK3KuRX/lBXW1ZDWYWWI2jQYQCM6PplibT8/BSb9lCz4Lk20a4Cam0j3SywRtIQzYyzt7jmzKjdHbkIu6Ro/rNFRjLu9TYcNQuW/FmXxRodC8RQ118rXrv98pS9BFUTDvw7KDra9lVrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/2] netfilter: nf_tables: disallow anonymous set with NFT_SET_{TIMEOUT,EVAL} flags
Date: Fri,  1 Mar 2024 01:46:08 +0100
Message-Id: <20240301004609.10237-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anonymous sets cannot be used neither with timeout nor with the dynamic
flag to be populated from packet path. Reject these combinations.

Fixes: 761da2935d6e ("netfilter: nf_tables: add set timeout API support")
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 7e938c7397dd..70f90e7d108c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5001,6 +5001,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if ((flags & (NFT_SET_EVAL | NFT_SET_OBJECT)) ==
 			     (NFT_SET_EVAL | NFT_SET_OBJECT))
 			return -EOPNOTSUPP;
+		if ((flags & NFT_SET_ANONYMOUS) &&
+		    (flags & (NFT_SET_TIMEOUT | NFT_SET_EVAL)))
+			return -EOPNOTSUPP;
 	}
 
 	desc.dtype = 0;
-- 
2.30.2


