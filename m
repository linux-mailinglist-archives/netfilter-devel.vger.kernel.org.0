Return-Path: <netfilter-devel+bounces-5102-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147E9C8B67
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Nov 2024 14:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB931F24A37
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Nov 2024 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA81FAF01;
	Thu, 14 Nov 2024 13:05:13 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75B61FAC5D;
	Thu, 14 Nov 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589513; cv=none; b=G/3O/ranOpu/VDoEikuNMqpbvTt4gB7fZL/Dw/61lsCUlwkJCV4VHp0ii6ncPxB6UlATNFckEljQxgLsfoWxHgD3oxXNMYNe0YPIXxoYwAjN+dn6+DCuZjnJ9WI/ssk7OQQfGM92VfY1QxJkr0gtLRJq92kBD+Whx0qNuPfBOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589513; c=relaxed/simple;
	bh=QPUiEAZl3lzHLwvEjSCy0Y1PfyOgnhOXErZmHXPZ0zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtHgzjCKVD+7L39qKPaKFrKf3Ea6eIDPZtF26frr+u3I8o5IDiKHgNejBQV3kzJ7xfjGDEtUKzpTxBFACbAG73VXLe0f+skpoH1CMLPzfUT1mQa4kyuoO720IAtNiuIajitDPP3k41Ua/oThrnsEwZBhvWdoct3ay3OuWc4nITY=
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
Subject: [PATCH net 2/3] selftests: netfilter: Fix missing return values in conntrack_dump_flush
Date: Thu, 14 Nov 2024 13:57:22 +0100
Message-Id: <20241114125723.82229-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241114125723.82229-1-pablo@netfilter.org>
References: <20241114125723.82229-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: guanjing <guanjing@cmss.chinamobile.com>

Fix the bug of some functions were missing return values.

Fixes: eff3c558bb7e ("netfilter: ctnetlink: support filtering by zone")
Signed-off-by: Guan Jing <guanjing@cmss.chinamobile.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../testing/selftests/net/netfilter/conntrack_dump_flush.c  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index 254ff03297f0..5f827e10717d 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -43,6 +43,8 @@ static int build_cta_tuple_v4(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
 }
 
 static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
@@ -71,6 +73,8 @@ static int build_cta_tuple_v6(struct nlmsghdr *nlh, int type,
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
 }
 
 static int build_cta_proto(struct nlmsghdr *nlh)
@@ -90,6 +94,8 @@ static int build_cta_proto(struct nlmsghdr *nlh)
 	mnl_attr_nest_end(nlh, nest_proto);
 
 	mnl_attr_nest_end(nlh, nest);
+
+	return 0;
 }
 
 static int conntrack_data_insert(struct mnl_socket *sock, struct nlmsghdr *nlh,
-- 
2.30.2


