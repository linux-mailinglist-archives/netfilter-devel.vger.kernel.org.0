Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A153A32F6
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Jun 2021 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFJSWf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Jun 2021 14:22:35 -0400
Received: from mail.netfilter.org ([217.70.188.207]:35008 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhFJSWe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:22:34 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8A2166423B
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Jun 2021 20:19:22 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/2] netfilter: nft_osf: check for TCP packet before further processing
Date:   Thu, 10 Jun 2021 20:20:31 +0200
Message-Id: <20210610182032.28096-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610182032.28096-1-pablo@netfilter.org>
References: <20210610182032.28096-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The osf expression only supports for TCP packets, add a upfront sanity
check to skip packet parsing if this is not a TCP packet.

Fixes: b96af92d6eaf ("netfilter: nf_tables: implement Passive OS fingerprint module in nft_osf")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_osf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index ac61f708b82d..4e6c65eaf567 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -28,6 +28,11 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct nf_osf_data data;
 	struct tcphdr _tcph;
 
+	if (pkt->tprot != IPPROTO_TCP) {
+		regs->verdict.code = NFT_BREAK;
+		break;
+	}
+
 	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
 				 sizeof(struct tcphdr), &_tcph);
 	if (!tcp) {
-- 
2.20.1

