Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD70B51954
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfFXRKj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 13:10:39 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51474 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbfFXRKj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:10:39 -0400
Received: from localhost ([::1]:36332 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hfSUI-0003Z3-FT; Mon, 24 Jun 2019 19:10:38 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/2] json: Print newline at end of list output
Date:   Mon, 24 Jun 2019 19:10:37 +0200
Message-Id: <20190624171038.24672-2-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624171038.24672-1-phil@nwl.cc>
References: <20190624171038.24672-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If listing ruleset elements with '-j' flag, print a final newline to not
upset shell prompts.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/json.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/json.c b/src/json.c
index 4e64684201638..1484c21be819a 100644
--- a/src/json.c
+++ b/src/json.c
@@ -1752,6 +1752,8 @@ int do_command_list_json(struct netlink_ctx *ctx, struct cmd *cmd)
 	root = json_pack("{s:o}", "nftables", root);
 	json_dumpf(root, ctx->nft->output.output_fp, 0);
 	json_decref(root);
+	fprintf(ctx->nft->output.output_fp, "\n");
+	fflush(ctx->nft->output.output_fp);
 	return 0;
 }
 
-- 
2.21.0

