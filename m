Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2DA25E2
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Aug 2019 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfH2SN4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 14:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbfH2SN4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8DD2341B;
        Thu, 29 Aug 2019 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102435;
        bh=3dCUh5B5V/+pwIdVufiDbzWGJ3Fse06EB+uMp16XkV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1CGOWP7r6ENB7eKqAawcPPKhvOLvfxBWM+XB+vM5Gj9WOKK+Q5uT2zGPc0by9Pa2
         TKP3Tkpg13ZbwoFXnhvS1GMFESnjpGjmf7A6imf/caDCb9XdpgHymyWwIL7yodlTzW
         jMDYILpA1vyNdTQ4beR1zF2PUx4SfAWrv5GS1F10=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 24/76] netfilter: nft_flow_offload: skip tcp rst and fin packets
Date:   Thu, 29 Aug 2019 14:12:19 -0400
Message-Id: <20190829181311.7562-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit dfe42be15fde16232340b8b2a57c359f51cc10d9 ]

TCP rst and fin packets do not qualify to place a flow into the
flowtable. Most likely there will be no more packets after connection
closure. Without this patch, this flow entry expires and connection
tracking picks up the entry in ESTABLISHED state using the fixup
timeout, which makes this look inconsistent to the user for a connection
that is actually already closed.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_flow_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index aa5f571d43619..060a4ed46d5e6 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -72,11 +72,11 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
+	struct tcphdr _tcph, *tcph = NULL;
 	enum ip_conntrack_info ctinfo;
 	struct nf_flow_route route;
 	struct flow_offload *flow;
 	enum ip_conntrack_dir dir;
-	bool is_tcp = false;
 	struct nf_conn *ct;
 	int ret;
 
@@ -89,7 +89,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 
 	switch (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum) {
 	case IPPROTO_TCP:
-		is_tcp = true;
+		tcph = skb_header_pointer(pkt->skb, pkt->xt.thoff,
+					  sizeof(_tcph), &_tcph);
+		if (unlikely(!tcph || tcph->fin || tcph->rst))
+			goto out;
 		break;
 	case IPPROTO_UDP:
 		break;
@@ -115,7 +118,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (!flow)
 		goto err_flow_alloc;
 
-	if (is_tcp) {
+	if (tcph) {
 		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
 		ct->proto.tcp.seen[1].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
 	}
-- 
2.20.1

