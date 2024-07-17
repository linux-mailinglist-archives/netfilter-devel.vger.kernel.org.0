Return-Path: <netfilter-devel+bounces-3014-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAE93443D
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2024 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFF81F226B2
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0043187877;
	Wed, 17 Jul 2024 21:52:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26B617F4F6;
	Wed, 17 Jul 2024 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253150; cv=none; b=RzcT236iGIpAeLn0Ximwmhi0ezb+yBiU4hZbv8+MirWgN91dVHBOcd5wZN4dvtMycHcqF2PKgICIT6smrecfQHb09xur3zsGrwOm+EChZGpzHorDRzBjFfH2in9aU/RMIeS9RLM6AH8j1VUw5vdRPkmsLN7cr2spcsCbeLpwWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253150; c=relaxed/simple;
	bh=vB4cRmjZA1tFdZYOEO/2WZkvusVgM9xolRK2K1uiqPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5lzJ3tFY+HMT9g4rjBsV0YJ0INqPiixfaEN/vawDaAUF2tfDCYqwyxqs02LOi/xtjmuFnPN8oCsYQpvlK+Z8lZt+cpUDRejYGSpb1s58FRZMlHQFzGeDDNaNPkaydx9KvFNVy/le/7rsGYdlcgshn0SQbMrtwZyVsElnUNAH+I=
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
Subject: [PATCH net 4/4] ipvs: properly dereference pe in ip_vs_add_service
Date: Wed, 17 Jul 2024 23:52:14 +0200
Message-Id: <20240717215214.225394-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240717215214.225394-1-pablo@netfilter.org>
References: <20240717215214.225394-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Hanxiao <chenhx.fnst@fujitsu.com>

Use pe directly to resolve sparse warning:

  net/netfilter/ipvs/ip_vs_ctl.c:1471:27: warning: dereference of noderef expression

Fixes: 39b972231536 ("ipvs: handle connections started by real-servers")
Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 78a1cc72dc38..706c2b52a1ac 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1459,18 +1459,18 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	if (ret < 0)
 		goto out_err;
 
-	/* Bind the ct retriever */
-	RCU_INIT_POINTER(svc->pe, pe);
-	pe = NULL;
-
 	/* Update the virtual service counters */
 	if (svc->port == FTPPORT)
 		atomic_inc(&ipvs->ftpsvc_counter);
 	else if (svc->port == 0)
 		atomic_inc(&ipvs->nullsvc_counter);
-	if (svc->pe && svc->pe->conn_out)
+	if (pe && pe->conn_out)
 		atomic_inc(&ipvs->conn_out_counter);
 
+	/* Bind the ct retriever */
+	RCU_INIT_POINTER(svc->pe, pe);
+	pe = NULL;
+
 	/* Count only IPv4 services for old get/setsockopt interface */
 	if (svc->af == AF_INET)
 		ipvs->num_services++;
-- 
2.30.2


