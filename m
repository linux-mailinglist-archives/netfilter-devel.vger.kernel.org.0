Return-Path: <netfilter-devel+bounces-130-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB06800DA5
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Dec 2023 15:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42D2B20BAB
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Dec 2023 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DC3C6BC;
	Fri,  1 Dec 2023 14:47:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E810FA
	for <netfilter-devel@vger.kernel.org>; Fri,  1 Dec 2023 06:47:27 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1r94nc-0005ze-PT; Fri, 01 Dec 2023 15:47:24 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Xingyuan Mo <hdthky0@gmail.com>
Subject: [PATCH nf] netfilter: nft_set_pipapo: skip inactive elements during set walk
Date: Fri,  1 Dec 2023 15:47:13 +0100
Message-ID: <20231201144716.19138-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise set elements can be deactivated twice which will cause a crash.

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 701977af3ee8..7252fcdae349 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2043,6 +2043,9 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		e = f->mt[r].e;
 
+		if (!nft_set_elem_active(&e->ext, iter->genmask))
+			goto cont;
+
 		iter->err = iter->fn(ctx, set, iter, &e->priv);
 		if (iter->err < 0)
 			goto out;
-- 
2.41.0


