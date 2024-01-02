Return-Path: <netfilter-devel+bounces-528-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8397821C84
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jan 2024 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0C1F21C52
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jan 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A1F9EF;
	Tue,  2 Jan 2024 13:24:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F2FBE1
	for <netfilter-devel@vger.kernel.org>; Tue,  2 Jan 2024 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_immediate: drop chain reference counter on error
Date: Tue,  2 Jan 2024 14:16:49 +0100
Message-Id: <20240102131649.30960-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the init path, nft_data_init() bumps the chain reference counter,
decrement it on error by following the error path which calls
nft_data_release() to restore it.

Fixes: 4bedf9eee016 ("netfilter: nf_tables: fix chain binding transaction logic")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_immediate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index fccb3cf7749c..6475c7abc1fe 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -78,7 +78,7 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		case NFT_GOTO:
 			err = nf_tables_bind_chain(ctx, chain);
 			if (err < 0)
-				return err;
+				goto err1;
 			break;
 		default:
 			break;
-- 
2.30.2


