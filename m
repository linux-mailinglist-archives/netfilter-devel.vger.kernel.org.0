Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99BEE192
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2019 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfKDNwv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 Nov 2019 08:52:51 -0500
Received: from correo.us.es ([193.147.175.20]:56812 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfKDNwv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:52:51 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 28118FF2D3
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 14:52:47 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19C82DA72F
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 14:52:47 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0F6EDDA8E8; Mon,  4 Nov 2019 14:52:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2DF6ADA72F
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 14:52:45 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 04 Nov 2019 14:52:45 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0854B4251480
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 14:52:44 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/2] netfilter: nf_tables_offload: skip EBUSY on chain update
Date:   Mon,  4 Nov 2019 14:52:42 +0100
Message-Id: <20191104135242.31662-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191104135242.31662-1-pablo@netfilter.org>
References: <20191104135242.31662-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Do not try to bind a chain again if it exists, otherwise the driver
returns EBUSY.

Fixes: c9626a2cbdb2 ("netfilter: nf_tables: add hardware offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 38dc00f7e32e..b418214cb846 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -401,7 +401,8 @@ int nft_flow_rule_offload_commit(struct net *net)
 
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWCHAIN:
-			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
+			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD) ||
+			    nft_trans_chain_update(trans))
 				continue;
 
 			policy = nft_trans_chain_policy(trans);
-- 
2.11.0

