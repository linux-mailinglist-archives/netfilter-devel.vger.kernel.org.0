Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D46EBFF38
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2019 08:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfI0Gij (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Sep 2019 02:38:39 -0400
Received: from correo.us.es ([193.147.175.20]:54794 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfI0Gij (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Sep 2019 02:38:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C8C371694A9
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Sep 2019 08:38:34 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BAA03FF6EB
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Sep 2019 08:38:34 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AFEA9FF6E0; Fri, 27 Sep 2019 08:38:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9A564DA72F;
        Fri, 27 Sep 2019 08:38:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 27 Sep 2019 08:38:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 708514265A5A;
        Fri, 27 Sep 2019 08:38:32 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net
Subject: [PATCH nft] libnftables: memleak when no batch commands in list
Date:   Fri, 27 Sep 2019 08:38:31 +0200
Message-Id: <20190927063831.9705-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

A ruleset listing triggers this bug.

Fixes: fc6d0f8b0cb1 ("libnftables: get rid of repeated initialization of netlink_ctx")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/libnftables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libnftables.c b/src/libnftables.c
index a19636b22683..e20372438db6 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -34,7 +34,7 @@ static int nft_netlink(struct nft_ctx *nft,
 	int ret = 0;
 
 	if (list_empty(cmds))
-		return 0;
+		goto out;
 
 	batch_seqnum = mnl_batch_begin(ctx.batch, mnl_seqnum_alloc(&seqnum));
 	list_for_each_entry(cmd, cmds, list) {
-- 
2.11.0

