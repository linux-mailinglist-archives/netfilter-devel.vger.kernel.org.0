Return-Path: <netfilter-devel+bounces-2849-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B291C326
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jun 2024 18:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA5A1F235A3
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jun 2024 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500401C8FDB;
	Fri, 28 Jun 2024 16:05:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D41C8FBD;
	Fri, 28 Jun 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590725; cv=none; b=qTz5186NDX+4re9OC303KLpZb+IgwKhXbLtFPEGqhNlXlSh2/s6ETYT1wey6Y2bVJ/yrpOYIFypNWeRB2d2J3qOB6ajD1Ol6Qwt845mDnMlegHeuTn7mxLmNONjy/vPRoJ06KfCL0bc+p2pcUACYC3M1/NIDwssVde4CTORo4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590725; c=relaxed/simple;
	bh=NHsYB2rHAUp/AEAcYFzmeaz/DJ6Y6n+OgYC4uvZodsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSeyz7r2l4fePOCmtRqHFoulqzz11Q1KIgk5CE2Lgc1fmw42iWCHtdkdCzNNrk6hQLvg/SNXhU6a+GcV8VD10Sd1GbyVvwAqAeUALyRuez4o9RNHgjWGXsoBfsGK1XcUfHiFx2AJ/jQn7/SQwI8MwFKhDSDgvUUibj4zpf7rVgE=
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
Subject: [PATCH net-next 03/17] netfilter: nf_tables: compact chain+ft transaction objects
Date: Fri, 28 Jun 2024 18:04:51 +0200
Message-Id: <20240628160505.161283-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240628160505.161283-1-pablo@netfilter.org>
References: <20240628160505.161283-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Cover holes to reduce both structures by 8 byte.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index f72448095833..1f0607b671ac 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1687,10 +1687,10 @@ struct nft_trans_set {
 struct nft_trans_chain {
 	struct nft_trans_binding	nft_trans_binding;
 	struct nft_chain		*chain;
-	bool				update;
 	char				*name;
 	struct nft_stats __percpu	*stats;
 	u8				policy;
+	bool				update;
 	bool				bound;
 	u32				chain_id;
 	struct nft_base_chain		*basechain;
@@ -1763,9 +1763,9 @@ struct nft_trans_obj {
 struct nft_trans_flowtable {
 	struct nft_trans		nft_trans;
 	struct nft_flowtable		*flowtable;
-	bool				update;
 	struct list_head		hook_list;
 	u32				flags;
+	bool				update;
 };
 
 #define nft_trans_container_flowtable(t)		\
-- 
2.30.2


