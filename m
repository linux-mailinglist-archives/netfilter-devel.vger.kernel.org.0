Return-Path: <netfilter-devel+bounces-503-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C504C81E6A5
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Dec 2023 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DD51F21C9C
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Dec 2023 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A134D132;
	Tue, 26 Dec 2023 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q+AjtJxf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB551C31
	for <netfilter-devel@vger.kernel.org>; Tue, 26 Dec 2023 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703583853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enz7PIMkFIUCxVHWnXh2ChdEcuA703jE9iFHAc9Olsk=;
	b=Q+AjtJxfY7CCNw7T2vnYRNb5fwHPpw2Oul1ENY5/az67MsHW8Z7p5hHblbGk7j0BL6eRhy
	NGvetNGRzqtvLtjXWFW5JkDCBcax3BUM/UR14sIf/KigKM9s+3oL9gYVar1Qt5LKA/erPl
	ca4sbqwQ2PZAPHdmZvOUgdmCkBUGsZE=
From: George Guo <dongtai.guo@linux.dev>
To: horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 10/14] netfilter: cleanup struct nft_chain
Date: Tue, 26 Dec 2023 17:42:51 +0800
Message-Id: <20231226094255.77911-10-dongtai.guo@linux.dev>
In-Reply-To: <20231226094255.77911-1-dongtai.guo@linux.dev>
References: <20231226094255.77911-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add comments for blob_gen_0, blob_gen_1, bound, genmask, udlen, udata,
blob_next in struct nft_chain.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 208cfedb083c..2ee906429cc9 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1060,14 +1060,21 @@ struct nft_rule_blob {
 /**
  *	struct nft_chain - nf_tables chain
  *
+ *	@blob_gen_0: rule blob pointer to the current generation
+ *	@blob_gen_1: rule blob pointer to the future generation
  *	@rules: list of rules in the chain
  *	@list: used internally
  *	@rhlhead: used internally
  *	@table: table that this chain belongs to
  *	@handle: chain handle
  *	@use: number of jump references to this chain
- *	@flags: bitmask of enum nft_chain_flags
+ *	@flags: bitmask of enum NFTA_CHAIN_FLAGS
+ *	@bound: bind or not
+ *	@genmask: generation mask
  *	@name: name of the chain
+ *	@udlen: user data length
+ *	@udata: user data in the chain
+ *	@blob_next: rule blob pointer to the next in the chain
  */
 struct nft_chain {
 	struct nft_rule_blob		__rcu *blob_gen_0;
-- 
2.39.2


