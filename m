Return-Path: <netfilter-devel+bounces-3669-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6AE96B685
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E1289030
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F81CEE86;
	Wed,  4 Sep 2024 09:24:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420017C9AA;
	Wed,  4 Sep 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441858; cv=none; b=u2PgdlsJGsgRiLfwihNSwS4C1Qgn8TbkI87rRc1UchQgxyfWz3Apzo3Ip58ESblV0zb0uR/vN7E1QQrRduEWu3QQUMFs1EDVYyKC7QXG/g8MPaXAeIP6fKQs4g6OgawHcRxths4k35KVjl8dye1p5k73s9e+bWLFHc6jUqLChTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441858; c=relaxed/simple;
	bh=/ccHUHyNp8wFv9njEhp4jo7AI1ResrGAiFUOk9+Tzro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMvm0ZvN4UeXdjZoDzIpEcCT4EwNWHU/0AtqtkLKl/86uILCSgXsMss6nFqcgTxhBBuSIIwnaKI5Mh+3ycl9rr8EI3i4/bbA7O55YJOGPzx7UV+uTHIXv3mF/3yXu4+iX8uYhUp1n9hW/WImelyVFpbC6uFEHWiDDd64i/3nVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzH9k0SVbz2DbgF;
	Wed,  4 Sep 2024 17:23:54 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 54ECD14011D;
	Wed,  4 Sep 2024 17:24:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 17:24:14 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jmaloy@redhat.com>,
	<ying.xue@windriver.com>, <pablo@netfilter.org>, <kadlec@netfilter.org>,
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH net-next v2 1/5] net/ipv4: make use of the helper macro LIST_HEAD()
Date: Wed, 4 Sep 2024 17:32:39 +0800
Message-ID: <20240904093243.3345012-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904093243.3345012-1-lihongbo22@huawei.com>
References: <20240904093243.3345012-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

list_head can be initialized automatically with LIST_HEAD()
instead of calling INIT_LIST_HEAD(). Here we can simplify
the code.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/ipv4/ip_input.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index d6fbcbd2358a..b6e7d4921309 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -596,9 +596,8 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 {
 	struct sk_buff *skb, *next, *hint = NULL;
 	struct dst_entry *curr_dst = NULL;
-	struct list_head sublist;
+	LIST_HEAD(sublist);
 
-	INIT_LIST_HEAD(&sublist);
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct net_device *dev = skb->dev;
 		struct dst_entry *dst;
@@ -646,9 +645,8 @@ void ip_list_rcv(struct list_head *head, struct packet_type *pt,
 	struct net_device *curr_dev = NULL;
 	struct net *curr_net = NULL;
 	struct sk_buff *skb, *next;
-	struct list_head sublist;
+	LIST_HEAD(sublist);
 
-	INIT_LIST_HEAD(&sublist);
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct net_device *dev = skb->dev;
 		struct net *net = dev_net(dev);
-- 
2.34.1


