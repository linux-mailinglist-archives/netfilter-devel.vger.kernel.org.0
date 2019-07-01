Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE4240E4
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfETTIe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 15:08:34 -0400
Received: from mail.us.es ([193.147.175.20]:38390 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfETTId (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 15:08:33 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C58D6BAEEC
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B6B63DA70D
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:31 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AC43CDA70B; Mon, 20 May 2019 21:08:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 91BBADA703;
        Mon, 20 May 2019 21:08:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 21:08:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 618AE4265A31;
        Mon, 20 May 2019 21:08:29 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH iptables 2/6] xtables: Fix for explicit rule flushes
Date:   Mon, 20 May 2019 21:08:18 +0200
Message-Id: <20190520190822.18873-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520190822.18873-1-pablo@netfilter.org>
References: <20190520190822.18873-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Phil Sutter <phil@nwl.cc>

The commit this fixes added a new parameter to __nft_rule_flush() to
mark a rule flush job as implicit or not. Yet the code added to that
function ignores the parameter and instead always sets batch job's
'implicit' flag to 1.

Fixes: 77e6a93d5c9dc ("xtables: add and set "implict" flag on transaction objects")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 288ada4af3ca..b9268b63c86d 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1778,7 +1778,7 @@ __nft_rule_flush(struct nft_handle *h, const char *table,
 		return;
 	}
 
-	obj->implicit = 1;
+	obj->implicit = implicit;
 }
 
 int nft_rule_flush(struct nft_handle *h, const char *chain, const char *table,
-- 
2.11.0

