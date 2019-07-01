Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED529E4E
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 May 2019 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfEXSqb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 May 2019 14:46:31 -0400
Received: from mail.us.es ([193.147.175.20]:49836 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbfEXSqb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 May 2019 14:46:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 48544C3281
        for <netfilter-devel@vger.kernel.org>; Fri, 24 May 2019 20:46:29 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3971EDA70B
        for <netfilter-devel@vger.kernel.org>; Fri, 24 May 2019 20:46:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2E2EDDA705; Fri, 24 May 2019 20:46:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 109CEDA708;
        Fri, 24 May 2019 20:46:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 24 May 2019 20:46:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [31.4.219.201])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id E96724265A5B;
        Fri, 24 May 2019 20:46:25 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, eric@garver.life
Subject: [PATCH nft] src: add cache_is_complete() and cache_is_updated()
Date:   Fri, 24 May 2019 20:46:18 +0200
Message-Id: <20190524184618.5315-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Just a few functions to help clarify cache update logic.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/rule.c b/src/rule.c
index 17bf5bbbe680..326edb5dd459 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -232,9 +232,14 @@ static int cache_completeness(enum cmd_ops cmd)
 	return 1;
 }
 
-static bool cache_needs_more(enum cmd_ops old_cmd, enum cmd_ops cmd)
+static bool cache_is_complete(struct nft_cache *cache, enum cmd_ops cmd)
 {
-	return cache_completeness(old_cmd) < cache_completeness(cmd);
+	return cache_completeness(cache->cmd) >= cache_completeness(cmd);
+}
+
+static bool cache_is_updated(struct nft_cache *cache, uint16_t genid)
+{
+	return genid && genid == cache->genid;
 }
 
 int cache_update(struct nft_ctx *nft, enum cmd_ops cmd, struct list_head *msgs)
@@ -252,10 +257,10 @@ int cache_update(struct nft_ctx *nft, enum cmd_ops cmd, struct list_head *msgs)
 replay:
 	ctx.seqnum = cache->seqnum++;
 	genid = mnl_genid_get(&ctx);
-	if (cache->genid && cache_needs_more(cache->cmd, cmd))
-		cache_release(cache);
-	if (genid && genid == cache->genid)
+	if (cache_is_complete(cache, cmd) &&
+	    cache_is_updated(cache, genid))
 		return 0;
+
 	if (cache->genid)
 		cache_release(cache);
 
-- 
2.11.0


