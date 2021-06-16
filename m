Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB53AA347
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jun 2021 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFPSmR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Jun 2021 14:42:17 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46548 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhFPSmQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:42:16 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4ED0264252
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Jun 2021 20:38:50 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2 2/2] netfilter: nft_osf: check for TCP packet before further processing
Date:   Wed, 16 Jun 2021 20:40:05 +0200
Message-Id: <20210616184005.120570-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616184005.120570-1-pablo@netfilter.org>
References: <20210616184005.120570-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The osf expression only supports for TCP packets, add a upfront sanity
check to skip packet parsing if this is not a TCP packet.

Fixes: b96af92d6eaf ("netfilter: nf_tables: implement Passive OS fingerprint module in nft_osf")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: fix kbuild report.

 net/netfilter/nft_osf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index ac61f708b82d..d82677e83400 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -28,6 +28,11 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct nf_osf_data data;
 	struct tcphdr _tcph;
 
+	if (pkt->tprot != IPPROTO_TCP) {
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+
 	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
 				 sizeof(struct tcphdr), &_tcph);
 	if (!tcp) {
-- 
2.30.2

