Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7276E745C
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfJ1PC6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 11:02:58 -0400
Received: from correo.us.es ([193.147.175.20]:41140 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfJ1PC6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:02:58 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D718E18CE7B
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 16:02:53 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C9546B7FF6
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 16:02:53 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BEDDCB7FF2; Mon, 28 Oct 2019 16:02:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D188A21FFA
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 16:02:51 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 28 Oct 2019 16:02:51 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id AE78E42EE38E
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 16:02:51 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: nft_meta: offload support for interface index
Date:   Mon, 28 Oct 2019 16:02:50 +0100
Message-Id: <20191028150250.15872-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds support for offloading the NFT_META_IIF selector.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables_offload.h | 1 +
 net/netfilter/nft_meta.c                  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
index 03cf5856d76f..ea7d1d78b92d 100644
--- a/include/net/netfilter/nf_tables_offload.h
+++ b/include/net/netfilter/nf_tables_offload.h
@@ -45,6 +45,7 @@ struct nft_flow_key {
 	struct flow_dissector_key_ip			ip;
 	struct flow_dissector_key_vlan			vlan;
 	struct flow_dissector_key_eth_addrs		eth_addrs;
+	struct flow_dissector_key_meta			meta;
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
 struct nft_flow_match {
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 317e3a9e8c5b..8fd21f436347 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -547,6 +547,10 @@ static int nft_meta_get_offload(struct nft_offload_ctx *ctx,
 				  sizeof(__u8), reg);
 		nft_offload_set_dependency(ctx, NFT_OFFLOAD_DEP_TRANSPORT);
 		break;
+	case NFT_META_IIF:
+		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_META, meta,
+				  ingress_ifindex, sizeof(__u32), reg);
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.11.0

