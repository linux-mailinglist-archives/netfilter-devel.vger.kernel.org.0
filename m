Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFB46F7E8
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Dec 2021 01:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhLJAQO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Dec 2021 19:16:14 -0500
Received: from mail.netfilter.org ([217.70.188.207]:44334 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhLJAQO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:16:14 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2F8FA60085
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Dec 2021 01:10:15 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/5] netfilter: nft_payload: WARN_ON_ONCE instead of BUG
Date:   Fri, 10 Dec 2021 01:12:28 +0100
Message-Id: <20211210001231.144098-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210001231.144098-1-pablo@netfilter.org>
References: <20211210001231.144098-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

BUG() is too harsh for unknown payload base, use WARN_ON_ONCE() instead.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index bd689938a2e0..f2e65df32a06 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -157,7 +157,8 @@ void nft_payload_eval(const struct nft_expr *expr,
 			goto err;
 		break;
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		goto err;
 	}
 	offset += priv->offset;
 
@@ -664,7 +665,8 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 			goto err;
 		break;
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		goto err;
 	}
 
 	csum_offset = offset + priv->csum_offset;
-- 
2.30.2

