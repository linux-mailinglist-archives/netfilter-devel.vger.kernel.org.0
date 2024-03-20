Return-Path: <netfilter-devel+bounces-1431-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AECA880E88
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 10:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD611F21402
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B463A28D;
	Wed, 20 Mar 2024 09:26:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9433985A
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Mar 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926807; cv=none; b=rAwGOZDpDIUmTPjgmO3zFrRQosFg0nPO7ulJlQQt9BqayGMqvilYDMRSnbpQ9YwvsQpuc3Y78Dc4L859cYNC1NmBdQSMI3v7l7LMWCLInvbIaZkT2SQXuCPwF4r5zRmsMXJxSbAub3OzFcqB3/9Hsuzl+FtEpCkQKP/oIIR42fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926807; c=relaxed/simple;
	bh=TLqTWL6HBsBPA6U3scbIPYedwXtg3Ir5/HqoYUqwtJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arewrljn5rpy0e9BQSmZHFOk0wZtJro4z3z7Y9du/wKTPG4TXoWoQFWpXRZ87acQTZvF7S/oSYdYO+28GwMVvik+9wdG7Ky47RjwRVq2fGzQq3YnL1J+5of2oZ+tEGQ2XmX/PPzoB0i6RzUtr2Zwj9vbTDA6jrbIzHZE1+pVI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: sven.auhagen@voleatech.de,
	cratiu@nvidia.com,
	ozsh@nvidia.com,
	vladbu@nvidia.com,
	gal@nvidia.com
Subject: [PATCH nf 2/2] netfilter: flowtable: use UDP timeout after flow teardown
Date: Wed, 20 Mar 2024 10:26:38 +0100
Message-Id: <20240320092638.798076-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240320092638.798076-1-pablo@netfilter.org>
References: <20240320092638.798076-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not subtract flow timeout from UDP timeout, simply use UDP timeout
instead. Users can tweak UDP conntrack timeouts leading to zero
conntrack timeout when handing over the flow back to classic conntrack
path.

Fixes: e5eaac2beb54 ("netfilter: flowtable: fix TCP flow teardown")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes, just rebase on top of 1/2

 net/netfilter/nf_flow_table_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index bd880c58bfab..16068ef04490 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -165,7 +165,7 @@ void flow_offload_route_init(struct flow_offload *flow,
 }
 EXPORT_SYMBOL_GPL(flow_offload_route_init);
 
-static s32 flow_offload_fixup_tcp(struct net *net, struct nf_conn *ct,
+static u32 flow_offload_fixup_tcp(struct net *net, struct nf_conn *ct,
 				  enum tcp_conntrack tcp_state)
 {
 	struct nf_tcp_net *tn = nf_tcp_pernet(net);
@@ -181,7 +181,7 @@ static void flow_offload_fixup_ct(struct nf_conn *ct)
 {
 	struct net *net = nf_ct_net(ct);
 	int l4num = nf_ct_protonum(ct);
-	s32 timeout;
+	u32 timeout;
 
 	if (l4num == IPPROTO_TCP) {
 		timeout = flow_offload_fixup_tcp(net, ct, ct->proto.tcp.state);
@@ -192,14 +192,10 @@ static void flow_offload_fixup_ct(struct nf_conn *ct)
 			UDP_CT_REPLIED : UDP_CT_UNREPLIED;
 
 		timeout = tn->timeouts[state];
-		timeout -= tn->offload_timeout;
 	} else {
 		return;
 	}
 
-	if (timeout < 0)
-		timeout = 0;
-
 	if (nf_flow_timeout_delta(READ_ONCE(ct->timeout)) > (__s32)timeout)
 		WRITE_ONCE(ct->timeout, nfct_time_stamp + timeout);
 }
-- 
2.30.2


