Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81121AB1E9
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2020 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438314AbgDOTiY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Apr 2020 15:38:24 -0400
Received: from correo.us.es ([193.147.175.20]:42644 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438305AbgDOTiV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:38:21 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E2322508CDD
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2020 21:38:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D415DBAC2F
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2020 21:38:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D307C5211E; Wed, 15 Apr 2020 21:38:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 672BEFA52A
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2020 21:38:13 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 Apr 2020 21:38:13 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 46A9742EF42C
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Apr 2020 21:38:13 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables] nft-shared: skip check for jumpto if cs->target is unset
Date:   Wed, 15 Apr 2020 21:38:10 +0200
Message-Id: <20200415193810.240720-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The command_jump() function leaves cs->target as NULL if the target is
not found. Check if the cs->jumpto string mismatches only in this case.

https://bugzilla.netfilter.org/show_bug.cgi?id=1422
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 extensions/libxt_NOTRACK.t | 3 +--
 iptables/nft-shared.c      | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/extensions/libxt_NOTRACK.t b/extensions/libxt_NOTRACK.t
index 585be82d56ec..27c4734ff497 100644
--- a/extensions/libxt_NOTRACK.t
+++ b/extensions/libxt_NOTRACK.t
@@ -1,4 +1,3 @@
 :PREROUTING,OUTPUT
 *raw
-# ERROR: cannot find: iptables -I PREROUTING -t raw -j NOTRACK
-#-j NOTRACK;=;OK
+-j NOTRACK;=;OK
diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 426765641cff..5192e36358b7 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -1013,7 +1013,8 @@ bool nft_ipv46_rule_find(struct nft_handle *h, struct nftnl_rule *r, void *data)
 		goto out;
 	}
 
-	if (strcmp(cs->jumpto, this.jumpto) != 0) {
+	if ((!cs->target || !this.target) &&
+	    strcmp(cs->jumpto, this.jumpto) != 0) {
 		DEBUGP("Different verdict\n");
 		goto out;
 	}
-- 
2.11.0

