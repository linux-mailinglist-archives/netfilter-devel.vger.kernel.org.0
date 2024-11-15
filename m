Return-Path: <netfilter-devel+bounces-5124-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5349CDFFF
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2024 14:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C513D281BDB
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2024 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3F1CD200;
	Fri, 15 Nov 2024 13:32:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4631C4A05;
	Fri, 15 Nov 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677542; cv=none; b=tP053hz3Vw8Vnb9ocWJSzAHFJSBQj2DlXgIr9sCwaO/y6X7w/L3Nv95HHU18TowDw18OSBi5OLlNf0PMQdRXn08jgL7CLdEIhqvAzJu8MjplRanv9NMYsHcVZa4o7LfKpVsfN9a28vdwK8OfegDMSVL/CUV00Dp5JW0lvkUkRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677542; c=relaxed/simple;
	bh=V3/gczBSE3XarU0Hry403KXQ5I/aTT0Sq61QvbGM5Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bkk7sEMs17TnuqhWZuuZR5Gs3ZWukq2GoksVGOPV43wlAe/fmAy+JvZgtJiSyoX8teDxorAZtoLfzd06nXaiNwn4j0f5tVoobcfEavx+piO+amUpWqSovLoqHCMbY0QNEcEP6M0ztjoOiN0s8Q1nnRuXJSaF23b3lSKDtty+a/A=
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
Subject: [PATCH net-next 01/14] netfilter: nfnetlink: Report extack policy errors for batched ops
Date: Fri, 15 Nov 2024 14:31:54 +0100
Message-Id: <20241115133207.8907-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241115133207.8907-1-pablo@netfilter.org>
References: <20241115133207.8907-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donald Hunter <donald.hunter@gmail.com>

The nftables batch processing does not currently populate extack with
policy errors. Fix this by passing extack when parsing batch messages.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 7784ec094097..e598a2a252b0 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -517,7 +517,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			err = nla_parse_deprecated(cda,
 						   ss->cb[cb_id].attr_count,
 						   attr, attrlen,
-						   ss->cb[cb_id].policy, NULL);
+						   ss->cb[cb_id].policy, &extack);
 			if (err < 0)
 				goto ack;
 
-- 
2.30.2


