Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82226E4BF
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 13:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfGSLKM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 07:10:12 -0400
Received: from kadath.azazel.net ([81.187.231.250]:52156 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSLKM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FVOsoidmuLp2ZWjjQ/jX6lOjmANXIU1gP72yHUoxL7A=; b=FsmFOCDyILLeBlqifaEInLClxj
        0a3FwVnHGU7yvAObqLeAtRfBQMOCI4kw54l9b3mat0dDMDFGphNo5sZGIf6ZwtOWtJ4jYcQmLH+5W
        ksb8zZovaPtljP6qGYe7USefHYaJuDRf8LRkxFQ+7LHGNeD80y+SFa8NddCJ/mMc1ve31NenQJxhD
        MSzDhmtAysEoxjqOj0uyctcF5/uw4Za8pLkvCF7qjm5EOdQSu/djmaaodw963oTf3xl5DfBvhapLV
        aS6U/114xoxyCn+QsJxNeoUyYMgay7gN04CfIgrWZFE0+hSBudGenE1cw9MBfYCCWf4ZN0IfvVPfC
        0w22ojxg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1hoQmA-00070n-R3; Fri, 19 Jul 2019 12:10:10 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nft v2 1/2] libnftables: got rid of repeated initialization of netlink_ctx variable in loop.
Date:   Fri, 19 Jul 2019 12:10:09 +0100
Message-Id: <20190719111010.14421-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719111010.14421-1-jeremy@azazel.net>
References: <20190719103205.GM1628@orbyte.nwl.cc>
 <20190719111010.14421-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Most members in the context doesn't change, so there is no need to
memset it and reassign them on every iteration.  Moved that code out of
the loop.

Fixes: a72315d2bad4 ("src: add rule batching support")
Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/libnftables.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/src/libnftables.c b/src/libnftables.c
index 2f77a7709e2c..4a139c58b2b3 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -22,8 +22,12 @@ static int nft_netlink(struct nft_ctx *nft,
 		       struct mnl_socket *nf_sock)
 {
 	uint32_t batch_seqnum, seqnum = 0, num_cmds = 0;
-	struct nftnl_batch *batch;
-	struct netlink_ctx ctx;
+	struct netlink_ctx ctx = {
+		.nft  = nft,
+		.msgs = msgs,
+		.list = LIST_HEAD_INIT(ctx.list),
+		.batch = mnl_batch_init(),
+	};
 	struct cmd *cmd;
 	struct mnl_err *err, *tmp;
 	LIST_HEAD(err_list);
@@ -32,16 +36,9 @@ static int nft_netlink(struct nft_ctx *nft,
 	if (list_empty(cmds))
 		return 0;
 
-	batch = mnl_batch_init();
-
-	batch_seqnum = mnl_batch_begin(batch, mnl_seqnum_alloc(&seqnum));
+	batch_seqnum = mnl_batch_begin(ctx.batch, mnl_seqnum_alloc(&seqnum));
 	list_for_each_entry(cmd, cmds, list) {
-		memset(&ctx, 0, sizeof(ctx));
-		ctx.msgs = msgs;
 		ctx.seqnum = cmd->seqnum = mnl_seqnum_alloc(&seqnum);
-		ctx.batch = batch;
-		ctx.nft = nft;
-		init_list_head(&ctx.list);
 		ret = do_command(&ctx, cmd);
 		if (ret < 0) {
 			netlink_io_error(&ctx, &cmd->location,
@@ -52,9 +49,9 @@ static int nft_netlink(struct nft_ctx *nft,
 		num_cmds++;
 	}
 	if (!nft->check)
-		mnl_batch_end(batch, mnl_seqnum_alloc(&seqnum));
+		mnl_batch_end(ctx.batch, mnl_seqnum_alloc(&seqnum));
 
-	if (!mnl_batch_ready(batch))
+	if (!mnl_batch_ready(ctx.batch))
 		goto out;
 
 	ret = mnl_batch_talk(&ctx, &err_list, num_cmds);
@@ -83,7 +80,7 @@ static int nft_netlink(struct nft_ctx *nft,
 		}
 	}
 out:
-	mnl_batch_reset(batch);
+	mnl_batch_reset(ctx.batch);
 	return ret;
 }
 
-- 
2.20.1

