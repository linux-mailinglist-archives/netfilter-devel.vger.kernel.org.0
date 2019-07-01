Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4364A1CA
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jun 2019 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfFRNNK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jun 2019 09:13:10 -0400
Received: from mail.us.es ([193.147.175.20]:46804 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRNNJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:13:09 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EC467C04E2
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Jun 2019 15:13:01 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DECEEDA707
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Jun 2019 15:13:01 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D436EDA702; Tue, 18 Jun 2019 15:13:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B2009DA702;
        Tue, 18 Jun 2019 15:12:59 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 18 Jun 2019 15:12:59 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 91D164265A2F;
        Tue, 18 Jun 2019 15:12:59 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     vaclav.zindulka@tlapnet.cz
Subject: [PATCH nft] evaluate: allow get/list/flush dynamic sets and maps via list command
Date:   Tue, 18 Jun 2019 15:12:56 +0200
Message-Id: <20190618131256.7226-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Before:

 # nft list set ip filter untracked_unknown
 Error: No such file or directory; did you mean set ‘untracked_unknown’ in table ip ‘filter’?
 list set ip filter untracked_unknown
                    ^^^^^^^^^^^^^^^^^

After:

 # nft list set ip filter untracked_unknown
 table ip filter {
        set untracked_unknown {
                type ipv4_addr . inet_service . ipv4_addr . inet_service . inet_proto
                size 100000
                flags dynamic,timeout
        }
 }

Reported-by: Václav Zindulka <vaclav.zindulka@tlapnet.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 511f9f14bedd..07617a7c94cb 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3520,7 +3520,7 @@ static int cmd_evaluate_get(struct eval_ctx *ctx, struct cmd *cmd)
 			return table_not_found(ctx);
 
 		set = set_lookup(table, cmd->handle.set.name);
-		if (set == NULL || set->flags & (NFT_SET_MAP | NFT_SET_EVAL))
+		if (set == NULL || set->flags & NFT_SET_MAP)
 			return set_not_found(ctx, &ctx->cmd->handle.set.location,
 					     ctx->cmd->handle.set.name);
 
@@ -3587,7 +3587,7 @@ static int cmd_evaluate_list(struct eval_ctx *ctx, struct cmd *cmd)
 			return table_not_found(ctx);
 
 		set = set_lookup(table, cmd->handle.set.name);
-		if (set == NULL || set->flags & (NFT_SET_MAP | NFT_SET_EVAL))
+		if (set == NULL || set->flags & NFT_SET_MAP)
 			return set_not_found(ctx, &ctx->cmd->handle.set.location,
 					     ctx->cmd->handle.set.name);
 
@@ -3698,7 +3698,7 @@ static int cmd_evaluate_flush(struct eval_ctx *ctx, struct cmd *cmd)
 			return table_not_found(ctx);
 
 		set = set_lookup(table, cmd->handle.set.name);
-		if (set == NULL || set->flags & (NFT_SET_MAP | NFT_SET_EVAL))
+		if (set == NULL || set->flags & NFT_SET_MAP)
 			return set_not_found(ctx, &ctx->cmd->handle.set.location,
 					     ctx->cmd->handle.set.name);
 
-- 
2.11.0

