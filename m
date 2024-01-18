Return-Path: <netfilter-devel+bounces-697-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71740831D62
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jan 2024 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42221C22DA0
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jan 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27012C1AA;
	Thu, 18 Jan 2024 16:17:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2B28E0B;
	Thu, 18 Jan 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594662; cv=none; b=SWdgmbc0Wg7S82hGzJZHVcfIgCjVCtDwcKMSeJCmuObPLdxzRyPf1XnzulTSrzxtXr6EWApazwuEtZrjqunm9u4r4WTJUVRUE3XtcrrmWmMZ5a2EGOxl+Dy4j+VZ2wvF8vx6VszAdqcBTr+TrJ+yw9UjM7DoMa4i7YBM2g1DE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594662; c=relaxed/simple;
	bh=m4VeRz3aCUPlhzMWpHbZ+htqsl/7a4Cmez1+3l76l/g=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=LBDpK9+SvYsyXYFitoxDW+DKKSYuPhZzUtylhGTmCz2zvPDeV6DOnH6SFC6VxP3BCwvb/cmerFVtjmEUF1WQdd7sd6o+GDBe04zHnmIl+mTGqGJQhSGseRC1VTXVkUL5QcBK9avSKcJuUl7yf5l4SLCVy9nnHRnR8qgHu7LsOSg=
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
Subject: [PATCH net 01/13] netfilter: nf_tables: reject invalid set policy
Date: Thu, 18 Jan 2024 17:17:14 +0100
Message-Id: <20240118161726.14838-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240118161726.14838-1-pablo@netfilter.org>
References: <20240118161726.14838-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report -EINVAL in case userspace provides a unsupported set backend
policy.

Fixes: c50b960ccc59 ("netfilter: nf_tables: implement proper set selection")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8438a8922e4a..a90a364f5be5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5048,8 +5048,16 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	}
 
 	desc.policy = NFT_SET_POL_PERFORMANCE;
-	if (nla[NFTA_SET_POLICY] != NULL)
+	if (nla[NFTA_SET_POLICY] != NULL) {
 		desc.policy = ntohl(nla_get_be32(nla[NFTA_SET_POLICY]));
+		switch (desc.policy) {
+		case NFT_SET_POL_PERFORMANCE:
+		case NFT_SET_POL_MEMORY:
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
 
 	if (nla[NFTA_SET_DESC] != NULL) {
 		err = nf_tables_set_desc_parse(&desc, nla[NFTA_SET_DESC]);
-- 
2.30.2


