Return-Path: <netfilter-devel+bounces-972-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E58384DFA7
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF291C25E1F
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243271B54;
	Thu,  8 Feb 2024 11:28:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04826EB75;
	Thu,  8 Feb 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391725; cv=none; b=roezVz4D0u6Bbj7E586Sch8ex1uVN+HuGC4nghi8BoeLOSLCSMCiomvv6RiKr8HkT4+6W+zPBXzQZ+svtwOaLn/QZ9NYEfxw2flXvt+mJiY2AdurIsUMeNSB8pj+v8VYadZPvC91vitlJ4lYmLq+x4glscXdV9wFAzstRwfW75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391725; c=relaxed/simple;
	bh=Iju1WJ9Ap8eJGChNGn1Xu+0Td4lpNM4WNCJCL29T/Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dr+G97VQM2Do67CWWQRU3OtE2Qj6S4GTjsrjdGRP8zUJuvZ7IBbeDY75fwjecCD/KuzGHZXawateWF9aKK48ZKnFhrQold6AsDd3zEY2J0lHsBd2b0HT8mo31hfC0htm0hwTo8rTwORP6uariMc8wElvRhT7TiHEvwkacsjGcro=
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
	fw@strlen.de,
	kadlec@netfilter.org
Subject: [PATCH net 07/13] netfilter: nft_ct: reject direction for ct id
Date: Thu,  8 Feb 2024 12:28:28 +0100
Message-Id: <20240208112834.1433-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240208112834.1433-1-pablo@netfilter.org>
References: <20240208112834.1433-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direction attribute is ignored, reject it in case this ever needs to be
supported

Fixes: 3087c3f7c23b ("netfilter: nft_ct: Add ct id support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_ct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index aac98a3c966e..bfd3e5a14dab 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -476,6 +476,9 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFT_CT_ID:
+		if (tb[NFTA_CT_DIRECTION])
+			return -EINVAL;
+
 		len = sizeof(u32);
 		break;
 	default:
-- 
2.30.2


