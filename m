Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84406373DC
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Jun 2019 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfFFMMA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Jun 2019 08:12:00 -0400
Received: from mail.us.es ([193.147.175.20]:44672 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFFMMA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:12:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5217C11ED85
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Jun 2019 14:11:58 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 440C9DA70F
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Jun 2019 14:11:58 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3728BDA70B; Thu,  6 Jun 2019 14:11:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1C960DA707;
        Thu,  6 Jun 2019 14:11:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 06 Jun 2019 14:11:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (barqueta.lsi.us.es [150.214.188.150])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 076244265A5B;
        Thu,  6 Jun 2019 14:11:56 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH nft] rule: ensure cache consistency
Date:   Thu,  6 Jun 2019 14:11:53 +0200
Message-Id: <20190606121153.3777-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Check for generation ID after the cache is populated. In case of
interference, release the inconsistent cache and retry.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/rule.c b/src/rule.c
index 1e081c8fe862..cb5bd2162c02 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -244,8 +244,6 @@ static bool cache_is_updated(struct nft_cache *cache, uint16_t genid)
 
 int cache_update(struct nft_ctx *nft, enum cmd_ops cmd, struct list_head *msgs)
 {
-	uint16_t genid;
-	int ret;
 	struct netlink_ctx ctx = {
 		.list		= LIST_HEAD_INIT(ctx.list),
 		.nft		= nft,
@@ -253,7 +251,8 @@ int cache_update(struct nft_ctx *nft, enum cmd_ops cmd, struct list_head *msgs)
 		.nft		= nft,
 	};
 	struct nft_cache *cache = &nft->cache;
-
+	uint16_t genid, genid_stop;
+	int ret;
 replay:
 	ctx.seqnum = cache->seqnum++;
 	genid = mnl_genid_get(&ctx);
@@ -273,6 +272,13 @@ replay:
 		}
 		return -1;
 	}
+
+	genid_stop = mnl_genid_get(&ctx);
+	if (genid != genid_stop) {
+		cache_release(cache);
+		goto replay;
+	}
+
 	cache->genid = genid;
 	cache->cmd = cmd;
 	return 0;
-- 
2.11.0

