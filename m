Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280B714884E
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Jan 2020 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405230AbgAXOVL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Jan 2020 09:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405223AbgAXOVK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635C721556;
        Fri, 24 Jan 2020 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875670;
        bh=tk6Byy/9gnS9TvzqixnbCarFVB/TnhObViSxEp0c7KE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjraEXxyOKUvg1F+QBpe5KYK2k6DvJeIwEcrdfSjUYgHC5juywnGVYuQkjX22hXl0
         vz3oN4nd3HQQIKvCPT6I9X1I+3XPJt3fNPy9mqITONzQlXQrX64jvCUw1wj28XrbYq
         C5itHxiFtOp2TcY9qhFE7iDW/IKyO2KNvJu7FNDI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        syzbot+76d0b80493ac881ff77b@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 49/56] netfilter: nft_tunnel: fix null-attribute check
Date:   Fri, 24 Jan 2020 09:20:05 -0500
Message-Id: <20200124142012.29752-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 1c702bf902bd37349f6d91cd7f4b372b1e46d0ed ]

else we get null deref when one of the attributes is missing, both
must be non-null.

Reported-by: syzbot+76d0b80493ac881ff77b@syzkaller.appspotmail.com
Fixes: aaecfdb5c5dd8ba ("netfilter: nf_tables: match on tunnel metadata")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 3a15f219e4e7f..09441bbb0166f 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -56,7 +56,7 @@ static int nft_tunnel_get_init(const struct nft_ctx *ctx,
 	struct nft_tunnel *priv = nft_expr_priv(expr);
 	u32 len;
 
-	if (!tb[NFTA_TUNNEL_KEY] &&
+	if (!tb[NFTA_TUNNEL_KEY] ||
 	    !tb[NFTA_TUNNEL_DREG])
 		return -EINVAL;
 
-- 
2.20.1

