Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35219115859
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 21:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLFUz1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 15:55:27 -0500
Received: from correo.us.es ([193.147.175.20]:33804 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfLFUz1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:55:27 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1CBBD83D0A
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 21:55:24 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0EC06DA702
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 21:55:24 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 040B9DA705; Fri,  6 Dec 2019 21:55:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 05AA7DA702
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 21:55:22 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Dec 2019 21:55:22 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id D4E3142EE38E
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 21:55:21 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: validate NFT_SET_ELEM_INTERVAL_END
Date:   Fri,  6 Dec 2019 21:55:20 +0100
Message-Id: <20191206205520.67969-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Only NFTA_SET_ELEM_KEY and NFTA_SET_ELEM_FLAGS make sense for elements
whose NFT_SET_ELEM_INTERVAL_END flag is set on.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 062b73a83af0..0db2784fee9a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4756,14 +4756,20 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		if (nla[NFTA_SET_ELEM_DATA] == NULL &&
 		    !(flags & NFT_SET_ELEM_INTERVAL_END))
 			return -EINVAL;
-		if (nla[NFTA_SET_ELEM_DATA] != NULL &&
-		    flags & NFT_SET_ELEM_INTERVAL_END)
-			return -EINVAL;
 	} else {
 		if (nla[NFTA_SET_ELEM_DATA] != NULL)
 			return -EINVAL;
 	}
 
+	if ((flags & NFT_SET_ELEM_INTERVAL_END) &&
+	     (nla[NFTA_SET_ELEM_DATA] ||
+	      nla[NFTA_SET_ELEM_OBJREF] ||
+	      nla[NFTA_SET_ELEM_TIMEOUT] ||
+	      nla[NFTA_SET_ELEM_EXPIRATION] ||
+	      nla[NFTA_SET_ELEM_USERDATA] ||
+	      nla[NFTA_SET_ELEM_EXPR]))
+		return -EINVAL;
+
 	timeout = 0;
 	if (nla[NFTA_SET_ELEM_TIMEOUT] != NULL) {
 		if (!(set->flags & NFT_SET_TIMEOUT))
-- 
2.11.0

