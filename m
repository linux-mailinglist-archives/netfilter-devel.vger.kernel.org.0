Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 682C397618
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHUJ03 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 05:26:29 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43760 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHUJ03 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:29 -0400
Received: from localhost ([::1]:56850 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i0Msu-00054g-Ng; Wed, 21 Aug 2019 11:26:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 01/14] nft: Fix typo in nft_parse_limit() error message
Date:   Wed, 21 Aug 2019 11:25:49 +0200
Message-Id: <20190821092602.16292-2-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821092602.16292-1-phil@nwl.cc>
References: <20190821092602.16292-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Seems like a trivial copy'n'paste bug.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 1c09277d85fb5..904bc845e6a41 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -566,7 +566,7 @@ static void nft_parse_limit(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 		matches = &ctx->cs->matches;
 		break;
 	default:
-		fprintf(stderr, "BUG: nft_parse_match() unknown family %d\n",
+		fprintf(stderr, "BUG: nft_parse_limit() unknown family %d\n",
 			ctx->family);
 		exit(EXIT_FAILURE);
 	}
-- 
2.22.0

