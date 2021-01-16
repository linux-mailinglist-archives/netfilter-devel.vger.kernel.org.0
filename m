Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FD2F8EAD
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Jan 2021 19:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAPSaU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 16 Jan 2021 13:30:20 -0500
Received: from correo.us.es ([193.147.175.20]:50940 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbhAPSaU (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 16 Jan 2021 13:30:20 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ABE1769262
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Jan 2021 19:28:49 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9DF72DA722
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Jan 2021 19:28:49 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 937CBDA73F; Sat, 16 Jan 2021 19:28:49 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 49A4BDA722
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Jan 2021 19:28:47 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 16 Jan 2021 19:28:47 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 3679E42DC6DF
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Jan 2021 19:28:47 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_dynset: add timeout extension to template
Date:   Sat, 16 Jan 2021 19:29:32 +0100
Message-Id: <20210116182932.737-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise, the newly create element shows no timeout when listing the
ruleset. If the set definition does not specify a default timeout, then
the set element only shows the expiration time, but not the timeout.
This is a problem when restoring a stateful ruleset listing since it
skips the timeout policy entirely.

Fixes: 22fe54d5fefc ("netfilter: nf_tables: add support for dynamic set updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_dynset.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 86204740f6c7..218c09e4fddd 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -312,8 +312,10 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		nft_dynset_ext_add_expr(priv);
 
 	if (set->flags & NFT_SET_TIMEOUT) {
-		if (timeout || set->timeout)
+		if (timeout || set->timeout) {
+			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_TIMEOUT);
 			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_EXPIRATION);
+		}
 	}
 
 	priv->timeout = timeout;
-- 
2.20.1

