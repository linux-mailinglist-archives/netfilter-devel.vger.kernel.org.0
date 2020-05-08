Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B51CAF57
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 May 2020 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgEHMoR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 May 2020 08:44:17 -0400
Received: from correo.us.es ([193.147.175.20]:35500 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgEHMoQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A94BA15C11E
        for <netfilter-devel@vger.kernel.org>; Fri,  8 May 2020 14:44:15 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9CF6520679
        for <netfilter-devel@vger.kernel.org>; Fri,  8 May 2020 14:44:15 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 927A5A869; Fri,  8 May 2020 14:44:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9E5B71158FD;
        Fri,  8 May 2020 14:44:13 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 08 May 2020 14:44:13 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 795D942EF4E5;
        Fri,  8 May 2020 14:44:13 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft 2/3] libnftables: call nft_cmd_expand() only with CMD_ADD
Date:   Fri,  8 May 2020 14:44:02 +0200
Message-Id: <20200508124403.876-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508124403.876-1-pablo@netfilter.org>
References: <20200508124403.876-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Restrict the expansion logic to the CMD_ADD command which is where this
is only required.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/libnftables.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/libnftables.c b/src/libnftables.c
index 32da0a29ee21..668e3fc43031 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -419,8 +419,12 @@ static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 	if (nft->state->nerrs)
 		return -1;
 
-	list_for_each_entry(cmd, cmds, list)
+	list_for_each_entry(cmd, cmds, list) {
+		if (cmd->op != CMD_ADD)
+			continue;
+
 		nft_cmd_expand(cmd);
+	}
 
 	return 0;
 }
-- 
2.20.1

