Return-Path: <netfilter-devel+bounces-3986-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25F97D9FB
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2024 22:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D561F22559
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2024 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B402185929;
	Fri, 20 Sep 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="ORJFo4j9"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6416A94F
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726863841; cv=none; b=oukxfDOCC2MIbiW86m6b64aKpqWk1/YZcCI5n04qtIzMXlD6FdwLIE9Cr6H0vqfjhoLzyHULt/KNGiRitaqwDqq57chVrzfXE3d0KL1OGSpYkiGswNo9TeHmauQM4IfeF4mOSt2bJdV8RgNPWpmJK5zEY3x8qvcXoK/Mo6GKpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726863841; c=relaxed/simple;
	bh=Mj3ULNJTBhjPqq1CZTIaexRT5N3czg39T18K4bQNDaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlrQWacQPw/xhAMduImeiAhESGur8QF3yKiBFH/XYWC885TMtvSePlG54rSVVnSMuPlrjzGJr95v1HdgP0JPNTgX/hOIRFSxwrlsUj5YFEjjEZZ8MHaoUJ5Ga5T3byrlENf0Ok6DP+uNuGhv54ww69wPzgcFROh8FCvFN+ZlrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=ORJFo4j9; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6rGI0WC3iRclcNdSk/jWWybMNLgGOetAn8fZWpU+IBo=; b=ORJFo4j9ZC9r3iQIP0KxikBtVa
	WX9sBG9wxglsUSyEHWUaPDQHWxZMfqWUkcgb+xSBWxYxRPGk0sofeRV/miaRHo8E6DqoQXVIHXeb5
	wS1uXCecOw8NFasZH1QBbwXOo+9Rv5p4WHne/zDQ7eDuFrUbLqDMCq/M3PxUauyKVVMmy6hCO/89p
	WhIIjs1HFik4fPPtrEf4+YwU2ja6BmHR6BwI6/16TkwLok3mC1j1CBtnL32JWWJg24wznZyOjnw+v
	uC7aqnIMtZQajaIFE8Si14A6J58t4fi90zpVyY/xsDh0HV4htKi0ClPIxM9jaIfdJHmZOFizGrCOP
	s1BQWsZA==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1srkAQ-000000006Hv-49aO;
	Fri, 20 Sep 2024 22:23:51 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Eric Garver <e@erig.me>
Subject: [nf-next PATCH v4 09/16] netfilter: nf_tables: Drop __nft_unregister_flowtable_net_hooks()
Date: Fri, 20 Sep 2024 22:23:40 +0200
Message-ID: <20240920202347.28616-10-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920202347.28616-1-phil@nwl.cc>
References: <20240920202347.28616-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is a 1:1 copy of nft_netdev_unregister_hooks(), use the
latter in its place.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nf_tables_api.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3721f4636e0a..7a721df27f12 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8560,25 +8560,10 @@ static void nft_unregister_flowtable_hook(struct net *net,
 				    FLOW_BLOCK_UNBIND);
 }
 
-static void __nft_unregister_flowtable_net_hooks(struct net *net,
-						 struct list_head *hook_list,
-					         bool release_netdev)
-{
-	struct nft_hook *hook, *next;
-
-	list_for_each_entry_safe(hook, next, hook_list, list) {
-		nf_unregister_net_hook(net, &hook->ops);
-		if (release_netdev) {
-			list_del(&hook->list);
-			kfree_rcu(hook, rcu);
-		}
-	}
-}
-
 static void nft_unregister_flowtable_net_hooks(struct net *net,
 					       struct list_head *hook_list)
 {
-	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
+	nft_netdev_unregister_hooks(net, hook_list, false);
 }
 
 static int nft_register_flowtable_ops(struct net *net,
@@ -11473,8 +11458,7 @@ static void __nft_release_hook(struct net *net, struct nft_table *table)
 	list_for_each_entry(chain, &table->chains, list)
 		__nf_tables_unregister_hook(net, table, chain, true);
 	list_for_each_entry(flowtable, &table->flowtables, list)
-		__nft_unregister_flowtable_net_hooks(net, &flowtable->hook_list,
-						     true);
+		nft_netdev_unregister_hooks(net, &flowtable->hook_list, true);
 }
 
 static void __nft_release_hooks(struct net *net)
-- 
2.43.0


