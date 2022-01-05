Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C84855CF
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jan 2022 16:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiAEP0T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jan 2022 10:26:19 -0500
Received: from mail.netfilter.org ([217.70.188.207]:33056 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiAEP0T (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:26:19 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9827C62BD8
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Jan 2022 16:23:32 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_payload: do not update layer 4 checksum when mangling fragments
Date:   Wed,  5 Jan 2022 16:26:13 +0100
Message-Id: <20220105152613.14133-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

IP fragments do not come with the transport header, hence skip bogus
layer 4 checksum updates.

Reported-by: Steffen Weinreich <steve@weinreich.org>
Tested-by: Steffen Weinreich <steve@weinreich.org>
Fixes: 1814096980bb ("netfilter: nft_payload: layer 4 checksum adjustment for pseudoheader fields")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index bd689938a2e0..58e96a0fe0b4 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -546,6 +546,9 @@ static int nft_payload_l4csum_offset(const struct nft_pktinfo *pkt,
 				     struct sk_buff *skb,
 				     unsigned int *l4csum_offset)
 {
+	if (pkt->fragoff)
+		return -1;
+
 	switch (pkt->tprot) {
 	case IPPROTO_TCP:
 		*l4csum_offset = offsetof(struct tcphdr, check);
-- 
2.30.2

