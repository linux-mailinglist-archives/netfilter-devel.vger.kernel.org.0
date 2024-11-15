Return-Path: <netfilter-devel+bounces-5131-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E97779CE00F
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2024 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962011F22331
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2024 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1081CEAA6;
	Fri, 15 Nov 2024 13:32:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF01CDA2D;
	Fri, 15 Nov 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677545; cv=none; b=Salal0hocQW39zIAvfgY7PkZPgWwocUa+f+afgNBILLdhJJWWWVaZnYkbelrvMsp0MQZ8VfGWe6DPA+EFS3nieRqKtqdh0nKJnBhuBW/FD1gNMkxgaY+6yX3FAhbfcNy5ljFNUG9MDV64HUCucQTsE/4ykXwKTjLV50txM5GQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677545; c=relaxed/simple;
	bh=xzE9ISdcJavZAe8IS3NE2ZfHKwwlRuHJoWu/SV+4uww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWE+gkQyQKs748CdUyUoBeVFTfQBsIKgMN40Ii55gFF2qxVXWGaCH7bNFFciQRnUr4k7Q48zCxbztJZoVo1WmilJhq1ngR3rmNjISa8BznMIo32hwi9forntJhh7hcP89g3rW0SU519wGmldgpgcj6K3jKEqYetyp0keT9drGqY=
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
Subject: [PATCH net-next 09/14] netfilter: flow_offload: Convert nft_flow_route() to dscp_t.
Date: Fri, 15 Nov 2024 14:32:02 +0100
Message-Id: <20241115133207.8907-10-pablo@netfilter.org>
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

From: Guillaume Nault <gnault@redhat.com>

Use ip4h_dscp()instead of reading ip_hdr()->tos directly.

ip4h_dscp() returns a dscp_t value which is temporarily converted back
to __u8 with inet_dscp_to_dsfield(). When converting ->flowi4_tos to
dscp_t in the future, we'll only have to remove that
inet_dscp_to_dsfield() call.

Also, remove the comment about the net/ip.h include file, since it's
now required for the ip4h_dscp() helper too.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_flow_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 65199c23c75c..3b474d235663 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -8,7 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/netfilter/nf_tables.h>
-#include <net/ip.h> /* for ipv4 options. */
+#include <net/ip.h>
 #include <net/inet_dscp.h>
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
@@ -236,7 +236,7 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		fl.u.ip4.saddr = ct->tuplehash[!dir].tuple.src.u3.ip;
 		fl.u.ip4.flowi4_oif = nft_in(pkt)->ifindex;
 		fl.u.ip4.flowi4_iif = this_dst->dev->ifindex;
-		fl.u.ip4.flowi4_tos = ip_hdr(pkt->skb)->tos & INET_DSCP_MASK;
+		fl.u.ip4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(pkt->skb)));
 		fl.u.ip4.flowi4_mark = pkt->skb->mark;
 		fl.u.ip4.flowi4_flags = FLOWI_FLAG_ANYSRC;
 		break;
-- 
2.30.2


