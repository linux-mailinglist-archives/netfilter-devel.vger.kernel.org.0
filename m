Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39658326F0B
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Feb 2021 22:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0VcS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 27 Feb 2021 16:32:18 -0500
Received: from correo.us.es ([193.147.175.20]:51812 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhB0VcQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 27 Feb 2021 16:32:16 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 432F915C101
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 22:31:34 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2F1A5DA704
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 22:31:34 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 240C9DA72F; Sat, 27 Feb 2021 22:31:34 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BDCFEDA704
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 22:31:31 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 27 Feb 2021 22:31:31 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id A749F42DC6E2
        for <netfilter-devel@vger.kernel.org>; Sat, 27 Feb 2021 22:31:31 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nftables: disallow updates on table ownership
Date:   Sat, 27 Feb 2021 22:31:27 +0100
Message-Id: <20210227213127.15719-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Disallow updating the ownership bit on an existing table: Do not allow
to grab ownership on an existing table. Do not allow to drop ownership
on an existing table.

Fixes: 6001a930ce03 ("netfilter: nftables: introduce table ownership")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Dropping ownership might make sense for a process stopping while leaving
the ruleset in place. But I prefer to disallow this explicitly until
there is a use-case.

 net/netfilter/nf_tables_api.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d3a03c5f8387..1f6134198777 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -914,6 +914,12 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags == ctx->table->flags)
 		return 0;
 
+	if ((nft_table_has_owner(ctx->table) &&
+	    !(flags && NFT_TABLE_F_OWNER)) ||
+	    (!nft_table_has_owner(ctx->table) &&
+	     flags & NFT_TABLE_F_OWNER))
+		return -EOPNOTSUPP;
+
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
 				sizeof(struct nft_trans_table));
 	if (trans == NULL)
-- 
2.20.1

